#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IbgAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IbgAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,Ibg_Ca_amp );
		PROPERTYSLOT_SET_GET( Real,Ibg_Na_amp );

	}
	
	IbgAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,Ibg_Ca_amp );
	SIMPLE_SET_GET_METHOD( Real,Ibg_Na_amp );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		ECa    = getVariableReference( "ECa" ).getVariable();
		ENa    = getVariableReference( "ENa" ).getVariable();

		cCa     = getVariableReference( "cCa" ).getVariable();
		cNa     = getVariableReference( "cNa" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();

	  Real _cCa = Ibg_Ca_amp * (theVm - ECa->getValue());
	  Real _cNa = Ibg_Na_amp * (theVm - ENa->getValue());

	  //setSingleCab(pA);

	  cCa->setValue( _cCa );
	  cNa->setValue( _cNa );

	  I->setValue( _cCa + _cNa );
	}

 protected:

	Variable* Vm;
	Variable* ECa;
	Variable* ENa;

	Variable* cCa;
	Variable* cNa;

	Variable* I;
      
	Real Ibg_Ca_amp;
	Real Ibg_Na_amp;

 private:

};

LIBECS_DM_INIT( IbgAssignmentProcess, Process );
