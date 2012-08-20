#include <gsl/gsl_errno.h> 
#include <gsl/gsl_math.h> 
#include <gsl/gsl_roots.h> 
#include <vector>

#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IsotonicContractionAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IsotonicContractionAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, B );
		PROPERTYSLOT_SET_GET( Real, hc );
		PROPERTYSLOT_SET_GET( Real, A );
		PROPERTYSLOT_SET_GET( Real, L0 );
		PROPERTYSLOT_SET_GET( Real, K );
		PROPERTYSLOT_SET_GET( Real, Kl );
		PROPERTYSLOT_SET_GET( Real, epsabs );
		PROPERTYSLOT_SET_GET( Real, epsrel );
		PROPERTYSLOT_SET_GET( Real, Y1 );
		PROPERTYSLOT_SET_GET( Real, Z1 );
		PROPERTYSLOT_SET_GET( Real, Y2 );
		PROPERTYSLOT_SET_GET( Real, La );
		PROPERTYSLOT_SET_GET( Real, KmPi );
		PROPERTYSLOT_SET_GET( Real, KmATP );
		PROPERTYSLOT_SET_GET( Real, Z2 );
		PROPERTYSLOT_SET_GET( Real, Y3 );
		PROPERTYSLOT_SET_GET( Real, Z3 );
		PROPERTYSLOT_SET_GET( Real, Y4 );
		PROPERTYSLOT_SET_GET( Real, dXdtFactor );
		PROPERTYSLOT_SET_GET( Real, Yd );
	}
	
	IsotonicContractionAssignmentProcess()
		:
		B( 1.2 ),
		hc( 0.005 ),
		A( 3.06e+6 ),
		L0( 0.97 ),
		K( 140000 ),
		Kl( 200 ),
		epsabs( 0.0 ),
		epsrel( 1.0e-6 ),
		Y1( 31200.0 ),         // α1 = 39 * bias1 * 1000
		Z1( 0.06 ),            // β1 = 0.03 * bias2
		Y2( 0.0039 ),          // for α2
		La( 1.17 ),            
		KmPi( 1.83e-3 ),       // (M)
		KmATP( 0.1e-3 ),       // (M)
		Z2( 0.0039 ),          // for β2
		Y3( 0.06 ),            // α3 = 0.03 * bias2
		Z3( 1248000.0 ),       // β3 = 1560 * bias1 * 1000
		Y4( 0.12 ),            // for α4
		dXdtFactor( 50.0 ),
		Yd( 8000.0 )           // for α5
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, B );
	SIMPLE_SET_GET_METHOD( Real, hc );
	SIMPLE_SET_GET_METHOD( Real, A );
	SIMPLE_SET_GET_METHOD( Real, L0 );
	SIMPLE_SET_GET_METHOD( Real, K );
	SIMPLE_SET_GET_METHOD( Real, Kl );
	SIMPLE_SET_GET_METHOD( Real, epsabs );
	SIMPLE_SET_GET_METHOD( Real, epsrel );
	SIMPLE_SET_GET_METHOD( Real, Y1 );
	SIMPLE_SET_GET_METHOD( Real, Z1 );
	SIMPLE_SET_GET_METHOD( Real, Y2 );
	SIMPLE_SET_GET_METHOD( Real, La );
	SIMPLE_SET_GET_METHOD( Real, KmPi );
	SIMPLE_SET_GET_METHOD( Real, KmATP );
	SIMPLE_SET_GET_METHOD( Real, Z2 );
	SIMPLE_SET_GET_METHOD( Real, Y3 );
	SIMPLE_SET_GET_METHOD( Real, Z3 );
	SIMPLE_SET_GET_METHOD( Real, Y4 );
	SIMPLE_SET_GET_METHOD( Real, dXdtFactor );
	SIMPLE_SET_GET_METHOD( Real, Yd );

	virtual void initialize()
	{
		Process::initialize();
		
		L         = getVariableReference( "L" ).getVariable();
		X         = getVariableReference( "X" ).getVariable();
		CBL       = getVariableReference( "CBL" ).getVariable();
		dXdt      = getVariableReference( "dXdt" ).getVariable();
		forceExt  = getVariableReference( "forceExt" ).getVariable();
		TCaCB     = getVariableReference( "TCaCB" ).getVariable();
		TCB       = getVariableReference( "TCB" ).getVariable();
		qb        = getVariableReference( "qb" ).getVariable();
		T         = getVariableReference( "T" ).getVariable();
		Tt        = getVariableReference( "Tt" ).getVariable();
		TCa       = getVariableReference( "TCa" ).getVariable();
		Ca        = getVariableReference( "Ca" ).getVariable();
		CaTotal   = getVariableReference( "CaTotal" ).getVariable();
		qa1       = getVariableReference( "qa1" ).getVariable();
		Pi        = getVariableReference( "Pi" ).getVariable();
		//ATPfactor  = getVariableReference( "ATPfactor" ).getVariable();
		ATP       = getVariableReference( "ATP" ).getVariable();
		qa2       = getVariableReference( "qa2" ).getVariable();
		ADP       = getVariableReference( "ADP" ).getVariable();
		qr        = getVariableReference( "qr" ).getVariable();
		qd        = getVariableReference( "qd" ).getVariable();
		//cbFactor  = getVariableReference( "cbFactor" ).getVariable();
		qd1       = getVariableReference( "qd1" ).getVariable();
		qd2       = getVariableReference( "qd2" ).getVariable();

		// 以下、筋収縮の代数方程式求根

		max_iter = 100;
		search_range = 0.01;

		// パラメータ内容を代入
		params.push_back( TCaCB->getMolarConc() * 1000.0 );
		params.push_back( TCB->getMolarConc() * 1000.0 );
		params.push_back( X->getValue() );
		params.push_back( forceExt->getValue() );
		params.push_back( K );
		params.push_back( Kl );
		params.push_back( L0 );
		params.push_back( A );
		
		// Fに関数、パラメータを指定する
		F.function = &IsotonicContractionAssignmentProcess::the_function; 
		F.params   = &params; 

		// 求根法のインスタンスsを生成する。simBioではsecant method
		// ここでは、収束が保証される囲い込み法（Brent法）
		solver_T = gsl_root_fsolver_brent;

	}

	virtual void fire()
	{
		_SizeN_A = getSuperSystem()->getSizeN_A();

		_Ca_MolarConc = Ca->getMolarConc();
		_TCa = TCa->getValue();
		_L = L->getValue();
		_TCB = TCB->getValue();
		_TCaCB = TCaCB->getValue();

		_CBL = _L - X->getValue();
		_dXdt = B * ( _CBL - hc );

		// 筋収縮の代数方程式求根 start

		iter = 0;

		// パラメータ内容を代入
		//params = t->getValue();
		params[ 0 ] = _TCaCB / _SizeN_A * 1000.0 ;
		params[ 1 ] = _TCB / _SizeN_A * 1000.0;
		params[ 2 ] = X->getValue();
		params[ 3 ] = forceExt->getValue();
		//printf ( "cTCaCB = %.7f\n", params[ 0 ] );
		//printf ( "cTCB   = %.7f\n", params[ 1 ] );

		// x  = L->getValue(); 


		// Brent法のインスタンスsを関数Fに適用するために初期化し、探索区間を設定する。
		s = gsl_root_fsolver_alloc( solver_T ); 
		x_lo = _L - search_range;
		x_hi = _L + search_range;
		// printf ("Solver Setting: [%.7f, %.7f]\n", x_lo, x_hi );
		gsl_root_fsolver_set( s, &F, x_lo, x_hi ); 

		do
		{
			iter++;
			status = gsl_root_fsolver_iterate (s);
			r = gsl_root_fsolver_root (s);
			x_lo = gsl_root_fsolver_x_lower (s);
			x_hi = gsl_root_fsolver_x_upper (s);
			status = gsl_root_test_interval (x_lo, x_hi, 1e-12, 0 );
			
			/*
			if (status == GSL_SUCCESS)
				printf ("Converged:\n");
			
			printf ("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n",
				iter, x_lo, x_hi,
				r, r - r_expected, 
				x_hi - x_lo);
			*/
		}
		while (status == GSL_CONTINUE && iter < max_iter);
		
		gsl_root_fsolver_free (s);
		
		_L = r;
		// printf ( "Solver Answer: %.7f\n", _L );
		L->setValue( _L );
		setActivity( _L );

		// 筋収縮の代数方程式求根 end

		/* // DEBUG
		std::cout << std::endl;
		std::cout << "T    : " << T->getValue()     << std::endl;
		std::cout << "TCa  : " << TCa->getValue() << std::endl;
		std::cout << "TCB  : " << TCB->getValue() << std::endl;
		std::cout << "TCaCB: " << TCaCB->getValue() << std::endl;
		std::cout << "qa1  : " << qa1->getValue() << std::endl;
		std::cout << "qa2  : " << qa2->getValue() << std::endl;
		std::cout << "qb   : " << qb->getValue() << std::endl;
		std::cout << "qr   : " << qr->getValue() << std::endl;
		std::cout << "qd   : " << qd->getValue() << std::endl;
		std::cout << "qd1  : " << qd1->getValue() << std::endl;
		std::cout << "qd2  : " << qd2->getValue() << std::endl;
		*/

		T->setValue( Tt->getValue() - _TCa - _TCaCB - _TCB );
		CBL->setValue( _CBL );
		dXdt->setValue( _dXdt );
		// Q1
		qb->setValue( Y1 * _Ca_MolarConc * T->getValue() - Z1 * _TCa );
		// 1st term of Q2
		qa1->setValue( Y2 * (0.54 * KmPi / (KmPi + Pi->getMolarConc() ) + 0.46) * _TCa * exp(-20.0 * gsl_pow_2( _L - La )));
		//ATPfactor->setValue( 1.0 / (1.0 + pow( KmATP / ATP->getMolarConc(), 3 )) );

		_ATPfactor = 1.0 / (1.0 + gsl_pow_3( KmATP / ATP->getMolarConc() ));
		_cbFactor = gsl_pow_2( _dXdt ) / ( Real( GSL_SIGN( _dXdt )) * ( dXdtFactor - 1.0 ) / 2.0 + (( dXdtFactor + 1.0 ) / 2.0 ));

		// 2nd term of Q2
		qa2->setValue( Z2 * _ATPfactor * TCaCB->getValue() );
		// Q3
		qr->setValue( Y3 * TCaCB->getValue() - Z3 * _Ca_MolarConc * _TCB );
		// 1st term of Q4
		qd->setValue( Y4 * _ATPfactor * _TCB );
		// 2nd term of Q4
		qd1->setValue( Yd * _ATPfactor * _cbFactor * _TCB );
		// Q5
		qd2->setValue( Yd * _ATPfactor * _cbFactor * TCaCB->getValue() );

	}

 protected:

	Variable* L;
	Variable* X;
	Variable* CBL;
	Variable* dXdt;
	Variable* forceExt;
	Variable* TCaCB;
	Variable* TCB;
	Variable* qb;
	Variable* T;
	Variable* Tt;
	Variable* TCa;
	Variable* Ca;
	Variable* CaTotal;
	Variable* qa1;
	Variable* Pi;
	//Variable* ATPfactor;
	Variable* ATP;
	Variable* qa2;
	Variable* ADP;
	Variable* qr;
	Variable* qd;
	//Variable* cbFactor;
	Variable* qd1;
	Variable* qd2;

	Real B;  // 1.2
	Real hc;  // 0.005
	Real A;  // 3.06e+6
	Real L0;  // 0.97
	Real K;  // 140000
	Real Kl;  // 200
	Real epsabs;
	Real epsrel;
	Real Y1;  // 31200.0
	Real Z1;  // 0.06
	Real Y2;  // 0.0039
	Real La;  // 1.17
	Real KmPi;  // 1.83e-3
	Real KmATP;  // 0.1e-3
	Real Z2;  // 0.0039
	Real Y3;  // 0.06
	Real Z3;  // 1248000.0
	Real Y4;  // 0.12
	Real dXdtFactor;  // 50.0
	Real Yd;  // 8000.0

 private:

	Real _SizeN_A;
	Real _CBL;
	Real _L;
	Real _Ca_MolarConc;
	Real _TCa;
	Real _ATPfactor;
	Real _cbFactor;
	Real _TCB;
	Real _TCaCB;
	Real _dXdt;

	// 以下、筋収縮の代数方程式求根

	int status;
	
	int iter;
	int max_iter;
	
	Real r, search_range, x_lo, x_hi;	// r: 根　search_range: 探索区間の幅
	// Real x;
	
	// Pointer of a derivative-based solver instance of type solver_T
	const gsl_root_fsolver_type *solver_T; 
	gsl_root_fsolver *s; 
	
	// A general function with parameters and its first derivative.
	gsl_function F; 
	
	// Defintion of parameters of the function.
	std::vector< Real > params;
	
	static Real the_function (Real x, void *params)
	{
		std::vector< Real > *p = ( std::vector< Real > * ) params;
		Real cTCaCB   = p->at( 0 );
		Real cTCB     = p->at( 1 );
		Real ex       = p->at( 2 );
		Real forceExt = p->at( 3 );
		Real K        = p->at( 4 );
		Real Kl       = p->at( 5 );
		Real L0       = p->at( 6 );
		Real A        = p->at( 7 );
	
		double strain = x - L0;
		double dforceNonLinear = K * gsl_pow_4( strain );
	
		double dforceB = A * (cTCaCB + cTCB);
	
		return forceExt - dforceNonLinear * strain - Kl * strain - dforceB * (x - ex);
	
		/*
		double f = forceExt - dforceNonLinear * strain - Kl * strain - dforceB * (x - ex);
		printf( "\nf   = %1.12e", f );
		return f;
		*/
	}


};

LIBECS_DM_INIT( IsotonicContractionAssignmentProcess, Process );

