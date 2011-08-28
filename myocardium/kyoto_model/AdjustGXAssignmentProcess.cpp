#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( AdjustGXAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( AdjustGXAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, k );
	}
	
	AdjustGXAssignmentProcess()
		:
		k( 0.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, k );

	virtual void initialize()
	{
		Process::initialize();

		state   = getVariableReference( "state" ).getVariable();
		prev  = getVariableReference( "prev" ).getVariable();
		I = getVariableReference( "I" ).getVariable();
		target   = getVariableReference( "target" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();

		prev->setValue( target->getMolarConc());
		_target0 = target->getMolarConc();

	}

	virtual void fire()
	{
		if (( I->getValue() <= 0.0 ) && ( state->getValue() > 0.0 ))
		{
			_GX_new = GX->getValue() - ( target->getMolarConc() - _target0 ) * k;

			if ( _GX_new < 0.1 ) _GX_new = 0.1;
			GX->setValue( _GX_new );

			state->setValue( -1.0 );
			prev->setValue( target->getMolarConc());
		}
		else if (( I->getValue() > 0.0 ) && ( state->getValue() < 0.0 )) state->setValue( 1.0 );

	}

 protected:

	Variable* state;
	Variable* prev;
	Variable* I;
	Variable* target;
	Variable* GX;

	Real k;

 private:

	Real _target0;
	Real _GX_new;
};

LIBECS_DM_INIT( AdjustGXAssignmentProcess, Process );

