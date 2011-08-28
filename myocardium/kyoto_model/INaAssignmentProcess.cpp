#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( INaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( INaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, kAIAP );

		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
	}
	
	INaAssignmentProcess()
		:
		kAIAP( 0.0000875 ),

		permeabilityNa( 21.666666666667 ),
		permeabilityK( 2.1666666666667 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, kAIAP );

	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	
	virtual void initialize()
	{
		Process::initialize();
		
		vRPAP  = getVariableReference( "vRPAP" ).getVariable();
		vAPAI  = getVariableReference( "vAPAI" ).getVariable();
		vAIRI  = getVariableReference( "vAIRI" ).getVariable();
		vRPRI  = getVariableReference( "vRPRI" ).getVariable();

		pAP  = getVariableReference( "pAP" ).getVariable();
		pRP  = getVariableReference( "pRP" ).getVariable();
		pAI  = getVariableReference( "pAI" ).getVariable();
		pRI  = getVariableReference( "pRI" ).getVariable();

		v  = getVariableReference( "v" ).getVariable();

		dy  = getVariableReference( "dy" ).getVariable();
		y  = getVariableReference( "y" ).getVariable();

		pOpen  = getVariableReference( "pOpen" ).getVariable();
		i  = getVariableReference( "i" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
		Cm  = getVariableReference( "Cm" ).getVariable();
		cNa  = getVariableReference( "cNa" ).getVariable();
		CFNa  = getVariableReference( "CFNa" ).getVariable();
		cK  = getVariableReference( "cK" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();
		I  = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{
		_Vm = v->getValue();

		_pRI = 1.0 - pRP->getValue() - pAP->getValue() - pAI->getValue();

		_kRPAP = 1.0 / ( 0.1027 * exp( _Vm / -8.0) + 0.25 * exp( _Vm / -50.0 ));
		_kAPRP = 1.0 / ( 26.0 * exp( _Vm / 17.0 ) + 0.02 * exp( _Vm / 800.0 ));
		_kAPAI = 1.0 / ( 0.8 * exp( _Vm / -400.0 ));
		_kAIRI = 1.0 / ( 1300.0 * exp( _Vm / 20.0 ) + 0.04 * exp( _Vm / 800.0 ));
		_kRIAI = 1.0 / ( 0.0001027 * exp( _Vm / -8.0 ) + 5.0 * exp( _Vm / -400.0 ));

		_kRPRI = 0.01 / (1.0 + kAIAP * _kAPRP * _kRIAI / _kAPAI / _kRPAP / _kAIRI );

		vRPAP->setValue( _kRPAP * pRP->getValue() - _kAPRP * pAP->getValue() );
		vAPAI->setValue( _kAPAI * pAP->getValue() -  kAIAP * pAI->getValue() );
		vAIRI->setValue( _kAIRI * pAI->getValue() - _kRIAI * _pRI );
		vRPRI->setValue( _kRPRI * pRP->getValue() - ( 0.01 - _kRPRI ) * _pRI );

		pRI->setValue( _pRI );

		dy->setValue( 1.0 / ( 9000000000.0 * exp( _Vm / 5.0 ) + 8000.0 * exp( _Vm / 100.0 ) ) * ( 1.0 - y->getValue()) - 1.0 / ( 0.014 * exp( _Vm / -5.0 ) + 4000.0 * exp( _Vm / -100.0 ) ) * y->getValue() );

		_pOpen = pAP->getValue() * y->getValue();
		pOpen->setValue( _pOpen );

		_i = GX->getValue() * _pOpen * Cm->getValue();
		i->setValue( _i );

		_cNa = permeabilityNa * CFNa->getValue() * _i;
		_cK  = permeabilityK  * CFK->getValue()  * _i;

		cNa->setValue( _cNa );
		cK->setValue( _cK );

		I->setValue( _cNa + _cK );
	}

 protected:

	Variable* vRPAP;
	Variable* vAPAI;
	Variable* vAIRI;
	Variable* vRPRI;

	Variable* pAP;
	Variable* pRP;
	Variable* pAI;
	Variable* pRI;

	Variable* v;

	Variable* dy;
	Variable* y;

	Variable* pOpen;
	Variable* i;
	Variable* GX;
	Variable* Cm;
	Variable* cNa;
	Variable* CFNa;
	Variable* cK;
	Variable* CFK;
	Variable* I;

	Real kAIAP;

	Real permeabilityNa;
	Real permeabilityK;

 private:
	Real _Vm;

	Real _pRI;
	Real _kAPAI;
	Real _kAPRP;
	Real _kRPAP;
	Real _kAIRI;
	Real _kRIAI;
	Real _kRPRI;
	Real _kRIRP;

	Real _pOpen;
	Real _i;
	Real _cNa;
	Real _cK;

};

LIBECS_DM_INIT( INaAssignmentProcess, Process );

