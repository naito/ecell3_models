#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ICaLAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ICaLAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, kAPAI );
		PROPERTYSLOT_SET_GET( Real, kAIAP );

		PROPERTYSLOT_SET_GET( Real, kUUCa );
		PROPERTYSLOT_SET_GET( Real, kCCCa );

		PROPERTYSLOT_SET_GET( Real, kCU );
		PROPERTYSLOT_SET_GET( Real, kUC );
		PROPERTYSLOT_SET_GET( Real, kUCaU );
		//PROPERTYSLOT_SET_GET( Real, kUUCaCa );
		PROPERTYSLOT_SET_GET( Real, kCCaUCa );
		PROPERTYSLOT_SET_GET( Real, kUCaCCa );
		PROPERTYSLOT_SET_GET( Real, kCCaC );
		//PROPERTYSLOT_SET_GET( Real, kCCCaCa );

		PROPERTYSLOT_SET_GET( Real, PKA0 );
		PROPERTYSLOT_SET_GET( Real, KmPKA );
		PROPERTYSLOT_SET_GET( Real, hill_n );
		PROPERTYSLOT_SET_GET( Real, MAX );
		//PROPERTYSLOT_SET_GET( Real, PKA_factor0 );

		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
		PROPERTYSLOT_SET_GET( Real, permeabilityCa );

		PROPERTYSLOT_SET_GET( Real, kSingleCurrentAmp );
		PROPERTYSLOT_SET_GET( Real, amplitudePKAf );
	}
	
	ICaLAssignmentProcess()
		:
		kAPAI( 0.004 ),
		kAIAP( 0.001 ),
		
		kUUCa( 6.954 ),
		kCCCa( 6.954 ),

		kCU( 0.143 ),
		kUC( 0.35 ),
		kUCaU( 2.0020000000000002 ),
		//kUUCaCa( 0.0 ),
		kCCaUCa( 0.0003 ),
		kUCaCCa( 0.35 ),
		kCCaC( 0.0042 ),
		//kCCCaCa( 0.0 ),
		
		PKA0( 1.3644055081894695e-7 ),
		KmPKA( 6.5e-07 ),
		hill_n( 2.0 ),
		MAX( 3.0 ),
		//PKA_factor0( 0.873393690783 ),
		permeabilityNa( 0.0008325 ),
		permeabilityK( 0.016425 ),
		permeabilityCa( 45.0 ),

		kSingleCurrentAmp( 0.3 ),
		amplitudePKAf( 0.0 )	// 0.0ならkuzumoto model
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, kAPAI );
	SIMPLE_SET_GET_METHOD( Real, kAIAP );

	SIMPLE_SET_GET_METHOD( Real, kUUCa );
	SIMPLE_SET_GET_METHOD( Real, kCCCa );

	SIMPLE_SET_GET_METHOD( Real, kCU );
	SIMPLE_SET_GET_METHOD( Real, kUC );
	SIMPLE_SET_GET_METHOD( Real, kUCaU );
	//SIMPLE_SET_GET_METHOD( Real, kUUCaCa );
	SIMPLE_SET_GET_METHOD( Real, kCCaUCa );
	SIMPLE_SET_GET_METHOD( Real, kUCaCCa );
	SIMPLE_SET_GET_METHOD( Real, kCCaC );
	//SIMPLE_SET_GET_METHOD( Real, kCCCaCa );

	SIMPLE_SET_GET_METHOD( Real, PKA0 );
	SIMPLE_SET_GET_METHOD( Real, KmPKA );
	SIMPLE_SET_GET_METHOD( Real, hill_n );
	SIMPLE_SET_GET_METHOD( Real, MAX );
	//SIMPLE_SET_GET_METHOD( Real, PKA_factor0 );

	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	SIMPLE_SET_GET_METHOD( Real, permeabilityCa );

	SIMPLE_SET_GET_METHOD( Real, kSingleCurrentAmp );
	SIMPLE_SET_GET_METHOD( Real, amplitudePKAf );
	
	virtual void initialize()
	{
		Process::initialize();
		
		vAPAI  = getVariableReference( "vAPAI" ).getVariable();
		vRPAP  = getVariableReference( "vRPAP" ).getVariable();
		vAIRI  = getVariableReference( "vAIRI" ).getVariable();
		vRPRI  = getVariableReference( "vRPRI" ).getVariable();

		v      = getVariableReference( "v" ).getVariable();

		pRI  = getVariableReference( "pRI" ).getVariable();
		pRP  = getVariableReference( "pRP" ).getVariable();
		pAP  = getVariableReference( "pAP" ).getVariable();
		pAI  = getVariableReference( "pAI" ).getVariable();

		vCU = getVariableReference( "vCU" ).getVariable();
		vUCaU = getVariableReference( "vUCaU" ).getVariable();
		vCCaUCa = getVariableReference( "vCCaUCa" ).getVariable();
		vCCaC = getVariableReference( "vCCaC" ).getVariable();

		Cai  = getVariableReference( "Cai" ).getVariable();

		pCCa  = getVariableReference( "pCCa" ).getVariable();
		pU  = getVariableReference( "pU" ).getVariable();
		pUCa  = getVariableReference( "pUCa" ).getVariable();
		pC  = getVariableReference( "pC" ).getVariable();

		dy  = getVariableReference( "dy" ).getVariable();
		y  = getVariableReference( "y" ).getVariable();

		PKA  = getVariableReference( "PKA" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		pOpen  = getVariableReference( "pOpen" ).getVariable();

		CaDiadic  = getVariableReference( "CaDiadic" ).getVariable();

		i  = getVariableReference( "i" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
		Cm  = getVariableReference( "Cm" ).getVariable();

		cNa  = getVariableReference( "cNa" ).getVariable();
		CFNa  = getVariableReference( "CFNa" ).getVariable();

		cK  = getVariableReference( "cK" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();

		cCa  = getVariableReference( "cCa" ).getVariable();
		CFCa  = getVariableReference( "CFCa" ).getVariable();

		I  = getVariableReference( "I" ).getVariable();


		if ( amplitudePKAf == 0.0 ) {
		
			// kuzumoto model
			_delta = 1.0 + pow( KmPKA / PKA->getMolarConc(), hill_n );
			_PKA_factor0 = 1.0 - MAX / _delta;
			_Vshift0 = -15.0 / _delta;

		} else {
			// himeno model
			_powKmPKAn = pow( KmPKA * 1000.0, hill_n );
		}
	}

	virtual void fire()
	{

		if ( amplitudePKAf == 0.0 ) {
		
			// kuzumoto model
			_delta = 1.0 + pow( KmPKA / PKA->getMolarConc(), hill_n );
			_PKA_factor = MAX / _delta + _PKA_factor0;
			_Vshift = 15.0 / _delta + _Vshift0;

		} else {
			// himeno model
			_delta = pow(( PKA->getMolarConc() - PKA0 ) * 1000.0, hill_n);
			_PKA_factor = amplitudePKAf * MAX * _delta / ( _delta + _powKmPKAn ) + 1.0;
			_Vshift = amplitudePKAf * 62.5 * _delta / (_delta + _powKmPKAn );
		}
		
		// Voltage Gate

		_Vm = v->getValue() + _Vshift;

		_pRI   = 1.0 - pRP->getValue() - pAP->getValue() - pAI->getValue();

		_kRPAP = 1.0 / ( 0.27      * exp( _Vm / -5.9 ) + 1.5  * exp( _Vm /  -65.0 ));
		_kAPRP = 1.0 / ( 480.0     * exp( _Vm /  7.0 ) + 2.2  * exp( _Vm /   65.0 ));
		_kAIRI = 1.0 / ( 2200000.0 * exp( _Vm /  7.4 ) + 11.0 * exp( _Vm /  100.0 ));
		_kRIAI = 1.0 / ( 0.0018    * exp( _Vm / -7.4 ) + 2.0  * exp( _Vm / -100.0 ));
		_kRPRI = 0.04 / (1.0 + kAIAP * _kAPRP * _kRIAI / kAPAI / _kRPAP / _kAIRI );

		vRPAP->setValue( _kRPAP * pRP->getValue() - _kAPRP * pAP->getValue() );
		vAPAI->setValue( kAPAI * pAP->getValue() - kAIAP * pAI->getValue() );
		vAIRI->setValue( _kAIRI * pAI->getValue() - _kRIAI * _pRI );
		vRPRI->setValue( _kRPRI * pRP->getValue() - ( 0.04 - _kRPRI ) * _pRI );

		pRI->setValue( _pRI );


		// Ca2+ Gate

		_CaEffC = ( Cai->getMolarConc() * 1000.0 - 0.3 * 0.0676 * CFCa->getValue() ) * pAP->getValue();

		_kUUCaCa = kUUCa * ( _CaEffC + Cai->getMolarConc() * 1000.0 * ( 1.0 - pAP->getValue()));
		_kCCCaCa = kCCCa * _CaEffC;

		_pCCa = 1.0 - pU->getValue() - pUCa->getValue() - pC->getValue();

		vCU->setValue( kCU * pC->getValue() - kUC * pU->getValue() );
		vUCaU->setValue( kUCaU * pUCa->getValue() - _kUUCaCa * pU->getValue() );
		vCCaUCa->setValue( kCCaUCa * _pCCa - kUCaCCa * pUCa->getValue() );
		vCCaC->setValue( kCCaC * _pCCa - _kCCCaCa * pC->getValue() );

		pCCa->setValue( _pCCa );


		// Ultra-slow gate

		dy->setValue( ( 1.0 / ( 250000.0 * exp( _Vm / 9.0 ) + 58.0 * exp( _Vm / 65.0 ))) * ( 1.0 - y->getValue()) - ( 1.0 / ( 1800.0 * exp( _Vm / -14.0 ) + 66.0 * exp( _Vm / -65.0 ))) * y->getValue() );


		// Ionic Current

		_pOpen = pAP->getValue() * ( pU->getValue() + pUCa->getValue() ) * y->getValue() * ( 1.0 / ( 1.0 + pow( 1.4e-3 / ATP->getMolarConc(), 3.0 ))) * _PKA_factor;
		_i = GX->getValue() * _pOpen * Cm->getValue();
		_cNa = permeabilityNa * CFNa->getValue() * _i;
		_cK  = permeabilityK  * CFK->getValue()  * _i;
		_cCa = permeabilityCa * CFCa->getValue() * _i;

		pOpen->setValue( _pOpen );
		CaDiadic->setValue( 0.0676 * CFCa->getValue() * _pOpen );
		i->setValue( _i );
		cNa->setValue( _cNa );
		cK->setValue( _cK );
		cCa->setValue( _cCa );

		I->setValue( _cNa + _cK + _cCa );
	}

 protected:

	Variable* vAPAI;
	Variable* vRPAP;
	Variable* vAIRI;
	Variable* vRPRI;

	Variable* v;

	Variable* pRP;
	Variable* pRI;
	Variable* pAP;
	Variable* pAI;

	Variable* vCU;
	Variable* vUCaU;
	Variable* vCCaUCa;
	Variable* vCCaC;

	Variable* Cai;

	Variable* pCCa;
	Variable* pU;
	Variable* pUCa;
	Variable* pC;

	Variable* dy;
	Variable* y;

	Variable* PKA;
	Variable* ATP;
	Variable* pOpen;
	Variable* CaDiadic;
	Variable* i;
	Variable* GX;
	Variable* Cm;
	Variable* cNa;
	Variable* CFNa;
	Variable* cK;
	Variable* CFK;
	Variable* cCa;
	Variable* CFCa;
	Variable* I;


	Real kAPAI;
	Real kAIAP;

	Real kUUCa;
	Real kCCCa;

	Real kCU;
	Real kUC;
	Real kUCaU;
	Real kCCaUCa;
	Real kUCaCCa;
	Real kCCaC;

	Real PKA0;
	Real KmPKA;
	Real hill_n;
	Real MAX;
	Real PKA_factor0;

	Real permeabilityNa;
	Real permeabilityK;
	Real permeabilityCa;

	Real kSingleCurrentAmp;
	Real amplitudePKAf;

 private:

	Real _Vm;
	Real _kRPAP;
	Real _kAPRP;
	Real _kAIRI;
	Real _kRIAI;
	Real _kRPRI;
	Real _pRI;

	Real _CaEffC;

	Real _kUUCaCa;
	Real _kCCCaCa;

	Real _pCCa;

	Real _pOpen;
	Real _i;
	Real _cNa;
	Real _cK;
	Real _cCa;

	Real _PKA_factor0;
	Real _PKA_factor;
	Real _Vshift;
	Real _Vshift0;
	Real _delta;
	Real _powKmPKAn;
};

LIBECS_DM_INIT( ICaLAssignmentProcess, Process );

