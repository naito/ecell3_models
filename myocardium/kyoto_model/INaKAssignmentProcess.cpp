#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( INaKAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( INaKAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KmNai );
		PROPERTYSLOT_SET_GET( Real, KmKi );
		PROPERTYSLOT_SET_GET( Real, nHNa );
		PROPERTYSLOT_SET_GET( Real, nHK );
		PROPERTYSLOT_SET_GET( Real, amplitudePKAf );
		PROPERTYSLOT_SET_GET( Real, ratio );
		PROPERTYSLOT_SET_GET( Real, KmPKA );
		PROPERTYSLOT_SET_GET( Real, hill );

		PROPERTYSLOT_SET_GET( Real, KmNao );
		PROPERTYSLOT_SET_GET( Real, KmKo );
		PROPERTYSLOT_SET_GET( Real, ramda );

		PROPERTYSLOT_SET_GET( Real, k2 );
		PROPERTYSLOT_SET_GET( Real, k3 );
		PROPERTYSLOT_SET_GET( Real, k4 );

		PROPERTYSLOT_SET_GET( Real, KmATP );
		PROPERTYSLOT_SET_GET( Real, amplitude0 );
	}
	
	INaKAssignmentProcess()
		:
		KmNai( 4.05e-3 ),
		KmKi( 32.88e-3 ),
		nHNa( 1.06 ),
		nHK( 1.12 ),
		amplitudePKAf( 1.0 ),
		ratio( 0.35 ),
		KmPKA( 0.0005e-3 ),
		hill( 5.0 ),

		KmNao( 69.8e-3 ),
		KmKo( 0.258e-3 ),
		ramda( -0.82 ),

		k2( 0.04 ),
		k3( 0.01 ),
		k4( 0.165 ),

		KmATP( 0.094e-3 ),
		amplitude0( 10.8 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KmNai );
	SIMPLE_SET_GET_METHOD( Real, KmKi );
	SIMPLE_SET_GET_METHOD( Real, nHNa );
	SIMPLE_SET_GET_METHOD( Real, nHK );
	SIMPLE_SET_GET_METHOD( Real, amplitudePKAf );
	SIMPLE_SET_GET_METHOD( Real, ratio );
	SIMPLE_SET_GET_METHOD( Real, KmPKA );
	SIMPLE_SET_GET_METHOD( Real, hill );

	SIMPLE_SET_GET_METHOD( Real, KmNao );
	SIMPLE_SET_GET_METHOD( Real, KmKo );
	SIMPLE_SET_GET_METHOD( Real, ramda );

	SIMPLE_SET_GET_METHOD( Real, k2 );
	SIMPLE_SET_GET_METHOD( Real, k3 );
	SIMPLE_SET_GET_METHOD( Real, k4 );

	SIMPLE_SET_GET_METHOD( Real, KmATP );
	SIMPLE_SET_GET_METHOD( Real, amplitude0 );
	
	virtual void initialize()
	{
		Process::initialize();
		
		Nai    = getVariableReference( "Nai" ).getVariable();
		Ki    = getVariableReference( "Ki" ).getVariable();
		PKA    = getVariableReference( "PKA" ).getVariable();
		E1A = getVariableReference( "E1A" ).getVariable();

		Vm    = getVariableReference( "Vm" ).getVariable();
		vrtf = getVariableReference( "vrtf" ).getVariable();
		T    = getVariableReference( "T" ).getVariable();
		Nao    = getVariableReference( "Nao" ).getVariable();
		Ko = getVariableReference( "Ko" ).getVariable();
		E2A = getVariableReference( "E2A" ).getVariable();

		R = getVariableReference( "R" ).getVariable();
		F = getVariableReference( "F" ).getVariable();

		R_F = R->getValue() / F->getValue();
		
		ATP     = getVariableReference( "ATP" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Couabain     = getVariableReference( "Couabain" ).getVariable();
		dy  = getVariableReference( "dy" ).getVariable();
		y  = getVariableReference( "y" ).getVariable();
		I     = getVariableReference( "I" ).getVariable();
		Cm    = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_E1A = 1.0 / (1.0 + pow(( KmNai * ( amplitudePKAf * ratio / (1.0 + pow( PKA->getMolarConc() / KmPKA, hill )) +  (1.0 - amplitudePKAf * ratio ))) / Nai->getMolarConc(), nHNa) * ( 1.0 + pow(( Ki->getMolarConc() / KmKi ), nHK )));
		_E2A = 1.0 / (1.0 + pow(( KmNao / ( Nao->getMolarConc() * exp( ramda * Vm->getValue() / ( R_F * T->getValue() )))), nHNa) * (1.0 + pow(( Ko->getMolarConc() / KmKo ), nHK )));

		dy->setValue( ( k2 * _E2A + k4 * ( 1.0 / (1.0 + pow(( KmKo / Ko->getMolarConc() ), nHK ) * (1.0 + pow((( Nao->getMolarConc() * exp( ramda * vrtf->getValue() )) / KmNao ), nHNa ))))) * (1.0 - y->getValue()) - ( ( 0.37 / (1.0 + KmATP / ATP->getMolarConc() ) ) * _E1A + k3 * ( 1.0 / (1.0 + pow( KmKi / Ki->getMolarConc(), nHK ) * ( 1.0 + pow(( Nai->getMolarConc() / ( KmNai * ( amplitudePKAf * ratio / (1.0 + pow( PKA->getMolarConc() / KmPKA, hill )) +  (1.0 - amplitudePKAf * ratio )))), nHNa))) )) * y->getValue() );

		E1A->setValue( _E1A );
		E2A->setValue( _E2A );

		I->setValue( ( GX->getValue() * amplitude0 / ( 1.0 + Couabain->getMolarConc() / 0.6 )) * Cm->getValue() * ( y->getValue() * ( 0.37 / (1.0 + KmATP / ATP->getMolarConc() )) * _E1A - ( 1.0 - y->getValue() ) * k2 * _E2A ) );
	}

 protected:

	Variable* Nai;
	Variable* Ki;
	Variable* PKA;
	Variable* E1A;

	Variable* Vm;
	Variable* vrtf;
	Variable* T;
	Variable* Nao;
	Variable* Ko;
	Variable* E2A;

	Variable* R;
	Variable* F;

	Variable* ATP;
	Variable* GX;
	Variable* Couabain;
	Variable* dy;
	Variable* y;
	Variable* I;
	Variable* Cm;

	Real KmNai;
	Real KmKi;
	Real nHNa;
	Real nHK;
	Real amplitudePKAf;
	Real ratio;
	Real KmPKA;
	Real hill;

	Real KmNao;
	Real KmKo;
	Real ramda;

	Real k2;
	Real k3;
	Real k4;

	Real KmATP;
	Real amplitude0;

 private:

	Real R_F;

	Real _E1A;
	Real _E2A;

	Real _pOpen;
	Real _i;
	Real _cK;
	Real _cNa;

};

LIBECS_DM_INIT( INaKAssignmentProcess, Process );

