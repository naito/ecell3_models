#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( EnvironmentAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( EnvironmentAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
	}
	
	EnvironmentAssignmentProcess()
	{
		// do nothing
	}

	virtual void initialize()
	{
		Process::initialize();
		
		TotalIon  = getVariableReference( "TotalIon" ).getVariable();
		Na  = getVariableReference( "Na" ).getVariable();
		K  = getVariableReference( "K" ).getVariable();
		Cl  = getVariableReference( "Cl" ).getVariable();
		Ca  = getVariableReference( "Ca" ).getVariable();
		LA  = getVariableReference( "LA" ).getVariable();
	}

	virtual void fire()
	{
		TotalIon->setValue( Na->getValue() + K->getValue() + Cl->getValue() + Ca->getValue() + LA->getValue() );
	}

 protected:

	Variable* TotalIon;
	Variable* Na;
	Variable* K;
	Variable* Cl;
	Variable* Ca;
	Variable* LA;
};

LIBECS_DM_INIT( EnvironmentAssignmentProcess, Process );

