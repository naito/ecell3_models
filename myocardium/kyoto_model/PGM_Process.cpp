#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PGM_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( PGM_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KPGM_3PG );
		PROPERTYSLOT_SET_GET( Real, KPGM_2PG );
		PROPERTYSLOT_SET_GET( Real, KPGM_eq );
	}
	
	PGM_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KPGM_3PG );
	SIMPLE_SET_GET_METHOD( Real, KPGM_2PG );
	SIMPLE_SET_GET_METHOD( Real, KPGM_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VPGM_maxf  = getVariableReference( "VPGM_maxf" ).getVariable();
		PG2  = getVariableReference( "PG2" ).getVariable();
		PG3  = getVariableReference( "PG3" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VPGM_maxr = VPGM_maxf->getValue() * KPGM_2PG / KPGM_3PG / KPGM_eq;

	  Real PGM_a = VPGM_maxf->getValue() * PG3->getMolarConc()*1000.0 / KPGM_3PG - VPGM_maxr * PG2->getMolarConc()*1000.0 / KPGM_2PG ;

	  Real PGM_b = 1.0 + PG3->getMolarConc()*1000.0 / KPGM_3PG + PG2->getMolarConc()*1000.0 / KPGM_2PG;
	  
	  setFlux( GX->getValue() * _SizeN_A * PGM_a / PGM_b /60000.0 /1000.0);
	  //	  setFlux(PGM_a / PGM_b );
	  //V_PGM.setValue(PGM_a / PGM_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VPGM_maxf;
	Variable* PG3;
	Variable* PG2;
	Variable* GX;

	Real KPGM_3PG;
	Real KPGM_2PG;
	Real KPGM_eq;

 private:


};

LIBECS_DM_INIT( PGM_Process, Process );

