#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IK1AssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IK1AssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
		
		PROPERTYSLOT_SET_GET( Real,coef_g );
		PROPERTYSLOT_SET_GET( Real,K_normal );
		
		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a11 );
		PROPERTYSLOT_SET_GET( Real,a12 );
		PROPERTYSLOT_SET_GET( Real,a13 );
		PROPERTYSLOT_SET_GET( Real,a2 );
		
		PROPERTYSLOT_SET_GET( Real,b0 );
		PROPERTYSLOT_SET_GET( Real,b1 );
		PROPERTYSLOT_SET_GET( Real,b2 );
		PROPERTYSLOT_SET_GET( Real,b3 );
		
		PROPERTYSLOT_SET_GET( Real,c0 );
		PROPERTYSLOT_SET_GET( Real,c1 );
		PROPERTYSLOT_SET_GET( Real,c2 );
		PROPERTYSLOT_SET_GET( Real,c3 );
		
		PROPERTYSLOT_SET_GET( Real,d11 );
		PROPERTYSLOT_SET_GET( Real,d12 );
		PROPERTYSLOT_SET_GET( Real,d13 );
		PROPERTYSLOT_SET_GET( Real,d2 );	       
	}
	
	IK1AssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,coef_g );
	SIMPLE_SET_GET_METHOD( Real,K_normal );
	
	SIMPLE_SET_GET_METHOD( Real,a0 );
	SIMPLE_SET_GET_METHOD( Real,a11 );
	SIMPLE_SET_GET_METHOD( Real,a12 );
	SIMPLE_SET_GET_METHOD( Real,a13 );
	SIMPLE_SET_GET_METHOD( Real,a2 );
  
	SIMPLE_SET_GET_METHOD( Real,b0 );
	SIMPLE_SET_GET_METHOD( Real,b1 );
	SIMPLE_SET_GET_METHOD( Real,b2 );
	SIMPLE_SET_GET_METHOD( Real,b3 );
	
	SIMPLE_SET_GET_METHOD( Real,c0 );
	SIMPLE_SET_GET_METHOD( Real,c1 );
	SIMPLE_SET_GET_METHOD( Real,c2 );
	SIMPLE_SET_GET_METHOD( Real,c3 );
	
	SIMPLE_SET_GET_METHOD( Real,d11 );
	SIMPLE_SET_GET_METHOD( Real,d12 );
	SIMPLE_SET_GET_METHOD( Real,d13 );
	SIMPLE_SET_GET_METHOD( Real,d2 );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();

		Ke  = getVariableReference( "Ke" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();

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

	  Real IRK1_GK1_amp = coef_g * sqrt(Ke->getMolarConc()*1000.0/K_normal);
    
	  Real IRK1_alpha_K1 = a0/(a11*exp((theVm-(_EK+a12))*a13)+a2);

	  Real d_numerator =  b0 + b1 * exp((theVm+b2-_EK)*b3);
	  d_numerator += c0 + c1 * exp((theVm-(_EK+c2))*c3);
  
	  Real IRK1_beta_K1 = d_numerator/(d11*exp((theVm+d12-_EK)*d13)+d2);
	  Real IRK1_K1_inf = IRK1_alpha_K1/(IRK1_alpha_K1 + IRK1_beta_K1);
  
	  
	  Real _cK = GX->getValue() * IRK1_GK1_amp * IRK1_K1_inf * (theVm - _EK);

	  cK->setValue( _cK );
	  I->setValue( _cK );
	}

 protected:

	Variable* Vm;
	Variable* EK;

	Variable* Ke;
	Variable* Ki;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;

	Variable* I;
	
	Real coef_g;
	Real K_normal;
	
	Real a0;
	Real a11;
	Real a12;
	Real a13;
	Real a2;
	
	Real b0;
	Real b1;
	Real b2;
	Real b3;
	
	Real c0;
	Real c1;
	Real c2;
	Real c3;
	
	Real d11;
	Real d12;
	Real d13;
	Real d2;  
	              
 private:

};

LIBECS_DM_INIT( IK1AssignmentProcess, Process );
