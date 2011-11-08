#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IRyRAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IRyRAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
	}
	
	IRyRAssignmentProcess()
	{
	  ;	 // do nothing
	}

	virtual void initialize()
	{
		Process::initialize();

		Vm = getVariableReference("Vm").getVariable();
		ICaL = getVariableReference("ICaL").getVariable();
		ICaT = getVariableReference("ICaT").getVariable();
		INaCa = getVariableReference("INaCa").getVariable();
		IPCa = getVariableReference("IPCa").getVariable();
		Ibg = getVariableReference("Ibg").getVariable();
		
		Ca_i_f = getVariableReference("Ca_i_f").getVariable();
		Ca_jsr = getVariableReference("Ca_jsr").getVariable();

		dcaiont =  getVariableReference("dcaiont").getVariable();
		caiontold =  getVariableReference("caiontold").getVariable();
		tcirc =  getVariableReference("tcirc").getVariable();

		I = getVariableReference( "I" ).getVariable();
		SR_factor =  getVariableReference("SR_f").getVariable();  
		GX   = getVariableReference( "GX" ).getVariable();

		TimeLatestdVdtmax = 0.0;
		FlagdVdtmaxEval = 0;
	}

	virtual void fire()
	{

	  Real TheVm = Vm->getValue();
	  	  Real stepper = 0.01;  //ms-1
		  //Real stepper = 0.00001;  //ms-1

	  Real _ICaL = ICaL->getValue();
	  Real _ICaT = ICaT->getValue();
	  Real _INaCa = INaCa->getValue();
	  Real _IPCa = IPCa->getValue();
	  Real _Ibg = Ibg->getValue();

	  Real G_rel_denominator = _ICaL + _Ibg + _IPCa;
	  G_rel_denominator += _ICaT - 2.0 * _INaCa + 5.0;
	  G_rel_denominator /= 0.9;
	  G_rel_denominator = exp(G_rel_denominator) + 1.0;

	  Real G_rel = 150.0;
	  G_rel /= G_rel_denominator;

	  Real caiont = _ICaL + _Ibg + _IPCa + _ICaT - 2.0 * _INaCa;

	  Real _caiontold = caiontold->getValue();
	  Real _dcaiont = dcaiont->getValue();
	  Real _tcirc = tcirc->getValue();

	  Real new_dcaiont = (caiont - _caiontold)/stepper; // msec or sec?
	  //	  Real new_dcaiont = (caiont - _caiontold)/0.01; // msec or sec?

	  if(( TheVm > -35.0 ) && (new_dcaiont > _dcaiont) && ( FlagdVdtmaxEval == 0 )){
	    FlagdVdtmaxEval = 1;
	    //tcirc->setValue(_tcirc - 1.0*_tcirc);
	    //tcirc.addValue(-1.0*the_tcirc);
	    tcirc->setValue(0);
	    _tcirc = 0;
	  }
	  else{
	    if((TheVm < -40.0) && (FlagdVdtmaxEval == 1)){
	      FlagdVdtmaxEval = 0;
	    }
	  }
	  //	  caiont -= the_caiontold;
	  caiontold->setValue(caiont);

	  //	  new_dcaiont -= the_dcaiont;
	  dcaiont->setValue(new_dcaiont);
	  
	  Real RyR_exp = 4.0;
	  RyR_exp -= (_tcirc);
  
	  Real RyR_open  = 1.0 / (1.0 + exp( RyR_exp/0.5 ));
	  Real RyR_close = 1.0 - RyR_open;

	  Real calc_Ca_jsr_Conc = Ca_jsr->getMolarConc()*1000.0;
	  Real calc_Ca_i_f_Conc = Ca_i_f->getMolarConc()*1000.0;

	  Real _IRyR = G_rel * RyR_open * RyR_close;
	  _IRyR *= (calc_Ca_jsr_Conc - calc_Ca_i_f_Conc);
	  _IRyR *= SR_factor->getValue();	  
  
	  I->setValue(_IRyR);
	  // setSingleRyR(IrelRyR);  // mM/ms
	  //  setActivity(IrelRyR);
	  //  setI(IrelRyR);
  
	  tcirc->setValue(tcirc->getValue() + stepper);
	  //tcirc->setValue(tcirc->getValue() + 0.01);
	  //tcirc.addValue(0.01);
	}
	
 protected:

	Variable* Vm;
	Variable* ICaL;
	Variable* ICaT;
	Variable* INaCa;
	Variable* IPCa;
	Variable* Ibg;

	Variable* Ca_i_f;
	Variable* Ca_jsr;

	Variable* dcaiont;
	Variable* caiontold;
	Variable* tcirc;

	Variable* I;
	Variable* SR_factor;
	Variable* GX;

 private:
	Real TimeLatestdVdtmax;

	int FlagdVdtmaxEval;

};

LIBECS_DM_INIT( IRyRAssignmentProcess, Process );

