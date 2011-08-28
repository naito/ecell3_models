#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ILCCaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ILCCaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
	}
	
	ILCCaAssignmentProcess()
		:
		permeabilityNa( 0.0075 ),
		permeabilityK( 0.0075 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );

	virtual void initialize()
	{
		Process::initialize();

		Cai    = getVariableReference( "Cai" ).getVariable();
		i    = getVariableReference( "i" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();
		cNa  = getVariableReference( "cNa" ).getVariable();
		CFNa  = getVariableReference( "CFNa" ).getVariable();
		cK  = getVariableReference( "cK" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();
		I      = getVariableReference( "I" ).getVariable();
		GX      = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
		_i = GX->getValue() * Cm->getValue() / ( 1.0 + pow(( 0.0012 / ( Cai->getMolarConc() * 1000.0 )), 3.0 ));
		i->setValue( _i );
		_cNa = permeabilityNa * CFNa->getValue() * _i;
		_cK  = permeabilityK  * CFK->getValue()  * _i;
		cNa->setValue( _cNa );
		cK->setValue( _cK );
		I->setValue( _cNa + _cK );

	}

 protected:

	Variable* Cai;
	Variable* i;
	Variable* Cm;
	Variable* cNa;
	Variable* CFNa;
	Variable* cK;
	Variable* CFK;
	Variable* I;
	Variable* GX;

	Real permeabilityNa;
	Real permeabilityK;

 private:

	Real _i;
	Real _cNa;
	Real _cK;

};

LIBECS_DM_INIT( ILCCaAssignmentProcess, Process );

