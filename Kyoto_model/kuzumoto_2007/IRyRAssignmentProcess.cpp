#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IRyRAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IRyRAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, diadicFactor );
		PROPERTYSLOT_SET_GET( Real, k2_1 );
		PROPERTYSLOT_SET_GET( Real, k2_2 );
		PROPERTYSLOT_SET_GET( Real, k3_1 );
		PROPERTYSLOT_SET_GET( Real, k3_hill );
		PROPERTYSLOT_SET_GET( Real, k4 );
		PROPERTYSLOT_SET_GET( Real, permeabilityCa );
	}
	
	IRyRAssignmentProcess()
		:
		diadicFactor( -150.0 ),
		k2_1( 0.08 ),
		k2_2( 0.36e-3 ),
		k3_1( 3.77e-4 ),
		k3_hill( 2.0 ),
		k4( 8.49e-4 ),
		permeabilityCa( 200.0e+3 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, diadicFactor );
	SIMPLE_SET_GET_METHOD( Real, k2_1 );
	SIMPLE_SET_GET_METHOD( Real, k2_2 );
	SIMPLE_SET_GET_METHOD( Real, k3_1 );
	SIMPLE_SET_GET_METHOD( Real, k3_hill );
	SIMPLE_SET_GET_METHOD( Real, k4 );
	SIMPLE_SET_GET_METHOD( Real, permeabilityCa );
	
	virtual void initialize()
	{
		Process::initialize();
		
		pOpen  = getVariableReference( "pOpen" ).getVariable();
		pClose    = getVariableReference( "pClose" ).getVariable();
		CaDiadic = getVariableReference( "CaDiadic" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();
		Cao  = getVariableReference( "Cao" ).getVariable();
		k1 = getVariableReference( "k1" ).getVariable();
		k2 = getVariableReference( "k2" ).getVariable();
		k3_k4 = getVariableReference( "k3_k4" ).getVariable();
		I = getVariableReference( "I" ).getVariable();
		GX   = getVariableReference( "GX" ).getVariable();
		Cm   = getVariableReference( "Cm" ).getVariable();
	}

	virtual void fire()
	{
		_Cai = Cai->getMolarConc();
		_Cao = Cao->getMolarConc();
		_pOpen = pOpen->getValue();
		_pClose = pClose->getValue();

		k1->setValue( ( 0.15 / (1.0 + pow( 1e-6 / _Cai, 3.15 )) + CaDiadic->getValue() * diadicFactor / ( 1.0 + exp( -100.0 * ( CaDiadic->getValue() * diadicFactor - 0.15 )))) * _pClose );
		k2->setValue( ( k2_1 / ( 1.0 + k2_2 / _Cao )) * _pOpen );
		k3_k4->setValue( k3_1 * pow( _Cao * 1000.0, k3_hill ) * ( 1.0 - _pClose - _pOpen ) - k4 * _pClose );

		I->setValue( GX->getValue() * permeabilityCa * Cm->getValue() * ( _Cao - _Cai ) * _pOpen );
	}

 protected:

	Variable* pOpen;
	Variable* pClose;
	Variable* CaDiadic;
	Variable* Cai;
	Variable* Cao;
	Variable* k1;
	Variable* k2;
	Variable* k3_k4;
	Variable* I;
	Variable* GX;
	Variable* Cm;



	Real diadicFactor;
	Real k2_1;
	Real k2_2;
	Real k3_1;
	Real k3_hill;
	Real k4;
	Real permeabilityCa;

 private:

	Real _Cai;
	Real _Cao;
	Real _pOpen;
	Real _pClose;

};

LIBECS_DM_INIT( IRyRAssignmentProcess, Process );

