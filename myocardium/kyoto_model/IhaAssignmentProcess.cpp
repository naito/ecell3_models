#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( IhaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IhaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, cAMP0 );
		PROPERTYSLOT_SET_GET( Real, hill_n );
		PROPERTYSLOT_SET_GET( Real, Vshift );
		PROPERTYSLOT_SET_GET( Real, amplitudecAMPf );
		PROPERTYSLOT_SET_GET( Real, KmcAMP_hill_n );
		PROPERTYSLOT_SET_GET( Real, permeabilityK );
		PROPERTYSLOT_SET_GET( Real, permeabilityNa );
	}
	
	IhaAssignmentProcess()
		:
		cAMP0( 2.93969563263e-07 ),
		hill_n( 1.0 ),
		Vshift( 0.0 ),
		amplitudecAMPf( 1.0 ),
		KmcAMP_hill_n( 0.0002 ),
		permeabilityK( 0.05635 ),
		permeabilityNa( 0.01379 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, cAMP0 );
	SIMPLE_SET_GET_METHOD( Real, hill_n );
	SIMPLE_SET_GET_METHOD( Real, Vshift );
	SIMPLE_SET_GET_METHOD( Real, amplitudecAMPf );
	SIMPLE_SET_GET_METHOD( Real, KmcAMP_hill_n );
	SIMPLE_SET_GET_METHOD( Real, permeabilityK );
	SIMPLE_SET_GET_METHOD( Real, permeabilityNa );
	
	virtual void initialize()
	{
		Process::initialize();
		
		cAMP  = getVariableReference( "cAMP" ).getVariable();
		//p  = getVariableReference( "p" ).getVariable();
		Vm  = getVariableReference( "Vm" ).getVariable();
		//v  = getVariableReference( "v" ).getVariable();
		//alpha  = getVariableReference( "alpha" ).getVariable();
		//beta  = getVariableReference( "beta" ).getVariable();
		vC1_C2  = getVariableReference( "vC1_C2" ).getVariable();
		vC2_O1  = getVariableReference( "vC2_O1" ).getVariable();
		vO1_O2  = getVariableReference( "vO1_O2" ).getVariable();
		vO2_O3  = getVariableReference( "vO2_O3" ).getVariable();
		pC1  = getVariableReference( "pC1" ).getVariable();
		pC2  = getVariableReference( "pC2" ).getVariable();
		pO1  = getVariableReference( "pO1" ).getVariable();
		pO2  = getVariableReference( "pO2" ).getVariable();
		pOpen  = getVariableReference( "pOpen" ).getVariable();
		i  = getVariableReference( "i" ).getVariable();
		GX  = getVariableReference( "GX" ).getVariable();
		Cm  = getVariableReference( "Cm" ).getVariable();
		cK  = getVariableReference( "cK" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();
		cNa  = getVariableReference( "cNa" ).getVariable();
		CFNa  = getVariableReference( "CFNa" ).getVariable();
		I  = getVariableReference( "I" ).getVariable();
	}

	virtual void fire()
	{
		_p = pow(( cAMP->getMolarConc() - cAMP0 ) * 1000.0, hill_n );
		_v  = Vm->getValue() - Vshift - ( amplitudecAMPf * 15.0 * _p / ( _p + KmcAMP_hill_n ));
		_alpha = 1.0 / ( 2400.0 * exp( _v / 17.0 ));
		_beta  = 1.0 / ( 6.5 * exp( -_v / 14.0 ) + 2.0 * exp( -_v / 530.0 ));
		_pC1 = pC1->getValue();
		_pC2 = pC2->getValue();
		_pO1 = pO1->getValue();
		_pO2 = pO2->getValue();
		_pOpen = 1.0 - _pC1 - _pC2;
		_i = GX->getValue() * _pOpen * Cm->getValue();
		_cK = permeabilityK * CFK->getValue() * _i;
		_cNa = permeabilityNa * CFNa->getValue() * _i;
		
		//p->setValue( _p );
		//v->setValue(  );
		//alpha->setValue( _alpha );
		//beta->setValue( _beta );
		vC1_C2->setValue( ( 1.0 / ( 14.5 * exp( -_v / 16.2 ) + 0.38 * exp( -_v / 530.0 )) ) * _pC2 - ( 1.0 / ( 20000000.0 * exp( _v / 8.0 ) + 350.0 * exp( _v / 600.0 )) ) * _pC1 );
		vC2_O1->setValue( _beta * _pO1 - _alpha * _pC2 );
		vO1_O2->setValue( _beta * _pO2 - _alpha * _pO1 );
		vO2_O3->setValue( _beta * ( 1.0 - _pC1 - _pC2 - _pO1 - _pO2 ) - _alpha * _pO2 );
		pOpen->setValue( _pOpen );
		i->setValue( _i );
		cK->setValue( _cK );
		cNa->setValue( _cNa );
		I->setValue( _cK + _cNa );
	}

 protected:

	Variable* cAMP;
	//Variable* p;
	Variable* Vm;
	//Variable* v;
	//Variable* alpha;
	//Variable* beta;
	Variable* vC1_C2;
	Variable* vC2_O1;
	Variable* vO1_O2;
	Variable* vO2_O3;
	Variable* pC1;
	Variable* pC2;
	Variable* pO1;
	Variable* pO2;
	Variable* pOpen;
	Variable* i;
	Variable* GX;
	Variable* Cm;
	Variable* cK;
	Variable* CFK;
	Variable* cNa;
	Variable* CFNa;
	Variable* I;

	Real cAMP0;  // 2.93969563263e-07
	Real hill_n;  // 1.0
	Real Vshift;  // 0.0
	Real amplitudecAMPf;  // 1.0
	Real KmcAMP_hill_n;  // 0.0002
	Real permeabilityK;  // 0.05635
	Real permeabilityNa;  // 0.01379

 private:

	Real _p;
	Real _v;
	Real _alpha;
	Real _beta;
	Real _pC1;
	Real _pC2;
	Real _pO1;
	Real _pO2;
	Real _pOpen;
	Real _i;
	Real _cK;
	Real _cNa;

};

LIBECS_DM_INIT( IhaAssignmentProcess, Process );

