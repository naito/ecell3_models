#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKAChAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKAChAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, Km );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
	}
	
	IKAChAssignmentProcess()
		:
		Km( 0.035 ),
		permeabilityK( 0.2 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, Km );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	
	virtual void initialize()
	{
		Process::initialize();
		
		I     = getVariableReference( "I" ).getVariable();
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();
		ACh   = getVariableReference( "ACh" ).getVariable();
		dgate   = getVariableReference( "dgate" ).getVariable();
		gate   = getVariableReference( "gate" ).getVariable();
		pOpen   = getVariableReference( "pOpen" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();
		Cm    = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_v = Vm->getValue();
		_y = gate->getValue();
		dgate->setValue( ( ( ACh->getValue() == 0.0 ) ? 0.0002475 : 0.01232 / (1.0 + Km / ACh->getMolarConc()) + 0.0002475 ) * ( 1.0 - _y ) - 0.01 * exp( 0.0133 * ( _v + 40.0 )) * _y );

		_pOpen = _y / ( 1.0 + exp(( _v + 20.0 ) / 20.0 ));
		pOpen->setValue( _pOpen );

		I->setValue( GX->getValue() * permeabilityK * ( _v - EK->getValue() ) * Cm->getValue() * _pOpen );
	}

 protected:

	Variable* I;
	Variable* Vm;
	Variable* EK;
	Variable* ACh;
	Variable* dgate;
	Variable* gate;
	Variable* pOpen;
	Variable* GX;
	Variable* Cm;

	Real Km;
	Real permeabilityK;

 private:

	Real _v;
	Real _y;
	Real _pOpen;

};

LIBECS_DM_INIT( IKAChAssignmentProcess, Process );

