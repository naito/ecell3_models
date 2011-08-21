#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IbNSCAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IbNSCAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
		PROPERTYSLOT_SET_GET( Real, pOpen );
	}
	
	IbNSCAssignmentProcess()
		:
		permeabilityNa( 5.69E-4 ),
		permeabilityK( 2.276E-4 ),
		pOpen( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	SIMPLE_SET_GET_METHOD( Real, pOpen );

	virtual void initialize()
	{
		Process::initialize();

		Cm   = getVariableReference( "Cm" ).getVariable();
		cNa  = getVariableReference( "cNa" ).getVariable();
		CFNa = getVariableReference( "CFNa" ).getVariable();
		cK   = getVariableReference( "cK" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();
		I    = getVariableReference( "I" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
		_cNa = GX->getValue() * permeabilityNa * CFNa->getValue() * pOpen * Cm->getValue();
		_cK  = GX->getValue() * permeabilityK  * CFK->getValue() * pOpen * Cm->getValue();

		cNa->setValue( _cNa );
		cK->setValue( _cK );
		I->setValue( _cNa + _cK );

	}

 protected:

	Variable* i;
	Variable* Cm;
	Variable* cNa;
	Variable* CFNa;
	Variable* cK;
	Variable* CFK;
	Variable* I;
	Variable* GX;

	Real permeabilityNa;
	Real permeabilityK;
	Real pOpen;

 private:

	Real _cNa;
	Real _cK;
};

LIBECS_DM_INIT( IbNSCAssignmentProcess, Process );

