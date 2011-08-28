#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IstAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IstAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, PKA0 );
		PROPERTYSLOT_SET_GET( Real, max );
		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
		PROPERTYSLOT_SET_GET( Real, Vshift );
	}
	
	IstAssignmentProcess()
		:
		PKA0( 1.3644055081894695E-7 ),
		max( 1.0 ),
		permeabilityNa( 0.007375 ),
		permeabilityK( 0.0043125 ),
		Vshift( 0.0 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, PKA0 );
	SIMPLE_SET_GET_METHOD( Real, max );
	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	SIMPLE_SET_GET_METHOD( Real, Vshift );
	
	virtual void initialize()
	{
		Process::initialize();
		
		Vm  = getVariableReference( "Vm" ).getVariable();
		Cm  = getVariableReference( "Cm" ).getVariable();
		CFNa  = getVariableReference( "CFNa" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();
		PKA  = getVariableReference( "PKA" ).getVariable();
		activation  = getVariableReference( "activation" ).getVariable();
		inactivation  = getVariableReference( "inactivation" ).getVariable();
		slowInactivation  = getVariableReference( "slowInactivation" ).getVariable();
		dactivation  = getVariableReference( "dactivation" ).getVariable();
		dinactivation  = getVariableReference( "dinactivation" ).getVariable();
		dslowInactivation  = getVariableReference( "dslowInactivation" ).getVariable();
		pOpen  = getVariableReference( "pOpen" ).getVariable();
		i  = getVariableReference( "i" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
		cK  = getVariableReference( "cK" ).getVariable();
		cNa  = getVariableReference( "cNa" ).getVariable();
		I  = getVariableReference( "I" ).getVariable();

		_KmPKA  = 0.000065e-3;    // M
		_hill_n = 1.0;
		_amplitudePKAf = 1.0;
		_powKmPKAn = pow( _KmPKA * 1000.0, _hill_n );
	}

	virtual void fire()
	{
		_delta = ( PKA->getMolarConc() - PKA0 ) * 1000.0;	// mM
		//_PKA_factor = _amplitudePKAf * max * pow( _delta, _hill_n ) / ( pow( _delta, hill_n ) + _powKmPKAn ) + 1.0;
		// _hill_n = 1.0 なので暫定的に簡略化
		_PKA_factor = _amplitudePKAf * max * _delta / ( _delta + _powKmPKAn ) + 1.0;

		_v0 = Vm->getValue();
		_v = _v0 + Vshift; 

		//_a1 = 1.0 / ( 0.25 * exp( _v / -11.0 ) + 0.2  * exp( _v / -700.0 ));
		//_b1 = 1.0 / ( 8.0 *  exp( _v / 8.0   ) + 13.5 * exp( _v / 50.0 ));
		_act = activation->getValue();
		dactivation->setValue( ( 1.0 / ( 0.25 * exp( _v / -11.0 ) + 0.2  * exp( _v / -700.0 )) ) * ( 1.0 - _act ) - ( 1.0 / ( 8.0 *  exp( _v / 8.0   ) + 13.5 * exp( _v / 50.0 )) ) * _act );

		//_a2 = 1.0 / ( 3100.0 * exp( _v0 / 13.0 ) + 700.0 * exp( _v0 / 70.0 ));
		//_b2 = 1.0 / ( 95.0   * exp( _v0 / -10.0) + 50.0  * exp( _v0 / -700.0 )) + Cai->getMolarConc() * 2.5e+3 / ( 1.0 + exp( -_v0 / 5.0 ));
		_inact = inactivation->getValue();
		dinactivation->setValue( ( 1.0 / ( 3100.0 * exp( _v0 / 13.0 ) + 700.0 * exp( _v0 / 70.0 )) ) * ( 1.0 - _inact ) - ( 1.0 / ( 95.0   * exp( _v0 / -10.0) + 50.0  * exp( _v0 / -700.0 )) + Cai->getMolarConc() * 2.5e+3 / ( 1.0 + exp( -_v0 / 5.0 )) ) * _inact);
		
		//_a3 = 1.0 / ( 400000.0 * exp( _v0 / 9.0   ) + 60.0 * exp( _v0 /  65.0 ));
		//_b3 = 1.0 / ( 700.0    * exp( _v0 / -14.0 ) + 60.0 * exp( _v0 / -65.0 ));
		_slow = slowInactivation->getValue();
		dslowInactivation->setValue( ( 1.0 / ( 400000.0 * exp( _v0 / 9.0   ) + 60.0 * exp( _v0 /  65.0 )) ) * ( 1.0 - _slow) - ( 1.0 / ( 700.0    * exp( _v0 / -14.0 ) + 60.0 * exp( _v0 / -65.0 )) ) * _slow );

		_pOpen = _act * _inact * _slow * _PKA_factor;
		pOpen->setValue( _pOpen );

		_i = GX->getValue() * _pOpen * Cm->getValue();
		i->setValue( _i );

		_cK  = permeabilityK  * CFK->getValue()  * _i;
		_cNa = permeabilityNa * CFNa->getValue() * _i;

		cK->setValue( _cK );
		cNa->setValue( _cNa );
		I->setValue( _cK + _cNa );
	}

 protected:

	Variable* Vm;
	Variable* Cm;
	Variable* CFNa;
	Variable* CFK;
	Variable* Cai;
	Variable* PKA;
	Variable* activation;
	Variable* inactivation;
	Variable* slowInactivation;
	Variable* dactivation;
	Variable* dinactivation;
	Variable* dslowInactivation;
	Variable* pOpen;
	Variable* i;
	Variable* GX;
	Variable* cK;
	Variable* cNa;
	Variable* I;

	Real PKA0;  // 1.3644055081894695E-7
	Real max;  // 1.0
	Real permeabilityNa;  // 0.007375
	Real permeabilityK;  // 0.0043125
	Real Vshift;

 private:

	Real _KmPKA;
	Real _hill_n;
	Real _amplitudePKAf;
	Real _powKmPKAn;
	Real _delta;
	Real _PKA_factor;
	Real _v0;
	Real _v;
	Real _act;
	Real _inact;
	Real _slow;
	Real _pOpen;
	Real _i;
	Real _cK;
	Real _cNa;
};

LIBECS_DM_INIT( IstAssignmentProcess, Process );

