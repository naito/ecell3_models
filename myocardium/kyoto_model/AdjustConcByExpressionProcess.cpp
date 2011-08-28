#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( AdjustConcByExpressionProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( AdjustConcByExpressionProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, k );
		PROPERTYSLOT_SET_GET( Real, max );
		PROPERTYSLOT_SET_GET( Real, min );
	}
	
	AdjustConcByExpressionProcess()
		:
		k( 0.0 ),
		max( 10.0 ),
		min( 10e-2 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, k );
	SIMPLE_SET_GET_METHOD( Real, max );
	SIMPLE_SET_GET_METHOD( Real, min );

	virtual void initialize()
	{
		Process::initialize();

		//state   = getVariableReference( "state" );
		//prev  = getVariableReference( "prev" );
		I        = getVariableReference( "I" ).getVariable();
		target   = getVariableReference( "target" ).getVariable();
		GX       = getVariableReference( "GX" ).getVariable();

		//prev->setValue( target->getMolarConc());
		_prev = target->getMolarConc();
		_target0 = target->getMolarConc();

		_state = -1;
	}

	virtual void fire()
	{
		if (( I->getValue() <= 0.0 ) && ( _state > 0 ))
		{
			_GX_new = GX->getValue() - ( target->getMolarConc() - _target0 ) * k;

			if ( _GX_new < min ) _GX_new = min;
			else if ( _GX_new > max ) _GX_new = max;

			GX->setValue( _GX_new );

			_state = -1;
			_prev = target->getMolarConc();
		}
		else if (( I->getValue() > 0.0 ) && ( _state < 0 )) _state = 1;
		// 電流が0.0以上（I相）に入ったら、_state を 1 に書き換える
	}

 protected:

	//VariableReference state;
	//VariableReference prev;
	//VariableReference I;
	//VariableReference target;
	//VariableReference GX;

	Variable* I;
	Variable* target;
	Variable* GX;

	Real k;
	Real max;
	Real min;

 private:

	Integer _state;
	Real _prev;
	Real _target0;
	Real _GX_new;
};

LIBECS_DM_INIT( AdjustConcByExpressionProcess, Process );

