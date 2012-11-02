#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( HK_Process, Process )
{

 public:

	LIBECS_DM_OBJECT( HK_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, Kapp );
		PROPERTYSLOT_SET_GET( Real, KATP );
		PROPERTYSLOT_SET_GET( Real, KGlc );
		PROPERTYSLOT_SET_GET( Real, KADP );
		PROPERTYSLOT_SET_GET( Real, KG6P );
		PROPERTYSLOT_SET_GET( Real, KiATP );
		PROPERTYSLOT_SET_GET( Real, KiGlc );
		PROPERTYSLOT_SET_GET( Real, KiADP );
		PROPERTYSLOT_SET_GET( Real, KiG6P );
	}
	
	HK_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, Kapp );
	SIMPLE_SET_GET_METHOD( Real, KATP );
	SIMPLE_SET_GET_METHOD( Real, KGlc );
	SIMPLE_SET_GET_METHOD( Real, KADP );
	SIMPLE_SET_GET_METHOD( Real, KG6P );
	SIMPLE_SET_GET_METHOD( Real, KiATP );
	SIMPLE_SET_GET_METHOD( Real, KiGlc );
	SIMPLE_SET_GET_METHOD( Real, KiADP );
	SIMPLE_SET_GET_METHOD( Real, KiG6P );

	virtual void initialize()
	{
		Process::initialize();
		
		Vf  = getVariableReference( "Vf" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		Glc  = getVariableReference( "Glc" ).getVariable();
		ADP  = getVariableReference( "ADP" ).getVariable();
		G6P  = getVariableReference( "G6P" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  //Real V_HK = 1.0 + FBP->getMolarConc()*1000.0 / KALD_FBP + DHAP->getMolarConc()*1000.0 / KALD_DHAP + GAP->getMolarConc()*1000.0 / KALD_GAP;

	  Real V_HK = ( Vf->getValue() * ATP->getMolarConc()*1000.0 * Glc->getMolarConc()*1000.0 - Vf->getValue() * ADP->getMolarConc()*1000.0 * G6P->getMolarConc()*1000.0 / Kapp ) / ( ATP->getMolarConc()*1000.0 * Glc->getMolarConc()*1000.0 + KATP * Glc->getMolarConc()*1000.0 + KGlc * ATP->getMolarConc()*1000.0 + KiATP * KGlc * ( 1.0 + G6P->getMolarConc()*1000.0 / KiG6P + ADP->getMolarConc()*1000.0 / KiADP + ADP->getMolarConc()*1000.0 * G6P->getMolarConc()*1000.0 / ( KiADP * KG6P )));

	  setFlux(GX->getValue() * _SizeN_A * V_HK / 60000.0 /1000.0);
	  //	  setFlux( V_HK );
	  //V_HK.setValue( V_HK / unit);
	  
	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* Vf;
	Variable* ATP;
	Variable* Glc;
	Variable* ADP;
	Variable* G6P;
	Variable* GX;

	Real Kapp;
	Real KATP;
	Real KGlc;
	Real KADP;
	Real KG6P;
	Real KiATP;
	Real KiGlc;
	Real KiADP;
	Real KiG6P;

 private:


};

LIBECS_DM_INIT( HK_Process, Process );

