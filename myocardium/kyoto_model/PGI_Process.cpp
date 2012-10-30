#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PGI_Process, Process )
{

 public:

 	LIBECS_DM_OBJECT( PGI_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KPGI_G6P );
		PROPERTYSLOT_SET_GET( Real, KPGI_F6P );
		PROPERTYSLOT_SET_GET( Real, KPGI_eq );
	}
	
	PGI_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KPGI_G6P );
	SIMPLE_SET_GET_METHOD( Real, KPGI_F6P );
	SIMPLE_SET_GET_METHOD( Real, KPGI_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VPGI_maxr  = getVariableReference( "VPGI_maxr" ).getVariable();
		G6P  = getVariableReference( "G6P" ).getVariable();
		F6P  = getVariableReference( "F6P" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  //	  Real VPGI_maxf = VPGI_maxr * KPGI_G6P * KPGI_eq / KPGI_F6P;
	  Real VPGI_maxf = VPGI_maxr->getValue() * KPGI_G6P * KPGI_eq / KPGI_F6P;

	  //	  Real PGI_a = VPGI_maxf * G6P->getValue() / KPGI_G6P - VPGI_maxr * F6P->getValue() / KPGI_F6P;
	  Real PGI_a = VPGI_maxf * G6P->getMolarConc()*1000.0 / KPGI_G6P - VPGI_maxr->getValue() * F6P->getMolarConc()*1000.0 / KPGI_F6P;

	  Real PGI_b = 1.0 + G6P->getMolarConc()*1000.0 / KPGI_G6P + F6P->getMolarConc()*1000.0 / KPGI_F6P;

	  setFlux( GX->getValue() * _SizeN_A * PGI_a / PGI_b / 60000.0 / 1000.0);
	  //	  setFlux(PGI_a / PGI_b );
	  //V_PGI.setValue(PGI_a / PGI_b / unit);
	  
	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VPGI_maxr;
	Variable* G6P;
	Variable* F6P;
	Variable* GX;

	Real KPGI_G6P;
	Real KPGI_F6P;
	Real KPGI_eq;

 private:


};

LIBECS_DM_INIT( PGI_Process, Process );

