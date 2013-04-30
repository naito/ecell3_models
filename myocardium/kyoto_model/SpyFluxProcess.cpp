#include "libecs.hpp"
#include "SpyContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SpyFluxProcess, SpyContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( SpyFluxProcess, Process )
	{
		INHERIT_PROPERTIES( SpyContinuousProcess ); 

		PROPERTYSLOT_SET_GET( Real,   k );
		PROPERTYSLOT_SET_GET( String, target );

	}
	
	SpyFluxProcess()
		:
		k( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real,   k );
	SIMPLE_SET_GET_METHOD( String, target );

	virtual void initialize()
	{
		Process::initialize();

	}

	virtual void fire()
	{
		setFlux( getPropertyValue( target ) * k );
	}

 protected:
	Real   k;
	String target;

};

LIBECS_DM_INIT( SpyFluxProcess, Process );

