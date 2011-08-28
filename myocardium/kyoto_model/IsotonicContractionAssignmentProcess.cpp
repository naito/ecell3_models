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
		Y1( 31200.0 ),
		Z1( 0.06 ),
		Y2( 0.0039 ),
		La( 1.17 ),
		KmPi( 1.83e-3 ),
		KmATP( 0.1e-3 ),
		Z2( 0.0039 ),
		Y3( 0.06 ),
		Z3( 1248000.0 ),
		Y4( 0.12 ),
		dXdtFactor( 50.0 ),
		Yd( 8000.0 )
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

		// パラメータ内容を代入
		params.push_back( TCaCB->getMolarConc() * 1000.0 );
		params.push_back( TCB->getMolarConc() * 1000.0 );
		params.push_back( X->getValue() );
		params.push_back( forceExt->getValue() );
		params.push_back( K );
		params.push_back( Kl );
		params.push_back( L0 );
		params.push_back( A );
		
		// FDFに関数、導関数、パラメータを指定する
		FDF.f      = &IsotonicContractionAssignmentProcess::the_f; 
		FDF.df     = &IsotonicContractionAssignmentProcess::the_df; 
		FDF.fdf    = &IsotonicContractionAssignmentProcess::the_fdf; 
		FDF.params = &params; 

		// 求根法のインスタンスsを生成する。simBioではsecant method
		//theSolver = gsl_root_fdfsolver_secant;
		theSolver = gsl_root_fdfsolver_steffenson;
		//theSolver = gsl_root_fdfsolver_newton;

		s = gsl_root_fdfsolver_alloc( theSolver ); 

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

		// x  = L->getValue(); 

		// x1に相当する値を計算してx0に格納
		x0 = _L - ( the_f( _L, &params ) / the_df( _L, &params ) );

		// Secant法のインスタンスsを関数FDFに適用するために初期化し、探索点の初期値をxに設定する。
		gsl_root_fdfsolver_set( s, &FDF, _L ); 

		for ( iter = 0; iter < max_iter; iter++ )
		{
			if ( gsl_root_test_delta ( _L, x0, epsabs, epsrel ) == GSL_SUCCESS ) break;
	
			// 求根法の繰り返し計算を１回実行。
	
			//printf( "\nx0  = %12.10f", x0 );
			//printf( "\nx   = %12.10f", x  );
			//printf( "\ndx  = %e", x - x0 );
	
			status = gsl_root_fdfsolver_iterate( s );
			if ( status ) {
				
				if ( status  == GSL_EBADFUNC ) printf( "gsl_root_fdfsolver_iterate: GSL_EBADFUNC" ); 
				if ( status  == GSL_EZERODIV ) printf( "gsl_root_fdfsolver_iterate: GSL_EZERODIV" ); 
			}
			
			//printf( "\nstatus: %d\n", status );
	
			x0 = _L; 
			_L = gsl_root_fdfsolver_root( s ); 
		}
	
	
		L->setValue( _L );
		setActivity( _L );

		// 筋収縮の代数方程式求根 end

		T->setValue( Tt->getValue() - _TCa - _TCaCB - _TCB );
		CBL->setValue( _CBL );
		dXdt->setValue( _dXdt );
		qb->setValue( Y1 * _Ca_MolarConc * T->getValue() - Z1 * _TCa );
		qa1->setValue( Y2 * (0.54 * KmPi / (KmPi + Pi->getMolarConc() ) + 0.46) * _TCa * exp(-20.0 * ( _L - La ) * ( _L - La )) );
		//ATPfactor->setValue( 1.0 / (1.0 + pow( KmATP / ATP->getMolarConc(), 3 )) );

		_ATPfactor = 1.0 / (1.0 + pow( KmATP / ATP->getMolarConc(), 3 ));
		_cbFactor = _dXdt * _dXdt / (( abs( _dXdt ) / _dXdt ) * ( dXdtFactor - 1.0 ) / 2.0 + (( dXdtFactor + 1.0 ) / 2.0 ));

		qa2->setValue( Z2 * _ATPfactor * TCaCB->getValue() );
		qr->setValue( Y3 * TCaCB->getValue() - Z3 * _Ca_MolarConc * _TCB );
		qd->setValue( Y4 * _ATPfactor * _TCB );
		//cbFactor->setValue( _dXdt * _dXdt / (( abs( _dXdt ) / _dXdt ) * ( dXdtFactor - 1.0 ) / 2.0 + (( dXdtFactor + 1.0 ) / 2.0 )) );
		qd1->setValue( Yd * _ATPfactor * _cbFactor * _TCB );
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
	
	Real x0;
	// Real x;
	
	// Pointer of a derivative-based solver instance of type theSolver
	const gsl_root_fdfsolver_type *theSolver; 
	gsl_root_fdfsolver *s; 
	
	// A general function with parameters and its first derivative.
	gsl_function_fdf FDF; 
	
	// Defintion of parameters of the function.
	std::vector< Real > params;
	
	// Prototypes of the function to solve (f), its derivative (df), and set of f & df (fdf)
	// They are set as static because their POINTERs will be called by a gsl_function_fdf instance. 
	static Real the_f (Real x, void *params)
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
		double dforceNonLinear = K * pow( strain, 4.0 );
	
		double dforceB = A * (cTCaCB + cTCB);
	
		return forceExt - dforceNonLinear * strain - Kl * strain - dforceB * (x - ex);
	
		/*
		double f = forceExt - dforceNonLinear * strain - Kl * strain - dforceB * (x - ex);
		printf( "\nf   = %1.12e", f );
		return f;
		*/
	}

	static Real the_df (Real x, void *params)
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
	
		return - 5.0 * K * pow( x - L0, 4.0 ) - Kl - A * (cTCaCB + cTCB);
	
		/*
		double df =  - 5.0 * K * pow( x - L0, 4.0 ) - Kl - A * (cTCaCB + cTCB);
		printf( "   df  = %1.12e", df );
		return df;
		*/
	}

	static void the_fdf (Real x, void *params, Real *y, Real *dy)
	{
		/*
		*y  = the_f(  x, params);
		*dy = the_df( x, params);
		*/
		
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
		double dforceNonLinear = 5.0 * K * pow( strain, 4.0 );
	
		double dforceB = A * (cTCaCB + cTCB);
	
		*y  = forceExt - dforceNonLinear / 5.0 * strain - Kl * strain - dforceB * (x - ex);
		*dy = - dforceNonLinear - Kl - dforceB;
		
	}

};

LIBECS_DM_INIT( IsotonicContractionAssignmentProcess, Process );

