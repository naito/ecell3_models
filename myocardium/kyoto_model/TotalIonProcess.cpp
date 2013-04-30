#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( TotalIonProcess, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( TotalIonProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, TotalIon );
	}
	
	TotalIonProcess()
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, TotalIon );

	virtual void initialize()
	{
		Process::initialize();
		
		Na  = getVariableReference( "Na" ).getVariable();
		K  = getVariableReference( "K" ).getVariable();
		Cl  = getVariableReference( "Cl" ).getVariable();
		Ca  = getVariableReference( "Ca" ).getVariable();
		LA  = getVariableReference( "LA" ).getVariable();
	}

	virtual void fire()
	{
		TotalIon =  Na->getMolarConc() + K->getMolarConc() + Cl->getMolarConc() + Ca->getMolarConc() + LA->getMolarConc();
		setFlux( 0.0 );
	}

 protected:

	Variable* Na;
	Variable* K;
	Variable* Cl;
	Variable* Ca;
	Variable* LA;

	Real TotalIon;
};

LIBECS_DM_INIT( TotalIonProcess, Process );

