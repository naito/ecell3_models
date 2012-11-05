#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( GP_Process, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( GP_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KGPA_GLYf );
		PROPERTYSLOT_SET_GET( Real, KGPA_iGLYf );
		PROPERTYSLOT_SET_GET( Real, KGPA_Pi );
		PROPERTYSLOT_SET_GET( Real, KGPA_iPi );
		PROPERTYSLOT_SET_GET( Real, KGPA_GLYb );
		PROPERTYSLOT_SET_GET( Real, KGPA_iGLYb );
		PROPERTYSLOT_SET_GET( Real, KGPA_iG1P );
		PROPERTYSLOT_SET_GET( Real, KGPA_eq);

		PROPERTYSLOT_SET_GET( Real, KGPB_iGLYf );
		PROPERTYSLOT_SET_GET( Real, KGPB_Pi );
		PROPERTYSLOT_SET_GET( Real, KGPB_iPi );
		PROPERTYSLOT_SET_GET( Real, KGPB_iGLYb );
		PROPERTYSLOT_SET_GET( Real, KGPB_G1P );
		PROPERTYSLOT_SET_GET( Real, KGPB_iG1P );
		PROPERTYSLOT_SET_GET( Real, KGPB_eq);
		PROPERTYSLOT_SET_GET( Real, KGPB_AMP);
		PROPERTYSLOT_SET_GET( Real, nH_GPB);
	}
	
	GP_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KGPA_GLYf );
	SIMPLE_SET_GET_METHOD( Real, KGPA_iGLYf );
	SIMPLE_SET_GET_METHOD( Real, KGPA_Pi );
	SIMPLE_SET_GET_METHOD( Real, KGPA_iPi );
	SIMPLE_SET_GET_METHOD( Real, KGPA_GLYb );
	SIMPLE_SET_GET_METHOD( Real, KGPA_iGLYb );
	SIMPLE_SET_GET_METHOD( Real, KGPA_iG1P );
	SIMPLE_SET_GET_METHOD( Real, KGPA_eq );

	SIMPLE_SET_GET_METHOD( Real, KGPB_iGLYf );
	SIMPLE_SET_GET_METHOD( Real, KGPB_Pi );
	SIMPLE_SET_GET_METHOD( Real, KGPB_iPi );
	SIMPLE_SET_GET_METHOD( Real, KGPB_iGLYb );
	SIMPLE_SET_GET_METHOD( Real, KGPB_G1P );
	SIMPLE_SET_GET_METHOD( Real, KGPB_iG1P );
	SIMPLE_SET_GET_METHOD( Real, KGPB_eq );
	SIMPLE_SET_GET_METHOD( Real, KGPB_AMP );
	SIMPLE_SET_GET_METHOD( Real, nH_GPB );

	virtual void initialize()
	{
		Process::initialize();
		
		VGPA_maxf  = getVariableReference( "VGPA_maxf" ).getVariable();
		VGPB_maxf  = getVariableReference( "VGPB_maxf" ).getVariable();
		frac_a  = getVariableReference( "frac_a" ).getVariable();
		frac_b  = getVariableReference( "frac_b" ).getVariable();
		GLY  = getVariableReference( "GLY" ).getVariable();
		Pi  = getVariableReference( "Pi" ).getVariable();
		AMP  = getVariableReference( "AMP" ).getVariable();
		G1P  = getVariableReference( "G1P" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();	  

	  Real VGPA_maxr = VGPA_maxf->getValue() * KGPA_GLYb * KGPA_iG1P / KGPA_iGLYf / KGPA_Pi / KGPA_eq;

	  Real GPA_a= VGPA_maxf->getValue() * (GLY->getMolarConc()*1000.0 * Pi->getMolarConc()*1000.0 / KGPA_iGLYf / KGPA_Pi ) - VGPA_maxr * (GLY->getMolarConc()*1000.0 * G1P->getMolarConc()*1000.0 / KGPA_GLYb / KGPA_iG1P);

	  Real GPA_b= 1.0 + GLY->getMolarConc()*1000.0 / KGPA_iGLYf + Pi->getMolarConc()*1000.0 / KGPA_iPi + GLY->getMolarConc()*1000.0 / KGPA_iGLYb + G1P->getMolarConc()*1000.0 / KGPA_iG1P + GLY->getMolarConc()*1000.0 * Pi->getMolarConc()*1000.0 / (KGPA_GLYf * KGPA_iPi) + GLY->getMolarConc()*1000.0 * G1P->getMolarConc()*1000.0 /(KGPA_GLYb * KGPA_iG1P) ;
	  
	  Real V_GPA = GPA_a / GPA_b;

	  Real VGPB_maxr = VGPB_maxf->getValue() * KGPB_iGLYb * KGPB_G1P / KGPB_iGLYf / KGPB_Pi / KGPB_eq;

	  Real GPB_a = (pow(AMP->getMolarConc()*1000.0, nH_GPB)/ KGPB_AMP) * (VGPB_maxf->getValue() * (GLY->getMolarConc()*1000.0 * Pi->getMolarConc()*1000.0 /(KGPB_iGLYf * KGPB_Pi)) - VGPB_maxr * (GLY->getMolarConc()*1000.0 * G1P->getMolarConc()*1000.0/(KGPB_iGLYb * KGPB_G1P)));

	  Real GPB_b = (1.0 + pow(AMP->getMolarConc()*1000.0, nH_GPB)/ KGPB_AMP) * ( 1.0 + GLY->getMolarConc()*1000.0 / KGPB_iGLYf + Pi->getMolarConc()*1000.0 / KGPB_iPi + GLY->getMolarConc()*1000.0 / KGPB_iGLYb + G1P->getMolarConc()*1000.0 / KGPB_iG1P + GLY->getMolarConc()*1000.0 * Pi->getMolarConc()*1000.0 / (KGPB_iGLYf * KGPB_Pi) + GLY->getMolarConc()*1000.0 * G1P->getMolarConc()*1000.0 /(KGPB_iGLYb * KGPB_G1P) );
	  	  
	  Real V_GPB = GPB_a / GPB_b;

       	  setFlux( GX->getValue() * _SizeN_A * ( V_GPA * frac_a->getValue() + V_GPB * frac_b->getValue()) / 60000.0 / 1000.0);

	  //	  setFlux( V_GPA * frac_a->getValue() + V_GPB * frac_b->getValue());
	  //	  setFlux(GPB_a / GPB_b );

	  //	  setFlux(GPA_a / GPA_b );


	  //V_GPA.setValue(GPA_a / GPA_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VGPA_maxf;
	Variable* VGPB_maxf;
	Variable* frac_a;
	Variable* frac_b;
	Variable* GLY;
	Variable* Pi;
	Variable* G1P;
	Variable* AMP;
	Variable* GX;

	Real KGPA_GLYf;
	Real KGPA_iGLYf;
	Real KGPA_Pi;
	Real KGPA_iPi;
	Real KGPA_GLYb;
	Real KGPA_iGLYb;
	Real KGPA_iG1P;
	Real KGPA_eq;

	Real KGPB_iGLYf;
	Real KGPB_Pi;
	Real KGPB_iPi;
	Real KGPB_iGLYb;
	Real KGPB_G1P;
	Real KGPB_iG1P;
	Real KGPB_eq;
	Real KGPB_AMP;
	Real nH_GPB;

 private:


};

LIBECS_DM_INIT( GP_Process, Process );

