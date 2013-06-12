#include <gsl/gsl_errno.h> 
#include <gsl/gsl_math.h> 

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
		PROPERTYSLOT_SET_GET( Real, Ka );
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
		PROPERTYSLOT_SET_GET( Real, StopgapStepInterval );
		PROPERTYSLOT_SET_GET( Real, conc_epsilon );
	}
	
	IsotonicContractionAssignmentProcess()
		:
		B( 1.2 ),
		hc( 0.005 ),
		A( 3.06e+6 ),
		L0( 0.97 ),
		K( 140000 ),
		Kl( 200 ),
		Ka( 0.01 ),
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
		Yd( 8000.0 ),          // for α5
		StopgapStepInterval( 0.02 ),
		conc_epsilon( 1.0e-12 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, B );
	SIMPLE_SET_GET_METHOD( Real, hc );
	SIMPLE_SET_GET_METHOD( Real, A );
	SIMPLE_SET_GET_METHOD( Real, L0 );
	SIMPLE_SET_GET_METHOD( Real, K );
	SIMPLE_SET_GET_METHOD( Real, Kl );
	SIMPLE_SET_GET_METHOD( Real, Ka );
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
	SIMPLE_SET_GET_METHOD( Real, StopgapStepInterval );
	SIMPLE_SET_GET_METHOD( Real, conc_epsilon );

	virtual void initialize()
	{
		Process::initialize();
		
		L         = getVariableReference( "L" ).getVariable();
		X         = getVariableReference( "X" ).getVariable();
		CBL       = getVariableReference( "CBL" ).getVariable();
		dXdt      = getVariableReference( "dXdt" ).getVariable();
		// ForceEcomp= getVariableReference( "ForceEcomp" ).getVariable();
		// ForceCB   = getVariableReference( "ForceCB" ).getVariable();
		// dF        = getVariableReference( "dF" ).getVariable();
		aL        = getVariableReference( "aL" ).getVariable();
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

	}

	virtual void fire()
	{
		_SizeN_A = getSuperSystem()->getSizeN_A();

		_Ca_MolarConc = Ca->getMolarConc();
		_TCa = TCa->getValue();
		_L = L->getValue();
		_TCB = TCB->getValue();
		_TCaCB = TCaCB->getValue();
		_Tt = Tt->getValue();

		_CBL = _L - X->getValue();
		_dXdt = B * ( _CBL - hc );

		_ForceEcomp = K * gsl_pow_5( L0 - _L ) + Kl * ( L0 - _L );
		_ForceCB = A * ( TCaCB->getMolarConc() + TCB->getMolarConc()) * 1000.0 * (_L - X->getValue());

		// ForceEcomp->setValue( _ForceEcomp );
		// ForceCB->setValue( _ForceCB );
		
		// dF->setValue( _ForceEcomp - _ForceCB );

		aL->setValue( Ka * ( forceExt->getValue() + _ForceEcomp - _ForceCB ) );

		// printf ( "Solver Answer: %.7f\n", _L );
		// setActivity( _L );

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

		_T = _Tt - _TCa - _TCaCB - _TCB;
		if ( _T <= ( _Tt * conc_epsilon )) {
			T->setValue( _Tt * conc_epsilon );
		} else {
			T->setValue( _T );
		}

		CBL->setValue( _CBL );
		dXdt->setValue( _dXdt );

		// Q1
		_qb = Y1 * _Ca_MolarConc * T->getValue() - Z1 * _TCa;
		// 1st term of Q2
		_qa1 = Y2 * (0.54 * KmPi / (KmPi + Pi->getMolarConc() ) + 0.46) * _TCa * exp(-20.0 * gsl_pow_2( _L - La ));
		//ATPfactor->setValue( 1.0 / (1.0 + pow( KmATP / ATP->getMolarConc(), 3 )) );

		_ATPfactor = 1.0 / (1.0 + gsl_pow_3( KmATP / ATP->getMolarConc() ));
		_cbFactor = gsl_pow_2( _dXdt ) / ( Real( GSL_SIGN( _dXdt )) * ( dXdtFactor - 1.0 ) / 2.0 + (( dXdtFactor + 1.0 ) / 2.0 ));

		// 2nd term of Q2
		_qa2 = Z2 * _ATPfactor * TCaCB->getValue();
		// Q3
		_qr = Y3 * TCaCB->getValue() - Z3 * _Ca_MolarConc * _TCB;
		// 1st term of Q4
		_qd = Y4 * _ATPfactor * _TCB;
		// 2nd term of Q4
		_qd1 = Yd * _ATPfactor * _cbFactor * _TCB;
		// Q5
		_qd2 = Yd * _ATPfactor * _cbFactor * TCaCB->getValue();

		/* // DEBUG
		std::cout << std::endl;
		std::cout << "next TCB: " << _TCB + (( _qr * ( 1.0 ) + _qd * ( -1.0 ) + _qd1 * ( -1.0 )) * StopgapStepInterval );
		std::cout << "\tTCB: "    << _TCB;
		std::cout << "\tqr: "     << _qr;
		std::cout << "\tqd: "     << _qd;
		std::cout << "\tqd1: "    << _qd1 << std::endl;
		*/

		if ( ( _TCB + (( _qr * ( 1.0 ) + _qd * ( -1.0 ) + _qd1 * ( -1.0 )) * StopgapStepInterval )) <= ( _Tt * conc_epsilon ))
		{
			if ( _qr  <= 0.0 ) _qr  = 0.0;
			if ( _qd  >= 0.0 ) _qd  = 0.0;
			if ( _qd1 >= 0.0 ) _qd1 = 0.0;
		}

		qb->setValue( _qb );
		qa1->setValue( _qa1 );
		qa2->setValue( _qa2 );
		qr->setValue( _qr );
		qd->setValue( _qd );
		qd1->setValue( _qd1 );
		qd2->setValue( _qd2 );

	}

 protected:

	Variable* L;
	Variable* X;
	Variable* CBL;
	Variable* dXdt;
	// Variable* ForceEcomp;
	// Variable* ForceCB;
	Variable* forceExt;
	Variable* aL;
	// Variable* dF;
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
	Real Ka;  // 0.01
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

	Real StopgapStepInterval;
	Real conc_epsilon;

 private:

	Real _SizeN_A;
	Real _CBL;
	Real _L;
	Real _Ca_MolarConc;
	Real _T;
	Real _TCa;
	Real _ATPfactor;
	Real _cbFactor;
	Real _TCB;
	Real _TCaCB;
	Real _Tt;
	Real _dXdt;
	Real _ForceEcomp;
	Real _ForceCB;

	Real _qb;
	Real _qa1;
	Real _qa2;
	Real _qr;
	Real _qd;
	Real _qd1;
	Real _qd2;
	
};

LIBECS_DM_INIT( IsotonicContractionAssignmentProcess, Process );

