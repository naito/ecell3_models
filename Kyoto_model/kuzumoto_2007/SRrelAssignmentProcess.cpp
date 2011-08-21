#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SRrelAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( SRrelAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, ratio );
		PROPERTYSLOT_SET_GET( Real, Km_calsequestrin );
		PROPERTYSLOT_SET_GET( Real, calsequestrin_total );
	}
	
	SRrelAssignmentProcess()
		:
		ratio( 1.0 ),
		Km_calsequestrin( 0.0008 ),
		calsequestrin_total( 0.01 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, ratio );
	SIMPLE_SET_GET_METHOD( Real, Km_calsequestrin );
	SIMPLE_SET_GET_METHOD( Real, calsequestrin_total );
	
	virtual void initialize()
	{
		Process::initialize();
		
		volume = getVariableReference( "volume" ).getVariable();
		total     = getVariableReference( "total" ).getVariable();
		CaTotal  = getVariableReference( "CaTotal" ).getVariable();
		Ca  = getVariableReference( "Ca" ).getVariable();
		calsequestrin  = getVariableReference( "calsequestrin" ).getVariable();
	}

	virtual void fire()
	{
		volume->setValue( total->getValue() * ratio );

		_Ca = CaTotal->getMolarConc();  // CaTotal.MolarConc
		_calsequestrin_term = calsequestrin_total - _Ca + Km_calsequestrin;
		_Ca = (( sqrt( _calsequestrin_term * _calsequestrin_term + 4.0 * Km_calsequestrin * _Ca ) - _calsequestrin_term ) * 0.5 ) * getSuperSystem()->getSizeN_A();  // Ca.Value
		Ca->setValue( _Ca );
		calsequestrin->setValue( CaTotal->getValue() - _Ca );
	}

 protected:

	Variable* volume;
	Variable* total;
	Variable* CaTotal;
	Variable* Ca;
	Variable* calsequestrin;

	Real ratio;
	Real Km_calsequestrin;
	Real calsequestrin_total;

 private:

	Real _Ca;
	Real _calsequestrin_term;
};

LIBECS_DM_INIT( SRrelAssignmentProcess, Process );

