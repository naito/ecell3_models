#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ISRCAAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ISRCAAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KmCaSR );
		PROPERTYSLOT_SET_GET( Real, hill );
		PROPERTYSLOT_SET_GET( Real, amplitudePKAf );
		PROPERTYSLOT_SET_GET( Real, a );
		PROPERTYSLOT_SET_GET( Real, b );
		PROPERTYSLOT_SET_GET( Real, kmcacp_minimum );
		PROPERTYSLOT_SET_GET( Real, KmATP );
		PROPERTYSLOT_SET_GET( Real, k1 );
		PROPERTYSLOT_SET_GET( Real, k3 );
		PROPERTYSLOT_SET_GET( Real, k4 );
		PROPERTYSLOT_SET_GET( Real, amplitude );
	}
	
	ISRCAAssignmentProcess()
		:
		KmCaSR( 3.0e-3 ),
		hill( 2.0 ),
		amplitudePKAf( 1.0 ),
		a( -3.93e-4 ),
		b( 6.85e-7 ),
		kmcacp_minimum( 1e-8 ),
		KmATP( 0.1e-3 ),
		k1( 0.01 ),
		k3( 1.0 ),
		k4( 0.01 ),
		amplitude( 19.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KmCaSR );
	SIMPLE_SET_GET_METHOD( Real, hill );
	SIMPLE_SET_GET_METHOD( Real, amplitudePKAf );
	SIMPLE_SET_GET_METHOD( Real, a );
	SIMPLE_SET_GET_METHOD( Real, b );
	SIMPLE_SET_GET_METHOD( Real, kmcacp_minimum );
	SIMPLE_SET_GET_METHOD( Real, KmATP );
	SIMPLE_SET_GET_METHOD( Real, k1 );
	SIMPLE_SET_GET_METHOD( Real, k3 );
	SIMPLE_SET_GET_METHOD( Real, k4 );
	SIMPLE_SET_GET_METHOD( Real, amplitude );
	
	virtual void initialize()
	{
		Process::initialize();
		
		Cao  = getVariableReference( "Cao" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();
		PLBphos  = getVariableReference( "PLBphos" ).getVariable();
		dE  = getVariableReference( "dE" ).getVariable();
		y  = getVariableReference( "y" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		I = getVariableReference( "I" ).getVariable();
		GX   = getVariableReference( "GX" ).getVariable();
		Cm   = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_Cao = Cao->getMolarConc();
		_Cai = Cai->getMolarConc();
		_y = y->getValue();

		_E1A = 1.0 / (1.0 + pow( KmCaSR / _Cao, hill));
		_kmcacp = amplitudePKAf * a * PLBphos->getMolarConc() + b;
		_kmcacp = ( _kmcacp > kmcacp_minimum ) ? _kmcacp : kmcacp_minimum;
		_E2A = 1.0 / ( 1.0 + pow( _kmcacp / _Cai, hill ));

		_dEA = ( 1.0 / ( 1.0 + KmATP / ATP->getMolarConc() )) * _E2A * ( 1.0 - _y ) - k1 * _E1A * _y;
		dE->setValue( _dEA + ( k4 * ( 1.0 - _E2A ) * ( 1.0 - _y ) - k3 * ( 1.0 - _E1A ) * _y ));

		I->setValue( GX->getValue() * amplitude * Cm->getValue() * -_dEA );
	}

 protected:

	Variable* Cao;
	Variable* Cai;
	Variable* PLBphos;
	Variable* dE;
	Variable* y;
	Variable* ATP;
	Variable* I;
	Variable* GX;
	Variable* Cm;



	Real KmCaSR;
	Real hill;
	Real amplitudePKAf;
	Real a;
	Real b;
	Real kmcacp_minimum;
	Real KmATP;
	Real k1;
	Real k3;
	Real k4;
	Real amplitude;

 private:

	Real _Cao;
	Real _Cai;
	Real _y;
	Real _E1A;
	Real _E2A;
	Real _kmcacp;
	Real _dEA;

};

LIBECS_DM_INIT( ISRCAAssignmentProcess, Process );

