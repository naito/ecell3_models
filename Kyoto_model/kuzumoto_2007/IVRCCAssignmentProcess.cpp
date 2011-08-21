#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IVRCCAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IVRCCAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, maxFactor );
		PROPERTYSLOT_SET_GET( Real, compliance );
		PROPERTYSLOT_SET_GET( Real, halfMaxVt );
		PROPERTYSLOT_SET_GET( Real, slope );
		PROPERTYSLOT_SET_GET( Real, halfMaxVm );
		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
		PROPERTYSLOT_SET_GET( Real, permeabilityCa );
		PROPERTYSLOT_SET_GET( Real, permeabilityCl );
	}
	
	IVRCCAssignmentProcess()
		:
		maxFactor( 200.0 ),
		compliance( 0.001 ),
		halfMaxVt( 21700.0 ),
		slope( 50.0 ),
		halfMaxVm( -100.0 ),
		permeabilityNa( 0.0 ),
		permeabilityK( 0.0 ),
		permeabilityCa( 0.0 ),
		permeabilityCl( -2.0E-5 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, maxFactor );
	SIMPLE_SET_GET_METHOD( Real, compliance );
	SIMPLE_SET_GET_METHOD( Real, halfMaxVt );
	SIMPLE_SET_GET_METHOD( Real, slope );
	SIMPLE_SET_GET_METHOD( Real, halfMaxVm );
	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	SIMPLE_SET_GET_METHOD( Real, permeabilityCa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityCl );
	
	virtual void initialize()
	{
		Process::initialize();
		
		I  = getVariableReference( "I" ).getVariable();
		CFCl  = getVariableReference( "CFCl" ).getVariable();
		Cm  = getVariableReference( "Cm" ).getVariable();
		Vt   = getVariableReference( "Vt" ).getVariable();
		Vm  = getVariableReference( "Vm" ).getVariable();

	}

	virtual void fire()
	{
		I->setValue( permeabilityCl * CFCl->getValue() * ( 1.0 + maxFactor / ( 1.0 + exp( -compliance * ( Vt->getValue() * 1.0e+15 - halfMaxVt )))) * ( 1.0 / ( 1.0 + exp(( halfMaxVm - Vm->getValue() ) / slope ))) * Cm->getValue() );
	}

 protected:

	Variable* I;
	Variable* CFCl;
	Variable* Cm;
	Variable* Vt;
	Variable* Vm;


	Real maxFactor;
	Real compliance;
	Real halfMaxVt;
	Real slope;
	Real halfMaxVm;
	Real permeabilityNa;
	Real permeabilityK;
	Real permeabilityCa;
	Real permeabilityCl;

 private:

	Real _pOpen;
	Real _i;
	Real _cNa;
	Real _cK;
	Real _cCa;

};

LIBECS_DM_INIT( IVRCCAssignmentProcess, Process );

