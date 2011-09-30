#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IPMCAAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IPMCAAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KmCaCp0 );
		PROPERTYSLOT_SET_GET( Real, KmCaCaM );
		PROPERTYSLOT_SET_GET( Real, hill );
		PROPERTYSLOT_SET_GET( Real, KmCao );
		PROPERTYSLOT_SET_GET( Real, k2 );
		PROPERTYSLOT_SET_GET( Real, KmATP );
		PROPERTYSLOT_SET_GET( Real, k3 );
		PROPERTYSLOT_SET_GET( Real, k4 );
		PROPERTYSLOT_SET_GET( Real, amplitude );
		PROPERTYSLOT_SET_GET( Real, amplitude0 );
		PROPERTYSLOT_SET_GET( Real, amplitudePKAf );
	}
	
	IPMCAAssignmentProcess()
		:
		KmCaCp0( 0.0019e-3 ),
		KmCaCaM( 0.00005e-3 ),
		hill( 1.0 ),
		KmCao( 2.0e-3 ),
		k2( 0.01 ),
		KmATP( 0.1e-3 ),
		k3( 0.01 ),
		k4( 1.0 ),
		amplitude( 0.045815939110831344 ),
		amplitude0( 0.0055 ),
		amplitudePKAf( 1.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KmCaCp0 );
	SIMPLE_SET_GET_METHOD( Real, KmCaCaM );
	SIMPLE_SET_GET_METHOD( Real, hill );
	SIMPLE_SET_GET_METHOD( Real, KmCao );
	SIMPLE_SET_GET_METHOD( Real, k2 );
	SIMPLE_SET_GET_METHOD( Real, KmATP );
	SIMPLE_SET_GET_METHOD( Real, k3 );
	SIMPLE_SET_GET_METHOD( Real, k4 );
	SIMPLE_SET_GET_METHOD( Real, amplitude );
	SIMPLE_SET_GET_METHOD( Real, amplitude0 );
	SIMPLE_SET_GET_METHOD( Real, amplitudePKAf );

	virtual void initialize()
	{
		Process::initialize();

		Cai    = getVariableReference( "Cai" ).getVariable();
		CaCaM    = getVariableReference( "CaCaM" ).getVariable();
		E1A    = getVariableReference( "E1A" ).getVariable();

		Cao    = getVariableReference( "Cao" ).getVariable();
		E2A    = getVariableReference( "E2A" ).getVariable();

		ATP = getVariableReference( "ATP" ).getVariable();
		y   = getVariableReference( "y" ).getVariable();
		dE     = getVariableReference( "dE" ).getVariable();

		PKA     = getVariableReference( "PKA" ).getVariable();
		I      = getVariableReference( "I" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_E1A = 1.0 / (1.0 + pow( KmCaCp0 / ( 1.0 + pow( CaCaM->getMolarConc() / KmCaCaM, hill )) / Cai->getMolarConc(), 3.0 ));
		E1A->setValue( _E1A );

		_E2A = 1.0 / ( 1.0 + pow( KmCao / Cao->getMolarConc(), 3.0 ));
		E2A->setValue( _E2A );

		_dEA = y->getValue() * ( 1.0 / ( 1.0 + KmATP / ATP->getMolarConc() ) ) * _E1A - ( 1.0 - y->getValue() ) * k2 * _E2A;

		dE->setValue( -_dEA + ( k4 * ( 1.0 - _E2A ) * ( 1.0 - y->getValue() ) - k3 * ( 1.0 - _E1A ) * y->getValue() ) );
		
		I->setValue( amplitude0 * ( amplitudePKAf * 1.5 / ( 1.0 + pow( 0.0000005 / PKA->getMolarConc(), 4.0 )) + 1.0 ) * ( 7.5 / ( 1.0 + pow( KmCaCaM / CaCaM->getMolarConc(), hill )) + 1.0 ) * Cm->getValue() * _dEA );
	}

 protected:

	Variable* Cai;
	Variable* CaCaM;
	Variable* E1A;

	Variable* Cao;
	Variable* E2A;

	Variable* ATP;
	Variable* y;
	Variable* dE;

	Variable* PKA;
	Variable* I;
	Variable* Cm;


	Real KmCaCp0;
	Real KmCaCaM;
	Real hill;
	Real KmCao;
	Real k2;
	Real KmATP;
	Real k3;
	Real k4;
	Real amplitude;
	Real amplitude0;
	Real amplitudePKAf;

 private:

	Real _E1A;
	Real _E2A;
	Real _dEA;

};

LIBECS_DM_INIT( IPMCAAssignmentProcess, Process );

