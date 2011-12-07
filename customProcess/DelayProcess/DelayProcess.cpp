#include <boost/shared_ptr.hpp>

#include "libecs.hpp"
#include "Process.hpp"

#include "Model.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( DelayProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( DelayProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, tau );
		PROPERTYSLOT_SET_GET( String, targetProperty );
	}
	
	DelayProcess()
		:
		tau( 0.0 ),
		targetProperty( "Value" )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, tau );
	SIMPLE_SET_GET_METHOD( String, targetProperty );

	// FullPN _o_FullPN( (String)"System::/:Size" );
	
	virtual void initialize()
	{
		Process::initialize();
		
		o = getVariableReference( "original" ).getVariable();
		d = getVariableReference( "delayed" ).getVariable();

		getModel()->getLoggerBroker().createLogger( 
			FullPN( o->getFullID(), targetProperty ), 
			Logger::Policy() 
		);

		//_o_FullPN = FullPN( o->getFullID(), targetProperty );

	}

	virtual void fire()
	{
		_t = getModel()->getCurrentTime();

		if ( _t <= tau ) {
			_theDataSlice = getModel()->getLoggerBroker().
				getLogger( FullPN( o->getFullID(), targetProperty ) )->
				getData();
		} else {
			_theDataSlice = getModel()->getLoggerBroker().
				getLogger( FullPN( o->getFullID(), targetProperty ) )->
				getData( _t - tau, _t );
		}

		d->setValue( _theDataSlice->asShort( 0 ).getValue());
	}

 protected:

	Variable* o;
	Variable* d;

	Real tau;
	String targetProperty;

 private:
	
	Real _t;
	boost::shared_ptr< DataPointVector > _theDataSlice;
};

LIBECS_DM_INIT( DelayProcess, Process );

