#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( CytoplasmAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( CytoplasmAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, Vn_L );
		PROPERTYSLOT_SET_GET( Real, Vt0i );
		PROPERTYSLOT_SET_GET( Real, ActivityFactor );
		PROPERTYSLOT_SET_GET( Real, kD_ATP );
		PROPERTYSLOT_SET_GET( Real, kD_ADP );
		PROPERTYSLOT_SET_GET( Real, TotalAdenosine );
		PROPERTYSLOT_SET_GET( Real, TotalCreatine );
		PROPERTYSLOT_SET_GET( Real, NAD_H_total );
		PROPERTYSLOT_SET_GET( Real, f );
		PROPERTYSLOT_SET_GET( Real, kfAK );
		PROPERTYSLOT_SET_GET( Real, kbAK );
		PROPERTYSLOT_SET_GET( Real, kfCK );
		PROPERTYSLOT_SET_GET( Real, kbCK );
		PROPERTYSLOT_SET_GET( Real, Km_calmodulin );
		PROPERTYSLOT_SET_GET( Real, calmodulin_total );
	}
	
	CytoplasmAssignmentProcess()
		:
		Vn_L( 3200.0e-15 ),        // Vn, the osmotically inactive cell volume (L, liter)
		Vt0i( 53898653951.9 ),
		ActivityFactor( 1.0 ),
		kD_ATP( 0.024e-3 ),
		kD_ADP( 0.347e-3 ),
		TotalAdenosine( 7.0e-3 ),
	        TotalCreatine( 25.0e-3 ),
	        NAD_H_total( 0.000594 ),
		f( 1.3743e-17 ),
		kfAK( 783.0 ),
		kbAK( 683.0 ),
		kfCK( 16.05e+6 ),
		kbCK( 9.67e-3 ),
		Km_calmodulin( 2.38e-06 ),
		calmodulin_total( 5e-05 )
	{
		// do nothing
	}

	SIMPLE_SET_GET_METHOD( Real, Vn_L );
	SIMPLE_SET_GET_METHOD( Real, Vt0i );
	SIMPLE_SET_GET_METHOD( Real, ActivityFactor );
	SIMPLE_SET_GET_METHOD( Real, kD_ATP );
	SIMPLE_SET_GET_METHOD( Real, kD_ADP );
	SIMPLE_SET_GET_METHOD( Real, TotalAdenosine );
	SIMPLE_SET_GET_METHOD( Real, TotalCreatine );
	SIMPLE_SET_GET_METHOD( Real, NAD_H_total );
	SIMPLE_SET_GET_METHOD( Real, f );
	SIMPLE_SET_GET_METHOD( Real, kfAK );
	SIMPLE_SET_GET_METHOD( Real, kbAK );
	SIMPLE_SET_GET_METHOD( Real, kfCK );
	SIMPLE_SET_GET_METHOD( Real, kbCK );
	SIMPLE_SET_GET_METHOD( Real, Km_calmodulin );
	SIMPLE_SET_GET_METHOD( Real, calmodulin_total );

	virtual void initialize()
	{
		Process::initialize();
		
		Vi  = getVariableReference( "Vi" ).getVariable();
		Vt  = getVariableReference( "Vt" ).getVariable();
		active_volume  = getVariableReference( "active_volume" ).getVariable();
		Volume_ratio  = getVariableReference( "Volume_ratio" ).getVariable();

		Proton  = getVariableReference( "Proton" ).getVariable();
		pH  = getVariableReference( "pH" ).getVariable();

		Mg  = getVariableReference( "Mg" ).getVariable();
		ATPtotal  = getVariableReference( "ATPtotal" ).getVariable();
		ATPfree  = getVariableReference( "ATPfree" ).getVariable();
		ATPmg  = getVariableReference( "ATPmg" ).getVariable();
		ADPtotal  = getVariableReference( "ADPtotal" ).getVariable();
		ADPfree  = getVariableReference( "ADPfree" ).getVariable();
		ADPmg  = getVariableReference( "ADPmg" ).getVariable();
		cAMP  = getVariableReference( "cAMP" ).getVariable();
		AMP  = getVariableReference( "AMP" ).getVariable();

		PCr  = getVariableReference( "PCr" ).getVariable();
		Creatine  = getVariableReference( "Creatine" ).getVariable();

		NAD  = getVariableReference( "NAD" ).getVariable();
		NADH  = getVariableReference( "NADH" ).getVariable();

		Pi  = getVariableReference( "Pi" ).getVariable();
		PiTotal  = getVariableReference( "PiTotal" ).getVariable();
		ATPtotal_mt  = getVariableReference( "ATPtotal_mt" ).getVariable();
		ADPtotal_mt  = getVariableReference( "ADPtotal_mt" ).getVariable();
		Pi_mt  = getVariableReference( "Pi_mt" ).getVariable();


		totalIonin  = getVariableReference( "totalIonin" ).getVariable();
		Na  = getVariableReference( "Na" ).getVariable();
		K  = getVariableReference( "K" ).getVariable();
		Cl  = getVariableReference( "Cl" ).getVariable();
		CaTotal  = getVariableReference( "CaTotal" ).getVariable();
		Ca  = getVariableReference( "Ca" ).getVariable();
		LA  = getVariableReference( "LA" ).getVariable();
		totalIonex  = getVariableReference( "totalIonex" ).getVariable();
		Cm  = getVariableReference( "Cm" ).getVariable();
		WaterFlux  = getVariableReference( "WaterFlux" ).getVariable();
		vAK  = getVariableReference( "vAK" ).getVariable();
		vCK  = getVariableReference( "vCK" ).getVariable();
		calmodulin  = getVariableReference( "calmodulin" ).getVariable();

		Tt  = getVariableReference( "Tt" ).getVariable();
		T  = getVariableReference( "T" ).getVariable();
		TCa  = getVariableReference( "TCa" ).getVariable();
		TCaCB  = getVariableReference( "TCaCB" ).getVariable();
		TCB  = getVariableReference( "TCB" ).getVariable();
	}

	virtual void fire()
	{
	  //		printf(" Vi : %e\n", Vi->getValue());
		
		//Vi->setValue( Vt->getValue() * active_volume->getValue());
		//		printf("->settedVi : %e\n", Vi->getValue());

		_SizeN_A = getSuperSystem()->getSizeN_A();

//		Vt->setValue( _Vt );
		//_Vt = Vi->getValue() + Vn_L;
		
		Volume_ratio->setValue( _Vt * Vt0i );  // simBio: org.simBio.bio.terashima_et_al_2006.experiment.VolumeRatio
		
		_Proton_MolarConc = Proton->getMolarConc();
		pH->setValue( -log10( ActivityFactor * _Proton_MolarConc) );

		_Mg_MolarConc = Mg->getMolarConc();
		_ATPtotal = ATPtotal->getValue();
		_ATPfree = _MetalEquilibrium( kD_ATP, _ATPtotal, _Mg_MolarConc );
		_ATPmg = _ATPtotal - _ATPfree;
		ATPfree->setValue( _ATPfree );
		ATPmg->setValue( _ATPmg );

		_ADPtotal = ADPtotal->getValue();
		_ADPfree = _MetalEquilibrium( kD_ADP, _ADPtotal, _Mg_MolarConc );
		_ADPmg = _ADPtotal - _ADPfree;
		ADPfree->setValue( _ADPfree );
		ADPmg->setValue( _ADPmg );
		_AMP = TotalAdenosine * _SizeN_A - _ATPtotal - _ADPtotal - cAMP->getValue();
		AMP->setValue( _AMP );

		_Creatine = TotalCreatine * _SizeN_A - PCr->getValue();
		Creatine->setValue( _Creatine );
		
		NADH->setValue( NAD_H_total * _SizeN_A - NAD->getValue() ); //ducky121026

		Pi->setValue( PiTotal->getValue() - PCr->getValue() - 3.0 * _ATPtotal - 2.0 * _ADPtotal - _AMP - 3.0 * ATPtotal_mt->getValue() - 2.0 * ADPtotal_mt->getValue() - Pi_mt->getValue() );

		_totalIonin = Na->getValue() + K->getValue() + Cl->getValue() + Ca->getValue() + LA->getValue();
		totalIonin->setValue( _totalIonin );
		
		//WaterFlux->setValue( f * Cm->getValue() * ( _totalIonin / _SizeN_A - totalIonex->getMolarConc() ) );
		WaterFlux->setValue( 0.0 );

		vAK->setValue( (( kfAK * _ADPfree * _ADPmg ) - (kbAK * _ATPmg * _AMP )) / _SizeN_A );
		vCK->setValue( (kfCK * _ADPtotal * PCr->getMolarConc() * _Proton_MolarConc ) - (kbCK * _ATPtotal * _Creatine / _SizeN_A ) );

		_Ca = CaTotal->getMolarConc();  // CaTotal.MolarConc
		_calmodulin_term = calmodulin_total - _Ca + Km_calmodulin;
		_Ca = (( sqrt( _calmodulin_term * _calmodulin_term + 4.0 * Km_calmodulin * _Ca ) - _calmodulin_term ) * 0.5 ) * _SizeN_A;  // Ca.Value
		Ca->setValue( _Ca );
		calmodulin->setValue( CaTotal->getValue() - _Ca );

		T->setValue( Tt->getValue() - TCa->getValue() - TCaCB->getValue() - TCB->getValue() );
	}

 protected:

	Variable* Vi;
	Variable* Vt;
	Variable* active_volume;
	Variable* Volume_ratio;

	Variable* Proton;
	Variable* pH;

	Variable* Mg;
	Variable* ATPtotal;
	Variable* ATPfree;
	Variable* ATPmg;
	Variable* ADPtotal;
	Variable* ADPfree;
	Variable* ADPmg;
	Variable* cAMP;
	Variable* AMP;

	Variable* PCr;
	Variable* Creatine;

	Variable* NAD;
	Variable* NADH;

	Variable* Pi;
	Variable* PiTotal;
	Variable* ATPtotal_mt;
	Variable* ADPtotal_mt;
	Variable* Pi_mt;

	Variable* totalIonin;
	Variable* Na;
	Variable* K;
	Variable* Cl;
	Variable* CaTotal;
	Variable* Ca;
	Variable* LA;
	Variable* totalIonex;
	Variable* Cm;
	Variable* WaterFlux;
	Variable* vAK;
	Variable* vCK;
	Variable* calmodulin;

	Variable* Tt;
	Variable* T;
	Variable* TCa;
	Variable* TCaCB;
	Variable* TCB;

	Real Vn_L;
	Real Vt0i;
	Real ActivityFactor;
	Real kD_ATP;
	Real kD_ADP;
	Real TotalAdenosine;
	Real TotalCreatine;
	Real NAD_H_total;
	Real f;
	Real kfAK;
	Real kbAK;
	Real kfCK;
	Real kbCK;
	Real Km_calmodulin;
	Real calmodulin_total;

 private:

	Real _SizeN_A;
	Real _Vt;
	Real _Proton_MolarConc;
	Real _Mg_MolarConc;
	Real _ATPtotal;
	Real _ATPfree;
	Real _ATPmg;
	Real _ADPtotal;
	Real _ADPfree;
	Real _ADPmg;
	Real _AMP;
	Real _Creatine;
	Real _totalIonin;
	Real _Ca;
	Real _calmodulin_term;

	Real _MetalEquilibrium( Real kD, Real total, Real ligand_M )
	{
		return total / ( 1.0 + ligand_M / kD );
	}
};

LIBECS_DM_INIT( CytoplasmAssignmentProcess, Process );

