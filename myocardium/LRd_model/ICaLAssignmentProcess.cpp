#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ICaLAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ICaLAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a11 );
		PROPERTYSLOT_SET_GET( Real,a12 );
		PROPERTYSLOT_SET_GET( Real,a13 );
		PROPERTYSLOT_SET_GET( Real,a2 );
		
		PROPERTYSLOT_SET_GET( Real,b0 );
		PROPERTYSLOT_SET_GET( Real,b1 );
		PROPERTYSLOT_SET_GET( Real,b2 );
		PROPERTYSLOT_SET_GET( Real,b3 );
		PROPERTYSLOT_SET_GET( Real,b11 );
		PROPERTYSLOT_SET_GET( Real,b12 );
		
		PROPERTYSLOT_SET_GET( Real,c0 );
		PROPERTYSLOT_SET_GET( Real,c11 );
		PROPERTYSLOT_SET_GET( Real,c12 );
		PROPERTYSLOT_SET_GET( Real,c13 );
		PROPERTYSLOT_SET_GET( Real,c2 );
		
		PROPERTYSLOT_SET_GET( Real,d0 );
		PROPERTYSLOT_SET_GET( Real,d11 );
		PROPERTYSLOT_SET_GET( Real,d12 );
		PROPERTYSLOT_SET_GET( Real,d13 );
		PROPERTYSLOT_SET_GET( Real,d2 );
		
		PROPERTYSLOT_SET_GET( Real,e0 );
		PROPERTYSLOT_SET_GET( Real,e11 );
		PROPERTYSLOT_SET_GET( Real,e12 );
		PROPERTYSLOT_SET_GET( Real,e13 );
		PROPERTYSLOT_SET_GET( Real,e14 );
		PROPERTYSLOT_SET_GET( Real,e15 );
		PROPERTYSLOT_SET_GET( Real,e2 );

		PROPERTYSLOT_SET_GET( Real, f0 );
		PROPERTYSLOT_SET_GET( Real, f2 );
		PROPERTYSLOT_SET_GET( Real, Km_Ca );
		
		PROPERTYSLOT_SET_GET( Real, g0 );
		PROPERTYSLOT_SET_GET( Real, g2 );
		PROPERTYSLOT_SET_GET( Real, g3 );
		PROPERTYSLOT_SET_GET( Real, g3_NaK );
		
		PROPERTYSLOT_SET_GET( Real, h11 );
		PROPERTYSLOT_SET_GET( Real, h12 );
		PROPERTYSLOT_SET_GET( Real, h13 );
		PROPERTYSLOT_SET_GET( Real, h13_NaK );
		PROPERTYSLOT_SET_GET( Real, h2 );
		
		PROPERTYSLOT_SET_GET( Real, e_gamma_Ca );
		PROPERTYSLOT_SET_GET( Real, i_gamma_Ca );
		PROPERTYSLOT_SET_GET( Real, P_Ca );
		PROPERTYSLOT_SET_GET( Real, Z_Ca );

		PROPERTYSLOT_SET_GET( Real, e_gamma_K );
		PROPERTYSLOT_SET_GET( Real, i_gamma_K );
		PROPERTYSLOT_SET_GET( Real, P_K );
		PROPERTYSLOT_SET_GET( Real, Z_K );

		PROPERTYSLOT_SET_GET( Real, e_gamma_Na );
		PROPERTYSLOT_SET_GET( Real, i_gamma_Na );
		PROPERTYSLOT_SET_GET( Real, P_Na );
		PROPERTYSLOT_SET_GET( Real, Z_Na );	      
	}
	
	ICaLAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,a0 );
	SIMPLE_SET_GET_METHOD( Real,a11 );
	SIMPLE_SET_GET_METHOD( Real,a12 );
	SIMPLE_SET_GET_METHOD( Real,a13 );
	SIMPLE_SET_GET_METHOD( Real,a2 );
	
	SIMPLE_SET_GET_METHOD( Real,b0 );
	SIMPLE_SET_GET_METHOD( Real,b1 );
	SIMPLE_SET_GET_METHOD( Real,b2 );
	SIMPLE_SET_GET_METHOD( Real,b3 );
	SIMPLE_SET_GET_METHOD( Real,b11 );
	SIMPLE_SET_GET_METHOD( Real,b12 );
	
	SIMPLE_SET_GET_METHOD( Real,c0 );
	SIMPLE_SET_GET_METHOD( Real,c11 );
	SIMPLE_SET_GET_METHOD( Real,c12 );
	SIMPLE_SET_GET_METHOD( Real,c13 );
	SIMPLE_SET_GET_METHOD( Real,c2 );
	
	SIMPLE_SET_GET_METHOD( Real,d0 );
	SIMPLE_SET_GET_METHOD( Real,d11 );
	SIMPLE_SET_GET_METHOD( Real,d12 );
	SIMPLE_SET_GET_METHOD( Real,d13 );
	SIMPLE_SET_GET_METHOD( Real,d2 );

	SIMPLE_SET_GET_METHOD( Real,e0 );
	SIMPLE_SET_GET_METHOD( Real,e11 );
	SIMPLE_SET_GET_METHOD( Real,e12 );
	SIMPLE_SET_GET_METHOD( Real,e13 );
	SIMPLE_SET_GET_METHOD( Real,e14 );
	SIMPLE_SET_GET_METHOD( Real,e15 );
	SIMPLE_SET_GET_METHOD( Real,e2 );
	
	SIMPLE_SET_GET_METHOD( Real, f0 );
	SIMPLE_SET_GET_METHOD( Real, f2 );
	SIMPLE_SET_GET_METHOD( Real, Km_Ca );
      
	SIMPLE_SET_GET_METHOD( Real, g0 );
	SIMPLE_SET_GET_METHOD( Real, g2 );
	SIMPLE_SET_GET_METHOD( Real, g3 );
	SIMPLE_SET_GET_METHOD( Real, g3_NaK );

	SIMPLE_SET_GET_METHOD( Real, h11 );
	SIMPLE_SET_GET_METHOD( Real, h12 );
	SIMPLE_SET_GET_METHOD( Real, h13 );
	SIMPLE_SET_GET_METHOD( Real, h13_NaK );
	SIMPLE_SET_GET_METHOD( Real, h2 );

	SIMPLE_SET_GET_METHOD( Real, e_gamma_Ca );
	SIMPLE_SET_GET_METHOD( Real, i_gamma_Ca );
	SIMPLE_SET_GET_METHOD( Real, P_Ca );
	SIMPLE_SET_GET_METHOD( Real, Z_Ca );

	SIMPLE_SET_GET_METHOD( Real, e_gamma_Na );
	SIMPLE_SET_GET_METHOD( Real, i_gamma_Na );
	SIMPLE_SET_GET_METHOD( Real, P_Na );
	SIMPLE_SET_GET_METHOD( Real, Z_Na );

	SIMPLE_SET_GET_METHOD( Real, e_gamma_K );
	SIMPLE_SET_GET_METHOD( Real, i_gamma_K );
	SIMPLE_SET_GET_METHOD( Real, P_K );
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

		ddGt     = getVariableReference( "ddGt" ).getVariable();
		dfGt     = getVariableReference( "dfGt" ).getVariable();
		dGt     = getVariableReference( "dGt" ).getVariable();
		fGt     = getVariableReference( "fGt" ).getVariable();

		pOpen  = getVariableReference( "pOpen" ).getVariable();

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

	  Real _dGt = dGt->getValue();
	  Real _fGt = fGt->getValue();
	  
	  /* f Ca gate */
	  Real _fCaGt = f0;
	  _fCaGt /= (f2 + Cai->getMolarConc()*1000.0/Km_Ca);
	  
	  pOpen->setValue( _dGt * _fGt * _fCaGt );

	  /* Ca Flux */	
	  Real g_numerator = exp((theVm+g2)*g3/_RTF);
	  g_numerator *= i_gamma_Ca * Cai->getMolarConc()*1000.0;
	  g_numerator += g0 * e_gamma_Ca * Cae->getMolarConc()*1000.0;

	  Real h_product = g_numerator/(h11*exp((theVm+h12)*h13/_RTF)+h2);
	  
	  Real _cCa = P_Ca * pow(Z_Ca,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  _cCa *= h_product;
	  _cCa *= GX->getValue() * _dGt * _fGt * _fCaGt;
	
	  cCa->setValue( _cCa );

	  /* K Flux */	
	  g_numerator = exp((theVm+g2)*g3_NaK/_RTF);
	  g_numerator *= i_gamma_K * Ki->getMolarConc()*1000.0;
	  g_numerator += g0 * e_gamma_K * Ke->getMolarConc()*1000.0;

	  h_product = g_numerator/(h11*exp((theVm+h12)*h13_NaK/_RTF)+h2);
	  
	  Real _cK = P_K * pow(Z_K,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  _cK *= h_product;
	  _cK *= GX->getValue() * _dGt * _fGt * _fCaGt;
	
	  cK->setValue( _cK );

	  /* Na Flux */	
	  g_numerator = exp((theVm+g2)*g3_NaK/_RTF);
	  g_numerator *= i_gamma_Na * Nai->getMolarConc()*1000.0;
	  g_numerator += g0 * e_gamma_Na * Nae->getMolarConc()*1000.0;

	  h_product = g_numerator/(h11*exp((theVm+h12)*h13_NaK/_RTF)+h2);
	  
	  Real _cNa = P_Na * pow(Z_Na,2.0) * theVm * _F / _RTF ; // modified from pA *= RTF_r * F;
	  _cNa *= h_product;
	  _cNa *= GX->getValue() * _dGt * _fGt * _fCaGt;
	
	  cNa->setValue( _cNa );
	 
	  I->setValue( _cCa + _cK + _cNa);

	  /// d gating
	  Real d_inf = a0/(a11 * exp((theVm + a12 )/a13 ) + a2);
	  Real d_tau = d_inf;
	  d_tau *= b0 + b1 * exp((theVm + b2)/b3);
	  d_tau /= (b11 * (theVm + b12));

	  Real d_alpha = d_inf/d_tau;
	  Real d_beta = (1.0 - d_inf)/d_tau;
		
	  Real _vGtd = d_alpha * ( 1.0 - _dGt ) - d_beta * _dGt;
	
	  ddGt->setValue( _vGtd );

	  /// f gating
	  Real f_inf = c0/(c11 * exp((theVm + c12 )/c13 ) + c2);
	  f_inf += d0/(d11 * exp((theVm + d12 )/d13 ) + d2);

	  Real f_tau = e11 * exp(e15 * pow(e13 * (theVm+e12),e14));
	  f_tau += e2;
	  f_tau = e0/f_tau;
	
	  Real f_alpha = f_inf/f_tau;
	  Real f_beta = (1.0 - f_inf)/f_tau;
	  
	  Real _vGtf = f_alpha * ( 1.0 - _fGt ) - f_beta * _fGt;

	  dfGt->setValue( _vGtf );
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

	Variable* ddGt;
	Variable* dfGt;
	Variable* dGt;
	Variable* fGt;

	Variable* pOpen;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cCa;
	Variable* cK;
	Variable* cNa;

	Variable* I;
       
	Real a0;
	Real a11;
	Real a12;
	Real a13;
	Real a2;
	
	Real b0;
	Real b1;
	Real b2;
	Real b3;
	Real b11;
	Real b12;
	
	Real c0;
	Real c11;
	Real c12;
	Real c13;
	Real c2;
	
	Real d0;
	Real d11;
	Real d12;
	Real d13;
	Real d2;
	
	Real e0;
	Real e11;
	Real e12;
	Real e13;
	Real e14;
	Real e15;
	Real e2;

	Real f0;
	Real f2;
	Real Km_Ca;
  
	Real g0;
	Real g2;
	Real g3;
	Real g3_NaK;

	Real h11;
	Real h12;
	Real h13;
	Real h13_NaK;
	Real h2;
	
	Real e_gamma_Ca;
	Real i_gamma_Ca;
	Real P_Ca;
	Real Z_Ca;

	Real e_gamma_Na;
	Real i_gamma_Na;
	Real P_Na;
	Real Z_Na;

	Real e_gamma_K;
	Real i_gamma_K;
	Real P_K;
	Real Z_K;
	       	
 private:

};

LIBECS_DM_INIT( ICaLAssignmentProcess, Process );
