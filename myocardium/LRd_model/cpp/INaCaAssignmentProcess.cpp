#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( INaCaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( INaCaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
		
		PROPERTYSLOT_SET_GET( Real,coef1 );
		PROPERTYSLOT_SET_GET( Real,coef2 );
		
		PROPERTYSLOT_SET_GET( Real,INaCa_gamma );
		
		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a2 );
		
		PROPERTYSLOT_SET_GET( Real,b12 );
		PROPERTYSLOT_SET_GET( Real,b13 );      
		PROPERTYSLOT_SET_GET( Real,b2 );      
		
		PROPERTYSLOT_SET_GET( Real,c2 );
		
		PROPERTYSLOT_SET_GET( Real,d0 );
		PROPERTYSLOT_SET_GET( Real,d2 );
		PROPERTYSLOT_SET_GET( Real,d3 );
		
	}
	
	INaCaAssignmentProcess()
	{
		;
	}
	

      SIMPLE_SET_GET_METHOD( Real,coef1 );
      SIMPLE_SET_GET_METHOD( Real,coef2 );

      SIMPLE_SET_GET_METHOD( Real,INaCa_gamma );

      SIMPLE_SET_GET_METHOD( Real,a0 );
      SIMPLE_SET_GET_METHOD( Real,a2 );

      SIMPLE_SET_GET_METHOD( Real,b12 );
      SIMPLE_SET_GET_METHOD( Real,b13 );
      SIMPLE_SET_GET_METHOD( Real,b2 );

      SIMPLE_SET_GET_METHOD( Real,c2 );

      SIMPLE_SET_GET_METHOD( Real,d0 );
      SIMPLE_SET_GET_METHOD( Real,d2 );
      SIMPLE_SET_GET_METHOD( Real,d3 );

		
	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		RTF    = getVariableReference( "RTF" ).getVariable();

		Cao  = getVariableReference( "Cao" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();
		Nao  = getVariableReference( "Nao" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();

		GX     = getVariableReference( "GX" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{
	  Real theVm = Vm->getValue();
	  Real _RTF = RTF->getValue();
	
	  Real a_numerator = exp((theVm+a2)/_RTF) *
	    pow(Nai->getMolarConc()*1000.0,3.0) * Cao->getMolarConc()*1000.0 +
	    a0 * pow(Nao->getMolarConc()*1000.0,3.0) * Cai->getMolarConc()*1000.0;
    
	  Real c_denominator = exp((theVm+c2)/_RTF) *
	    pow(Nai->getMolarConc()*1000.0,3.0) * Cao->getMolarConc()*1000.0 +
	    pow(Nao->getMolarConc()*1000.0,3.0) * Cai->getMolarConc()*1000.0;
    
	  Real b_product = a_numerator /
	    (b2 + coef2 * c_denominator * 
	     exp((theVm + b12)*(INaCa_gamma - b13)/_RTF));
	  
	  Real _I = exp((theVm+d2)*(INaCa_gamma - d3)/_RTF) * coef1 * b_product + d0;
	  
	  _I *= GX->getValue();
	  I->setValue( _I );
	  
	  //setSingleNaCaEx(INaCa);
	}

 protected:

	Variable* Vm;
	Variable* RTF;

	Variable* Cao;
	Variable* Cai;
	Variable* Nao;
	Variable* Nai;

	Variable* GX;

	Variable* I;
      
	Real coef1;
	Real coef2;
	
	Real INaCa_gamma;
	
	Real a0;
	Real a2;
	
	Real b12;
	Real b13;
	Real b2;
	
	Real c2;
	
	Real d0;
	Real d2;
	Real d3;
		
 private:

};

LIBECS_DM_INIT( INaCaAssignmentProcess, Process );
