#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( EN_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( EN_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KEN_2PG );
		PROPERTYSLOT_SET_GET( Real, KEN_PEP );
		PROPERTYSLOT_SET_GET( Real, KEN_eq );
	}
	
	EN_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KEN_2PG );
	SIMPLE_SET_GET_METHOD( Real, KEN_PEP );
	SIMPLE_SET_GET_METHOD( Real, KEN_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VEN_maxf  = getVariableReference( "VEN_maxf" ).getVariable();
		PG2  = getVariableReference( "PG2" ).getVariable();
		PEP  = getVariableReference( "PEP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VEN_maxr = VEN_maxf->getValue() * KEN_PEP / KEN_2PG / KEN_eq;

	  Real EN_a = VEN_maxf->getValue() * PG2->getMolarConc()*1000.0 / KEN_2PG - VEN_maxr * PEP->getMolarConc()*1000.0 / KEN_PEP;

	  Real EN_b = 1 + PG2->getMolarConc()*1000.0 / KEN_2PG + PEP->getMolarConc()*1000.0 / KEN_PEP;
	  
	  setFlux( GX->getValue() * _SizeN_A * EN_a / EN_b / 60000.0 /1000.0);
	  //	  setFlux(EN_a / EN_b );
	  //V_EN.setValue(EN_a / EN_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VEN_maxf;
	Variable* PG2;
	Variable* PEP;
	Variable* GX;

	Real KEN_2PG;
	Real KEN_PEP;
	Real KEN_eq;

 private:


};

LIBECS_DM_INIT( EN_Process, Process );

