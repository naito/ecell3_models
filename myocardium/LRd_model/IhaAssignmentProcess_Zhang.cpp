#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IhaAssignmentProcess_Zhang, Process )
{

 public:

	LIBECS_DM_OBJECT( IhaAssignmentProcess_Zhang, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,a11 );
		PROPERTYSLOT_SET_GET( Real,a12 );

		PROPERTYSLOT_SET_GET( Real,b11 );
		PROPERTYSLOT_SET_GET( Real,b12 );

		PROPERTYSLOT_SET_GET( Real,P_Na );
		PROPERTYSLOT_SET_GET( Real,P_K );		
	}
	
	IhaAssignmentProcess_Zhang()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,a11 );
	SIMPLE_SET_GET_METHOD( Real,a12 );

	SIMPLE_SET_GET_METHOD( Real,b11 );
	SIMPLE_SET_GET_METHOD( Real,b12 );

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
	  
	  if(yHCN < 0){
	  	    yHCN = 0;
	  }

	  Real _cK = GX->getValue() * P_K * (theVm - _EK) * yHCN;
	  Real _cNa = GX->getValue() * P_Na * (theVm - _ENa) * yHCN;

	  cK->setValue( _cK );
	  cNa->setValue( _cNa );
	  I->setValue( _cK + _cNa );

	  /// HCN gating
	  Real alpha = exp((theVm+a11)/a12);
	  Real beta = exp((theVm+b11)/b12);

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
      
	Real a11;
	Real a12;

	Real b11;
	Real b12;

	Real P_Na;
	Real P_K;
       
 private:

};

LIBECS_DM_INIT( IhaAssignmentProcess_Zhang, Process );

