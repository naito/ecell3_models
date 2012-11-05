#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( CK_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( CK_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KCK_PCr );
		PROPERTYSLOT_SET_GET( Real, KCK_iATP );
		PROPERTYSLOT_SET_GET( Real, KCK_iADP );
		PROPERTYSLOT_SET_GET( Real, KCK_iPCr );
		PROPERTYSLOT_SET_GET( Real, KCK_Cr );
		PROPERTYSLOT_SET_GET( Real, KCK_eq );
	}
	
	CK_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KCK_PCr );
	SIMPLE_SET_GET_METHOD( Real, KCK_iATP );
	SIMPLE_SET_GET_METHOD( Real, KCK_iADP );
	SIMPLE_SET_GET_METHOD( Real, KCK_iPCr );
	SIMPLE_SET_GET_METHOD( Real, KCK_Cr );
	SIMPLE_SET_GET_METHOD( Real, KCK_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VCK_maxr  = getVariableReference( "VCK_maxr" ).getVariable();
		PCr  = getVariableReference( "PCr" ).getVariable();
		ADP  = getVariableReference( "ADP" ).getVariable();
		Cr  = getVariableReference( "Cr" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VCK_maxf = VCK_maxr->getValue() * KCK_iATP * KCK_Cr * KCK_eq / KCK_iADP / KCK_PCr;

	  Real CK_a = VCK_maxr->getValue() * ATP->getMolarConc()*1000.0 * Cr->getMolarConc()*1000.0 / (KCK_iATP * KCK_Cr) - VCK_maxf * ADP->getMolarConc()*1000.0 * PCr->getMolarConc()*1000.0 / (KCK_iADP * KCK_PCr);

	  Real CK_b = 1.0 + ADP->getMolarConc()*1000.0 / KCK_iADP + PCr->getMolarConc()*1000.0 / KCK_iPCr + ADP->getMolarConc()*1000.0 * PCr->getMolarConc()*1000.0 / (KCK_iADP * KCK_PCr) + ATP->getMolarConc()*1000.0 / KCK_iATP + Cr->getMolarConc()*1000.0 / KCK_Cr + ATP->getMolarConc()*1000.0 * Cr->getMolarConc()*1000.0 / (KCK_iATP * KCK_Cr);
	  
	  setFlux(GX->getValue() * _SizeN_A * CK_a / CK_b / 60000.0 /1000.0);
	  
	  //	  Real V_CK = 16.05 * PCr->getMolarConc()*1000.0 * ADP->getMolarConc()*1000.0 - 9.67e-6 * ATP->getMolarConc()*1000.0 * Cr->getMolarConc()*1000.0;
	  //	  setFlux(V_CK * _SizeN_A / 60000.0 / 1000.0);
	  //	  setFlux(CK_a / CK_b );
	  //V_CK.setValue(CK_a / CK_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VCK_maxr;
	Variable* PCr;
	Variable* ADP;
	Variable* Cr;
	Variable* ATP;
	Variable* GX;

	Real KCK_PCr;
	Real KCK_iATP;
	Real KCK_iADP;
	Real KCK_iPCr;
	Real KCK_Cr;
	Real KCK_eq;

 private:


};

LIBECS_DM_INIT( CK_Process, Process );

