#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( GAPDH_Process, Process )
{

 public:

	LIBECS_DM_OBJECT( GAPDH_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KGAPDH_GAP );
		PROPERTYSLOT_SET_GET( Real, KGAPDH_NAD );
		PROPERTYSLOT_SET_GET( Real, KGAPDH_Pi );
		PROPERTYSLOT_SET_GET( Real, KGAPDH_13BPG );
		PROPERTYSLOT_SET_GET( Real, KGAPDH_NADH );
		PROPERTYSLOT_SET_GET( Real, KGAPDH_eq );
	}
	
	GAPDH_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KGAPDH_GAP );
	SIMPLE_SET_GET_METHOD( Real, KGAPDH_NAD );
	SIMPLE_SET_GET_METHOD( Real, KGAPDH_Pi );
	SIMPLE_SET_GET_METHOD( Real, KGAPDH_13BPG );
	SIMPLE_SET_GET_METHOD( Real, KGAPDH_NADH );
	SIMPLE_SET_GET_METHOD( Real, KGAPDH_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VGAPDH_maxf  = getVariableReference( "VGAPDH_maxf" ).getVariable();
		GAP  = getVariableReference( "GAP" ).getVariable();
		NAD  = getVariableReference( "NAD" ).getVariable();
		Pi  = getVariableReference( "Pi" ).getVariable();
		BPG13  = getVariableReference( "BPG13" ).getVariable();
		NADH  = getVariableReference( "NADH" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VGAPDH_maxr = VGAPDH_maxf->getValue() * KGAPDH_13BPG * KGAPDH_NADH / KGAPDH_GAP / KGAPDH_NAD / KGAPDH_Pi / KGAPDH_eq;

	  Real GAPDH_a = VGAPDH_maxf->getValue() * GAP->getMolarConc()*1000.0 * NAD->getMolarConc()*1000.0 * Pi->getMolarConc()*1000.0 / (KGAPDH_GAP * KGAPDH_NAD * KGAPDH_Pi) - VGAPDH_maxr * BPG13->getMolarConc()*1000.0 * NADH->getMolarConc()*1000.0 / (KGAPDH_13BPG * KGAPDH_NADH);

	  Real GAPDH_b = 1.0 + GAP->getMolarConc()*1000.0 / KGAPDH_GAP + NAD->getMolarConc()*1000.0 / KGAPDH_NAD + Pi->getMolarConc()*1000.0 / KGAPDH_Pi + GAP->getMolarConc()*1000.0 * NAD->getMolarConc()*1000.0 / (KGAPDH_GAP * KGAPDH_NAD) + GAP->getMolarConc()*1000.0 * NAD->getMolarConc()*1000.0 * Pi->getMolarConc()*1000.0 / (KGAPDH_GAP * KGAPDH_NAD * KGAPDH_Pi) + BPG13->getMolarConc()*1000.0 / KGAPDH_13BPG + NADH->getMolarConc()*1000.0 / KGAPDH_NADH + BPG13->getMolarConc()*1000.0 * NADH->getMolarConc()*1000.0/(KGAPDH_13BPG * KGAPDH_NADH);
	  
	  setFlux( GX->getValue() * _SizeN_A * GAPDH_a / GAPDH_b / 60000.0 /1000.0);

	  //	  setFlux(GAPDH_a / GAPDH_b );
	  //V_GAPDH.setValue(GAPDH_a / GAPDH_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VGAPDH_maxf;
	Variable* GAP;
	Variable* NAD;
	Variable* Pi;
	Variable* BPG13;
	Variable* NADH;
	Variable* GX;

	Real KGAPDH_GAP;
	Real KGAPDH_NAD;
	Real KGAPDH_Pi;
	Real KGAPDH_13BPG;
	Real KGAPDH_NADH;
	Real KGAPDH_eq;

 private:


};

LIBECS_DM_INIT( GAPDH_Process, Process );

