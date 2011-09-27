#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ApplyCurrentProcess, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( ApplyCurrentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
	}
	
	ApplyCurrentProcess()
	{
		// do nothing
	}
		
	virtual void initialize()
	{
		Process::initialize();
		
		I  = getVariableReference( "I"  ).getVariable();
		Cm = getVariableReference( "Cm" ).getVariable();

	}

	virtual void fire()
	{
		setFlux( - I->getValue() / Cm->getValue() );
	}

 protected:

	Variable* I;
	Variable* Cm;

};

LIBECS_DM_INIT( ApplyCurrentProcess, Process );

