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
		
		target = getVariableReference( "target" ).getVariable();
		flag   = getVariableReference( "flag" ).getVariable();

		_rockOn = false;
		_nextFire = 0.0;
		_lastValue = target->getValue();
	}

	virtual void fire()
	{
		_t = getModel()->getCurrentTime();

		if ( _rockOn == false ) {
			if ( flag->getValue() == 1.0 ) flag->setValue( 0.0 );

			if ( isFromBelow == 1 ) {
				if ((target->getValue() >= threshold) && ( _lastValue < threshold)) {
					_rockOn = true;
					_nextFire = _t + delay;
				}
			} else {
				if ((target->getValue() <= threshold) && ( _lastValue > threshold)) {
					_rockOn = true;
					_nextFire = _t + delay;
				}
			}
		}

		if (( _rockOn == true ) && ( _t >= _nextFire )) {
			flag->setValue( 1.0 );
			_rockOn = false;
		}

		_lastValue = target->getValue();

	}

 protected:

	Variable* target;
	Variable* flag;

	Real    delay;
	Real    threshold;
	Integer isFromBelow;
	String  targetProperty;

 private:
	
	bool _rockOn;
	Real _t;
	Real _nextFire;
	Real _lastValue;
};

LIBECS_DM_INIT( CrossFireProcess, Process );

