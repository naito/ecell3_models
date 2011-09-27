#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKplAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKplAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,IKpl_GK_amp );
		PROPERTYSLOT_SET_GET( Real,k0 );
		PROPERTYSLOT_SET_GET( Real,k11 );
		PROPERTYSLOT_SET_GET( Real,k12 );
		PROPERTYSLOT_SET_GET( Real,k13 );
		PROPERTYSLOT_SET_GET( Real,k2 );
	}
	
	IKplAssignmentProcess()
	{
		;
	}

  	SIMPLE_SET_GET_METHOD( Real,IKpl_GK_amp );
	SIMPLE_SET_GET_METHOD( Real,k0 );
	SIMPLE_SET_GET_METHOD( Real,k11 );
	SIMPLE_SET_GET_METHOD( Real,k12 );
	SIMPLE_SET_GET_METHOD( Real,k13 );
	SIMPLE_SET_GET_METHOD( Real,k2 );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();

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

	  Real _GK_amp = IKpl_GK_amp;	  
	  _GK_amp *= k0/(k11*exp((theVm+k12)/k13)+k2);
		
	  Real _cK = GX->getValue() * _GK_amp * (theVm - _EK);

	  cK->setValue( _cK );
	  I->setValue( _cK );
	}

 protected:

	Variable* Vm;
	Variable* EK;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;

	Variable* I;
      
	Real IKpl_GK_amp;
	Real k0;
	Real k11;
	Real k12;
	Real k13;
	Real k2;       
 private:

};

LIBECS_DM_INIT( IKplAssignmentProcess, Process );
