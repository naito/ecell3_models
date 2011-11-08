#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( CaBufAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( CaBufAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real , KmTRPN );
		PROPERTYSLOT_SET_GET( Real , KmCMDN );
		PROPERTYSLOT_SET_GET( Real , KmCSQN );	   		
	}
	
	CaBufAssignmentProcess()
	{
	  ;	 // do nothing
	}

	SIMPLE_SET_GET_METHOD( Real , KmTRPN );
	SIMPLE_SET_GET_METHOD( Real , KmCMDN );
	SIMPLE_SET_GET_METHOD( Real , KmCSQN );

	virtual void initialize()
	{
		Process::initialize();

		Vm = getVariableReference("Vm").getVariable();
		ICaL = getVariableReference("ICaL").getVariable();
		ICaT = getVariableReference("ICaT").getVariable();
		INaCa = getVariableReference("INaCa").getVariable();
		IPCa = getVariableReference("IPCa").getVariable();
		Ibg = getVariableReference("Ibg").getVariable();

		IRyR = getVariableReference("IRyR").getVariable();
		ISRTransfer = getVariableReference("ISRTransfer").getVariable();
		ISRLeak = getVariableReference("ISRLeak").getVariable();
		ISRCA = getVariableReference("ISRCA").getVariable();
		
		Ca_i_f = getVariableReference("Ca_i_f").getVariable();
		Ca_sr_f = getVariableReference("Ca_sr_f").getVariable();
		Ca_nsr_f = getVariableReference("Ca_nsr_f").getVariable();
		TRPN_i_f = getVariableReference("TRPN_i_f").getVariable();
		CMDN_i_f = getVariableReference("CMDN_i_f").getVariable();
		CSQN_sr_f = getVariableReference("CSQN_sr_f").getVariable();
		TRPN_i_t = getVariableReference("TRPN_i_t").getVariable();
		CMDN_i_t = getVariableReference("CMDN_i_t").getVariable();
		CSQN_sr_t = getVariableReference("CSQN_sr_t").getVariable();  

		t_jsrol = getVariableReference("t_jsrol").getVariable();  
 
		_KmTRPN = KmTRPN;
		_KmCMDN = KmCMDN;
		_KmCSQN = KmCSQN;	       
	}

	virtual void fire()
	{
	  	  Real stepper = 0.01;  //ms-1
		  //Real stepper = 0.00001;  //ms-1

	  /* total (maximum) */
	  Real TRPN_i_t_Conc = TRPN_i_t->getMolarConc()*1000.0;
	  Real CMDN_i_t_Conc = CMDN_i_t->getMolarConc()*1000.0;
	  Real CSQN_sr_t_Conc = CSQN_sr_t->getMolarConc()*1000.0;
	  
	  /* free */
	  Real Ca_i_f_Conc = Ca_i_f->getMolarConc()*1000.0;
	  Real Ca_sr_f_Conc = Ca_sr_f->getMolarConc()*1000.0;
	  Real Ca_nsr_f_Conc = Ca_nsr_f->getMolarConc()*1000.0;
	  Real TRPN_i_f_Conc = TRPN_i_f->getMolarConc()*1000.0;
	  Real CMDN_i_f_Conc = CMDN_i_f->getMolarConc()*1000.0;
	  Real CSQN_sr_f_Conc = CSQN_sr_f->getMolarConc()*1000.0;
  
	  /* new */
	  Real NewCa_i_f_Conc;
	  Real NewCa_sr_f_Conc;
	  Real NewCa_nsr_f_Conc;
	  Real NewTRPN_i_f_Conc;
	  Real NewCMDN_i_f_Conc;
	  Real NewCSQN_sr_f_Conc;

	  //  SingleCaL = getEntityProperty(SingleCaLfullPN);
	  Real _ICaL = ICaL->getValue();
	  Real _ICaT = ICaT->getValue();
	  Real _INaCa = INaCa->getValue();
	  Real _IPCa = IPCa->getValue();
	  Real _Ibg = Ibg->getValue();

	  Real _IRyR = IRyR->getValue();
	  Real _ISRTransfer = ISRTransfer->getValue();
	  Real _ISRLeak = ISRLeak->getValue();
	  Real _ISRCA = ISRCA->getValue();

	  /* void conc_jsr */
	  /* Ca release from JSR to myo. due to JSR overload mM/ms */
	  Real G_rel_bar_jsrol = 0.0; // ms-1
	  Real CSQN_th = 8.75; // mM
  
	  Real the_t_jsrol = t_jsrol->getValue();

	  if(CSQN_sr_f_Conc >= CSQN_th && the_t_jsrol > 50){    
	    t_jsrol->setValue(0.0);
	    //	    t_jsrol->addValue(-1.0*the_t_jsrol);
	    G_rel_bar_jsrol = 4.0; 
	  }

	  Real G_rel_exp = exp(-1.0*the_t_jsrol/0.5);
	  Real G_rel_jsrol = G_rel_bar_jsrol;
	  G_rel_jsrol *= (1.0 - G_rel_exp)*G_rel_exp;
  
	  Real I_rel_jsrol = G_rel_jsrol*(Ca_sr_f_Conc - Ca_i_f_Conc); 
	  t_jsrol->setValue(t_jsrol->getValue()+stepper);
	  //t_jsrol->setValue(t_jsrol->getValue()+0.01);
	  //t_jsrol->addValue(0.01);

	  /* CSQN */
	  NewCSQN_sr_f_Conc = CSQN_sr_t_Conc * Ca_sr_f_Conc;
	  NewCSQN_sr_f_Conc /= (Ca_sr_f_Conc + _KmCSQN);

	  NewCSQN_sr_f_Conc -= CSQN_sr_f_Conc; 
	  CSQN_sr_f_Conc += NewCSQN_sr_f_Conc;
	  NewCSQN_sr_f_Conc *= CSQN_sr_f->getSuperSystem()->getSize(); //mM->mmol
	  NewCSQN_sr_f_Conc /= 1000.0; //mmol->mol
	  NewCSQN_sr_f_Conc *= N_A; //mol->molecules
	  CSQN_sr_f->setValue(CSQN_sr_f->getValue() + NewCSQN_sr_f_Conc);
	  //	  CSQN_sr_f->addValue(NewCSQN_sr_f_Conc);

	  /* JSR */
	  Real djsr = stepper * (_ISRTransfer - _IRyR - I_rel_jsrol);
	  Real bjsr = CSQN_sr_t_Conc - CSQN_sr_f_Conc - djsr - Ca_sr_f_Conc + _KmCSQN;
	  Real cjsr = _KmCSQN * (CSQN_sr_f_Conc + djsr + Ca_sr_f_Conc);
  
	  NewCa_sr_f_Conc = (sqrt(bjsr*bjsr+4.0*cjsr)-bjsr)/2.0;
	  NewCa_sr_f_Conc -= Ca_sr_f_Conc;
	  Ca_sr_f_Conc += NewCa_sr_f_Conc;
	  NewCa_sr_f_Conc *= Ca_sr_f->getSuperSystem()->getSize(); //mM->mmol
	  NewCa_sr_f_Conc /= 1000.0; //mmol->mol
	  NewCa_sr_f_Conc *= N_A; //mol->molecules
	  Ca_sr_f->setValue(Ca_sr_f->getValue() + NewCa_sr_f_Conc);
	  // Ca_sr_f->addValue(NewCa_sr_f_Conc);

	  /* NSR */
	  Real V_jsr = 0.000000182; //JSR volume (uL)
	  Real V_nsr = 0.000002098;
	    
	  NewCa_nsr_f_Conc = stepper;
	  NewCa_nsr_f_Conc *= (_ISRCA - _ISRLeak - _ISRTransfer*V_jsr/V_nsr);
	  Ca_nsr_f_Conc += NewCa_nsr_f_Conc;
	  NewCa_nsr_f_Conc *= Ca_nsr_f->getSuperSystem()->getSize(); //mM->mmol
	  NewCa_nsr_f_Conc /= 1000.0; //mmol->mol
	  NewCa_nsr_f_Conc *= N_A; //mol->molecules
	  Ca_nsr_f->setValue(Ca_nsr_f->getValue() + NewCa_nsr_f_Conc);
	  // Ca_nsr_f->addValue(NewCa_nsr_f_Conc);

	    /* Cytoplasm Ca */
	  /* TRPN */
	  NewTRPN_i_f_Conc = TRPN_i_t_Conc * Ca_i_f_Conc;
	  NewTRPN_i_f_Conc /= (Ca_i_f_Conc + _KmTRPN);
	  
	  NewTRPN_i_f_Conc -= TRPN_i_f_Conc; 
	  TRPN_i_f_Conc += NewTRPN_i_f_Conc;
	  NewTRPN_i_f_Conc *= TRPN_i_f->getSuperSystem()->getSize(); //mM->mmol
	  NewTRPN_i_f_Conc /= 1000.0; //mmol->mol
	  NewTRPN_i_f_Conc *= N_A; //mol->molecules
	  TRPN_i_f->setValue(TRPN_i_f->getValue() + NewTRPN_i_f_Conc);
	  //TRPN_i_f->addValue(NewTRPN_i_f_Conc);
	  
	  /* CMDN */
	  NewCMDN_i_f_Conc = CMDN_i_t_Conc * Ca_i_f_Conc;
	  NewCMDN_i_f_Conc /= (Ca_i_f_Conc + _KmCMDN);
	  
	  NewCMDN_i_f_Conc -= CMDN_i_f_Conc; 
	  CMDN_i_f_Conc += NewCMDN_i_f_Conc;
	  NewCMDN_i_f_Conc *= CMDN_i_f->getSuperSystem()->getSize(); //mM->mmol
	  NewCMDN_i_f_Conc /= 1000.0; //mmol->mol
	  NewCMDN_i_f_Conc *= N_A; //mol->molecules
	  CMDN_i_f->setValue(CMDN_i_f->getValue() + NewCMDN_i_f_Conc);
	  //CMDN_i_f->addValue(NewCMDN_i_f_Conc);
	  
	  /* Cytoplasm Ca(2+) */
	  Real Ca_ion_t = _ICaL + _Ibg + _IPCa + _ICaT - 2.0 * _INaCa;
	  Real A_cap = 0.0001534;
	  Real V_myo = 0.00002584;
	  Real F = 9.64867e+4;

	  Ca_ion_t *= A_cap;
	  Ca_ion_t /= V_myo;
	  Ca_ion_t /= 2.0; //Ca.Z
	  Ca_ion_t /= F;
	  
	  Real vnsr = _ISRCA - _ISRLeak;
	  vnsr *= V_nsr/V_myo;
  
	  Real vjsr = _IRyR + I_rel_jsrol;
	  vjsr *= V_jsr/V_myo;

	  Real dcai = Ca_ion_t + vnsr - vjsr;
	  dcai *= stepper * (-1.0); /* mM */
  
	  Real Ca_total = TRPN_i_f_Conc + CMDN_i_f_Conc + dcai + Ca_i_f_Conc; //mM
  
	  Real bmyo = CMDN_i_t_Conc + TRPN_i_t_Conc - Ca_total + _KmTRPN + _KmCMDN;
	  Real cmyo = (_KmCMDN*_KmTRPN)-(Ca_total*(_KmTRPN + _KmCMDN));
	  cmyo += (TRPN_i_t_Conc * KmCMDN)+(CMDN_i_t_Conc * _KmTRPN);
	  Real dmyo = -1.0*_KmTRPN*_KmCMDN*Ca_total;
  
	  Real gpig = sqrt(bmyo*bmyo-3.0*cmyo);
	  NewCa_i_f_Conc = (2.0*gpig/3.0);
	  Real Cai_acos = 9.0*bmyo*cmyo-2*bmyo*bmyo*bmyo-27.0*dmyo;
	  Cai_acos /= (2.0*pow((bmyo*bmyo-3.0*cmyo),1.5));

	  Real Cai_cos = acos(Cai_acos)/3.0;
	  NewCa_i_f_Conc *= cos(Cai_cos);
	  NewCa_i_f_Conc -= bmyo/3.0;
	  
	  NewCa_i_f_Conc -= Ca_i_f_Conc; 
	  Ca_i_f_Conc += NewCa_i_f_Conc;
	  NewCa_i_f_Conc *= Ca_i_f->getSuperSystem()->getSize(); //mM->mmol
	  NewCa_i_f_Conc /= 1000.0; //mmol->mol
	  NewCa_i_f_Conc *= N_A; //mol->molecules
	  Ca_i_f->setValue(Ca_i_f->getValue() + NewCa_i_f_Conc);
	  //Ca_i_f->addValue(NewCa_i_f_Conc);
	}
	
 protected:

	Variable* Vm;
	Variable* ICaL;
	Variable* ICaT;
	Variable* INaCa;
	Variable* IPCa;
	Variable* Ibg;

	Variable* IRyR;
	Variable* ISRTransfer;
	Variable* ISRLeak;
	Variable* ISRCA;

	Variable* Ca_i_f;
	Variable* Ca_sr_f;
	Variable* Ca_nsr_f;
	Variable* TRPN_i_f;
	Variable* CMDN_i_f;
	Variable* CSQN_sr_f;
	Variable* TRPN_i_t;
	Variable* CMDN_i_t;
	Variable* CSQN_sr_t;
	
	Variable* t_jsrol;

	Real KmTRPN;
	Real KmCMDN;
	Real KmCSQN;
  
 private:
	Real _KmTRPN;
	Real _KmCMDN;
	Real _KmCSQN;

};

LIBECS_DM_INIT( CaBufAssignmentProcess, Process );

