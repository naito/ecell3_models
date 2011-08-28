#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ICabAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ICabAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityCa );
		PROPERTYSLOT_SET_GET( Real, pOpen );
	}
	
	ICabAssignmentProcess()
		:
		permeabilityCa( 3.03E-4 ),
		pOpen( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityCa );
	SIMPLE_SET_GET_METHOD( Real, pOpen );

	virtual void initialize()
	{
		Process::initialize();

		Cm   = getVariableReference( "Cm" ).getVariable();
		CFCa = getVariableReference( "CFCa" ).getVariable();
		I    = getVariableReference( "I" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();

		_I = permeabilityCa * pOpen;
	}

	virtual void fire()
	{
		I->setValue( GX->getValue() * _I * CFCa->getValue() * Cm->getValue() );

	}

 protected:

	Variable* Cm;
	Variable* CFCa;
	Variable* I;
	Variable* GX;

	Real permeabilityCa;
	Real pOpen;

 private:

	Real _I;
};

LIBECS_DM_INIT( ICabAssignmentProcess, Process );

