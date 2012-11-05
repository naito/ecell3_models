#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PGLM_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( PGLM_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KPGLM_G1P );
		PROPERTYSLOT_SET_GET( Real, KPGLM_G6P );
		PROPERTYSLOT_SET_GET( Real, KPGLM_eq );
	}
	
	PGLM_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KPGLM_G1P );
	SIMPLE_SET_GET_METHOD( Real, KPGLM_G6P );
	SIMPLE_SET_GET_METHOD( Real, KPGLM_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VPGLM_maxf  = getVariableReference( "VPGLM_maxf" ).getVariable();
		G1P  = getVariableReference( "G1P" ).getVariable();
		G6P  = getVariableReference( "G6P" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VPGLM_maxr = VPGLM_maxf->getValue() * KPGLM_G6P / KPGLM_G1P / KPGLM_eq;

	  Real PGLM_a = VPGLM_maxf->getValue() * G1P->getMolarConc()*1000.0 / KPGLM_G1P - VPGLM_maxr * G6P->getMolarConc()*1000.0 / KPGLM_G6P;

	  Real PGLM_b = 1.0 + G1P->getMolarConc()*1000.0 / KPGLM_G1P + G6P->getMolarConc()*1000.0 / KPGLM_G6P;

	  setFlux( GX->getValue() * _SizeN_A * PGLM_a / PGLM_b / 60000.0 /1000.0);
	  //	  setFlux(PGLM_a / PGLM_b );
	  //V_PGLM.setValue(PGLM_a / PGLM_b / unit);
	  
	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VPGLM_maxf;
	Variable* G1P;
	Variable* G6P;
	Variable* GX;

	Real KPGLM_G1P;
	Real KPGLM_G6P;
	Real KPGLM_eq;

 private:


};

LIBECS_DM_INIT( PGLM_Process, Process );

