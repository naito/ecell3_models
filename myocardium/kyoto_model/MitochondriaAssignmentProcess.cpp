#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( MitochondriaAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( MitochondriaAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		//PROPERTYSLOT_SET_GET( Real, PiTotal );
		PROPERTYSLOT_SET_GET( Real, dPsi );
		PROPERTYSLOT_SET_GET( Real, dPsimit );
		PROPERTYSLOT_SET_GET( Real, dPsicell );
		PROPERTYSLOT_SET_GET( Real, Zvalue );
		PROPERTYSLOT_SET_GET( Real, ActivityFactor );
		PROPERTYSLOT_SET_GET( Real, cbuffer );
		PROPERTYSLOT_SET_GET( Real, dpH );
		PROPERTYSLOT_SET_GET( Real, dP_myu );
		PROPERTYSLOT_SET_GET( Real, dPsi_ratio );
		PROPERTYSLOT_SET_GET( Real, ANP_total );
		PROPERTYSLOT_SET_GET( Real, kD_ATP );
		PROPERTYSLOT_SET_GET( Real, kD_ADP );
		PROPERTYSLOT_SET_GET( Real, NAD_H_total );
		PROPERTYSLOT_SET_GET( Real, UQ_H2_total );
		PROPERTYSLOT_SET_GET( Real, Cytc_23_total );
		PROPERTYSLOT_SET_GET( Real, ZscaleN );
		PROPERTYSLOT_SET_GET( Real, ZscaleU );
		PROPERTYSLOT_SET_GET( Real, Zscalec );
		PROPERTYSLOT_SET_GET( Real, EmN0 );
		PROPERTYSLOT_SET_GET( Real, EmU0 );
		PROPERTYSLOT_SET_GET( Real, Emc0 );
		PROPERTYSLOT_SET_GET( Real, Ema0 );
		PROPERTYSLOT_SET_GET( Real, Amp );
		PROPERTYSLOT_SET_GET( Real, kC1 );
		PROPERTYSLOT_SET_GET( Real, kC3 );
		PROPERTYSLOT_SET_GET( Real, Cyta_total );
		PROPERTYSLOT_SET_GET( Real, KmOC4 );
		PROPERTYSLOT_SET_GET( Real, kC4_0 );
		PROPERTYSLOT_SET_GET( Real, KmC4 );
		PROPERTYSLOT_SET_GET( Real, nC4 );
		PROPERTYSLOT_SET_GET( Real, dGp0 );
		PROPERTYSLOT_SET_GET( Real, kSN );
		PROPERTYSLOT_SET_GET( Real, nASN );
		PROPERTYSLOT_SET_GET( Real, kEX );
		PROPERTYSLOT_SET_GET( Real, KmADP );
		PROPERTYSLOT_SET_GET( Real, kPI );
		PROPERTYSLOT_SET_GET( Real, pKa );
		PROPERTYSLOT_SET_GET( Real, kLK1 );        // 未使用 kLK1 or kLK1_0 で十分？
		PROPERTYSLOT_SET_GET( Real, kLK1_0 );
		PROPERTYSLOT_SET_GET( Real, kLK2 );
		PROPERTYSLOT_SET_GET( Real, kDH );        // 未使用 kLK1 or kLK1_0 で十分？
		PROPERTYSLOT_SET_GET( Real, KmN );
		PROPERTYSLOT_SET_GET( Real, PD );
	}
	
	MitochondriaAssignmentProcess()
		:
		//PiTotal( 46.0e-3 ),
		dPsi( -159.9041054871848 ),
		dPsimit( -103.93766856667013 ),
		dPsicell( 55.96643692051468 ),
		Zvalue( 61.51965192093832 ),
		ActivityFactor( 1.0 ),
		cbuffer( 0.022 ),
		dpH( 0.001 ),
		dP_myu( 0.861 ),
		dPsi_ratio( 0.65 ),
		ANP_total( 16.26e-3 ),
		kD_ATP( 0.017e-3 ),
		kD_ADP( 0.282e-3 ),
		NAD_H_total( 2.97e-3 ),
		UQ_H2_total( 1.35e-3 ),
		Cytc_23_total( 0.27e-3 ),
		Cyta_total( 1.35e-4 ),
		ZscaleN( 1.0 ),
		ZscaleU( 1.0 ),
		Zscalec( 2.0 ),
		EmN0( -320.0 ),
		EmU0( 85.0 ),
		Emc0( 250.0 ),
		Ema0( 540.0 ),
		Amp( 5.0 ),
		kC1( 3.9825E-6 ),
		kC3( 2.2735e-6 ),
		KmOC4( 0.0008e-3 ),
		kC4_0( 0.06 ),
		KmC4( 0.12e-3 ),
		nC4( 5.0 ),
		dGp0( 31.9 ),
		kSN( 5.7193e-4 ),
		nASN( 2.5 ),
		kEX( 0.000909533 ),
		KmADP( 0.0035e-3 ),
		kPI( 1.157016667 ),
		pKa( 6.8 ),
		kLK1( 4.16667e-8 ),
		kLK1_0( 4.16667e-8 ),
		kLK2( 0.038 ),
		kDH( 4.679e-4 ),
		KmN( 100.0 ),
		PD( 0.8 )
	{
		// do nothing
	}

	//SIMPLE_SET_GET_METHOD( Real, PiTotal );
	SIMPLE_SET_GET_METHOD( Real, dPsi );
	SIMPLE_SET_GET_METHOD( Real, dPsimit );
	SIMPLE_SET_GET_METHOD( Real, dPsicell );
	SIMPLE_SET_GET_METHOD( Real, Zvalue );
	SIMPLE_SET_GET_METHOD( Real, ActivityFactor );
	SIMPLE_SET_GET_METHOD( Real, cbuffer );
	SIMPLE_SET_GET_METHOD( Real, dpH );
	SIMPLE_SET_GET_METHOD( Real, dP_myu );
	SIMPLE_SET_GET_METHOD( Real, dPsi_ratio );
	SIMPLE_SET_GET_METHOD( Real, ANP_total );
	SIMPLE_SET_GET_METHOD( Real, kD_ATP );
	SIMPLE_SET_GET_METHOD( Real, kD_ADP );
	SIMPLE_SET_GET_METHOD( Real, NAD_H_total );
	SIMPLE_SET_GET_METHOD( Real, UQ_H2_total );
	SIMPLE_SET_GET_METHOD( Real, Cytc_23_total );
	SIMPLE_SET_GET_METHOD( Real, Cyta_total );
	SIMPLE_SET_GET_METHOD( Real, ZscaleN );
	SIMPLE_SET_GET_METHOD( Real, ZscaleU );
	SIMPLE_SET_GET_METHOD( Real, Zscalec );
	SIMPLE_SET_GET_METHOD( Real, EmN0 );
	SIMPLE_SET_GET_METHOD( Real, EmU0 );
	SIMPLE_SET_GET_METHOD( Real, Emc0 );
	SIMPLE_SET_GET_METHOD( Real, Ema0 );
	SIMPLE_SET_GET_METHOD( Real, Amp );
	SIMPLE_SET_GET_METHOD( Real, kC1 );
	SIMPLE_SET_GET_METHOD( Real, kC3 );
	SIMPLE_SET_GET_METHOD( Real, KmOC4 );
	SIMPLE_SET_GET_METHOD( Real, kC4_0 );
	SIMPLE_SET_GET_METHOD( Real, KmC4 );
	SIMPLE_SET_GET_METHOD( Real, nC4 );
	SIMPLE_SET_GET_METHOD( Real, dGp0 );
	SIMPLE_SET_GET_METHOD( Real, kSN );
	SIMPLE_SET_GET_METHOD( Real, nASN );
	SIMPLE_SET_GET_METHOD( Real, kEX );
	SIMPLE_SET_GET_METHOD( Real, KmADP );
	SIMPLE_SET_GET_METHOD( Real, kPI );
	SIMPLE_SET_GET_METHOD( Real, pKa );
	SIMPLE_SET_GET_METHOD( Real, kLK1 );
	SIMPLE_SET_GET_METHOD( Real, kLK1_0 );
	SIMPLE_SET_GET_METHOD( Real, kLK2 );
	SIMPLE_SET_GET_METHOD( Real, kDH );
	SIMPLE_SET_GET_METHOD( Real, KmN );
	SIMPLE_SET_GET_METHOD( Real, PD );
	
	virtual void initialize()
	{
		Process::initialize();
		
		volume    = getVariableReference( "volume" ).getVariable();
		total = getVariableReference( "total" ).getVariable();
		ratio  = getVariableReference( "ratio" ).getVariable();
		Rcm   = getVariableReference( "Rcm" ).getVariable();

		Pi    = getVariableReference( "Pi" ).getVariable();
		PiTotal = getVariableReference( "PiTotal" ).getVariable();
		PCr  = getVariableReference( "PCr" ).getVariable();
		ATPtcell   = getVariableReference( "ATPtcell" ).getVariable();
		ADPtcell   = getVariableReference( "ADPtcell" ).getVariable();
		AMP        = getVariableReference( "AMP"      ).getVariable();
		ATPtmit    = getVariableReference( "ATPtmit"  ).getVariable();
		ADPtmit    = getVariableReference( "ADPtmit"  ).getVariable();
		ATPfcell   = getVariableReference( "ATPfcell" ).getVariable();
		ADPfcell   = getVariableReference( "ADPfcell" ).getVariable();
		ATPfmit    = getVariableReference( "ATPfmit"  ).getVariable();
		ADPfmit    = getVariableReference( "ADPfmit"  ).getVariable();
		Pimit  = getVariableReference( "Pimit" ).getVariable();
		Mg  = getVariableReference( "Mg" ).getVariable();
		ATPMg  = getVariableReference( "ATPMg" ).getVariable();
		ADPMg  = getVariableReference( "ADPMg" ).getVariable();

		T  = getVariableReference( "T" ).getVariable();
		R = getVariableReference( "R" ).getVariable();
		F  = getVariableReference( "F" ).getVariable();

		Proton = getVariableReference( "Proton" ).getVariable();
		Hcell = getVariableReference( "Hcell" ).getVariable();
		pH  = getVariableReference( "pH" ).getVariable();
		pHcell  = getVariableReference( "pHcell" ).getVariable();
		rbuffer  = getVariableReference( "rbuffer" ).getVariable();

		NADH  = getVariableReference( "NADH" ).getVariable();
		NAD = getVariableReference( "NAD" ).getVariable();
		EmN = getVariableReference( "EmN" ).getVariable();

		UQH2  = getVariableReference( "UQH2" ).getVariable();
		UQ = getVariableReference( "UQ" ).getVariable();
		EmU = getVariableReference( "EmU" ).getVariable();

		Cytc2  = getVariableReference( "Cytc2" ).getVariable();
		Cytc3 = getVariableReference( "Cytc3" ).getVariable();
		Emc = getVariableReference( "Emc" ).getVariable();

		Ema = getVariableReference( "Ema" ).getVariable();
		//Cyta_total  = getVariableReference( "Cyta_total" ).getVariable();
		Cyta2  = getVariableReference( "Cyta2" ).getVariable();
		Cyta3 = getVariableReference( "Cyta3" ).getVariable();

		vC1 = getVariableReference( "vC1" ).getVariable();
		vC3  = getVariableReference( "vC3" ).getVariable();
		vC4  = getVariableReference( "vC4" ).getVariable();
		jC1 = getVariableReference( "jC1" ).getVariable();
		jC3  = getVariableReference( "jC3" ).getVariable();
		jC4  = getVariableReference( "jC4" ).getVariable();
		//Amp  = getVariableReference( "Amp" ).getVariable();

		O2 = getVariableReference( "O2" ).getVariable();
		CN  = getVariableReference( "CN" ).getVariable();
		jO2 = getVariableReference( "jO2" ).getVariable();

		vSN = getVariableReference( "vSN" ).getVariable();
		vANT = getVariableReference( "vANT" ).getVariable();
		vPI = getVariableReference( "vPI" ).getVariable();
		vLK = getVariableReference( "vLK" ).getVariable();
		jSN = getVariableReference( "jSN" ).getVariable();
		jANT = getVariableReference( "jANT" ).getVariable();
		jPI = getVariableReference( "jPI" ).getVariable();
		jLK = getVariableReference( "jLK" ).getVariable();
		FCCP = getVariableReference( "FCCP" ).getVariable();
		vDH = getVariableReference( "vDH" ).getVariable();
		jDH = getVariableReference( "jDH" ).getVariable();


		_F  = F->getValue() / 1000.0;         // C/mmol  （simBio内では C/mM と表記）
		R_F = R->getValue() / F->getValue();  // (C mV/K/mol)/(C/mol) = mV/K

		_vSN0 = dGp0 * 1000.0 / _F;           // (mJ/mmol)/(C/mmol) = (C mV/mmol)/(C/mmol) = mV

		// simBioでは体積の変動につれて、総濃度が維持されて、
		// 総量が変化するモデルになっているが、それは不合理なので
		// 総量一定とする。事実上、大きな差はないと思われる。
		// _ANP_total_Value = ANP_total * ATPtmit->getSuperSystem()->getSizeN_A();
	}

	virtual void fire()
	{
		_ATPtmit = ATPtmit->getValue();

		volume->setValue( total->getValue() * ratio->getValue() );

		_SizeN_A = getSuperSystem()->getSizeN_A();
		//		printf("Mit: %12.10f\n",_SizeN_A);

		_Rcm = 1.0 / ratio->getValue();
		Rcm->setValue( _Rcm );
		Pi->setValue( PiTotal->getValue() - PCr->getValue() - 3.0 * ATPtcell->getValue() - 2.0 * ADPtcell->getValue() - AMP->getValue() - 3.0 * _ATPtmit - 2.0 * ADPtmit->getValue() - Pimit->getValue() );

		_z = 2.303 * R_F * T->getValue();
		Zvalue = _z;

		_pH = pH->getValue();
		pH->setValue( -log10( ActivityFactor * Proton->getMolarConc()) );

		_rbuffer = cbuffer / ( (pow(10.0, - _pH) - pow(10.0, (-_pH - dpH))) / dpH );
		rbuffer->setValue( _rbuffer );

		_dpH = _z * ( _pH - pHcell->getValue() );  // className="org.simBio.bio.matsuoka_et_al_2004.function.GradientpH"
		_dP = _dpH * 1.0 / ( 1.0 - dP_myu );       // className="org.simBio.bio.matsuoka_et_al_2004.function.GradientP"

		_dPsi = -( _dP - _dpH );                   // className="org.simBio.bio.matsuoka_et_al_2004.function.MembranePotential"
		dPsi = _dPsi;
		_dPsimit = _dPsi * dPsi_ratio;             // className="org.simBio.bio.matsuoka_et_al_2004.function.PartialPotential"
		dPsimit = _dPsimit;
		_dPsicell = -( _dPsi - _dPsimit );         // className="org.simBio.bio.matsuoka_et_al_2004.function.PartialPotential"
		dPsicell = _dPsicell;

		_ADPtmit = ANP_total * _SizeN_A - _ATPtmit;
		ADPtmit->setValue( _ADPtmit );
		//setComponent( ANP_total,     ADPtmit, ATPtmit );

		_ATPfmit = _MetalEquilibrium( kD_ATP, _ATPtmit, Mg->getMolarConc());
		ATPfmit->setValue( _ATPfmit );
		ATPMg->setValue( _ATPtmit - _ATPfmit );

		_ADPfmit = _MetalEquilibrium( kD_ADP, _ADPtmit, Mg->getMolarConc());
		ADPfmit->setValue( _ADPfmit );
		ADPMg->setValue( _ADPtmit - _ADPfmit );

		//setMetalEquilibrium( kD_ATP, ATPtmit, Mg, ATPMg, ATPfmit );
		//setMetalEquilibrium( kD_ADP, ADPtmit, Mg, ADPMg, ADPfmit );

		NAD->setValue(   NAD_H_total   * _SizeN_A - NADH->getValue()  );
		// needs modification 120702
		UQ->setValue(    UQ_H2_total   * _SizeN_A - UQH2->getValue()  );
		Cytc3->setValue( Cytc_23_total * _SizeN_A - Cytc2->getValue() );
		//setComponent( NAD_H_total,   NAD,     NADH    );
		//setComponent( UQ_H2_total,   UQ,      UQH2    );
		//setComponent( Cytc_23_total, Cytc3,   Cytc2   );

		EmN->setValue( _RedoxPotential( EmN0, ZscaleN, _z, NAD->getValue(),   NADH->getValue()  ));
		EmU->setValue( _RedoxPotential( EmU0, ZscaleU, _z, UQ->getValue(),    UQH2->getValue()  ));
		Emc->setValue( _RedoxPotential( Emc0, Zscalec, _z, Cytc3->getValue(), Cytc2->getValue() ));

		//setRedoxPotential( EmN0, ZscaleN, _z, EmN, NAD,   NADH );
		//setRedoxPotential( EmU0, ZscaleU, _z, EmU, UQ,    UQH2 );
		//setRedoxPotential( Emc0, Zscalec, _z, Emc, Cytc3, Cytc2 );

		//Ema->setValue( Emc->getValue() + _dP * ( 2.0 + 2.0 * dP_myu ) / 2.0 );
		Ema->setValue( Emc->getValue() + _dP * ( 1.0 + 1.0 * dP_myu ) );

		_Cyta2 = Cyta_total * _SizeN_A / ( 1.0 + pow( 10.0, ( Ema->getValue() - Ema0 ) / _z ));
		Cyta2->setValue( _Cyta2 );
		Cyta3->setValue( Cyta_total * _SizeN_A - _Cyta2 );

		_vC1 = 0.0;
		_vC3 = 0.0;
		_vC4 = 0.0;

		_kC4 = kC4_0 / (1.0 + pow( CN->getMolarConc() / 0.12e-3, 5.0 ));

		if ( vC4->getValue() >= 0.0 ) {
		
			if ( vC3->getValue() >= 0.0 ) {
			
				if ( vC1->getValue() >= 0.0 ) {
				
					_vC1 = Amp * kC1 * ( EmU->getValue() - EmN->getValue() - _dP * 2.0 );
				}
			
				_vC3 = Amp * kC3 * ( Emc->getValue() - EmU->getValue() - _dP * ( 4.0 - 2.0 * dP_myu ) / 2.0 );
			}
			//_vC4 = Amp * ( _kC4 / ( 1.0 + pow( CN->getMolarConc() / KmC4, nC4 ))) * ( Cyta2->getMolarConc()* 1000.0 ) * ( Cytc2->getMolarConc() * 1000.0 ) * ( O2->getMolarConc() / ( O2->getMolarConc() + KmOC4 ));

			_vC4 = Amp * ( _kC4 / ( 1.0 + pow( CN->getMolarConc() / KmC4, nC4 ))) * ( Cyta2->getMolarConc() * 1000.0 ) * ( Cytc2->getMolarConc() * 1000.0 ) * ( O2->getMolarConc() / ( O2->getMolarConc() + KmOC4 ));
		}

		_Rcm_SizeN_A = _Rcm / 1000.0 * _SizeN_A;

		vC1->setValue( _vC1 );
		vC3->setValue( _vC3 );
		vC4->setValue( _vC4 );

		jC1->setValue( _vC1 * _Rcm_SizeN_A / 5.0 );
		jC3->setValue( _vC3 * _Rcm_SizeN_A );
		jC4->setValue( _vC4 * _Rcm_SizeN_A );

		_vSN1 = pow( 10.0, ( nASN * _dP - ( _vSN0 + _z * log10( ATPtmit->getMolarConc() / ADPtmit->getMolarConc() / Pimit->getMolarConc() ))) / _z );
		_vSN = 0.0;
		vSN->setValue( _vSN );
		jSN->setValue( _vSN * _Rcm_SizeN_A );

		/*
		ePsimito = pow( 10, (-_dPsimit  / _z ));
		ePsicell = pow( 10, (-_dPsicell / _z ));
		ATPratio_mito = ADPfmit->getMolarConc() / (ADPfmit->getMolarConc() + ePsimito * ATPfmit->getMolarConc() );
		ATPratio_cell = ADPfcell->getMolarConc() / (ADPfcell->getMolarConc() + ePsicell * ATPfcell->getMolarConc() );
		ADPFactor = 1.0 / (1.0 + KmADP / ADPfcell->getMolarConc() );
		_vANT = Amp * kEX * ( ATPratio_cell - ATPratio_mito ) * ADPFactor;
		*/

		_ADPfcell = ADPfcell->getValue();
		_ATPfcell = ATPfcell->getValue();
		//_ADPfcell_M = ADPfcell->getMolarConc();
		//_ATPfcell_M = ATPfcell->getMolarConc();
		//_ADPfmit_M  = ADPfmit->getMolarConc();
		//_ATPfmit_M  = ATPfmit->getMolarConc();
		_vANT = 0.0;
		vANT->setValue( _vANT );
		jANT->setValue( _vANT * _Rcm_SizeN_A );
		
		// org.simBio.bio.matsuoka_et_al_2004.molecule.Transporter.PhosphateCarrier
		_vPI = Amp * kPI * ( \
			(( Pi->getMolarConc() * 1000.0 / ( 1.0 + pow( 10.0, ( pHcell->getValue() - pKa )))) * \
			Hcell->getMolarConc() * 1000.0 ) - \
			(( Pimit->getMolarConc() * 1000.0 / ( 1.0 + pow( 10.0, ( pH->getValue() - pKa )))) * \
			Proton->getMolarConc() * 1000.0 ));
		vPI->setValue( _vPI );
		jPI->setValue( _vPI * _Rcm_SizeN_A );

		_vLK = Amp * kLK1_0 * ( 1.0 + 1.0e+4 * FCCP->getMolarConc() / ( FCCP->getMolarConc() + 1.0e-7 )) * ( exp( kLK2 * _dP ) - 1.0 );
		vLK->setValue( _vLK );
		jLK->setValue( _vLK * _Rcm_SizeN_A / _rbuffer );

		/*
		std::cout << std::endl;
		std::cout << "Amp  = " << Amp  << std::endl;
		std::cout << "kDH  = " << kDH  << std::endl;
		std::cout << "KmN  = " << KmN  << std::endl;
		std::cout << "PD   = " << PD   << std::endl;
		std::cout << "_vDH = " << _vDH << std::endl;
		*/
		_vDH = Amp * kDH / pow( 1.0 + KmN * NADH->getValue() / NAD->getValue(), PD );
		vDH->setValue( _vDH );
		jDH->setValue( _vDH * _Rcm_SizeN_A / 5.0 );

		jO2->setValue( ( - (( 2.0 * ( 2.0 + 2.0 * dP_myu ) * _vC4 ) + (( 4.0 - 2.0 * dP_myu ) * _vC3 ) + ( 4.0 * _vC1 )) + nASN * _vSN + dP_myu * _vANT + ( 1.0 - dP_myu ) * _vPI ) * _Rcm_SizeN_A / _rbuffer );
	}

 protected:

	Variable* volume;
	Variable* total;
	Variable* ratio;
	Variable* Rcm;

	Variable* Pi;
	Variable* PiTotal;
	Variable* PCr;
	Variable* ATPtcell;
	Variable* ADPtcell;
	Variable* AMP;
	Variable* ATPtmit;
	Variable* ADPtmit;
	Variable* ATPfcell;
	Variable* ADPfcell;
	Variable* ATPfmit;
	Variable* ADPfmit;
	Variable* Pimit;
	Variable* Mg;
	Variable* ATPMg;
	Variable* ADPMg;

	Variable* T;
	Variable* R;
	Variable* F;

	Variable* Proton;
	Variable* Hcell;
	Variable* pH;
	Variable* pHcell;
	Variable* rbuffer;

	Variable* NADH;
	Variable* NAD;
	Variable* EmN;

	Variable* UQH2;
	Variable* UQ;
	Variable* EmU;

	Variable* Cytc2;
	Variable* Cytc3;
	Variable* Emc;

	Variable* Ema;
	//Variable* Cyta_total;
	Variable* Cyta2;
	Variable* Cyta3;

	Variable* vC1;
	Variable* vC3;
	Variable* vC4;
	Variable* jC1;
	Variable* jC3;
	Variable* jC4;
	//Variable* Amp;

	Variable* O2;
	Variable* CN;
	Variable* jO2;

	Variable* vSN;
	Variable* vANT;
	Variable* vPI;
	Variable* vLK;
	Variable* jSN;
	Variable* jANT;
	Variable* jPI;
	Variable* jLK;
	Variable* FCCP;
	Variable* vDH;
	Variable* jDH;

	//Real PiTotal;
	Real dPsi;
	Real dPsimit;
	Real dPsicell;
	Real Zvalue;

	Real ActivityFactor;
	Real cbuffer;
	Real dpH;
	Real dP_myu;

	Real dPsi_ratio;

	Real ANP_total;
	Real kD_ATP;
	Real kD_ADP;


	Real NAD_H_total;
	Real UQ_H2_total;
	Real Cytc_23_total;
	Real Cyta_total;

	Real ZscaleN;
	Real ZscaleU;
	Real Zscalec;
	Real EmN0;
	Real EmU0;
	Real Emc0;
	Real Ema0;

	Real Amp;
	Real kC1;
	Real kC3;

	Real KmOC4;
	Real kC4_0;
	Real KmC4;
	Real nC4;

	Real dGp0;
	Real kSN;
	Real nASN;

	Real kEX;
	Real KmADP;

	Real kPI;
	Real pKa;

	Real kLK1;
	Real kLK1_0;
	Real kLK2;

	Real kDH;
	Real KmN;
	Real PD;


 private:
	Real R_F;

	Real _F;
	Real _z;
	Real _rbuffer;
	Real _pH;
	Real _dpH;
	Real _dP;
	Real _dPsi;
	Real _dPsimit;
	Real _dPsicell;
	// Real _ANP_total_Value;
	Real _ATPtmit;
	Real _ADPtmit;
	Real _ATPfmit;
	Real _ADPfmit;
	Real _Cyta2;
	Real _vC1;
	Real _vC3;
	Real _vC4;
	Real _kC4;
	Real _vSN;
	Real _vSN0;
	Real _vSN1;
	Real _vANT;
	Real _vPI;
	Real _vLK;
	Real _vDH;
	Real _SizeN_A;
	Real _Rcm;
	Real _Rcm_SizeN_A;

	Real _ADPfcell;
	Real _ATPfcell;
	/*
	Real _ADPfcell_M;
	Real _ATPfcell_M;
	Real _ADPfmit_M;
	Real _ATPfmit_M;
	*/
	/*
	Real ePsimito;
	Real ePsicell;
	Real ATPratio_mito;
	Real ATPratio_cell;
	Real ADPFactor;
	*/
	
/*
	void setComponent( Real total, VariableReference self, VariableReference other )
	{
		self->setValue( total * getSuperSystem()->getSizeN_A() - other->getValue() );
	}

	void setRedoxPotential( Real Em0, Real Zscale, Real Zvalue, VariableReference Em, VariableReference product, VariableReference substrate )
	{
		Em->setValue( Em0 + Zscale * Zvalue * 0.5 * log10( product->getValue() / substrate->getValue() ) );
	}

	void setMetalEquilibrium( Real kD, VariableReference total, VariableReference ligand, VariableReference bind, VariableReference free )
	{
		Real _free = total->getValue() / ( 1.0 + ligand->getMolarConc() / kD);
		free->setValue( _free );
		bind->setValue( total->getValue() - _free );
	}
*/

	Real _RedoxPotential( Real Em0, Real Zscale, Real Zvalue, Real product, Real substrate )
	{
		return Em0 + Zscale * Zvalue * 0.5 * log10( product / substrate ) ;
	}

	Real _MetalEquilibrium( Real kD, Real total, Real ligand_M )
	{
		return total / ( 1.0 + ligand_M / kD );
	}

};

LIBECS_DM_INIT( MitochondriaAssignmentProcess, Process );

