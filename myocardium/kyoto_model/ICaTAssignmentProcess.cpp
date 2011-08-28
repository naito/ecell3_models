#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ICaTAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ICaTAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityCa );
	}
	
	ICaTAssignmentProcess()
		:
		permeabilityCa( 4.636 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityCa );
	
	virtual void initialize()
	{
		Process::initialize();
		
		v     = getVariableReference( "v" ).getVariable();
		dy1   = getVariableReference( "dy1" ).getVariable();
		dy2   = getVariableReference( "dy2" ).getVariable();
		y1    = getVariableReference( "y1"    ).getVariable();
		y2    = getVariableReference( "y2"    ).getVariable();
		pOpen = getVariableReference( "pOpen" ).getVariable();
		GX    = getVariableReference( "GX"    ).getVariable();
		Cm    = getVariableReference( "Cm"    ).getVariable();
		CFCa  = getVariableReference( "CFCa"  ).getVariable();
		I     = getVariableReference( "I"     ).getVariable();
	}

	virtual void fire()
	{
		_v = v->getValue();

		dy1->setValue( ( 1.0 / (0.019 * exp( _v / -5.6 ) + 0.82 * exp( _v / -250.0 )) ) * ( 1.0 - y1->getValue() ) - ( 1.0 / ( 40.0 * exp( _v / 6.3 ) + 1.5 * exp( _v / 10000.0 ))) * y1->getValue() );
		dy2->setValue( (( 1.0 / ( 62000.0 * exp( _v / 10.1) + 30.0 * exp( _v / 3000.0 ))) * ( 1.0 - y2->getValue() ) - ( 1.0 / ( 0.0006 * exp( _v / -6.7 ) + 1.2 * exp( _v / -25.0 ))) * y2->getValue() ) );

		_pOpen = y1->getValue() * y2->getValue();
		pOpen->setValue( _pOpen );
		I->setValue( GX->getValue() * permeabilityCa * CFCa->getValue() * _pOpen * Cm->getValue() );
	}

 protected:

	Variable* v;
	Variable* dy1;
	Variable* dy2;
	Variable* y1;
	Variable* y2;
	Variable* pOpen;
	Variable* GX;
	Variable* Cm;
	Variable* CFCa;
	Variable* I;

	Real permeabilityCa;

 private:

	Real _v;
	Real _pOpen;

};

LIBECS_DM_INIT( ICaTAssignmentProcess, Process );

