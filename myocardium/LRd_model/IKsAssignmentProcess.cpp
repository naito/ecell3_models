#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKsAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKsAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, s1_ka0 );
		PROPERTYSLOT_SET_GET( Real, s1_a0 );
		PROPERTYSLOT_SET_GET( Real, s1_a11 );
		PROPERTYSLOT_SET_GET( Real, s1_a12 );
		PROPERTYSLOT_SET_GET( Real, s1_a13 );
		PROPERTYSLOT_SET_GET( Real, s1_a2 );
		
		PROPERTYSLOT_SET_GET( Real, s1_kb0 );
		PROPERTYSLOT_SET_GET( Real, s1_b0 );
		PROPERTYSLOT_SET_GET( Real, s1_b11 );
		PROPERTYSLOT_SET_GET( Real, s1_b12 );
		PROPERTYSLOT_SET_GET( Real, s1_b13 );
		PROPERTYSLOT_SET_GET( Real, s1_b2 );
		
		PROPERTYSLOT_SET_GET( Real, s1_c0 );
		PROPERTYSLOT_SET_GET( Real, s1_c11 );
		PROPERTYSLOT_SET_GET( Real, s1_c12 );
		PROPERTYSLOT_SET_GET( Real, s1_c13 );
		PROPERTYSLOT_SET_GET( Real, s1_c2 );

		PROPERTYSLOT_SET_GET( Real, s2_ka0 );
		PROPERTYSLOT_SET_GET( Real, s2_a0 );
		PROPERTYSLOT_SET_GET( Real, s2_a11 );
		PROPERTYSLOT_SET_GET( Real, s2_a12 );
		PROPERTYSLOT_SET_GET( Real, s2_a13 );
		PROPERTYSLOT_SET_GET( Real, s2_a2 );
		
		PROPERTYSLOT_SET_GET( Real, s2_kb0 );
		PROPERTYSLOT_SET_GET( Real, s2_b0 );
		PROPERTYSLOT_SET_GET( Real, s2_b11 );
		PROPERTYSLOT_SET_GET( Real, s2_b12 );
		PROPERTYSLOT_SET_GET( Real, s2_b13 );
		PROPERTYSLOT_SET_GET( Real, s2_b2 );
		
		PROPERTYSLOT_SET_GET( Real, s2_c0 );
		PROPERTYSLOT_SET_GET( Real, s2_c11 );
		PROPERTYSLOT_SET_GET( Real, s2_c12 );
		PROPERTYSLOT_SET_GET( Real, s2_c13 );
		PROPERTYSLOT_SET_GET( Real, s2_c2 );

		PROPERTYSLOT_SET_GET( Real,PR_NaK );      
	}
	
	IKsAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real, s1_ka0 );
	SIMPLE_SET_GET_METHOD( Real, s1_a0 );
	SIMPLE_SET_GET_METHOD( Real, s1_a11 );
	SIMPLE_SET_GET_METHOD( Real, s1_a12 );
	SIMPLE_SET_GET_METHOD( Real, s1_a13 );
	SIMPLE_SET_GET_METHOD( Real, s1_a2 );
	
	SIMPLE_SET_GET_METHOD( Real, s1_kb0 );
	SIMPLE_SET_GET_METHOD( Real, s1_b0 );
	SIMPLE_SET_GET_METHOD( Real, s1_b11 );
	SIMPLE_SET_GET_METHOD( Real, s1_b12 );
	SIMPLE_SET_GET_METHOD( Real, s1_b13 );
	SIMPLE_SET_GET_METHOD( Real, s1_b2 );
	
	SIMPLE_SET_GET_METHOD( Real, s1_c0 );
	SIMPLE_SET_GET_METHOD( Real, s1_c11 );
	SIMPLE_SET_GET_METHOD( Real, s1_c12 );
	SIMPLE_SET_GET_METHOD( Real, s1_c13 );
	SIMPLE_SET_GET_METHOD( Real, s1_c2 );

	SIMPLE_SET_GET_METHOD( Real, s2_ka0 );
	SIMPLE_SET_GET_METHOD( Real, s2_a0 );
	SIMPLE_SET_GET_METHOD( Real, s2_a11 );
	SIMPLE_SET_GET_METHOD( Real, s2_a12 );
	SIMPLE_SET_GET_METHOD( Real, s2_a13 );
	SIMPLE_SET_GET_METHOD( Real, s2_a2 );
	
	SIMPLE_SET_GET_METHOD( Real, s2_kb0 );
	SIMPLE_SET_GET_METHOD( Real, s2_b0 );
	SIMPLE_SET_GET_METHOD( Real, s2_b11 );
	SIMPLE_SET_GET_METHOD( Real, s2_b12 );
	SIMPLE_SET_GET_METHOD( Real, s2_b13 );
	SIMPLE_SET_GET_METHOD( Real, s2_b2 );
	
	SIMPLE_SET_GET_METHOD( Real, s2_c0 );
	SIMPLE_SET_GET_METHOD( Real, s2_c11 );
	SIMPLE_SET_GET_METHOD( Real, s2_c12 );
	SIMPLE_SET_GET_METHOD( Real, s2_c13 );
	SIMPLE_SET_GET_METHOD( Real, s2_c2 );
	
	SIMPLE_SET_GET_METHOD( Real,PR_NaK );
	
	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		RTF    = getVariableReference( "RTF" ).getVariable();

		Cai  = getVariableReference( "Cai" ).getVariable();
		Ke  = getVariableReference( "Ke" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();
		Nae  = getVariableReference( "Nae" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();

		ds1     = getVariableReference( "ds1" ).getVariable();
		ds2     = getVariableReference( "ds2" ).getVariable();
		s1     = getVariableReference( "s1" ).getVariable();
		s2     = getVariableReference( "s2" ).getVariable();

		pOpen  = getVariableReference( "pOpen" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cK     = getVariableReference( "cK" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();
	
	  Real IKs_GKs_amp = 0.6;
	  IKs_GKs_amp /= (1.0 + pow(0.000038/(Cai->getMolarConc()*1000.0),1.4));
	  IKs_GKs_amp += 1.0;
	  IKs_GKs_amp *= 0.433;
  
	  Real IKs_EKs = Ke->getMolarConc() + PR_NaK * Nae->getMolarConc();
	  IKs_EKs /= Ki->getMolarConc() + PR_NaK * Nai->getMolarConc();
	
	  IKs_EKs = log(IKs_EKs);
	  IKs_EKs *= RTF->getValue();

	  Real yXs1 = s1->getValue();
	  Real yXs2 = s2->getValue();

	  pOpen->setValue( yXs1 * yXs2 );
  
	  Real _cK = GX->getValue() * IKs_GKs_amp * yXs1 * yXs2 * (theVm - IKs_EKs);
	  cK->setValue( _cK );
	  I->setValue( _cK );

	  /// s1 gating
	  
	  Real IKs_Xs1Gt_tau = s1_ka0*(theVm + s1_a0);
	  IKs_Xs1Gt_tau /= (s1_a11*exp((theVm+s1_a12)*s1_a13)+s1_a2);
	  IKs_Xs1Gt_tau += s1_kb0*(theVm+s1_b0)/(s1_b11*exp((theVm+s1_b12)*s1_b13)+s1_b2);
	  IKs_Xs1Gt_tau = 1.0/IKs_Xs1Gt_tau;

	  Real IKs_Xs1Gt_inf = s1_c0/(s1_c11 * exp((theVm+s1_c12)/s1_c13)+s1_c2);

	  Real Xs1_alpha = IKs_Xs1Gt_inf/IKs_Xs1Gt_tau;
	  Real Xs1_beta = (1.0 - IKs_Xs1Gt_inf)/IKs_Xs1Gt_tau;
		
	  Real _vXs1 = Xs1_alpha * ( 1.0 - yXs1 ) - Xs1_beta * yXs1;
	  ds1->setValue( _vXs1 ); 	
	  //setFlux( 1000.0 * velocity );	// x1000 for msec^-1 -> sec^-1 

	  /// s2 gating

	  Real IKs_Xs2Gt_tau = s2_ka0*(theVm + s2_a0);
	  IKs_Xs2Gt_tau /= (s2_a11*exp((theVm+s2_a12)*s2_a13)+s2_a2);
	  IKs_Xs2Gt_tau += s2_kb0*(theVm+s2_b0)/(s2_b11*exp((theVm+s2_b12)*s2_b13)+s2_b2);
	  IKs_Xs2Gt_tau = 4.0/IKs_Xs2Gt_tau;
	  /// Real IKs_Xs2Gt_tau = 4.0 * IKs_Xs1Gt_tau;
	
	  Real IKs_Xs2Gt_inf = s2_c0/(s2_c11*exp((theVm+s2_c12)/s2_c13)+s2_c2);
	  
	  Real Xs2_alpha = IKs_Xs2Gt_inf/IKs_Xs2Gt_tau;
	  Real Xs2_beta = (1.0 - IKs_Xs2Gt_inf)/IKs_Xs2Gt_tau;
		
	  Real _vXs2 = Xs2_alpha * ( 1.0 - yXs2 ) - Xs2_beta * yXs2;
	  ds2->setValue( _vXs2 ); 
	
	  /// setFlux( 1000.0 * velocity );	// x1000 for msec^-1 -> sec^-1 
	}

 protected:

	Variable* Vm;
	Variable* RTF;

	Variable* Cai;
	Variable* Ke;
	Variable* Ki;
	Variable* Nae;
	Variable* Nai;

	Variable* ds1;
	Variable* ds2;
	Variable* s1;
	Variable* s2;

	Variable* pOpen;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;

	Variable* I;
       
	Real s1_ka0;
	Real s1_a0;
	Real s1_a11;
	Real s1_a12;
	Real s1_a13;  
	Real s1_a2;
	
	Real s1_kb0;
	Real s1_b0;
	Real s1_b11;
	Real s1_b12;
	Real s1_b13;  
	Real s1_b2;
	
	Real s1_c0;
	Real s1_c11;
	Real s1_c12;
	Real s1_c13;  
	Real s1_c2;

	Real s2_ka0;
	Real s2_a0;
	Real s2_a11;
	Real s2_a12;
	Real s2_a13;  
	Real s2_a2;
	
	Real s2_kb0;
	Real s2_b0;
	Real s2_b11;
	Real s2_b12;
	Real s2_b13;  
	Real s2_b2;
	
	Real s2_c0;
	Real s2_c11;
	Real s2_c12;
	Real s2_c13;  
	Real s2_c2;
	       
	Real PR_NaK;

 private:

};

LIBECS_DM_INIT( IKsAssignmentProcess, Process );
