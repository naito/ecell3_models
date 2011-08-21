#include "libecs.hpp"
#include "ContinuousProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IonFluxProcess, ContinuousProcess )
{

 public:

	LIBECS_DM_OBJECT( IonFluxProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
	}
	
	IonFluxProcess()
	{
		// do nothing
	}
		
	virtual void initialize()
	{
		Process::initialize();
		
		i    = getVariableReference( "i" ).getVariable();
		N_A  = getVariableReference( "N_A" ).getVariable();
		F    = getVariableReference( "F" ).getVariable();
		z    = getVariableReference( "z" ).getVariable();

		_pA2J = 1.0e-15 * N_A->getValue() / z->getValue() / F->getValue();
	}

	virtual void fire()
	{
		setFlux( i->getValue() * _pA2J );
	}

 protected:

	Variable* i;
	Variable* N_A;
	Variable* F;
	Variable* z;

 protected:

	Real _pA2J;
};

LIBECS_DM_INIT( IonFluxProcess, Process );

