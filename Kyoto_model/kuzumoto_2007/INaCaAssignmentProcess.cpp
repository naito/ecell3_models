#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( INaCaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( INaCaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KmNai );
		PROPERTYSLOT_SET_GET( Real, nHNa );
		PROPERTYSLOT_SET_GET( Real, KmCai );

		PROPERTYSLOT_SET_GET( Real, KmNao );
		PROPERTYSLOT_SET_GET( Real, KmCao );

		PROPERTYSLOT_SET_GET( Real, KmCaact );

		PROPERTYSLOT_SET_GET( Real, partition );

		PROPERTYSLOT_SET_GET( Real, amplitude );

		PROPERTYSLOT_SET_GET( Real, k3 );
		PROPERTYSLOT_SET_GET( Real, k4 );

		PROPERTYSLOT_SET_GET( Real, a1Caon );
		PROPERTYSLOT_SET_GET( Real, b1Caon );
		PROPERTYSLOT_SET_GET( Real, a1Caoff );
		PROPERTYSLOT_SET_GET( Real, b1Caoff );

		PROPERTYSLOT_SET_GET( Real, a2Caon );
		PROPERTYSLOT_SET_GET( Real, b2Caon );
		PROPERTYSLOT_SET_GET( Real, a2Caoff );
		PROPERTYSLOT_SET_GET( Real, b2Caoff );
	}
	
	INaCaAssignmentProcess()
		:
		KmNai( 20.74854e-3 ),
		nHNa( 3.0 ),
		KmCai( 0.0184e-3 ),
		KmNao( 87.5e-3 ),
		KmCao( 1.38e-3 ),
		KmCaact( 0.004e-3 ),
		partition( 0.32 ),
		amplitude( 110.0 ),
		k3( 1.0 ),
		k4( 1.0 ),
		
		a1Caon( 0.002 ),
		b1Caon( 0.0012 ),
		a1Caoff( 0.0015 ),
		b1Caoff( 5.0E-7 ),
		
		a2Caon( 0.01 ),
		b2Caon( 1.0E-4 ),
		a2Caoff( 3.0E-5 ),
		b2Caoff( 0.09 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KmNai );
	SIMPLE_SET_GET_METHOD( Real, nHNa );
	SIMPLE_SET_GET_METHOD( Real, KmCai );

	SIMPLE_SET_GET_METHOD( Real, KmNao );
	SIMPLE_SET_GET_METHOD( Real, KmCao );

	SIMPLE_SET_GET_METHOD( Real, KmCaact );

	SIMPLE_SET_GET_METHOD( Real, partition );

	SIMPLE_SET_GET_METHOD( Real, amplitude );

	SIMPLE_SET_GET_METHOD( Real, k3 );
	SIMPLE_SET_GET_METHOD( Real, k4 );

	SIMPLE_SET_GET_METHOD( Real, a1Caon );
	SIMPLE_SET_GET_METHOD( Real, b1Caon );
	SIMPLE_SET_GET_METHOD( Real, a1Caoff );
	SIMPLE_SET_GET_METHOD( Real, b1Caoff );

	SIMPLE_SET_GET_METHOD( Real, a2Caon );
	SIMPLE_SET_GET_METHOD( Real, b2Caon );
	SIMPLE_SET_GET_METHOD( Real, a2Caoff );
	SIMPLE_SET_GET_METHOD( Real, b2Caoff );

	virtual void initialize()
	{
		Process::initialize();
		
		Nai    = getVariableReference( "Nai" ).getVariable();
		Cai    = getVariableReference( "Cai" ).getVariable();
		E1A    = getVariableReference( "E1A" ).getVariable();

		Nao    = getVariableReference( "Nao" ).getVariable();
		Cao    = getVariableReference( "Cao" ).getVariable();
		E2A    = getVariableReference( "E2A" ).getVariable();

		//FCaact = getVariableReference( "FCaact" ).getVariable();

		vrtf   = getVariableReference( "vrtf" ).getVariable();
		//k1     = getVariableReference( "k1" ).getVariable();
		//k2     = getVariableReference( "k2" ).getVariable();

		dinact1 = getVariableReference( "dinact1" ).getVariable();
		dinact2 = getVariableReference( "dinact2" ).getVariable();
		inact1 = getVariableReference( "inact1" ).getVariable();
		inact2 = getVariableReference( "inact2" ).getVariable();
		pE1tot = getVariableReference( "pE1tot" ).getVariable();
		pE2tot = getVariableReference( "pE2tot" ).getVariable();

		dE     = getVariableReference( "dE" ).getVariable();

		GX     = getVariableReference( "GX" ).getVariable();
		I      = getVariableReference( "I" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_pE1tot = pE1tot->getValue();
		_Cai    = Cai->getMolarConc();

		_E1A = 1.0 / ( 1.0 + pow(( KmNai / Nai->getMolarConc()), nHNa ) * ( 1.0 + _Cai / KmCai ));
		_E2A = 1.0 / ( 1.0 + pow(( KmNao / Nao->getMolarConc()), nHNa ) * ( 1.0 + Cao->getMolarConc() / KmCao ));

		E1A->setValue( _E1A );
		E2A->setValue( _E2A );

		_FCaact = 1.0 / ( 1.0 + ( KmCaact / _Cai ));

		dinact1->setValue( ( _E1A * ( _FCaact * a1Caon + ( 1.0 - _FCaact ) * a1Caoff ) ) * _pE1tot - ( _FCaact * b1Caon + ( 1.0 - _FCaact ) * b1Caoff ) * inact1->getValue() );
		dinact2->setValue( ( _FCaact * a2Caon + ( 1.0 - _FCaact ) * a2Caoff ) * _pE1tot - ( _FCaact * b2Caon + ( 1.0 - _FCaact ) * b2Caoff ) * inact2->getValue() );

		_k1 = exp( partition * vrtf->getValue() );
		_k2 = exp(( partition - 1.0 ) * vrtf->getValue() );
		//k1->setValue( _k1 );
		//k2->setValue( _k2 );

		_pE2tot = 1.0 - _pE1tot - inact1->getValue() - inact2->getValue();
		pE2tot->setValue( _pE2tot );

		_dEA = _pE2tot * _k2 * _E2A - _pE1tot * _k1 * _E1A;

		dE->setValue( _dEA + ( _pE2tot * ( k4 * ( 1.0 / ( 1.0 + ( KmCao / Cao->getMolarConc() ) * ( 1.0 + pow(( Nao->getMolarConc() / KmNao ), nHNa ))))) - _pE1tot * ( k3 * ( 1.0 / ( 1.0 + ( KmCai / _Cai ) * ( 1.0 + pow(( Nai->getMolarConc() / KmNai ), nHNa )))))) );
		
		I->setValue( GX->getValue() * amplitude * Cm->getValue() * -_dEA );
	}

 protected:

	Variable* Nai;
	Variable* Cai;
	Variable* E1A;

	Variable* Nao;
	Variable* Cao;
	Variable* E2A;

	//Variable* FCaact;

	Variable* vrtf;
	//Variable* k1;
	//Variable* k2;

	Variable* dinact1;
	Variable* dinact2;
	Variable* inact1;
	Variable* inact2;
	Variable* pE1tot;
	Variable* pE2tot;

	Variable* dE;
//	Variable* dEA;
//	Variable* dEB;

	Variable* GX;
	Variable* I;
	Variable* Cm;

	Real KmNai;
	Real nHNa;
	Real KmCai;

	Real KmNao;
	Real KmCao;

	Real KmCaact;

	Real partition;

	Real amplitude;

	Real k3;
	Real k4;

	Real a1Caon;
	Real b1Caon;
	Real a1Caoff;
	Real b1Caoff;

	Real a2Caon;
	Real b2Caon;
	Real a2Caoff;
	Real b2Caoff;

 private:

	Real _pE1tot;
	Real _Cai;
	Real _E1A;
	Real _E2A;
	Real _k1;
	Real _k2;
	Real _pE2tot;
	Real _dEA;
	Real _FCaact;

};

LIBECS_DM_INIT( INaCaAssignmentProcess, Process );

