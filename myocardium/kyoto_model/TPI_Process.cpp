#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( TPI_Process, ContinuousProcess )
{
 public:

	LIBECS_DM_OBJECT( TPI_Process, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KTPI_GAP );
		PROPERTYSLOT_SET_GET( Real, KTPI_DHAP );
		PROPERTYSLOT_SET_GET( Real, KTPI_eq );
	}
	
	TPI_Process()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KTPI_GAP );
	SIMPLE_SET_GET_METHOD( Real, KTPI_DHAP );
	SIMPLE_SET_GET_METHOD( Real, KTPI_eq );

	virtual void initialize()
	{
		Process::initialize();
		
		VTPI_maxf  = getVariableReference( "VTPI_maxf" ).getVariable();
		GAP  = getVariableReference( "GAP" ).getVariable();
		DHAP  = getVariableReference( "DHAP" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
	}

	virtual void fire()
	{
	  Real _SizeN_A = getSuperSystem()->getSizeN_A();

	  Real VTPI_maxr = VTPI_maxf->getValue() * KTPI_DHAP / KTPI_GAP / KTPI_eq;

	  Real TPI_a = VTPI_maxf->getValue() * GAP->getMolarConc()*1000.0 / KTPI_GAP - VTPI_maxr * DHAP->getMolarConc()*1000.0 / KTPI_DHAP;

	  Real TPI_b = 1.0 + GAP->getMolarConc()*1000.0 /KTPI_GAP + DHAP->getMolarConc()*1000.0 / KTPI_DHAP;
	  
	  setFlux( GX->getValue() * _SizeN_A * TPI_a / TPI_b / 60000.0 /1000.0);

	  //	  setFlux(TPI_a / TPI_b );
	  //V_TPI.setValue(TPI_a / TPI_b / unit);
	  
	  // ducky

	  // T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* VTPI_maxf;
	Variable* GAP;
	Variable* DHAP;
	Variable* GX;

	Real KTPI_GAP;
	Real KTPI_DHAP;
	Real KTPI_eq;

 private:


};

LIBECS_DM_INIT( TPI_Process, Process );

