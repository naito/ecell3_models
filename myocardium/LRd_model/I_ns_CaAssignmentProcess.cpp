#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( I_ns_CaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( I_ns_CaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, g0 );
		PROPERTYSLOT_SET_GET( Real, g2 );
		PROPERTYSLOT_SET_GET( Real, g3_NaK );
		
		PROPERTYSLOT_SET_GET( Real, h11 );
		PROPERTYSLOT_SET_GET( Real, h12 );
		PROPERTYSLOT_SET_GET( Real, h13_NaK );
		PROPERTYSLOT_SET_GET( Real, h2 );

		PROPERTYSLOT_SET_GET( Real, P_ns_Ca );
		PROPERTYSLOT_SET_GET( Real, K_m_ns_Ca );
		
		PROPERTYSLOT_SET_GET( Real, e_gamma_Ca );
		PROPERTYSLOT_SET_GET( Real, i_gamma_Ca );
		PROPERTYSLOT_SET_GET( Real, Z_Ca );

		PROPERTYSLOT_SET_GET( Real, e_gamma_K );
		PROPERTYSLOT_SET_GET( Real, i_gamma_K );
		PROPERTYSLOT_SET_GET( Real, Z_K );

		PROPERTYSLOT_SET_GET( Real, e_gamma_Na );
		PROPERTYSLOT_SET_GET( Real, i_gamma_Na );
		PROPERTYSLOT_SET_GET( Real, Z_Na );	      
	}
	
	I_ns_CaAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real, g0 );
	SIMPLE_SET_GET_METHOD( Real, g2 );
	SIMPLE_SET_GET_METHOD( Real, g3_NaK );

	SIMPLE_SET_GET_METHOD( Real, h11 );
	SIMPLE_SET_GET_METHOD( Real, h12 );
	SIMPLE_SET_GET_METHOD( Real, h13_NaK );
	SIMPLE_SET_GET_METHOD( Real, h2 );

	SIMPLE_SET_GET_METHOD( Real, P_ns_Ca );
	SIMPLE_SET_GET_METHOD( Real, K_m_ns_Ca );

	SIMPLE_SET_GET_METHOD( Real, e_gamma_Ca );
	SIMPLE_SET_GET_METHOD( Real, i_gamma_Ca );
	SIMPLE_SET_GET_METHOD( Real, Z_Ca );

	SIMPLE_SET_GET_METHOD( Real, e_gamma_Na );
	SIMPLE_SET_GET_METHOD( Real, i_gamma_Na );
	SIMPLE_SET_GET_METHOD( Real, Z_Na );

	SIMPLE_SET_GET_METHOD( Real, e_gamma_K );
	SIMPLE_SET_GET_METHOD( Real, i_gamma_K );
	SIMPLE_SET_GET_METHOD( Real, Z_K );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		RTF    = getVariableReference( "RTF" ).getVariable();
		F    = getVariableReference( "F" ).getVariable();

		Cae  = getVariableReference( "Cae" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();
		Ke  = getVariableReference( "Ke" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();
		Nae  = getVariableReference( "Nae" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cCa     = getVariableReference( "cCa" ).getVariable();
		cK     = getVariableReference( "cK" ).getVariable();
		cNa     = getVariableReference( "cNa" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();
	  Real _RTF = RTF->getValue();
	  Real _F = F->getValue();

	  /* K Flux */	
	  Real g_numerator = exp((theVm+g2)*g3_NaK/_RTF);
	  g_numerator *= i_gamma_K * Ki->getMolarConc()*1000.0;
	  g_numerator += g0 * e_gamma_K * Ke->getMolarConc()*1000.0;

	  Real h_product = g_numerator/(h11*exp((theVm+h12)*h13_NaK/_RTF)+h2);
	  
	  //	  Real _cK = P_K * pow(Z_K,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  Real _cK = P_ns_Ca * pow(Z_K,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  _cK *= h_product;
	  //	  _cK *= GX->getValue() * _dGt * _fGt * _fCaGt;
	  _cK /= 1.0 + pow((K_m_ns_Ca/Cai->getMolarConc()), 3.0);
      	  _cK *= GX->getValue();
	
	  cK->setValue( _cK );

	  /* Na Flux */	
	  g_numerator = exp((theVm+g2)*g3_NaK/_RTF);
	  g_numerator *= i_gamma_Na * Nai->getMolarConc()*1000.0;
	  g_numerator += g0 * e_gamma_Na * Nae->getMolarConc()*1000.0;

	  h_product = g_numerator/(h11*exp((theVm+h12)*h13_NaK/_RTF)+h2);
	  
	  //	  Real _cNa = P_Na * pow(Z_Na,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  Real _cNa = P_ns_Ca * pow(Z_Na,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  _cNa *= h_product;
	  //	  _cNa *= GX->getValue() * _dGt * _fGt * _fCaGt;
	  _cNa /= 1.0 + pow((K_m_ns_Ca/Cai->getMolarConc()), 3.0);
      	  _cNa *= GX->getValue();
	
	  cNa->setValue( _cNa );
	 
	  I->setValue( _cK + _cNa);

	}

 protected:

	Variable* Vm;
	Variable* RTF;
	Variable* F;

	Variable* Cae;
	Variable* Cai;
	Variable* Ke;
	Variable* Ki;
	Variable* Nae;
	Variable* Nai;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cCa;
	Variable* cK;
	Variable* cNa;

	Variable* I;
       
	Real g0;
	Real g2;
	Real g3_NaK;

	Real h11;
	Real h12;
	Real h13_NaK;
	Real h2;

	Real P_ns_Ca;
	Real K_m_ns_Ca;
	
	Real e_gamma_Ca;
	Real i_gamma_Ca;
	Real Z_Ca;

	Real e_gamma_Na;
	Real i_gamma_Na;
	Real Z_Na;

	Real e_gamma_K;
	Real i_gamma_K;
	Real Z_K;
	       	
 private:

};

LIBECS_DM_INIT( I_ns_CaAssignmentProcess, Process );
