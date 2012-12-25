#include "libecs.hpp"
#include "Process.hpp"

#include "Model.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( CrossFireProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( CrossFireProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,    delay );
		PROPERTYSLOT_SET_GET( Real,    threshold );
		PROPERTYSLOT_SET_GET( Integer, isFromBelow );
		PROPERTYSLOT_SET_GET( String,  targetProperty );
	}
	
	CrossFireProcess()
		:
		delay( 0.0 ),
		isFromBelow( 1 ),
		targetProperty( "Value" )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real,    delay );
	SIMPLE_SET_GET_METHOD( Real,    threshold );
	SIMPLE_SET_GET_METHOD( Integer, isFromBelow );
	SIMPLE_SET_GET_METHOD( String,  targetProperty );

	// FullPN _o_FullPN( (String)"System::/:Size" );
	
	virtual void initialize()
	{
		Process::initialize();
		
		o  = getVariableReference( "object" ).getVariable();
		sw = getVariableReference( "switch" ).getVariable();

		rockOn = false;
		nextFire = 0.0
		if ( isFromBelow != 1 ) isFromBelow = -1;

	}

	virtual void fire()
	{
		_t = getModel()->getCurrentTime();

		if ( rockOn == false ) {
			if ((o.getValue() >= threshold) && ( o.getVelocity() * Real(isFromBelow) >= 0.0)) {
				rockOn = true;
				nextFire = _t + delay;
			}
		}

		if (( rockOn == true ) && ( _t >= nextFire )) {
			sw->setValue( 1.0 );
			rockOn = false;
		}

	}

 protected:

	Variable* o;
	Variable* sw;

	Real    delay;
	Real    threshold;
	Integer isFromBelow;
	String  targetProperty;

 private:
	
	std::bool rockOn;
	Real _t;
	Real nextFire;
};

LIBECS_DM_INIT( CrossFireProcess, Process );

