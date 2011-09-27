#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( INaKAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( INaKAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a1 );
		PROPERTYSLOT_SET_GET( Real,a2 );
		PROPERTYSLOT_SET_GET( Real,a3 );
		
		PROPERTYSLOT_SET_GET( Real,b0 );
		PROPERTYSLOT_SET_GET( Real,b11 );
		PROPERTYSLOT_SET_GET( Real,b12 );
		PROPERTYSLOT_SET_GET( Real,b13 );
		PROPERTYSLOT_SET_GET( Real,b21 );
		PROPERTYSLOT_SET_GET( Real,b22 );
		PROPERTYSLOT_SET_GET( Real,b23 );
		PROPERTYSLOT_SET_GET( Real,b3 );
		
		PROPERTYSLOT_SET_GET( Real,I_NaK );
		PROPERTYSLOT_SET_GET( Real,Km_K_e );
		PROPERTYSLOT_SET_GET( Real,Km_Na_i );
		
	}
	
	INaKAssignmentProcess()
	{
		;
	}
	
	SIMPLE_SET_GET_METHOD( Real,a0 );
	SIMPLE_SET_GET_METHOD( Real,a1 );
	SIMPLE_SET_GET_METHOD( Real,a2 );
	SIMPLE_SET_GET_METHOD( Real,a3 );
	
	SIMPLE_SET_GET_METHOD( Real,b0 );
	SIMPLE_SET_GET_METHOD( Real,b11 );
	SIMPLE_SET_GET_METHOD( Real,b12 );
	SIMPLE_SET_GET_METHOD( Real,b13 );
	SIMPLE_SET_GET_METHOD( Real,b21 );
	SIMPLE_SET_GET_METHOD( Real,b22 );
	SIMPLE_SET_GET_METHOD( Real,b23 );
	SIMPLE_SET_GET_METHOD( Real,b3 ); 
	
	SIMPLE_SET_GET_METHOD( Real,I_NaK );
	SIMPLE_SET_GET_METHOD( Real,Km_K_e );
	SIMPLE_SET_GET_METHOD( Real,Km_Na_i );
		
	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		RTF    = getVariableReference( "RTF" ).getVariable();

		Ko  = getVariableReference( "Ko" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();
		Nao  = getVariableReference( "Nao" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();

		GX     = getVariableReference( "GX" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{
	  Real theVm = Vm->getValue();
	  Real _RTF = RTF->getValue();
	
  
	  Real INaK_sigma = 1.0/a0 + exp((Nao->getMolarConc()*1000.0 + a2)/a3)/a1;
  
	  Real INaK_f_NaK = b0 /
	    (b11*exp((theVm+b12)*b13/_RTF)+b21*INaK_sigma*exp((theVm+b22)/b23/_RTF)+b3);
  
	  Real INaK_numerator = I_NaK * INaK_f_NaK * Ko->getMolarConc()*1000.0;
	  Real INaK_denominator = Ko->getMolarConc()*1000.0 + Km_K_e;
	  INaK_denominator *= (1.0 + pow((Km_Na_i/(Nai->getMolarConc()*1000.0)),2));

	  Real _I = GX->getValue()*INaK_numerator/INaK_denominator;
  
	  I->setValue( _I );
	}

 protected:

	Variable* Vm;
	Variable* RTF;

	Variable* Ko;
	Variable* Ki;
	Variable* Nao;
	Variable* Nai;

	Variable* GX;

	Variable* I;
      
	Real a0;
	Real a1;
	Real a2;
	Real a3;
	
	Real b0;
	Real b11;
	Real b12;
	Real b13;
	Real b21;
	Real b22;
	Real b23;
	Real b3;
	
	Real I_NaK;
	Real Km_K_e;
	Real Km_Na_i;    
	
 private:

};

LIBECS_DM_INIT( INaKAssignmentProcess, Process );
