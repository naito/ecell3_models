#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IhaAssignmentProcess_Kurata, Process )
{

 public:

	LIBECS_DM_OBJECT( IhaAssignmentProcess_Kurata, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a11 );
		PROPERTYSLOT_SET_GET( Real,a12 );
		PROPERTYSLOT_SET_GET( Real,a13 );
		
		PROPERTYSLOT_SET_GET( Real,b0 );
		PROPERTYSLOT_SET_GET( Real,b12 );
		PROPERTYSLOT_SET_GET( Real,b13 );
		PROPERTYSLOT_SET_GET( Real,b22 );
		PROPERTYSLOT_SET_GET( Real,b23 );

		PROPERTYSLOT_SET_GET( Real,P_Na );
		PROPERTYSLOT_SET_GET( Real,P_K );		
	}
	
	IhaAssignmentProcess_Kurata()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,a0 );
	SIMPLE_SET_GET_METHOD( Real,a11 );
	SIMPLE_SET_GET_METHOD( Real,a12 );
	SIMPLE_SET_GET_METHOD( Real,a13 );
	
	SIMPLE_SET_GET_METHOD( Real,b0 );
	SIMPLE_SET_GET_METHOD( Real,b12 );
	SIMPLE_SET_GET_METHOD( Real,b13 );
	SIMPLE_SET_GET_METHOD( Real,b22 );
	SIMPLE_SET_GET_METHOD( Real,b23 );

	SIMPLE_SET_GET_METHOD( Real,P_Na );
	SIMPLE_SET_GET_METHOD( Real,P_K );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		EK    = getVariableReference( "EK" ).getVariable();
		ENa    = getVariableReference( "ENa" ).getVariable();

		Ke  = getVariableReference( "Ke" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();
		Nae  = getVariableReference( "Nae" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();

		dvHCNGt     = getVariableReference( "dvHCNGt" ).getVariable();
		HCNGt     = getVariableReference( "HCNGt" ).getVariable();

		pOpen  = getVariableReference( "pOpen" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cK     = getVariableReference( "cK" ).getVariable();
		cNa     = getVariableReference( "cNa" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();
	  Real _EK = EK->getValue();
	  Real _ENa = ENa->getValue();

	  Real yHCN = HCNGt->getValue();
	  pOpen->setValue( yHCN );

	  Real _cK = GX->getValue() * P_K * (theVm - _EK) * yHCN * yHCN ;
	  Real _cNa = GX->getValue() * P_Na * (theVm - _ENa) * yHCN * yHCN ;

	  cK->setValue( _cK );
	  cNa->setValue( _cNa );
	  I->setValue( _cK + _cNa );

	  /// HCN gating
	  Real Iha_HCNGt_inf = a0 / (a11 + exp((theVm - a12)/a13));
	  Real Iha_HCNGt_tau = b0 / (exp((theVm - b12)/b13)+exp((theVm - b22)/b23));

	  Real alpha = Iha_HCNGt_inf/Iha_HCNGt_tau;
	  Real beta = (1.0-Iha_HCNGt_inf)/Iha_HCNGt_tau;

	  Real _vHCN = alpha * (1.0 - yHCN ) - beta * yHCN;

	  dvHCNGt->setValue( _vHCN );

	}

 protected:

	Variable* Vm;
	Variable* EK;
	Variable* ENa;

	Variable* Ke;
	Variable* Ki;
	Variable* Nae;
	Variable* Nai;

	Variable* dvHCNGt;
	Variable* HCNGt;

	Variable* pOpen;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cK;
	Variable* cNa;

	Variable* I;
      
	Real a0;
	Real a11;
	Real a12;
	Real a13;

	Real b0;
	Real b12;
	Real b13;
	Real b22;
	Real b23;
	
	Real P_Na;
	Real P_K;
       
 private:

};

LIBECS_DM_INIT( IhaAssignmentProcess_Kurata, Process );

