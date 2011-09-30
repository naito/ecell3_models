#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SRleakDiffusionAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( SRleakDiffusionAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityCa );
	}
	
	SRleakDiffusionAssignmentProcess()
		:
		permeabilityCa( 0.3e+3 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityCa );
	
	virtual void initialize()
	{
		Process::initialize();
		
		I    = getVariableReference( "I" ).getVariable();
		SR_f = getVariableReference( "SR_f" ).getVariable();
		act = getVariableReference( "act" ).getVariable();
		Cai = getVariableReference( "Cai" ).getVariable();
		Cao  = getVariableReference( "Cao" ).getVariable();
		Cm   = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		I->setValue( SR_f->getValue() * act->getValue() * permeabilityCa * ( Cao->getMolarConc() - Cai->getMolarConc() ) * Cm->getValue() );
	}
 protected:

	Variable* I;
	Variable* SR_f;
	Variable* act;
	Variable* Cai;
	Variable* Cao;
	Variable* Cm;

	Real permeabilityCa;
};

LIBECS_DM_INIT( SRleakDiffusionAssignmentProcess, Process );

