#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( LDH_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( LDH_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KLDH_PYR );
		PROPERTYSLOT_SET_GET( Real, KLDH_NADH );
		PROPERTYSLOT_SET_GET( Real, KLDH_LAC );
		PROPERTYSLOT_SET_GET( Real, KLDH_NAD );
		PROPERTYSLOT_SET_GET( Real, KLDH_eq );
	}
	
	LDH_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KLDH_PYR );
	SIMPLE_SET_GET_METHOD( Real, KLDH_NADH );
	SIMPLE_SET_GET_METHOD( Real, KLDH_LAC );
	SIMPLE_SET_GET_METHOD( Real, KLDH_NAD );
	SIMPLE_SET_GET_METHOD( Real, KLDH_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VLDH_maxf  = getVariableReference( "VLDH_maxf" ).getVariable();
		PYR  = getVariableReference( "PYR" ).getVariable();
		NADH  = getVariableReference( "NADH" ).getVariable();
		LAC  = getVariableReference( "LAC" ).getVariable();
		NAD  = getVariableReference( "NAD" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VLDH_maxr = VLDH_maxf->getValue() * KLDH_LAC * KLDH_NAD / KLDH_PYR / KLDH_NADH / KLDH_eq;

	  Real LDH_a = VLDH_maxf->getValue() * PYR->getMolarConc()*1000.0 * NADH->getMolarConc()*1000.0 / (KLDH_PYR * KLDH_NADH) - VLDH_maxr * LAC->getMolarConc()*1000.0 * NAD->getMolarConc()*1000.0 / (KLDH_LAC * KLDH_NAD);

	  Real LDH_b = 1.0 + PYR->getMolarConc()*1000.0 / KLDH_PYR + NADH->getMolarConc()*1000.0 / KLDH_NADH + PYR->getMolarConc()*1000.0 * NADH->getMolarConc()*1000.0 / (KLDH_PYR * KLDH_NADH) + LAC->getMolarConc()*1000.0 / KLDH_LAC + NAD->getMolarConc()*1000.0 / KLDH_NAD + LAC->getMolarConc()*1000.0 * NAD->getMolarConc()*1000.0 / (KLDH_LAC * KLDH_NAD);
	  
	  setFlux( GX->getValue() * _SizeN_A * LDH_a / LDH_b / 60000.0 /1000.0);

	  //	  setFlux(LDH_a / LDH_b );
	  //V_LDH.setValue(LDH_a / LDH_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VLDH_maxf;
	Variable* PYR;
	Variable* NADH;
	Variable* LAC;
	Variable* NAD;
	Variable* GX;

	Real KLDH_PYR;
	Real KLDH_NADH;
	Real KLDH_LAC;
	Real KLDH_NAD;
	Real KLDH_eq;

 private:


};

LIBECS_DM_INIT( LDH_Process, Process );

