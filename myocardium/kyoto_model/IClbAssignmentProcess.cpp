#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IClbAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IClbAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityCl );
		PROPERTYSLOT_SET_GET( Real, pOpen );
	}
	
	IClbAssignmentProcess()
		:
		permeabilityCl( -1.82E-5 ),
		pOpen( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityCl );
	SIMPLE_SET_GET_METHOD( Real, pOpen );

	virtual void initialize()
	{
		Process::initialize();

		Cm   = getVariableReference( "Cm" ).getVariable();
		CFCl = getVariableReference( "CFCl" ).getVariable();
		I    = getVariableReference( "I" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();

		_I = permeabilityCl * pOpen;
	}

	virtual void fire()
	{
		I->setValue( GX->getValue() * _I * CFCl->getValue() * Cm->getValue() );

	}

 protected:

	Variable* Cm;
	Variable* CFCl;
	Variable* I;
	Variable* GX;

	Real permeabilityCl;
	Real pOpen;

 private:

	Real _I;
};

LIBECS_DM_INIT( IClbAssignmentProcess, Process );

