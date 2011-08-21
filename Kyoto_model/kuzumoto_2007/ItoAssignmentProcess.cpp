#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ItoAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ItoAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityK );
		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
	}
	
	ItoAssignmentProcess()
		:
		permeabilityK( 2.5E-4 ),
		permeabilityNa( 2.25E-5 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	
	virtual void initialize()
	{
		Process::initialize();
		
		Vm = getVariableReference( "Vm" ).getVariable();
		dy1     = getVariableReference( "dy1" ).getVariable();
		dy2     = getVariableReference( "dy2" ).getVariable();
		y1     = getVariableReference( "y1" ).getVariable();
		y2     = getVariableReference( "y2" ).getVariable();
		pOpen  = getVariableReference( "pOpen" ).getVariable();
		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();
		cK     = getVariableReference( "cK" ).getVariable();
		CFK    = getVariableReference( "CFK" ).getVariable();
		cNa    = getVariableReference( "cNa" ).getVariable();
		CFNa   = getVariableReference( "CFNa" ).getVariable();
		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{
		_v  = Vm->getValue();
		_y1 = y1->getValue();
		_y2 = y2->getValue();

		dy1->setValue( ( 1.0 / ( 11.0 * exp( _v / -28.0 ) + 0.2 * exp( _v / -400.0 ))) * ( 1.0 - _y1 ) - ( 1.0 / ( 4.4 * exp( _v / 16.0 ) + 0.2 * exp( _v / 500.0 ))) * _y1 );
		dy2->setValue( (( 0.0038 * exp(-( _v + 13.5 ) / 11.3 ) / ( 1.0 + 0.051335 * exp( -( _v + 13.5 ) / 11.3))) * ( 1.0 - _y2 ) - ( 0.0038 * exp(( _v +13.5) / 11.3 ) / ( 1.0 + 0.067083 * exp(( _v + 13.5) / 11.3 ))) * _y2 ) );


		_pOpen = _y1 * _y1 * _y1 * _y2;
		pOpen->setValue( _pOpen );

		_i = GX->getValue() * _pOpen * Cm->getValue();
		i->setValue( _i );

		_cK  = permeabilityK * CFK->getValue() * _i;
		_cNa = permeabilityNa * CFNa->getValue() * _i;

		cK->setValue( _cK );
		cNa->setValue( _cNa );
		I->setValue( _cK + _cNa );
	}

 protected:

	Variable* Vm;
	Variable* dy1;
	Variable* dy2;
	Variable* y1;
	Variable* y2;
	Variable* pOpen;
	Variable* i;
	Variable* GX;
	Variable* Cm;
	Variable* cK;
	Variable* CFK;
	Variable* cNa;
	Variable* CFNa;
	Variable* I;

	Real permeabilityK;
	Real permeabilityNa;

 private:

	Real _v;
	Real _y1;
	Real _y2;
	Real _pOpen;
	Real _i;
	Real _cK;
	Real _cNa;

};

LIBECS_DM_INIT( ItoAssignmentProcess, Process );

