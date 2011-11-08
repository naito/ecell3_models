#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IPCaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IPCaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,I_pCa );
		PROPERTYSLOT_SET_GET( Real,IPCa_Km_pCa );

		PROPERTYSLOT_SET_GET( Real,PCa_KO );    
	}
	
	IPCaAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,I_pCa );
	SIMPLE_SET_GET_METHOD( Real,IPCa_Km_pCa );

	SIMPLE_SET_GET_METHOD( Real,PCa_KO );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();

		Cae    = getVariableReference( "Cae" ).getVariable();
		Cai    = getVariableReference( "Cai" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cCa     = getVariableReference( "cCa" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();

	  Real IPCa = I_pCa * Cai->getMolarConc()*1000.0;
	  IPCa /= (IPCa_Km_pCa + Cai->getMolarConc()*1000.0);
  
	  IPCa *= PCa_KO;
  
	  //setSinglePCa(IPCa);  
		
	  Real _cCa = GX->getValue() * IPCa;

	  cCa->setValue( _cCa );
	  I->setValue( _cCa );
	}

 protected:

	Variable* Vm;

	Variable* Cae;
	Variable* Cai;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cCa;

	Variable* I;
      
	Real I_pCa;
	Real IPCa_Km_pCa;

	Real PCa_KO;

 private:

};

LIBECS_DM_INIT( IPCaAssignmentProcess, Process );
