#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SRDiffusionAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( SRDiffusionAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
		
		PROPERTYSLOT_SET_GET( Real,Itr_tau );
	}
	
	SRDiffusionAssignmentProcess()
	{
	  ;	 // do nothing
	}

	SIMPLE_SET_GET_METHOD( Real,Itr_tau );
  
	virtual void initialize()
	{
		Process::initialize();

		Ca_jsr = getVariableReference("Ca_jsr").getVariable();
		Ca_nsr = getVariableReference("Ca_nsr").getVariable();

		I = getVariableReference( "I" ).getVariable();
		SR_factor =  getVariableReference("SR_f").getVariable();  
		GX   = getVariableReference( "GX" ).getVariable();

	}

	virtual void fire()
	{
	  Real calc_Ca_nsr_Conc = Ca_nsr->getMolarConc();
	  Real calc_Ca_jsr_Conc = Ca_jsr->getMolarConc();


	  Real IsrTransfer = (calc_Ca_nsr_Conc - calc_Ca_jsr_Conc);
	  IsrTransfer *= 1000.0/Itr_tau;
  
	  IsrTransfer *= SR_factor->getValue() * GX->getValue();

	  I->setValue(IsrTransfer);
	  //setSingleSRTransfer(IsrTransfer);
	  //setActivity(IsrTransfer);
	}
	
 protected:

	Variable* Ca_jsr;
	Variable* Ca_nsr;

	Variable* I;
	Variable* SR_factor;
	Variable* GX;

	Real Itr_tau;
 private:

};

LIBECS_DM_INIT( SRDiffusionAssignmentProcess, Process );

