#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKATPAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKATPAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, amplitude );
		PROPERTYSLOT_SET_GET( Real, number );
		PROPERTYSLOT_SET_GET( Real, constant );
		PROPERTYSLOT_SET_GET( Real, power );
		PROPERTYSLOT_SET_GET( Real, Cm0 );
	}
	
	IKATPAssignmentProcess()
		:
		amplitude( 0.0236 ),
		number( 1.0 ),
		constant( 1.0e-3 ),
		power( 0.24 ),
		Cm0( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, amplitude );
	SIMPLE_SET_GET_METHOD( Real, number );
	SIMPLE_SET_GET_METHOD( Real, constant );
	SIMPLE_SET_GET_METHOD( Real, power );
	SIMPLE_SET_GET_METHOD( Real, Cm0 );

	virtual void initialize()
	{
		Process::initialize();

		ATPi    = getVariableReference( "ATPi" ).getVariable();
		pOpen    = getVariableReference( "pOpen" ).getVariable();
		I      = getVariableReference( "I" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
		Ko  = getVariableReference( "Ko" ).getVariable();
		EK  = getVariableReference( "EK" ).getVariable();
		Vm  = getVariableReference( "Vm" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		//Cm0 = Cm->getValue();
	}

	virtual void fire()
	{
		_pOpen = 0.8 / ( 1.0 + pow(( ATPi->getMolarConc() / 0.0001 ), 2.0 ));
		pOpen->setValue( _pOpen );
		I->setValue( GX->getValue() * ( number * ( amplitude * pow(( Ko->getMolarConc() / constant), power )) / Cm0 ) * ( Vm->getValue() - EK->getValue() ) * Cm->getValue() * _pOpen );

	}

 protected:

	Variable* ATPi;
	Variable* pOpen;
	Variable* I;
	Variable* GX;
	Variable* Ko;
	Variable* EK;
	Variable* Vm;
	Variable* Cm;

	Real amplitude;
	Real number;
	Real constant;
	Real power;
	Real Cm0;

 private:

	Real _pOpen;
};

LIBECS_DM_INIT( IKATPAssignmentProcess, Process );

