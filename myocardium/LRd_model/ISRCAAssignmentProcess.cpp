#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ISRCAAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ISRCAAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,I_up );
		PROPERTYSLOT_SET_GET( Real,Km_up );
	}
	
	ISRCAAssignmentProcess()
	{
	  ;	 // do nothing
	}

	SIMPLE_SET_GET_METHOD( Real,I_up );
	SIMPLE_SET_GET_METHOD( Real,Km_up );

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
	  Real calc_Ca_i_f_Conc = Ca_i_f->getMolarConc() * 1000.0;
  
	  Real Km = Km_up;
	  
	  Real IsrUptake = I_up;
	  IsrUptake *= calc_Ca_i_f_Conc;
	  IsrUptake /= (calc_Ca_i_f_Conc + Km);
	  IsrUptake *= SR_factor->getValue() * GX->getValue();

	  I->setValue(IsrUptake);
	  //  setSingleSRUptake(IsrUptake);  
	  //  setActivity(IsrUptake);
	}
	
 protected:

	Variable* Ca_i_f;
	Variable* Ca_nsr;

	Variable* I;
	Variable* SR_factor;
	Variable* GX;

	Real I_up;
	Real Km_up;
 private:

};

LIBECS_DM_INIT( ISRCAAssignmentProcess, Process );

