#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ALD_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( ALD_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KALD_FBP );
		PROPERTYSLOT_SET_GET( Real, KALD_DHAP );
		PROPERTYSLOT_SET_GET( Real, KALD_GAP );
		PROPERTYSLOT_SET_GET( Real, KALD_eq );
	}
	
	ALD_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KALD_FBP );
	SIMPLE_SET_GET_METHOD( Real, KALD_DHAP );
	SIMPLE_SET_GET_METHOD( Real, KALD_GAP );
	SIMPLE_SET_GET_METHOD( Real, KALD_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VALD_maxf  = getVariableReference( "VALD_maxf" ).getVariable();
		FBP  = getVariableReference( "FBP" ).getVariable();
		DHAP  = getVariableReference( "DHAP" ).getVariable();
		GAP  = getVariableReference( "GAP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VALD_maxr = VALD_maxf->getValue() * KALD_DHAP * KALD_GAP / KALD_FBP / KALD_eq;

	  Real ALD_a = VALD_maxf->getValue() * FBP->getMolarConc()*1000.0 / KALD_FBP - VALD_maxr * DHAP->getMolarConc()*1000.0 * GAP->getMolarConc()*1000.0 / (KALD_DHAP * KALD_GAP);

	  Real ALD_b = 1.0 + FBP->getMolarConc()*1000.0 / KALD_FBP + DHAP->getMolarConc()*1000.0 / KALD_DHAP + GAP->getMolarConc()*1000.0 / KALD_GAP;
	  
	  setFlux(GX->getValue() * _SizeN_A * ALD_a / ALD_b / 60000.0 /1000.0);
	  //	  setFlux(ALD_a / ALD_b );
	  //V_ALD.setValue(ALD_a / ALD_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VALD_maxf;
	Variable* FBP;
	Variable* DHAP;
	Variable* GAP;
	Variable* GX;

	Real KALD_FBP;
	Real KALD_DHAP;
	Real KALD_GAP;
	Real KALD_eq;

 private:


};

LIBECS_DM_INIT( ALD_Process, Process );

