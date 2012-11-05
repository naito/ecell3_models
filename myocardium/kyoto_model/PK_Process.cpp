#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PK_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( PK_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KPK_PEP );
		PROPERTYSLOT_SET_GET( Real, KPK_ADP );
		PROPERTYSLOT_SET_GET( Real, KPK_PYR );
		PROPERTYSLOT_SET_GET( Real, KPK_ATP );
		PROPERTYSLOT_SET_GET( Real, KPK_eq );
	}
	
	PK_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KPK_PEP );
	SIMPLE_SET_GET_METHOD( Real, KPK_ADP );
	SIMPLE_SET_GET_METHOD( Real, KPK_PYR );
	SIMPLE_SET_GET_METHOD( Real, KPK_ATP );
	SIMPLE_SET_GET_METHOD( Real, KPK_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VPK_maxf  = getVariableReference( "VPK_maxf" ).getVariable();
		PEP  = getVariableReference( "PEP" ).getVariable();
		ADP  = getVariableReference( "ADP" ).getVariable();
		PYR  = getVariableReference( "PYR" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VPK_maxr = VPK_maxf->getValue() * KPK_ATP * KPK_PYR / KPK_PEP / KPK_ADP / KPK_eq;

	  Real PK_a = VPK_maxf->getValue() * PEP->getMolarConc()*1000.0 * ADP->getMolarConc()*1000.0 /(KPK_PEP * KPK_ADP) - VPK_maxr * PYR->getMolarConc()*1000.0 * ATP->getMolarConc()*1000.0 / (KPK_PYR * KPK_ATP);

	  Real PK_b = 1.0 + PEP->getMolarConc()*1000.0 / KPK_PEP + ADP->getMolarConc()*1000.0 / KPK_ADP + PEP->getMolarConc()*1000.0 * ADP->getMolarConc()*1000.0 /(KPK_PEP * KPK_ADP) + PYR->getMolarConc()*1000.0 / KPK_PYR + ATP->getMolarConc()*1000.0 / KPK_ATP + PYR->getMolarConc()*1000.0 * ATP->getMolarConc()*1000.0 / (KPK_PYR * KPK_ATP);
	  
	  setFlux( GX->getValue() * _SizeN_A * PK_a / PK_b / 60000.0 /1000.0);
	  //	  setFlux(PK_a / PK_b );
	  //V_PK.setValue(PK_a / PK_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VPK_maxf;
	Variable* PEP;
	Variable* ADP;
	Variable* PYR;
	Variable* ATP;
	Variable* GX;

	Real KPK_PEP;
	Real KPK_ADP;
	Real KPK_PYR;
	Real KPK_ATP;
	Real KPK_eq;

 private:


};

LIBECS_DM_INIT( PK_Process, Process );

