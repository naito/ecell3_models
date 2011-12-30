#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( RangeFixProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( RangeFixProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		// PROPERTYSLOT_SET_GET( Integer, mode );
	}
	
	RangeFixProcess()
		// :
		// mode( 0 )
	{
		// do nothing
	}

	// SIMPLE_SET_GET_METHOD( Integer, mode );
	
	virtual void initialize()
	{
		Process::initialize();

		max    = getVariableReference( "max" ).getVariable();
		min    = getVariableReference( "min" ).getVariable();
		target = getVariableReference( "target" ).getVariable();

		/*
		if ( mode == 0 ) {
			_modeIn  = 1;
			_modeOut = 0;
		} else {
			_modeIn  = 0;
			_modeOut = 1;
		}
		*/
	}

	virtual void fire()
	{

		if (( target->getValue() < max->getValue()) && ( target->getValue() > min->getValue())) {
			aLocation = 1;  //  1: within the area
		} else {
			aLocation = -1;  // -1: out of the area
		}

		for( VariableReferenceVector::const_iterator s(
			theVariableReferenceVector.begin() );
			s != theVariableReferenceVector.end(); ++s )
		{
			VariableReference const& aVariableReference( *s );
			// Integer aCoefficient( aVariableReference.getCoefficient() );

			switch ( aVariableReference.getCoefficient() * aLocation )
			{
				case 1:
					aVariableReference.setFixed( 1 );
					break;
				case 2:
					aVariableReference.setFixed( 1 );
					break;
				case 3:
					aVariableReference.setFixed( 0 );
					break;
				case 4:
					aVariableReference.setFixed( 0 );
					break;
				case -1:
					aVariableReference.setFixed( 0 );
					break;
				case -3:
					aVariableReference.setFixed( 1 );
					break;
				case -5:
					aVariableReference.setFixed( 1 );
					break;
				case -6:
					aVariableReference.setFixed( 0 );
					break;
				default:
					break;
			}
		}
	}

 protected:

	Variable* max;
	Variable* min;
	Variable* target;

	// Integer mode;

 private:

	Integer aLocation;
	// Integer _modeIn;
	// Integer _modeOut;
};

LIBECS_DM_INIT( RangeFixProcess, Process );

