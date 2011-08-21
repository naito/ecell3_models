#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ZeroOrderFluxProcess, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( ZeroOrderFluxProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, k );
	}
	
	ZeroOrderFluxProcess()
		:
		k( 0.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, k );

	virtual void initialize()
	{
		Process::initialize();
	}

	virtual void fire()
	{
		setFlux( k );
	}

 protected:

	Real k;
};

LIBECS_DM_INIT( ZeroOrderFluxProcess, Process );

