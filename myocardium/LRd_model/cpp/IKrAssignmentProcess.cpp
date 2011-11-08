#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKrAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKrAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,ka0 );
		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a11 );
		PROPERTYSLOT_SET_GET( Real,a12 );
		PROPERTYSLOT_SET_GET( Real,a13 );
		PROPERTYSLOT_SET_GET( Real,a2 );
		
		PROPERTYSLOT_SET_GET( Real,kb0 );
		PROPERTYSLOT_SET_GET( Real,b0 );
		PROPERTYSLOT_SET_GET( Real,b11 );
		PROPERTYSLOT_SET_GET( Real,b12 );
		PROPERTYSLOT_SET_GET( Real,b13 );
		PROPERTYSLOT_SET_GET( Real,b2 );
		
		PROPERTYSLOT_SET_GET( Real,c0 );
		PROPERTYSLOT_SET_GET( Real,c11 );
		PROPERTYSLOT_SET_GET( Real,c12 );
		PROPERTYSLOT_SET_GET( Real,c13 );
		PROPERTYSLOT_SET_GET( Real,c2 );
		
		PROPERTYSLOT_SET_GET( Real,k0 );
		PROPERTYSLOT_SET_GET( Real,k11 );
		PROPERTYSLOT_SET_GET( Real,k12 );
		PROPERTYSLOT_SET_GET( Real,k13 );
		PROPERTYSLOT_SET_GET( Real,k2 );
	}
	
	IKrAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,ka0 );
	SIMPLE_SET_GET_METHOD( Real,a0 );
	SIMPLE_SET_GET_METHOD( Real,a11 );
	SIMPLE_SET_GET_METHOD( Real,a12 );
	SIMPLE_SET_GET_METHOD( Real,a13 );
	SIMPLE_SET_GET_METHOD( Real,a2 );
	
	SIMPLE_SET_GET_METHOD( Real,kb0 );
	SIMPLE_SET_GET_METHOD( Real,b0 );
	SIMPLE_SET_GET_METHOD( Real,b11 );
	SIMPLE_SET_GET_METHOD( Real,b12 );
	SIMPLE_SET_GET_METHOD( Real,b13 );
	SIMPLE_SET_GET_METHOD( Real,b2 );
	
	SIMPLE_SET_GET_METHOD( Real,c0 );
	SIMPLE_SET_GET_METHOD( Real,c11 );
	SIMPLE_SET_GET_METHOD( Real,c12 );
	SIMPLE_SET_GET_METHOD( Real,c13 );
	SIMPLE_SET_GET_METHOD( Real,c2 );
	
	SIMPLE_SET_GET_METHOD( Real,k0 );
	SIMPLE_SET_GET_METHOD( Real,k11 );
	SIMPLE_SET_GET_METHOD( Real,k12 );
	SIMPLE_SET_GET_METHOD( Real,k13 );
	SIMPLE_SET_GET_METHOD( Real,k2 );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();

		Ke  = getVariableReference( "Ke" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();

		dr     = getVariableReference( "dr" ).getVariable();
		r     = getVariableReference( "r" ).getVariable();

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
	  Real _EK = EK->getValue();

	  Real IKr_GKr_amp = 0.02614 * sqrt(Ke->getMolarConc()*1000.0/5.4);
	  Real IKr_Rr = k0/(k11*exp((theVm+k12)/k13)+k2);
  
	  Real yXr = r->getValue();
	  pOpen->setValue( yXr );

	  Real _cK = GX->getValue() * IKr_GKr_amp * yXr * IKr_Rr * (theVm - _EK);
	  cK->setValue( _cK );
	  I->setValue( _cK );

	  /// r gating
	  Real IKr_XrGt_inf = c0/(c11*exp((theVm+c12)/c13)+c2);

	  Real IKr_XrGt_tau = ka0*(theVm + a0)/(a11*exp((theVm+a12)*a13)+a2); 
	  IKr_XrGt_tau += kb0*(theVm + b0)/(b11*exp((theVm+b12)*b13)+b2);

	  IKr_XrGt_tau = 1.0/IKr_XrGt_tau;

	  Real alpha = IKr_XrGt_inf/IKr_XrGt_tau;
	  Real beta = (1.0 - IKr_XrGt_inf)/IKr_XrGt_tau;
		
	  Real _vXr = alpha * ( 1.0 - yXr ) - beta * yXr;
	  dr->setValue( _vXr ); 
	}

 protected:

	Variable* Vm;
	Variable* EK;

	Variable* Ke;
	Variable* Ki;

	Variable* dr;
	Variable* r;

	Variable* pOpen;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;

	Variable* I;
      
	Real ka0;
	Real a0;
	Real a11;
	Real a12;
	Real a13;
	Real a2;
	
	Real kb0;
	Real b0;
	Real b11;
	Real b12;
	Real b13;
	Real b2;
	
	Real c0;
	Real c11;
	Real c12;
	Real c13;
	Real c2;
       
	Real k0;
	Real k11;
	Real k12;
	Real k13;
	Real k2;
       
 private:

};

LIBECS_DM_INIT( IKrAssignmentProcess, Process );
