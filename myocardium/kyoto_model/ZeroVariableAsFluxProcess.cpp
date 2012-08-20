#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ZeroVariableAsFluxProcess, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( ZeroVariableAsFluxProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, k );

	}
	
	ZeroVariableAsFluxProcess():k( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, k );

	virtual void initialize()
	{
		Process::initialize();
		// ZeroVariableの数が不正な時にエラーを吐くようにした方がbetter
	}

	virtual void fire()
	{
		/* DEBUG
		_value = ( *theZeroVariableReferenceIterator ).getVariable()->getValue();
		std::cout << getFullID().asString() << ": " << _value << std::endl;
		setFlux( _value * k );
		*/
		setFlux( ( *theZeroVariableReferenceIterator ).getVariable()->getValue() * k );
	}

 protected:
	Real k;

 private:
	// Real _value;  // DEBUG
};

LIBECS_DM_INIT( ZeroVariableAsFluxProcess, Process );

