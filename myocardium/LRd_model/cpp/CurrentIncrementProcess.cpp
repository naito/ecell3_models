#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( CurrentIncrementProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( CurrentIncrementProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, n );
	}
	
	CurrentIncrementProcess(): n( 1.0 )
	{
		// do nothing
	}
	
	SIMPLE_SET_GET_METHOD( Real, n );

	virtual void initialize()
	{
		Process::initialize();
		
		total  = getVariableReference( "total"  ).getVariable();
		c = getVariableReference( "c" ).getVariable();

	}

	virtual void fire()
	{
		total->setValue( total->getValue() + n * c->getValue() );
	}

 protected:

	Variable* total;
	Variable* c;

	Real n;

};

LIBECS_DM_INIT( CurrentIncrementProcess, Process );

