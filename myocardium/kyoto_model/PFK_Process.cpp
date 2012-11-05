#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PFK_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( PFK_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KPFK_F6P );
		PROPERTYSLOT_SET_GET( Real, KPFK_F6P2 );
		PROPERTYSLOT_SET_GET( Real, KPFK_ATP );
		PROPERTYSLOT_SET_GET( Real, KPFK_ATP2 );
		PROPERTYSLOT_SET_GET( Real, KPFK_FBP );
		PROPERTYSLOT_SET_GET( Real, KPFK_FBP2 );
		PROPERTYSLOT_SET_GET( Real, KPFK_ADP );
		PROPERTYSLOT_SET_GET( Real, KPFK_ADP2 );
		PROPERTYSLOT_SET_GET( Real, KPFK_iATP );
		PROPERTYSLOT_SET_GET( Real, KPFK_aAMP );
		PROPERTYSLOT_SET_GET( Real, d_PFK );
		PROPERTYSLOT_SET_GET( Real, e_PFK );
		PROPERTYSLOT_SET_GET( Real, Lo_PFK ); 
		PROPERTYSLOT_SET_GET( Real, KPFK_eq);
	}
	
	PFK_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KPFK_F6P );
	SIMPLE_SET_GET_METHOD( Real, KPFK_F6P2 );
	SIMPLE_SET_GET_METHOD( Real, KPFK_ATP );
	SIMPLE_SET_GET_METHOD( Real, KPFK_ATP2 );
	SIMPLE_SET_GET_METHOD( Real, KPFK_FBP );
	SIMPLE_SET_GET_METHOD( Real, KPFK_FBP2 );
	SIMPLE_SET_GET_METHOD( Real, KPFK_ADP );
	SIMPLE_SET_GET_METHOD( Real, KPFK_ADP2 );
	SIMPLE_SET_GET_METHOD( Real, KPFK_iATP );
	SIMPLE_SET_GET_METHOD( Real, KPFK_aAMP );
	SIMPLE_SET_GET_METHOD( Real, d_PFK );
	SIMPLE_SET_GET_METHOD( Real, e_PFK );
	SIMPLE_SET_GET_METHOD( Real, Lo_PFK ); 
	SIMPLE_SET_GET_METHOD( Real, KPFK_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VPFK_maxf  = getVariableReference( "VPFK_maxf" ).getVariable();
		F6P  = getVariableReference( "F6P" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		ADP  = getVariableReference( "ADP" ).getVariable();
		AMP  = getVariableReference( "AMP" ).getVariable();
		FBP  = getVariableReference( "FBP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real delta1 = (1.0 + F6P->getMolarConc()*1000.0 / KPFK_F6P) * (1.0 + ATP->getMolarConc()*1000.0 / KPFK_ATP)+ ADP->getMolarConc()*1000.0 / KPFK_ADP + FBP->getMolarConc()*1000.0 / KPFK_FBP * (1.0 + ADP->getMolarConc()*1000.0 / KPFK_ADP);

	  Real delta2 = (1.0 + F6P->getMolarConc()*1000.0 / KPFK_F6P2) * (1.0 + ATP->getMolarConc()*1000.0 / KPFK_ATP2)+ ADP->getMolarConc()*1000.0 / KPFK_ADP2 + FBP->getMolarConc()*1000.0 / KPFK_FBP2 * (1.0 + ADP->getMolarConc()*1000.0 / KPFK_ADP2);

	  Real alpha = KPFK_F6P * KPFK_ATP / KPFK_F6P2 / KPFK_ATP2;
	  Real L = Lo_PFK * pow(((1.0+ATP->getMolarConc()*1000.0/KPFK_iATP) / (1.0 + d_PFK * ATP->getMolarConc()*1000.0/KPFK_iATP)) * ((1.0 + e_PFK * AMP->getMolarConc()*1000.0/KPFK_aAMP) / (1.0 + AMP->getMolarConc()*1000.0/KPFK_aAMP)), 4);
	  
	  Real VPFK_maxr = VPFK_maxf->getValue() * KPFK_ADP * KPFK_FBP / KPFK_ATP / KPFK_F6P / KPFK_eq;
	  
	  Real PFK_a = (1.0 + alpha * L * pow(delta2/delta1, 3))*(VPFK_maxf->getValue() * ATP->getMolarConc()*1000.0 * F6P->getMolarConc()*1000.0 /(KPFK_ATP * KPFK_F6P) - VPFK_maxr * ADP->getMolarConc()*1000.0 * FBP->getMolarConc()*1000.0 /(KPFK_ADP * KPFK_FBP));
	  Real PFK_b = delta1 * (1.0 + L * pow(delta2/delta1, 4));
	  
	  setFlux( GX->getValue() * _SizeN_A * PFK_a / PFK_b / 60000.0 /1000.0);

	  //	  setFlux(PFK_a / PFK_b );
	  //V_PFK.setValue(PFK_a / PFK_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VPFK_maxf;
	Variable* F6P;
	Variable* ATP;
	Variable* ADP;
	Variable* AMP;
	Variable* FBP;
	Variable* GX;

	Real KPFK_F6P;
	Real KPFK_F6P2;
	Real KPFK_ATP;
	Real KPFK_ATP2;
	Real KPFK_FBP;
	Real KPFK_FBP2;
	Real KPFK_ADP;
	Real KPFK_ADP2;
	Real KPFK_iATP;
	Real KPFK_aAMP;
	Real d_PFK;
	Real e_PFK;
	Real Lo_PFK;
	Real KPFK_eq;

 private:


};

LIBECS_DM_INIT( PFK_Process, Process );

