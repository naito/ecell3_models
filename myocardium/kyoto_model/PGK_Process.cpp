#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PGK_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( PGK_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KPGK_13BPG );
		PROPERTYSLOT_SET_GET( Real, KPGK_ADP );
		PROPERTYSLOT_SET_GET( Real, KPGK_3PG );
		PROPERTYSLOT_SET_GET( Real, KPGK_ATP );
		PROPERTYSLOT_SET_GET( Real, KPGK_eq );
	}
	
	PGK_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KPGK_13BPG );
	SIMPLE_SET_GET_METHOD( Real, KPGK_ADP );
	SIMPLE_SET_GET_METHOD( Real, KPGK_3PG );
	SIMPLE_SET_GET_METHOD( Real, KPGK_ATP );
	SIMPLE_SET_GET_METHOD( Real, KPGK_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VPGK_maxr  = getVariableReference( "VPGK_maxr" ).getVariable();
		BPG13  = getVariableReference( "BPG13" ).getVariable();
		ADP  = getVariableReference( "ADP" ).getVariable();
		PG3  = getVariableReference( "PG3" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VPGK_maxf =VPGK_maxr->getValue() * KPGK_13BPG * KPGK_ADP * KPGK_eq / KPGK_3PG / KPGK_ATP;

	  Real PGK_a = VPGK_maxf * BPG13->getMolarConc()*1000.0 * ADP->getMolarConc()*1000.0 / (KPGK_13BPG * KPGK_ADP) - VPGK_maxr->getValue() * PG3->getMolarConc()*1000.0 * ATP->getMolarConc()*1000.0 / (KPGK_3PG * KPGK_ATP);

	  Real PGK_b = 1.0 + BPG13->getMolarConc()*1000.0 / KPGK_13BPG + ADP->getMolarConc()*1000.0 / KPGK_ADP + BPG13->getMolarConc()*1000.0 * ADP->getMolarConc()*1000.0 / (KPGK_13BPG * KPGK_ADP) + PG3->getMolarConc()*1000.0 / KPGK_3PG + ATP->getMolarConc()*1000.0 / KPGK_ATP + PG3->getMolarConc()*1000.0 * ATP->getMolarConc()*1000.0 / (KPGK_3PG * KPGK_ATP);
	  
	  setFlux( GX->getValue() * _SizeN_A * PGK_a / PGK_b /60000.0 /1000.0);

	  //	  setFlux(PGK_a / PGK_b );
	  //V_PGK.setValue(PGK_a / PGK_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VPGK_maxr;
	Variable* BPG13;
	Variable* ADP;
	Variable* PG3;
	Variable* ATP;
	Variable* GX;

	Real KPGK_13BPG;
	Real KPGK_ADP;
	Real KPGK_3PG;
	Real KPGK_ATP;
	Real KPGK_eq;

 private:


};

LIBECS_DM_INIT( PGK_Process, Process );

