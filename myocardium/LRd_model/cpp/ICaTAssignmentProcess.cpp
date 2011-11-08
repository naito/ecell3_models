#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ICaTAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ICaTAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real,a0 );
		PROPERTYSLOT_SET_GET( Real,a11 );
		PROPERTYSLOT_SET_GET( Real,a12 );
		PROPERTYSLOT_SET_GET( Real,a13 );
		PROPERTYSLOT_SET_GET( Real,a2 );
		
		PROPERTYSLOT_SET_GET( Real,b0 );
		PROPERTYSLOT_SET_GET( Real,b11 );
		PROPERTYSLOT_SET_GET( Real,b12 );
		PROPERTYSLOT_SET_GET( Real,b13 );
		PROPERTYSLOT_SET_GET( Real,b2 );
		PROPERTYSLOT_SET_GET( Real,b3 );
		
		PROPERTYSLOT_SET_GET( Real,c0 );
		PROPERTYSLOT_SET_GET( Real,c11 );
		PROPERTYSLOT_SET_GET( Real,c12 );
		PROPERTYSLOT_SET_GET( Real,c13 );
		PROPERTYSLOT_SET_GET( Real,c2 );
		
		PROPERTYSLOT_SET_GET( Real,d0 );
		PROPERTYSLOT_SET_GET( Real,d1 );
		PROPERTYSLOT_SET_GET( Real,d2 );
		
		PROPERTYSLOT_SET_GET( Real,gCaT_amp );      
	}
	
	ICaTAssignmentProcess()
	{
		;
	}

	SIMPLE_SET_GET_METHOD( Real,a0 );
	SIMPLE_SET_GET_METHOD( Real,a11 );
	SIMPLE_SET_GET_METHOD( Real,a12 );
	SIMPLE_SET_GET_METHOD( Real,a13 );
	SIMPLE_SET_GET_METHOD( Real,a2 );
	
	SIMPLE_SET_GET_METHOD( Real,b0 );
	SIMPLE_SET_GET_METHOD( Real,b11 );
	SIMPLE_SET_GET_METHOD( Real,b12 );
	SIMPLE_SET_GET_METHOD( Real,b13 );
	SIMPLE_SET_GET_METHOD( Real,b2 );
	SIMPLE_SET_GET_METHOD( Real,b3 );
	
	SIMPLE_SET_GET_METHOD( Real,c0 );
	SIMPLE_SET_GET_METHOD( Real,c11 );
	SIMPLE_SET_GET_METHOD( Real,c12 );
	SIMPLE_SET_GET_METHOD( Real,c13 );
	SIMPLE_SET_GET_METHOD( Real,c2 );
	
	SIMPLE_SET_GET_METHOD( Real,d0 );
	SIMPLE_SET_GET_METHOD( Real,d1 );
	SIMPLE_SET_GET_METHOD( Real,d2 );
	
	SIMPLE_SET_GET_METHOD( Real,gCaT_amp );

	virtual void initialize()
	{
		Process::initialize();
		
		Vm    = getVariableReference( "Vm" ).getVariable();
		ECa    = getVariableReference( "ECa" ).getVariable();

		Cae  = getVariableReference( "Cae" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();

		dbGt     = getVariableReference( "dbGt" ).getVariable();
		dgGt     = getVariableReference( "dgGt" ).getVariable();
		bGt     = getVariableReference( "bGt" ).getVariable();
		gGt     = getVariableReference( "gGt" ).getVariable();

		pOpen  = getVariableReference( "pOpen" ).getVariable();

		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();

		cCa     = getVariableReference( "cCa" ).getVariable();

		I      = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{

	  Real theVm = Vm->getValue();

	  Real _bGt = bGt->getValue();
	  Real _gGt = gGt->getValue();
	  
	  pOpen->setValue( _bGt * _gGt );

	  Real _cCa = GX->getValue() * gCaT_amp * _bGt * _bGt * _gGt;
	  _cCa *= (theVm - ECa->getValue());
	  
	  cCa->setValue( _cCa );
	  I->setValue( _cCa );

	  /// b gating
	  Real bGt_inf = a0/(a11*exp((theVm+a12)/a13)+a2);
	  Real bGt_tau = b3;
	  bGt_tau += b0/(b11*exp((theVm+b12)/b13)+b2);

	  Real b_alpha = bGt_inf/bGt_tau;
	  Real b_beta = (1.0 - bGt_inf)/bGt_tau;
		
	  Real _vGtb = b_alpha * ( 1.0 - _bGt ) - b_beta * _bGt;

	  dbGt->setValue( _vGtb );

	  /// g gating
	  Real gGt_inf = c0/(c11*exp((theVm+c12)/c13)+c2);
	  Real gGt_tau;
	
	  if(theVm > 0.0) gGt_tau = d0;
	  else gGt_tau = d1 * theVm + d2;

	  Real g_alpha = gGt_inf/gGt_tau;
	  Real g_beta = (1.0 - gGt_inf)/gGt_tau;

	  Real _vGtg = g_alpha * ( 1.0 - _gGt ) - g_beta * _gGt;
	  dgGt->setValue( _vGtg );

	  ///setFlux( 1000.0 * velocity );	// x1000 for msec^-1 -> sec^-1	
	  
	}

 protected:

	Variable* Vm;
	Variable* ECa;

	Variable* Cae;
	Variable* Cai;

	Variable* dbGt;
	Variable* dgGt;
	Variable* bGt;
	Variable* gGt;

	Variable* pOpen;

	Variable* i;
	Variable* GX;
	Variable* Cm;

	Variable* cCa;

	Variable* I;
       
	Real a0;
	Real a11;
	Real a12;
	Real a13;
	Real a2;
	
	Real b0;
	Real b11;
	Real b12;
	Real b13;
	Real b2;
	Real b3;
	
	Real c0;
	Real c11;
	Real c12;
	Real c13;
	Real c2;
	
	Real d0;
	Real d1;
	Real d2;
	
	Real gCaT_amp;
	
 private:

};

LIBECS_DM_INIT( ICaTAssignmentProcess, Process );
