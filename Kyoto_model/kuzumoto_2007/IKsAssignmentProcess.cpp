#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IKsAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IKsAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, eps );
		PROPERTYSLOT_SET_GET( Real, kPKA_KCNQ1 );
		PROPERTYSLOT_SET_GET( Real, KmPKA_KCNQ1 );
		PROPERTYSLOT_SET_GET( Real, kPP1_KCNQ1 );
		PROPERTYSLOT_SET_GET( Real, KmPP1_KCNQ1 );
		PROPERTYSLOT_SET_GET( Real, PKAtot_Yot );
		PROPERTYSLOT_SET_GET( Real, PP1tot_Yot );
		PROPERTYSLOT_SET_GET( Real, KCNQ1tot );
		PROPERTYSLOT_SET_GET( Real, Yottot );
		PROPERTYSLOT_SET_GET( Real, Kyotiao );

		PROPERTYSLOT_SET_GET( Real, F_KCNQ1p0 );

		PROPERTYSLOT_SET_GET( Real, b2 );
		PROPERTYSLOT_SET_GET( Real, a3 );
		PROPERTYSLOT_SET_GET( Real, b3 );

		PROPERTYSLOT_SET_GET( Real, permeabilityK0 );
		PROPERTYSLOT_SET_GET( Real, relativePNa );

		PROPERTYSLOT_SET_GET( Real, amplitudePKAf );

		PROPERTYSLOT_SET_GET( Real, ka11 );
		PROPERTYSLOT_SET_GET( Real, ka12 );
		PROPERTYSLOT_SET_GET( Real, ka13 );
		PROPERTYSLOT_SET_GET( Real, ka14 );
		PROPERTYSLOT_SET_GET( Real, kb11 );
		PROPERTYSLOT_SET_GET( Real, kb12 );
		PROPERTYSLOT_SET_GET( Real, kb13 );
		PROPERTYSLOT_SET_GET( Real, kb14 );
	}
	
	IKsAssignmentProcess()
		:
		eps( 10.0 ),
		kPKA_KCNQ1( 205.2e-3 / 500.0 ),
		KmPKA_KCNQ1( 0.2 * 17.64e-3 ),
		kPP1_KCNQ1( 8.52e-3 / 500.0 ),
		KmPP1_KCNQ1( 0.2 * 0.28e-3 * 1.0e-3 ),
		PKAtot_Yot( 0.04e-3 ),
		PP1tot_Yot( 0.025e-3 ),
		KCNQ1tot( 0.025e-6 ),
		Yottot( 0.025e-3 ),
		Kyotiao( 1.0e-7 ),

		F_KCNQ1p0( 0.0947077 ),

		b2( 0.000148 ),
		a3( 0.005 ),
		b3( 0.03 ),

		permeabilityK0( 0.025 ),
		relativePNa( 0.04 ),

		amplitudePKAf( 0.0 ),	// 0.0ならkuzumoto model

		ka11( 85.0 ),
		ka12( -10.5 ),
		ka13( 370.0 ),
		ka14( -62.0 ),
		kb11( 1450.0 ),
		kb12( 20.0 ),
		kb13( 300.0 ),
		kb14( 210.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, eps );
	SIMPLE_SET_GET_METHOD( Real, kPKA_KCNQ1 );
	SIMPLE_SET_GET_METHOD( Real, KmPKA_KCNQ1 );
	SIMPLE_SET_GET_METHOD( Real, kPP1_KCNQ1 );
	SIMPLE_SET_GET_METHOD( Real, KmPP1_KCNQ1 );
	SIMPLE_SET_GET_METHOD( Real, PKAtot_Yot );
	SIMPLE_SET_GET_METHOD( Real, PP1tot_Yot );
	SIMPLE_SET_GET_METHOD( Real, KCNQ1tot );
	SIMPLE_SET_GET_METHOD( Real, Yottot );
	SIMPLE_SET_GET_METHOD( Real, Kyotiao );

	SIMPLE_SET_GET_METHOD( Real, F_KCNQ1p0 );
	
	SIMPLE_SET_GET_METHOD( Real, b2 );
	SIMPLE_SET_GET_METHOD( Real, a3 );
	SIMPLE_SET_GET_METHOD( Real, b3 );
	
	SIMPLE_SET_GET_METHOD( Real, permeabilityK0 );
	SIMPLE_SET_GET_METHOD( Real, relativePNa );

	SIMPLE_SET_GET_METHOD( Real, amplitudePKAf );
	
	SIMPLE_SET_GET_METHOD( Real, ka11 );
	SIMPLE_SET_GET_METHOD( Real, ka12 );
	SIMPLE_SET_GET_METHOD( Real, ka13 );
	SIMPLE_SET_GET_METHOD( Real, ka14 );
	SIMPLE_SET_GET_METHOD( Real, kb11 );
	SIMPLE_SET_GET_METHOD( Real, kb12 );
	SIMPLE_SET_GET_METHOD( Real, kb13 );
	SIMPLE_SET_GET_METHOD( Real, kb14 );
	
	virtual void initialize()
	{
		Process::initialize();
		
		pka     = getVariableReference( "pka" ).getVariable();
		PKAtot  = getVariableReference( "PKAtot" ).getVariable();
		vkcnq1p = getVariableReference( "vkcnq1p" ).getVariable();
		kcnq1p = getVariableReference( "kcnq1p" ).getVariable();
		kcnq1 = getVariableReference( "kcnq1" ).getVariable();
		Vm    = getVariableReference( "Vm" ).getVariable();
		Ca  = getVariableReference( "Ca" ).getVariable();

		dy1     = getVariableReference( "dy1" ).getVariable();
		dy2     = getVariableReference( "dy2" ).getVariable();
		dyC2     = getVariableReference( "dyC2" ).getVariable();
		y1     = getVariableReference( "y1" ).getVariable();
		y2     = getVariableReference( "y2" ).getVariable();
		yC2     = getVariableReference( "yC2" ).getVariable();
		pOpen  = getVariableReference( "pOpen" ).getVariable();
		i      = getVariableReference( "i" ).getVariable();
		GX     = getVariableReference( "GX" ).getVariable();
		Cm     = getVariableReference( "Cm" ).getVariable();
		cK     = getVariableReference( "cK" ).getVariable();
		CFK    = getVariableReference( "CFK" ).getVariable();
		cNa    = getVariableReference( "cNa" ).getVariable();
		CFNa   = getVariableReference( "CFNa" ).getVariable();
		I      = getVariableReference( "I" ).getVariable();

		_KCNQ1tot_mM = KCNQ1tot * 1000.0;

		_amplitudePKAf = ( amplitudePKAf == 0.0 ) ? 1.0 : amplitudePKAf;
	}

	virtual void fire()
	{

		if ( amplitudePKAf == 0.0 ) {
		
			// kuzumoto model
			_KCNQ1_Yot = (( _KCNQ1tot_mM - 2.0 * kcnq1p->getMolarConc() * 1000.0 + Yottot + Kyotiao ) - pow( pow( _KCNQ1tot_mM - 2.0 * kcnq1p->getMolarConc() * 1000.0 + Yottot + Kyotiao, 2.0 ) - 4.0 * 1.0 * ( _KCNQ1tot_mM - kcnq1p->getMolarConc() * 1000.0 ) * ( Yottot - kcnq1p->getMolarConc() * 1000.0 ), 0.5)) / 2.0;

		} else {
			// himeno model
			_KCNQ1_Yot = kcnq1->getMolarConc() * 1000.0;
		}

		vkcnq1p->setValue( eps * kPKA_KCNQ1 * ( pka->getMolarConc() * PKAtot_Yot / PKAtot->getMolarConc() ) * _KCNQ1_Yot / ( KmPKA_KCNQ1 + eps * _KCNQ1_Yot ) - eps * kPP1_KCNQ1 * PP1tot_Yot * kcnq1p->getMolarConc() / (KmPP1_KCNQ1 + eps * kcnq1p->getMolarConc() ) );

		_KCNQ1p_ratio = kcnq1p->getMolarConc() / KCNQ1tot;
		_v = Vm->getValue() + _amplitudePKAf * ( 1.35 * _KCNQ1p_ratio / F_KCNQ1p0 - 1.35 );

		dy1->setValue(  ( 1.0 / ( ka11 * exp( _v / ka12 ) + ka13 * exp( _v / ka14 ))) * ( 1.0 - y1->getValue() ) - ( 1.0 / ( kb11 * exp( _v / kb12 ) + kb13 * exp( _v / kb14))) * y1->getValue() );
		dy2->setValue(  ( Ca->getMolarConc() * 1000.0 * 4.0 ) * yC2->getValue() - b2 * y2->getValue() );
		dyC2->setValue( a3 * ( 1.0 - yC2->getValue() - y2->getValue() ) - b3 * yC2->getValue() );

		_pOpen = y1->getValue() * y1->getValue() * ( 0.9 * y2->getValue() + 0.1 );
		pOpen->setValue( _pOpen );

		_i = GX->getValue() * _pOpen * Cm->getValue();
		i->setValue( _i );

		_permeabilityK = permeabilityK0 * ( _amplitudePKAf * ( 2.3 - 1.0 ) / ( 1.0 + pow( 0.4 / _KCNQ1p_ratio, 6.0 )) + 1.0 );
		_cK  = _permeabilityK * CFK->getValue() * _i;
		_cNa = _permeabilityK * relativePNa * CFNa->getValue() * _i;

		cK->setValue( _cK );
		cNa->setValue( _cNa );
		I->setValue( _cK + _cNa );
	}

 protected:

	Variable* pka;
	Variable* PKAtot;
	Variable* vkcnq1p;
	Variable* kcnq1p;
	Variable* kcnq1;
	Variable* Vm;
	Variable* Ca;

	Variable* dy1;
	Variable* dy2;
	Variable* dyC2;
	Variable* y1;
	Variable* y2;
	Variable* yC2;
	Variable* pOpen;
	Variable* i;
	Variable* GX;
	Variable* Cm;
	Variable* cK;
	Variable* CFK;
	Variable* cNa;
	Variable* CFNa;
	Variable* I;

	Real eps;
	Real kPKA_KCNQ1;
	Real KmPKA_KCNQ1;
	Real kPP1_KCNQ1;
	Real KmPP1_KCNQ1;
	Real PKAtot_Yot;
	Real PP1tot_Yot;
	Real KCNQ1tot;
	Real Yottot;
	Real Kyotiao;

	Real F_KCNQ1p0;

	Real b2;
	Real a3;
	Real b3;

	Real permeabilityK0;
	Real relativePNa;

	Real amplitudePKAf;

	Real ka11;
	Real ka12;
	Real ka13;
	Real ka14;
	Real kb11;
	Real kb12;
	Real kb13;
	Real kb14;

 private:

	Real _KCNQ1tot_mM;
	Real _KCNQ1_Yot;

	Real _KCNQ1p_ratio;
	Real _permeabilityK;
	Real _v;
	
	Real _pOpen;
	Real _i;
	Real _cK;
	Real _cNa;

	Real _amplitudePKAf;
};

LIBECS_DM_INIT( IKsAssignmentProcess, Process );

