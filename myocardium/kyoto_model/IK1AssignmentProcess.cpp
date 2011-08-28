#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IK1AssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IK1AssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, Phi );
		PROPERTYSLOT_SET_GET( Real, amplitude );
		PROPERTYSLOT_SET_GET( Real, constant );
		PROPERTYSLOT_SET_GET( Real, power );
		PROPERTYSLOT_SET_GET( Real, A );
		PROPERTYSLOT_SET_GET( Real, B );
	}
	
	IK1AssignmentProcess()
		:
		Phi( 0.9 ),
		amplitude( 2.6 ),
		constant( 5.4 ),
		power( 0.6 ),
		A( -0.6 ),
		B( 3.1 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, Phi );
	SIMPLE_SET_GET_METHOD( Real, amplitude );
	SIMPLE_SET_GET_METHOD( Real, constant );
	SIMPLE_SET_GET_METHOD( Real, power );
	SIMPLE_SET_GET_METHOD( Real, A );
	SIMPLE_SET_GET_METHOD( Real, B );
	
	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();
		Mg    = getVariableReference( "Mg" ).getVariable();
		SPM   = getVariableReference( "SPM" ).getVariable();
		vPspm  = getVariableReference( "vPspm" ).getVariable();
		Pspm  = getVariableReference( "Pspm" ).getVariable();
		fracO = getVariableReference( "fracO" ).getVariable();

		pOpen = getVariableReference( "pOpen" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();
		Ko    = getVariableReference( "Ko" ).getVariable();
		Cm    = getVariableReference( "Cm" ).getVariable();
		I     = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{
		_v       = Vm->getValue() - EK->getValue();
		_vmg     = _v + 8000.0 * Mg->getMolarConc();
		_alphaMg = 12.0 * exp( -0.025 * _v );

		_fracO = _alphaMg / ( _alphaMg + ( Mg->getMolarConc() * 28.0e+3 * exp( 0.025 * _v )));
		_fracB = 1.0 - _fracO;

		_pOpen = Phi * ( 1.0 - Pspm->getValue() ) * ( ( _fracO * _fracO * _fracO ) + 2.0 / 3.0 * ( 3.0 * _fracO * _fracO * _fracB ) + 1.0 / 3.0 * ( 3.0 * _fracO * _fracB * _fracB )) + (1.0 - Phi) / (1.0 + ( SPM->getMolarConc() * 1.0e+6 ) / ( 40.0 * exp( -( Vm->getValue() - EK->getValue()) / 9.1 ) ));

		vPspm->setValue( ( SPM->getMolarConc() * 1.0e+6 * 0.28 * exp( 0.15 * _vmg ) / ( 1.0 + 0.01 * exp( 0.13 * _vmg ))) * ( 1.0 - Pspm->getValue() ) * ( _fracO * _fracO * _fracO ) - ( 0.17 * exp( -0.07 * _vmg ) / ( 1.0 + 0.01 * exp( 0.12 * _vmg ))) * Pspm->getValue() );
		fracO->setValue( _fracO );
		pOpen->setValue( _pOpen );
		I->setValue( ( GX->getValue() * amplitude * pow(( Ko->getMolarConc() * 1000.0 / constant ), power ) / ( 1.0 + exp(( Ko->getMolarConc() * 1000.0 - B ) / A ))) * ( Vm->getValue() - EK->getValue() ) * Cm->getValue() * _pOpen );
	}

 protected:

	Variable* Vm;
	Variable* EK;
	Variable* Mg;
	Variable* SPM;
	Variable* vPspm;
	Variable* Pspm;
	Variable* fracO;
	Variable* pOpen;
	Variable* GX;
	Variable* Ko;
	Variable* Cm;
	Variable* I;

	Real Phi;
	Real amplitude;
	Real constant;
	Real power;
	Real A;
	Real B;

 private:

	Real _v;
	Real _vmg;
	Real _alphaMg;

	Real _fracO;
	Real _fracB;
	Real _pOpen;

};

LIBECS_DM_INIT( IK1AssignmentProcess, Process );

