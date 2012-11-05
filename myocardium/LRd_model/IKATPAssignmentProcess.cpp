#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKATPAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKATPAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,IKATP_GK_amp );
		PROPERTYSLOT_SET_GET( Real,nATP );
		PROPERTYSLOT_SET_GET( Real,nicholsarea );
		PROPERTYSLOT_SET_GET( Real,ATPi );
		PROPERTYSLOT_SET_GET( Real,hATP );
		PROPERTYSLOT_SET_GET( Real,kATP );
	}
	
	IKATPAssignmentProcess()
	{
		;
	}

  	SIMPLE_SET_GET_METHOD( Real,IKATP_GK_amp );
	SIMPLE_SET_GET_METHOD( Real,nATP );
	SIMPLE_SET_GET_METHOD( Real,nicholsarea );
	SIMPLE_SET_GET_METHOD( Real,ATPi );
	SIMPLE_SET_GET_METHOD( Real,hATP );
	SIMPLE_SET_GET_METHOD( Real,kATP );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();
		Ko    = getVariableReference( "Ko" ).getVariable();

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
	  
	  Real _GK_amp = IKATP_GK_amp / nicholsarea;
	  Real _pATP = 1.0/(1.0 + pow(ATPi/kATP,hATP));
	  
	  Real _GKbaraATP = _GK_amp * _pATP * pow(Ko->getMolarConc()*1000.0/4.0, nATP);
	  
	  Real _cK = GX->getValue() * _GKbaraATP * (theVm - _EK);

	  cK->setValue( _cK );
	  I->setValue( _cK );
	}

 protected:

	Variable* Vm;
	Variable* EK;
	Variable* Ko;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;

	Variable* I;
      
	Real IKATP_GK_amp;

	Real nATP;
	Real nicholsarea;
	Real ATPi;
	Real hATP;
	Real kATP;       
 private:

};

LIBECS_DM_INIT( IKATPAssignmentProcess, Process );
