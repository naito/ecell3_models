#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SRupAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( SRupAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, ratio );
	}
	
	SRupAssignmentProcess()
		:
		ratio( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, ratio );
	
	virtual void initialize()
	{
		Process::initialize();
		
		volume = getVariableReference( "volume" ).getVariable();
		total     = getVariableReference( "total" ).getVariable();
	}

	virtual void fire()
	{
		volume->setValue( total->getValue() * ratio );
	}

 protected:

	Variable* volume;
	Variable* total;

	Real ratio;
};

LIBECS_DM_INIT( SRupAssignmentProcess, Process );

