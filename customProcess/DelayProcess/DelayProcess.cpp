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
	}
	
	DelayProcess()
		:
		tau( 0.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, tau );
	
	virtual void initialize()
	{
		Process::initialize();

		getModel()->getLoggerBroker().createLogger( 
			FullPN( "Variable:/:t:Value" ), 
			Logger::Policy() 
		);
		
		o = getVariableReference( "original" ).getVariable();
		d = getVariableReference( "delayed" ).getVariable();

		// Real t = getModel()->getCurrentTime();

		/*
		if ( onset >= t->getValue() ) {
		
			_nextOnset = onset;
		
		} else {

			_nextOnset = onset + floor( ( t->getValue() - onset ) / interval ) * interval;
		}

		_nextOffset = _nextOnset + offset - onset;
		*/
	}

	virtual void fire()
	{
		_t = getModel()->getCurrentTime();

		//Logger* theLogger = getModel()->getLoggerBroker().getLogger( 
		//	FullPN( "Variable:/:t:Value" ));

		if ( _t <= tau ) {

			_theDataSlice = getModel()->getLoggerBroker().getLogger( 
				FullPN( "Variable:/:t:Value" )
				)->getData();

		} else {

			_theDataSlice = getModel()->getLoggerBroker().getLogger( 
				FullPN( "Variable:/:t:Value" )
				)->getData( _t - tau, _t );

		}

		d->setValue( _t );
	}

 protected:

	Variable* o;
	Variable* d;

	Real tau;

	//LoggerBroker& theLoggerBroker;
	//Logger* const theLogger;


 private:
	
	Real _t;
	boost::shared_ptr< DataPointVector > _theDataSlice;
};

LIBECS_DM_INIT( DelayProcess, Process );

