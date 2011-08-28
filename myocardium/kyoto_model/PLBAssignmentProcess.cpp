#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( PLBAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( PLBAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, PLBItot );
		PROPERTYSLOT_SET_GET( Real, PP1tot );
		PROPERTYSLOT_SET_GET( Real, Inhib1tot );
		PROPERTYSLOT_SET_GET( Real, b_i1pt );

		PROPERTYSLOT_SET_GET( Real, KmPKA_PLB );
		PROPERTYSLOT_SET_GET( Real, kPKA_PLB );
		PROPERTYSLOT_SET_GET( Real, KmPP1_PLB );
		PROPERTYSLOT_SET_GET( Real, kPP1_PLB );
		PROPERTYSLOT_SET_GET( Real, KmPKA_Inhib1 );
		PROPERTYSLOT_SET_GET( Real, kPKA_Inhib1 );
		PROPERTYSLOT_SET_GET( Real, VmaxPP2A_Inhib1 );
		PROPERTYSLOT_SET_GET( Real, KmPP2A_Inhib1 );
	}
	
	PLBAssignmentProcess()
		:
		PLBItot( 0.106e-3 ),
		PP1tot( 8.9E-7 ),
		Inhib1tot( 3.0E-7 ),
		b_i1pt( 8.91e-07 ),

		KmPKA_PLB( 0.021e-3 ),
		kPKA_PLB( 0.0324e+3 ),
		KmPP1_PLB( 0.0070e-3 ),
		kPP1_PLB( 0.0085e+3 ),

		KmPKA_Inhib1( 0.0010e-3 ),
		kPKA_Inhib1( 0.06e+3 ),
		VmaxPP2A_Inhib1( 1.4E-5 ),
		KmPP2A_Inhib1( 0.0010e-3 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, PLBItot );
	SIMPLE_SET_GET_METHOD( Real, PP1tot );
	SIMPLE_SET_GET_METHOD( Real, Inhib1tot );
	SIMPLE_SET_GET_METHOD( Real, b_i1pt );

	SIMPLE_SET_GET_METHOD( Real, KmPKA_PLB );
	SIMPLE_SET_GET_METHOD( Real, kPKA_PLB );
	SIMPLE_SET_GET_METHOD( Real, KmPP1_PLB );
	SIMPLE_SET_GET_METHOD( Real, kPP1_PLB );
	SIMPLE_SET_GET_METHOD( Real, KmPKA_Inhib1 );
	SIMPLE_SET_GET_METHOD( Real, kPKA_Inhib1 );
	SIMPLE_SET_GET_METHOD( Real, VmaxPP2A_Inhib1 );
	SIMPLE_SET_GET_METHOD( Real, KmPP2A_Inhib1 );
	
	virtual void initialize()
	{
		Process::initialize();
		
		plb  = getVariableReference( "plb" ).getVariable();
		plbp  = getVariableReference( "plbp" ).getVariable();
		phos  = getVariableReference( "phos" ).getVariable();
		pp1  = getVariableReference( "pp1" ).getVariable();
		pp1_i1p  = getVariableReference( "pp1_i1p" ).getVariable();
		i1  = getVariableReference( "i1" ).getVariable();
		i1pt  = getVariableReference( "i1pt" ).getVariable();
		i1p  = getVariableReference( "i1p" ).getVariable();
		pka  = getVariableReference( "pka" ).getVariable();

		dATP_PLB  = getVariableReference( "dATP_PLB" ).getVariable();
		dATP_Inhib1  = getVariableReference( "dATP_Inhib1" ).getVariable();
	}

	virtual void fire()
	{
		_SizeN_A = getSuperSystem()->getSizeN_A();

		_plbp_MolarConc = plbp->getMolarConc();
		_i1pt_MolarConc = i1pt->getMolarConc();
		_plb_MolarConc = PLBItot - _plbp_MolarConc ;
		_pp1_MolarConc = PP1tot - pp1_i1p->getMolarConc();
		_i1_MolarConc = Inhib1tot - _i1pt_MolarConc;

		plb->setValue( _plb_MolarConc * _SizeN_A );
		phos->setValue( ( _plbp_MolarConc / PLBItot / 1000.0 ) * _SizeN_A );
		pp1->setValue( _pp1_MolarConc * _SizeN_A );
		i1->setValue( _i1_MolarConc * _SizeN_A );

		_pp1_i1p_MolarConc = _i1pt_MolarConc + b_i1pt;  // 二次方程式を解く途中項
		_pp1_i1p_MolarConc = ( _pp1_i1p_MolarConc - sqrt( _pp1_i1p_MolarConc * _pp1_i1p_MolarConc - 4.0 * _i1pt_MolarConc * PP1tot )) / 2.0;

		i1p->setValue( ( _i1pt_MolarConc - _pp1_i1p_MolarConc ) * _SizeN_A );
		pp1_i1p->setValue( _pp1_i1p_MolarConc * _SizeN_A );

		_pka_MolarConc = pka->getMolarConc();

		dATP_PLB->setValue( ( kPKA_PLB * _pka_MolarConc * _plb_MolarConc / ( KmPKA_PLB + _plb_MolarConc ) - kPP1_PLB * _pp1_MolarConc * _plbp_MolarConc / ( KmPP1_PLB + _plbp_MolarConc )) * _SizeN_A );
		dATP_Inhib1->setValue( ( kPKA_Inhib1 * _pka_MolarConc * _i1_MolarConc / ( KmPKA_Inhib1 + _i1_MolarConc ) - VmaxPP2A_Inhib1 * _i1pt_MolarConc / ( KmPP2A_Inhib1 + _i1pt_MolarConc )) * _SizeN_A );

	}

 protected:

	Variable* plb;
	Variable* plbp;
	Variable* phos;
	Variable* pp1;
	Variable* pp1_i1p;
	Variable* i1;
	Variable* i1pt;
	Variable* i1p;
	Variable* pka;

	Variable* dATP_PLB;
	Variable* dATP_Inhib1;

	Real PLBItot;
	Real PP1tot;
	Real Inhib1tot;
	Real b_i1pt;

	Real KmPKA_PLB;
	Real kPKA_PLB;
	Real KmPP1_PLB;
	Real kPP1_PLB;

	Real KmPKA_Inhib1;
	Real kPKA_Inhib1;
	Real VmaxPP2A_Inhib1;
	Real KmPP2A_Inhib1;

 private:

	Real _SizeN_A;
	Real _plbp_MolarConc;
	Real _i1pt_MolarConc;
	Real _plb_MolarConc;
	Real _pp1_MolarConc;
	Real _i1_MolarConc;
	Real _pp1_i1p_MolarConc;
	Real _pka_MolarConc;
};

LIBECS_DM_INIT( PLBAssignmentProcess, Process );

