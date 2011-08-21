#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( ICFTRAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( ICFTRAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, permeabilityCl );
		PROPERTYSLOT_SET_GET( Real, alpha1 );
		PROPERTYSLOT_SET_GET( Real, alpha2 );
		PROPERTYSLOT_SET_GET( Real, beta1 );
		PROPERTYSLOT_SET_GET( Real, beta2 );
		PROPERTYSLOT_SET_GET( Real, k2 );
	}
	
	ICFTRAssignmentProcess()
		:
		permeabilityCl( -0.0040 ),
		alpha1( 0.0756e+3 ),
		alpha2( 0.000109e+3 ),
		beta1( 0.0065 ),
		beta2( 0.00003 ),
		k2( 0.00385 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, permeabilityCl );
	SIMPLE_SET_GET_METHOD( Real, alpha1 );
	SIMPLE_SET_GET_METHOD( Real, alpha2 );
	SIMPLE_SET_GET_METHOD( Real, beta1 );
	SIMPLE_SET_GET_METHOD( Real, beta2 );
	SIMPLE_SET_GET_METHOD( Real, k2 );
	
	virtual void initialize()
	{
		Process::initialize();
		
		PKA  = getVariableReference( "PKA" ).getVariable();
		I    = getVariableReference( "I" ).getVariable();
		CFCl = getVariableReference( "CFCl" ).getVariable();
		ATP  = getVariableReference( "ATP" ).getVariable();
		CPKA = getVariableReference( "CPKA" ).getVariable();
		Cm   = getVariableReference( "Cm" ).getVariable();
		Vm   = getVariableReference( "Vm" ).getVariable();

		_alpha1xalpha2 = alpha1 * alpha2;
		_alpha1xbeta2 = alpha1 * beta2;
		_alpha1xk2 = alpha1 * k2;
		_alpha1xbeta2xk2 = alpha1 * beta2 * k2;
		_beta1xbeta2 = beta1 * beta2;
		_beta1xbeta2xk2 = beta1 * beta2 * k2;
		_beta1xk2 = beta1 * k2;
		_beta2xk2 = beta2 * k2;
	}

	virtual void fire()
	{
		_CPKA = 0.2 / (1.0 + pow( 5.8e-7 / PKA->getMolarConc(), 9.0 ));
		_k1 = 0.768 * _CPKA;
		_k3 = 0.712 * _CPKA;
		_k1xk3 = _k1 * _k3;
		_ATP = ATP->getMolarConc();
		_ATPxATP = _ATP * _ATP;
		
		I->setValue( permeabilityCl * CFCl->getValue() * ( _alpha1xbeta2 * _ATP * _k1 + alpha1 * _ATP * _k1xk3 + _alpha1xalpha2* _ATPxATP * _k1 ) / (( _alpha1xbeta2 * _ATP * _k1 + alpha1 * _ATP * _k1xk3 + _alpha1xalpha2 * _ATPxATP * _k1 ) + ( _alpha1xbeta2xk2 * _ATP + _alpha1xk2 * _ATP * _k3 + _beta1xbeta2xk2 + _beta1xk2 * _k3 ) + ( _beta2xk2 * _k1 + _k1xk3 * k2 )) * Cm->getValue() );
	}

 protected:

	Variable* PKA;
	Variable* I;
	Variable* CFCl;
	Variable* ATP;
	Variable* CPKA;
	Variable* Cm;
	Variable* Vm;


	Real permeabilityCl;
	Real alpha1;
	Real alpha2;
	Real beta1;
	Real beta2;
	Real k2;

 private:

	Real _alpha1xalpha2;
	Real _alpha1xbeta2;
	Real _alpha1xk2;
	Real _alpha1xbeta2xk2;
	Real _beta1xbeta2;
	Real _beta1xbeta2xk2;
	Real _beta1xk2;
	Real _beta2xk2;
	Real _CPKA;
	Real _k1;
	Real _k3;
	Real _k1xk3;
	Real _ATP;
	Real _ATPxATP;

};

LIBECS_DM_INIT( ICFTRAssignmentProcess, Process );

