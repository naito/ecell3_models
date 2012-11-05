#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKNaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKNaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,g_K_Na );
		PROPERTYSLOT_SET_GET( Real,nKNa );
		PROPERTYSLOT_SET_GET( Real,kdKNa );
	}
	
	IKNaAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,g_K_Na );
	SIMPLE_SET_GET_METHOD( Real,nKNa );
	SIMPLE_SET_GET_METHOD( Real,kdKNa );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();
		Nai    = getVariableReference( "Nai" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cK     = getVariableReference( "cK" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();
	  Real _EK = EK->getValue();
	  
	  Real _pona = 0.85 / (1.0 + pow(kdKNa/Nai->getMolarConc(),nKNa));
	  Real _pov = 0.8 - 0.65 / (1.0 * exp((Vm->getValue() + 125.0)/15.0));

	  Real _cK = GX->getValue() * g_K_Na * _pona * _pov * (theVm - _EK);

	  cK->setValue( _cK );
	  I->setValue( _cK );
	}

 protected:

	Variable* Vm;
	Variable* EK;
	Variable* Nai;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;

	Variable* I;

	Real g_K_Na;
	Real nKNa;
	Real kdKNa;
 private:

};

LIBECS_DM_INIT( IKNaAssignmentProcess, Process );
