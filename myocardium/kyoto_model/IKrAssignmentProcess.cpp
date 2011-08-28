#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKrAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKrAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, amplitude );
		PROPERTYSLOT_SET_GET( Real, constant );
		PROPERTYSLOT_SET_GET( Real, power );
	}
	
	IKrAssignmentProcess()
		:
		amplitude( 0.035 ),
		constant( 5.4 ),
		power( 0.2 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, amplitude );
	SIMPLE_SET_GET_METHOD( Real, constant );
	SIMPLE_SET_GET_METHOD( Real, power );
	
	virtual void initialize()
	{
		Process::initialize();
		
		dy1   = getVariableReference( "dy1" ).getVariable();
		dy2   = getVariableReference( "dy2" ).getVariable();
		dy3   = getVariableReference( "dy3" ).getVariable();
		y1    = getVariableReference( "y1" ).getVariable();
		y2    = getVariableReference( "y2" ).getVariable();
		y3    = getVariableReference( "y3" ).getVariable();
		pOpen = getVariableReference( "pOpen" ).getVariable();
		I     = getVariableReference( "I" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();
		Ko    = getVariableReference( "Ko" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();
		Vm    = getVariableReference( "Vm" ).getVariable();
		Cm    = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_v = Vm->getValue();

		dy1->setValue( ( 1.0 / (20.0 * exp( _v / -11.5 ) + 5.0 * exp( _v / -300.0 )) ) * ( 1.0 - y1->getValue() ) - ( 1.0 / ( 160.0 * exp( _v / 28.0 ) + 200.0 * exp( _v / 1000.0 )) + 1.0 / ( 2500.0 * exp( _v / 20.0 ))) * y1->getValue() );
		dy2->setValue( (( 1.0 / ( 200.0 * exp( _v / -13.0) + 20.0 * exp( _v / -300.0 ))) * ( 1.0 - y2->getValue() ) - ( 1.0 / ( 1600.0 * exp( _v / 28.0 ) + 2000.0 * exp( _v / 1000.0 )) + 1.0 / ( 10000.0 * exp( _v / 20.0 ))) * y2->getValue() ) );
		dy3->setValue( ( 1.0 / ( 10.0 * exp( _v / 17.0 ) + 2.5 * exp( _v / 300.0 ))) * ( 1.0 - y3->getValue() ) - ( 1.0 / ( 0.35 * exp( _v / -17.0 ) + 2.0 * exp( _v / -150.0 ))) * y3->getValue() );

		_pOpen = ( 0.6 * y1->getValue() + 0.4 * y2->getValue() ) * y3->getValue();
		pOpen->setValue( _pOpen );
		I->setValue( GX->getValue() * ( amplitude * pow(( Ko->getMolarConc() * 1000.0 / constant ), power )) * ( _v - EK->getValue() ) * Cm->getValue() * _pOpen );
	}

 protected:

	Variable* dy1;
	Variable* dy2;
	Variable* dy3;
	Variable* y1;
	Variable* y2;
	Variable* y3;
	Variable* pOpen;
	Variable* I;
	Variable* GX;
	Variable* Ko;
	Variable* EK;
	Variable* Vm;
	Variable* Cm;

	Real amplitude;
	Real constant;
	Real power;

 private:

	Real _v;
	Real _pOpen;

};

LIBECS_DM_INIT( IKrAssignmentProcess, Process );

