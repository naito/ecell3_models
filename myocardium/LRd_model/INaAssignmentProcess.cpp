#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( INaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( INaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, ka0 );
		PROPERTYSLOT_SET_GET( Real, a0 );
		PROPERTYSLOT_SET_GET( Real, a11 );
		PROPERTYSLOT_SET_GET( Real, a12 );
		PROPERTYSLOT_SET_GET( Real, a13 );
		PROPERTYSLOT_SET_GET( Real, a2 );
		
		PROPERTYSLOT_SET_GET( Real, b0 );
		PROPERTYSLOT_SET_GET( Real, b1 );
		PROPERTYSLOT_SET_GET( Real, b2 );
		PROPERTYSLOT_SET_GET( Real, b3 );

		PROPERTYSLOT_SET_GET( Real, c0 );
		PROPERTYSLOT_SET_GET( Real, c1 );
		PROPERTYSLOT_SET_GET( Real, c2 );
		PROPERTYSLOT_SET_GET( Real, c3 );
		
		PROPERTYSLOT_SET_GET( Real, d0 );
		PROPERTYSLOT_SET_GET( Real, d1 );
		PROPERTYSLOT_SET_GET( Real, d2 );
		PROPERTYSLOT_SET_GET( Real, d3 );
		
		PROPERTYSLOT_SET_GET( Real, e0 );
		PROPERTYSLOT_SET_GET( Real, e1 );
		PROPERTYSLOT_SET_GET( Real, e2 );
		PROPERTYSLOT_SET_GET( Real, e3 );
		
		PROPERTYSLOT_SET_GET( Real, f0 );
		PROPERTYSLOT_SET_GET( Real, f11 );
		PROPERTYSLOT_SET_GET( Real, f12 );
		PROPERTYSLOT_SET_GET( Real, f13 );
		PROPERTYSLOT_SET_GET( Real, f2 );
		
		PROPERTYSLOT_SET_GET( Real, g0 );
		PROPERTYSLOT_SET_GET( Real, g1 );
		PROPERTYSLOT_SET_GET( Real, g2 );
		PROPERTYSLOT_SET_GET( Real, g3 );
		
		PROPERTYSLOT_SET_GET( Real, h0 );
		PROPERTYSLOT_SET_GET( Real, h1 );
		PROPERTYSLOT_SET_GET( Real, h2 );
		PROPERTYSLOT_SET_GET( Real, h3 );
		
		PROPERTYSLOT_SET_GET( Real, i0 );
		PROPERTYSLOT_SET_GET( Real, i11 );
		PROPERTYSLOT_SET_GET( Real, i12 );
		PROPERTYSLOT_SET_GET( Real, i13 );
		PROPERTYSLOT_SET_GET( Real, i2 );
		
		PROPERTYSLOT_SET_GET( Real, j0 );
		PROPERTYSLOT_SET_GET( Real, j1 );
		PROPERTYSLOT_SET_GET( Real, j2 );
		PROPERTYSLOT_SET_GET( Real, j3 );
		
		PROPERTYSLOT_SET_GET( Real, k0 );
		PROPERTYSLOT_SET_GET( Real, k11 );
		PROPERTYSLOT_SET_GET( Real, k12 );
		PROPERTYSLOT_SET_GET( Real, k13 );
		PROPERTYSLOT_SET_GET( Real, k2 );
		
		PROPERTYSLOT_SET_GET( Real, l0 );
		PROPERTYSLOT_SET_GET( Real, l1 );
		PROPERTYSLOT_SET_GET( Real, l2 );
		PROPERTYSLOT_SET_GET( Real, l3 );
		
		PROPERTYSLOT_SET_GET( Real, m0 );
		PROPERTYSLOT_SET_GET( Real, m11 );
		PROPERTYSLOT_SET_GET( Real, m12 );
		PROPERTYSLOT_SET_GET( Real, m13 );
		PROPERTYSLOT_SET_GET( Real, m2 );
		
		PROPERTYSLOT_SET_GET( Real, P );
		
	}
	
	INaAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real, ka0 );
	SIMPLE_SET_GET_METHOD( Real, a0 );
	SIMPLE_SET_GET_METHOD( Real, a11 );
	SIMPLE_SET_GET_METHOD( Real, a12 );
	SIMPLE_SET_GET_METHOD( Real, a13 );
	SIMPLE_SET_GET_METHOD( Real, a2 );

	SIMPLE_SET_GET_METHOD( Real, b0 );
	SIMPLE_SET_GET_METHOD( Real, b1 );
	SIMPLE_SET_GET_METHOD( Real, b2 );
	SIMPLE_SET_GET_METHOD( Real, b3 );

	SIMPLE_SET_GET_METHOD( Real, c0 );
	SIMPLE_SET_GET_METHOD( Real, c1 );
	SIMPLE_SET_GET_METHOD( Real, c2 );
	SIMPLE_SET_GET_METHOD( Real, c3 );
	
	SIMPLE_SET_GET_METHOD( Real, d0 );
	SIMPLE_SET_GET_METHOD( Real, d1 );
	SIMPLE_SET_GET_METHOD( Real, d2 );
	SIMPLE_SET_GET_METHOD( Real, d3 );
	
	SIMPLE_SET_GET_METHOD( Real, e0 );
	SIMPLE_SET_GET_METHOD( Real, e1 );
	SIMPLE_SET_GET_METHOD( Real, e2 );
	SIMPLE_SET_GET_METHOD( Real, e3 );
	
	SIMPLE_SET_GET_METHOD( Real, f0 );
	SIMPLE_SET_GET_METHOD( Real, f11 );
	SIMPLE_SET_GET_METHOD( Real, f12 );
	SIMPLE_SET_GET_METHOD( Real, f13 );
	SIMPLE_SET_GET_METHOD( Real, f2 );
	
	SIMPLE_SET_GET_METHOD( Real, g0 );
	SIMPLE_SET_GET_METHOD( Real, g1 );
	SIMPLE_SET_GET_METHOD( Real, g2 );
	SIMPLE_SET_GET_METHOD( Real, g3 );
	
	SIMPLE_SET_GET_METHOD( Real, h0 );
	SIMPLE_SET_GET_METHOD( Real, h1 );
	SIMPLE_SET_GET_METHOD( Real, h2 );
	SIMPLE_SET_GET_METHOD( Real, h3 );
	
	SIMPLE_SET_GET_METHOD( Real, i0 );
	SIMPLE_SET_GET_METHOD( Real, i11 );
	SIMPLE_SET_GET_METHOD( Real, i12 );
	SIMPLE_SET_GET_METHOD( Real, i13 );
	SIMPLE_SET_GET_METHOD( Real, i2 );
	
	SIMPLE_SET_GET_METHOD( Real, j0 );
	SIMPLE_SET_GET_METHOD( Real, j1 );
	SIMPLE_SET_GET_METHOD( Real, j2 );
	SIMPLE_SET_GET_METHOD( Real, j3 );
	
	SIMPLE_SET_GET_METHOD( Real, k0 );
	SIMPLE_SET_GET_METHOD( Real, k11 );
	SIMPLE_SET_GET_METHOD( Real, k12 );
	SIMPLE_SET_GET_METHOD( Real, k13 );
	SIMPLE_SET_GET_METHOD( Real, k2 );
	
	SIMPLE_SET_GET_METHOD( Real, l0 );
	SIMPLE_SET_GET_METHOD( Real, l1 );
	SIMPLE_SET_GET_METHOD( Real, l2 );
	SIMPLE_SET_GET_METHOD( Real, l3 );
	
	SIMPLE_SET_GET_METHOD( Real, m0 );
	SIMPLE_SET_GET_METHOD( Real, m11 );
	SIMPLE_SET_GET_METHOD( Real, m12 );
	SIMPLE_SET_GET_METHOD( Real, m13 );
	SIMPLE_SET_GET_METHOD( Real, m2 );
	
	SIMPLE_SET_GET_METHOD( Real, P );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		ENa    = getVariableReference( "ENa" ).getVariable();

		Nae  = getVariableReference( "Nae" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();

		dmGt     = getVariableReference( "dmGt" ).getVariable();
		dhGt     = getVariableReference( "dhGt" ).getVariable();
		djGt     = getVariableReference( "djGt" ).getVariable();
		mGt     = getVariableReference( "mGt" ).getVariable();
		hGt     = getVariableReference( "hGt" ).getVariable();
		jGt     = getVariableReference( "jGt" ).getVariable();

		pOpen  = getVariableReference( "pOpen" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cNa     = getVariableReference( "cNa" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();
	  
	  Real _mGt = mGt->getValue();
	  Real _hGt = hGt->getValue();
	  Real _jGt = jGt->getValue();
	  
	  pOpen->setValue( _mGt * _hGt * _jGt );

	  Real _cNa = GX->getValue() * P * (_mGt*_mGt*_mGt) * _hGt * _jGt;
	  _cNa *= (theVm - ENa->getValue());

	  cNa->setValue( _cNa );
	  I->setValue( _cNa );

	  /// m gating
	  Real m_alpha = (ka0 * (theVm + a0))/
	    (a11 * exp((theVm + a12 )*a13 ) + a2);
	  
	  Real m_beta = b0 + b1 * exp((theVm + b2)/b3);
	  
	  Real _vGtm = 0;
	  
	  if(theVm >= -80.0){
	    _vGtm = m_alpha * ( 1.0 - _mGt ) - m_beta * _mGt;
	  }

	  dmGt->setValue( _vGtm );

	  /// h gating
	  
	  Real h_alpha,h_beta;

	  if(theVm < -40.0){
	    h_alpha = c0 + c1 * exp((theVm + c2)/c3);
	    h_beta = d0 + d1 * exp((theVm + d2)*d3);
	    h_beta += e0 + e1 * exp((theVm + e2)*e3);
	  }
	  else{
	    h_alpha = 0.0;
	    h_beta = f0/(f11 * exp((theVm + f12 )/f13 ) + f2);
	  }
	
	  Real _vGth = h_alpha * ( 1.0 - _hGt ) - h_beta * _hGt;

	  dhGt->setValue( _vGth );

	  /// j gating

	  Real j_alpha,j_beta;	

	  if(theVm < -40.0){
	    j_alpha = g0 + g1 * exp((theVm + g2)*g3);
	    j_alpha += h0 + h1 * exp((theVm + h2)*h3);
	    j_alpha *= (theVm + i0)/(i11 * exp((theVm + i12 )*i13 ) + i2);
	    
	    j_beta = j0 + j1 * exp((theVm + j2)*j3);
	    j_beta /= (k11 * exp((theVm + k12 )*k13 ) + k2);
	  }
	  else{
	    j_alpha = 0.0;
	    j_beta = l0 + l1 * exp((theVm + l2)*l3);
	    j_beta /= (m11 * exp((theVm + m12 )*m13 ) + m2);
	  }
	  
	  Real _vGtj = j_alpha * ( 1.0 - _jGt ) - j_beta * _jGt;

	  djGt->setValue( _vGtj );

	  ///setFlux( 1000.0 * velocity );	// x1000 for msec^-1 -> sec^-1	
	  
	}

 protected:

	Variable* Vm;
	Variable* ENa;

	Variable* Nae;
	Variable* Nai;

	Variable* dmGt;
	Variable* dhGt;
	Variable* djGt;
	Variable* mGt;
	Variable* hGt;
	Variable* jGt;

	Variable* pOpen;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cNa;

	Variable* I;
       
	Real ka0;
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
	
	Real d0;
	Real d1;
	Real d2;
	Real d3;
	
	Real e0;
	Real e1;
	Real e2;
	Real e3;
	
	Real f0;
	Real f11;
	Real f12;
	Real f13;  
	Real f2;	

	Real g0;
	Real g1;
	Real g2;
	Real g3;
	
	Real h0;
	Real h1;
	Real h2;
	Real h3;
	
	Real i0;
	Real i11;
	Real i12;
	Real i13;  
	Real i2;
	
	Real j0;
	Real j1;
	Real j2;
	Real j3;
	
	Real k0;
	Real k11;
	Real k12;
	Real k13;  
	Real k2;
	
	Real l0;
	Real l1;
	Real l2;
	Real l3;

	Real m0;
	Real m11;
	Real m12;
	Real m13;  
	Real m2;

	Real P;

 private:

};

LIBECS_DM_INIT( INaAssignmentProcess, Process );
