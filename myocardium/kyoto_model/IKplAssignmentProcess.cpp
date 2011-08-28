#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKplAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKplAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, amplitude );
		PROPERTYSLOT_SET_GET( Real, constant );
		PROPERTYSLOT_SET_GET( Real, power );
		PROPERTYSLOT_SET_GET( Real, pOpen );
	}
	
	IKplAssignmentProcess()
		:
		amplitude( 8.333E-7 ),
		constant( 5.4 ),
		power( 0.16 ),
		pOpen( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, amplitude );
	SIMPLE_SET_GET_METHOD( Real, constant );
	SIMPLE_SET_GET_METHOD( Real, power );
	SIMPLE_SET_GET_METHOD( Real, pOpen );

	virtual void initialize()
	{
		Process::initialize();

		I      = getVariableReference( "I" ).getVariable();
		GX      = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();
		Vm  = getVariableReference( "Vm" ).getVariable();
		Ko  = getVariableReference( "Ko" ).getVariable();
		CFK    = getVariableReference( "CFK" ).getVariable();
	}

	virtual void fire()
	{
		_Vm = Vm->getValue();

		_Veff = ( _Vm == -3.0 ) ? 13.0077 : (( _Vm + 3.0 ) / ( 1.0 - exp( - ( _Vm + 3.0 ) / 13.0 )));

		I->setValue( GX->getValue() * ( amplitude * pow(( Ko->getMolarConc() * 1000.0 / constant ), power )) * _Veff * CFK->getValue() * pOpen * Cm->getValue() );

	}

 protected:

	Variable* I;
	Variable* GX;
	Variable* Cm;
	Variable* Vm;
	Variable* Ko;
	Variable* CFK;

	Real amplitude;
	Real constant;
	Real power;
	Real pOpen;

 private:

	Real _Vm;
	Real _Veff;
};

LIBECS_DM_INIT( IKplAssignmentProcess, Process );

