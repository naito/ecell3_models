#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( NKCCAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( NKCCAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, KK );
		PROPERTYSLOT_SET_GET( Real, KCl );
		PROPERTYSLOT_SET_GET( Real, KNa );
		PROPERTYSLOT_SET_GET( Real, kbEmpty );
		PROPERTYSLOT_SET_GET( Real, kfEmpty );
		PROPERTYSLOT_SET_GET( Real, kbFull );
		PROPERTYSLOT_SET_GET( Real, kfFull );
		PROPERTYSLOT_SET_GET( Real, P );
	}
	
	NKCCAssignmentProcess()
		:
		KK( 1.16 ),
		KCl( 57.35 ),
		KNa( 84.45 ),
		kbEmpty( 79.522 ),
		kfEmpty( 37.767 ),
		kbFull( 1.456 ),
		kfFull( 3.065 ),
		P( 0.0359 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, KK );
	SIMPLE_SET_GET_METHOD( Real, KCl );
	SIMPLE_SET_GET_METHOD( Real, KNa );
	SIMPLE_SET_GET_METHOD( Real, kbEmpty );
	SIMPLE_SET_GET_METHOD( Real, kfEmpty );
	SIMPLE_SET_GET_METHOD( Real, kbFull );
	SIMPLE_SET_GET_METHOD( Real, kfFull );
	SIMPLE_SET_GET_METHOD( Real, P );

	virtual void initialize()
	{
		Process::initialize();

		Clo   = getVariableReference( "Clo" ).getVariable();
		Ko   = getVariableReference( "Ko" ).getVariable();
		Nao   = getVariableReference( "Nao" ).getVariable();
		Cli   = getVariableReference( "Cli" ).getVariable();
		Ki   = getVariableReference( "Ki" ).getVariable();
		Nai   = getVariableReference( "Nai" ).getVariable();
		I    = getVariableReference( "I" ).getVariable();
		GX    = getVariableReference( "GX" ).getVariable();
		ClFlux    = getVariableReference( "ClFlux" ).getVariable();
		F    = getVariableReference( "F" ).getVariable();

		_F = F->getValue() / 1000.0;
	}

	virtual void fire()
	{
		_Clo = Clo->getMolarConc();
		_Ko  = Ko->getMolarConc();
		_Nao = Nao->getMolarConc();
		_Cli = Cli->getMolarConc();
		_Ki  = Ki->getMolarConc();
		_Nai = Nai->getMolarConc();

		_tmp1 = KNa * _Nao * KCl * _Clo * KK * _Ko * KCl * _Clo;
		_tmp2 = KNa * _Nai * KCl * _Cli * KK * _Ki * KCl * _Cli;

		_pE1  = 1.0 / ( 1.0 + KNa * _Nao + KNa * _Nao * KCl * _Clo + KNa * _Nao * KCl * _Clo * KK * _Ko + _tmp1 );
		_pE2  = 1.0 / ( 1.0 + KCl * _Cli + KK * _Ki * KCl * _Cli + KCl * _Cli * KK * _Ki * KCl * _Cli + _tmp2 );

		_pE1S = ( kbFull * _tmp2 * _pE2 + kfEmpty * _pE2 ) / ( kfFull * _tmp1 * _pE1 + kbEmpty * _pE1 + kbFull * _tmp2 * _pE2 + kfEmpty * _pE2 );

		_I = GX->getValue() * P * ( kfFull * _tmp1 * _pE1 * _pE1S - kbFull * _tmp2 * _pE2 * ( 1.0 - _pE1S )) * _F;

		// I = cNa = cK
		I->setValue( -_I );
		// ClFlux = cCl
		ClFlux->setValue( 2.0 * _I );

	}

 protected:

	Variable* Clo;
	Variable* Ko;
	Variable* Nao;
	Variable* Cli;
	Variable* Ki;
	Variable* Nai;
	Variable* I;
	Variable* GX;
	Variable* ClFlux;
	Variable* F;

	Real KK;
	Real KCl;
	Real KNa;
	Real kbEmpty;
	Real kfEmpty;
	Real kbFull;
	Real kfFull;
	Real P;

 private:

	Real _Clo;
	Real _Ko;
	Real _Nao;
	Real _Cli;
	Real _Ki;
	Real _Nai;

	Real _tmp1;
	Real _tmp2;
	Real _pE1;
	Real _pE2;
	Real _pE1S;
	Real _J;
	Real _I;
	Real _F;
};

LIBECS_DM_INIT( NKCCAssignmentProcess, Process );

