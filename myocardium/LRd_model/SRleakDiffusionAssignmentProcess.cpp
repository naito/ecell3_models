#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SRleakDiffusionAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( SRleakDiffusionAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,I_up );
		PROPERTYSLOT_SET_GET( Real,Ca_NSR_max );
	}
	
	SRleakDiffusionAssignmentProcess()
	{
	  ;	 // do nothing
	}

	SIMPLE_SET_GET_METHOD( Real,I_up );
	SIMPLE_SET_GET_METHOD( Real,Ca_NSR_max );

	virtual void initialize()
	{
		Process::initialize();

		Ca_i_f = getVariableReference("Ca_i_f").getVariable();
		Ca_nsr = getVariableReference("Ca_nsr").getVariable();

		I = getVariableReference( "I" ).getVariable();
		SR_factor =  getVariableReference("SR_f").getVariable();  
		GX   = getVariableReference( "GX" ).getVariable();

	}

	virtual void fire()
	{
	  Real calc_Ca_nsr_Conc = Ca_nsr->getMolarConc()*1000.0;
  
	  Real IsrLeak_K = I_up/(Ca_NSR_max);  
	  Real IsrLeak = IsrLeak_K * calc_Ca_nsr_Conc;

	  IsrLeak *= SR_factor->getValue() * GX->getValue();

	  I->setValue(IsrLeak);
	  //setSingleSRLeak(IsrLeak);  
	  //setActivity(IsrLeak);
	}
	
 protected:

	Variable* Ca_i_f;
	Variable* Ca_nsr;

	Variable* I;
	Variable* SR_factor;
	Variable* GX;

	Real I_up;
	Real Ca_NSR_max;
 private:

};

LIBECS_DM_INIT( SRleakDiffusionAssignmentProcess, Process );

