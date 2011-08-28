@# Kuzumoto et al. 2007

@{
'''モデル中ので共有する値'''

'''cAMP0 (M)'''
cAMP0 = 2.9402986755873916e-7



'''アボガドロ数'''
N_A = 6.0221367e+23

'''ファラデー定数（C/mmol）'''
F   = 96.4867

'''気体定数（mV/K/mmol）'''
R   = 8.3143

zNa = 1.0
zK  = 1.0
zCa = 2.0
zCl = -1.0

R_F = R / F

R_FzNa = R / F / zNa
R_FzK  = R / F / zK
R_FzCa = R / F / zCa
R_FzCl = R / F / zCl

FzNa_R = zNa * F / R
FzK_R  = zK  * F / R
FzCa_R = zCa * F / R
FzCl_R = zCl * F / R

# (/sec)
'''
_pA2J = 1.0e-15 * N_A / F
_pA2J_Na = 1.0e-15 * N_A / zNa / F
_pA2J_K  = 1.0e-15 * N_A / zK  / F
_pA2J_Ca = 1.0e-15 * N_A / zCa / F
_pA2J_Cl = 1.0e-15 * N_A / zCl / F

_C2mV = 1.0e-15 / N_A * F
'''

# (/msec)
_pA2J = 1.0e-18 * N_A / F
_pA2J_Na = 1.0e-18 * N_A / zNa / F
_pA2J_K  = 1.0e-18 * N_A / zK  / F
_pA2J_Ca = 1.0e-18 * N_A / zCa / F
_pA2J_Cl = 1.0e-18 * N_A / zCl / F

_C2mV = 1.0e-18 / N_A * F

'''モデル内パラメータ'''
StepInterval = 0.01  # (msec)

Vt0 = 6034.827102834567e-15
Cm0 = 211.2

Cytoplasm_SIZE = 5029.527102834567e-15  # (L)

PKA0   = 1.3644055081894695e-7
amplitudePKAf = 0.0

IsotonicContraction_X = 0.9642934482030562
IsotonicContraction_dXdt = -5.728095994809306E-7

vAK = 2.974768800484851E-9  # (mM/ms)
vCK = -1.944599969721096E-5  # (mM/ms)

INa_I = -0.027871077416313655
INa_pRP = 0.0025006281477573987
INa_pAP = 1.2996075720006722E-4
INa_pAI = 0.9614569723080927
INa_pRI = 1.0 - INa_pRP - INa_pAP - INa_pAI
INa_gate = 0.06522287523631946
INa_GX = 0.375 / 21.666666666667

ICaL_AssignmentProcess_Name = "ICaLAssignmentHimeno08Process"
ICaL_I = -5.698659920323735
ICaL_pRP = 0.6984862394675786
ICaL_pAP = 0.004815159319985881
ICaL_pAI = 0.2965571818408713
ICaL_pRI = 1.0 - ICaL_pRP - ICaL_pAP - ICaL_pAI
ICaL_pU = 0.20970854897849503
ICaL_pUCa = 2.9086182929658735E-4
ICaL_pC = 0.5133806379005986
ICaL_pCCa = 1.0 - ICaL_pU - ICaL_pUCa - ICaL_pC
ICaL_gate = 0.953203122169012
ICaL_KmPKA  = 0.00065e-3
ICaL_hill_n = 2.0
ICaL_MAX    = 17.5
ICaL_kSingleCurrentAmp = 0.3
ICaL_GX = 31.5 / 45.0

CaDiadic = -3.829497696421197E-4

ICaT_I = -0.2831726320956765
ICaT_activation = 0.03860652073540893
ICaT_inactivation = 0.008328043625930398
ICaT_GX = 1.0

Ist_I = -11.854337592615822
Ist_max = 1.0
Ist_activation = 0.3141402829962753
Ist_inactivation = 0.7679681596792866
Ist_slowInactivation = 0.8299423547898264
Ist_GX = 1.0

Iha_I              = -0.5673935854045364
Iha_cAMP_Vshift    = -0.005343609952096294
Iha_closedState1   =  0.9802898362737278
Iha_closedState2   =  0.004748257229221275
Iha_openState1     =  0.004959347187308034
Iha_openState2     =  0.004823623958079242
Iha_GX = 1.0

IK1_I = 0.06010967672690573
IK1_Pspm = 0.9898965676123382
IK1_GX = 0.007079 / 2.6

IKr_I = 10.439484070085971
IKr_gate1 = 0.07692272268388735
IKr_gate2 = 0.2548122335766171
IKr_gate3 = 0.6993191046995856
IKr_POpen = 7.75568229426937E-4
IKr_GX = 0.07 / 0.035

IKS_AssignmentProcess_Name = "IKsAssignmentHimeno08Process"
IKs_I = 0.7691293998087532
IKs_gate1 = 0.04413350343041109
IKs_gate2 = 0.33149798928652635
IKs_gateC2 = 0.09606746048152735
IKs_KCNQ1 = 2.1138351225877917E-8
IKs_KCNQ1free = 1.4550328494666098E-9
IKs_KCNQ1p = 2.3680605828505056E-9
IKs_KCNQ1p_ratio = 0.09472242331388207
IKs_POpen = 0.012150164373409759
IKs_ka11 = 85.0
IKs_ka12 = -10.5
IKs_ka13 = 370.0
IKs_ka14 = -62.0
IKs_kb11 = 1450.0
IKs_kb12 = 20.0
IKs_kb13 = 300.0
IKs_kb14 = 210.0
IKs_GX = 0.86 / 0.025

Ito_GX = 0.0

IKACh_I = 4.021110926835921
IKACh_Km = 0.0042e-3  # M
IKACh_permeabilityK = 0.135
IKACh_gate = 0.027497803645978498
IKACh_GX = 1.0

INaK_I = 16.560562155909018
INaK_gate = 0.6773216532867061
INaK_amplitude0 = 14.5
INaK_GX = 14.5 / 10.8

INaCa_I = -1.7734311595487071
INaCa_pE1total = 0.13404849927387902
INaCa_inActivation1 = 0.08411974735336292
INaCa_inActivation2 = 0.7811977658013294
INaCa_pE2total = 1.0 - INaCa_pE1total - INaCa_inActivation1 - INaCa_inActivation2
INaCa_GX = 150.0 / 110.0

IPMCA_I = 0.41061664333489445
IPMCA_gate = 0.513148808394973
IPMCA_amplitude = 0.045815939110831344
IPMCA_GX = 0.045725301882469004 / 0.045815939110831344

ILCCa_I = -0.043631594045484556
ILCCa_GX = 0.03 / 0.0075

IKATP_I = 0.014883691806805308
IKATP_number = 2333.0
IKATP_Cm0 = Cm0 * 132.0 / 211.2
IKATP_GX =  0.04173 / 0.0236 * IKATP_Cm0 / 2333.0

IKpl_I = 0.6670751594510492
IKpl_GX = 2.187E-4 / 8.333E-7

IbNSC_I = -19.12393818544875
IbNSC_GX = 0.0023 / 5.69E-4

ICab_I = -0.047517695380462674
ICab_GX = 2.5E-4 / 3.03E-4

IClb_I = -0.0013826441141333214
IClb_GX = 1.0

NKCC_ClFlux = 5.226310117876499E-4
NKCC_GX = 2.3687E-5 / 0.0359

IRyR_I = 1.3337693366079364
IRyR_open = 1.0180387591148615E-4
IRyR_close = 0.20023792311289876
IRyR_GX = 300.0 / 200.0

PLB_Inhib1ptot = 1.0531670704296041E-7
PLB_PLBp = 0.008394872299140389E-3
PLB_Inhib1tot = 3.0E-7
PLB_PP1tot = 8.9E-7
PLB_PLB = 0.09760512770096365E-3
PLB_Inhib1 = 1.9468329297692058E-7
PLB_Inhib1p = 1.3402187128373755E-10
PLB_PP1_Inhib1p = 1.0518268515179565E-7
PLB_PP1 = 7.848173148482043E-7
PLB_PLBItot = 0.106e-3

ISRCA_I = -6.551008411826968
ISRCA_gate = 0.024612414535178432
ISRCA_GX = 1.0

leak_I = 13.140621339917605
leak_permeabilityCa = 0.3e+3

Mitochondria_SIZE = 1156.791233640463e-15
Mitochondria_Rcm = 4.3478260869565215
Mitochondria_Mg = 0.38e-3
Mitochondria_Proton = 3.8260380134352804E-8
Mitochondria_pH = 7.417250709119239
Mitochondria_rbuffer = 250010.1296389743
Mitochondria_ATPtotal = 6.378369513312658E-3
Mitochondria_ATPfree = 2.731291172081207E-4
Mitochondria_ATPmg = 6.105239090534464E-3
Mitochondria_ADPtotal = 9.881631792257418E-3
Mitochondria_ADPfree = 4.209396020266754E-3
Mitochondria_ADPmg = 5.672235771990663E-3
Mitochondria_ANP_total = 16.26e-3
Mitochondria_Pi = 5.848112980163107E-3
Mitochondria_NADH = 8.305473749351762E-4
Mitochondria_NAD = 2.1394526374059115E-3
Mitochondria_NAD_H_total = 2.97e-3
Mitochondria_UQH2 = 1.0529746600206569E-3
Mitochondria_UQ = 2.970252962753779E-4
Mitochondria_UQ_H2_total = 1.35e-3
Mitochondria_Cytc2 = 5.058170838154749E-5
Mitochondria_Cytc3 = 2.1941828721798734E-4
Mitochondria_Cytc_23_total = 0.27e-3
Mitochondria_EmN = -307.3596102367213
Mitochondria_EmU = 68.09364602934353
Mitochondria_Emc = 289.20520006192976
Mitochondria_Ema = 632.8759146052397
Mitochondria_Cyta2 = 4.0495967567304E-6
Mitochondria_Cyta3 = 1.3095040324326962E-4
Mitochondria_Cyta_total = 1.35e-4
Mitochondria_vC1 = 2.921605011306486E-5
Mitochondria_vC3 = 2.9389586820767207E-5
Mitochondria_vC4 = 1.4699161676708284E-5
Mitochondria_vSN = 6.890465125692704E-5
Mitochondria_vANT = 6.372058315433686E-5
Mitochondria_vPI = 6.809435244812406E-5
Mitochondria_vLK = 5.57472927641354E-5
Mitochondria_vDH = 2.9461065831902776E-5
Mitochondria_Amp = 1.2

CurrentClamp_amplitude = -8000.0
CurrentClamp_onset     =  50.0
CurrentClamp_offset    =  52.0
CurrentClamp_interval  =  400.0


''' メソッド '''

'''
電流に基づくイオン流束の計算
'''
def IonFlux( Ion, Current ):

	theTemplate = '''
	Process IonFluxProcess( j%s ) 
	{
		Priority	11;

		VariableReferenceList
			[ %se  :/:%s                1 ]
			[ %si  :../../CYTOPLASM:%s -1 ]
			[ i   :.:%s                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:z%s                0 ];
	}
'''
	if Ion == 'Ca':
		Xi = 'CaTotal'
	else:
		Xi = Ion

	return theTemplate % ( Ion, Ion, Ion, Ion, Xi, Current, Ion )

'''
電流に基づき膜電位Variableに変動を加える
'''
def MembranePotential( Current, Coefficient = 1 ):

	Vm_template = '''
	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  %d ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:%s    0 ];
	}
'''
	return Vm_template % ( Coefficient, Current )

'''
各チャネルの電流を総電流Variableに加算する
'''
def addToTotalCurrent( totalCurrentName, eachCurrentName, Coefficient = 1.0 ):

	totalCurrent_template = '''
	Process CurrentIncrementProcess( %s ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:%s  1 ]
			[ c     :.:%s               0 ];

		n %s;
		
	}
'''
	return totalCurrent_template % ( totalCurrentName, totalCurrentName, eachCurrentName, Coefficient )

'''
IonFlux(), MembranePotential(), addToTotalCurrent() をまとめて処理する

第１引数：[ "チャネル総電流名", MembranePotential()の計数（省略可） ]
第２引数以降（可変）： [ "イオン種名", "電流成分名", addToTotalCurrent()の計数（省略可） ] 
'''
def setCurrents( totalCurrent, *eachCurrent ):

	IonFluxEM = ''
	CurrentEM = ''

	for aCurrent in eachCurrent:
		IonFluxEM += IonFlux( aCurrent[ 0 ], aCurrent[ 1 ] )
		
		if len( aCurrent ) > 2 :
			aCoefficient = aCurrent[ 2 ]
		else:
			aCoefficient = 1.0
		aCurrentName = 'current' + aCurrent[ 0 ]
		CurrentEM += addToTotalCurrent( aCurrentName, aCurrent[ 1 ], aCoefficient )

	if len( totalCurrent ) > 1 :
		aCoefficient = aCurrent[ 1 ]
	else:
		aCoefficient = 1

	return IonFluxEM + MembranePotential( totalCurrent[ 0 ], aCoefficient ) + CurrentEM + addToTotalCurrent( 'current', totalCurrent[ 0 ] )

}


@# 連続Stepperの名称は「ODE」中身は切り替え可能

Stepper FixedODE1Stepper( ODE ){ StepInterval   @StepInterval; }
#Stepper ODEStepper( ODE ){}
#Stepper ODE45Stepper( ODE ){}

@# 離散イベントはPassiveStepper「PSV」で処理。これでほとんど問題ないはず

Stepper PassiveStepper( PSV ){}
#Stepper DiscreteTimeStepper( PSV ){}

#Stepper DiscreteTimeStepper( DSC ){}

#Stepper DAEStepper( DAE ){}

System System( / )
{
	StepperID	ODE;

	@# <variable name="volume" initial_value="1.28E7" units="um^3" />

	Variable Variable( SIZE )
	{
		Value 1.28e-8;
		Fixed 1;
	}

	@# 物理・化学定数

	Variable Variable( N_A )
	{
		Name "Avogadro number (mol^-1)";
		Value 6.0221367e+23;
	}

	Variable Variable( F )
	{
		Name "Faraday's constant (C/mol)";
		Value 96.4867e+3;
	}

	Variable Variable( R )
	{
		Name "Gas constant (C mV/K/mol)";
		Value 8.3143e+3;
	}

	Variable Variable( zNa )
	{
		Value 1.0;
	}

	Variable Variable( zK )
	{
		Value 1.0;
	}

	Variable Variable( zCa )
	{
		Value 2.0;
	}

	Variable Variable( zCl )
	{
		Value -1.0;
	}

	@# 実験環境

	Variable Variable( T )
	{
		Name "absolute temperature (K)";
		Value 310.0;
	}

	@# 時刻
	Variable Variable( t )
	{
		Value 0.0;
	}

	Process ZeroOrderFluxProcess( elapsedTime ) 
	{
		Priority	15;

		VariableReferenceList
			[ t :.:t  1 ];

		k "1.0";
		
	}

	@# 等張性収縮時に細胞に負荷されている外力
	Variable Variable( forceExt )
	{
		Name "External force";
		Value 0.0;
	}

	@# 細胞外液

	Variable Variable( Na )
	{
		Name "Extracellular Na+";
		MolarConc 141.0e-3;
		Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Extracellular K+";
		MolarConc 5.4e-3;
		Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Extracellular Ca2+";
		MolarConc 1.8e-3;
		Fixed 1;
	}

	Variable Variable( Cl )
	{
		Name "Extracellular Cl-";
		MolarConc 140.0e-3;
		Fixed 1;
	}

	Variable Variable( LA )
	{
		Name "Extracellular large anionic compound";
		MolarConc 10.0e-3;
		Fixed 1;
	}

	Variable Variable( FCCP )
	{
		Name "Extracellular FCCP";
		MolarConc 0.0;
		Fixed 1;
	}

	Variable Variable( CN )
	{
		Name "Extracellular CN";
		MolarConc 0.0;
		Fixed 1;
	}

	Variable Variable( Oxygen )
	{
		Name "Extracellular Oxygen";
		MolarConc 0.24e-3;
		Fixed 1;
	}

	Variable Variable( isoproterenol )
	{
		Name "Extracellular isoproterenol";
		MolarConc 0.0;
		Fixed 1;
	}

#	Variable Variable( Tonicity )
#	{
#		Name "Extracellular fluid tonicity";
#		Value 1.0;
#	}
#
#	Process PythonProcess( Tonicity ) 
#	{
#		StepperID    PSV;
#		Priority     10;
#
#		Name "Extracellular fluid tonicity";
#
#		VariableReferenceList
#			[ t     :.:Tonicity 0 ]
#			[ Naext :.:Na       0 ]
#			[ Kext  :.:K        0 ]
#			[ Caext :.:Ca       0 ]
#			[ Clext :.:Cl       0 ]
#			[ LAext :.:LA       0 ];
#
#		InitializeMethod '''
#Naext.Value = t.Value * Naext.Value
#Kext.Value  = t.Value * Kext.Value
#Caext.Value = t.Value * Caext.Value
#Clext.Value = t.Value * Clext.Value
#LAext.Value = t.Value * LAext.Value
#'''; 
#	}



# 	Process PythonProcess( pipette )
# 	{
# 		Name "Pipette for CurrentClamp";
# 
# 		interval   400.0;
# 		onset      50.0;
# 		offset     52.0;
# 		amplitude  -8000.0;
# 
# 		InitializeMethod "";
# 		FireMethod "";
# 	}

	Variable Variable( TotalIon )
	{
		Name "Extracellular total ion";
		MolarConc 298.2e-3;
	}

	Process EnvironmentAssignmentProcess( TotalIon ) 
	{
		Name "Extracellular total ion";

		StepperID	PSV;
		Priority	5;

		VariableReferenceList
			[ TotalIon :.:TotalIon 1 ]
			[ Na       :.:Na       0 ]
			[ K        :.:K        0 ]
			[ Cl       :.:Cl       0 ]
			[ Ca       :.:Ca       0 ]
			[ LA       :.:LA       0 ];
	}


#	Process ExpressionFluxProcess( Dummy ) 
#	{
#		StepperID	ODE;
#
#		Name "Dummy Process for ODE";
#
#		VariableReferenceList [ _ :.:Na 1 ];
#
#		Expression "0.0";
#	}

}


@# 心筋細胞

System System( /CELL )
{
	StepperID	ODE;
}

@# 細胞質

System System( /CELL/CYTOPLASM )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value @Cytoplasm_SIZE;  # units="L"
	}

	Variable Variable( active_volume )
	{
		Value 80.0;	# percentage(dimensionless)
	}


	@# 遺伝子発現

	@# INa
	Variable Variable( Nav1_5 )
	{
		Name   "Relative expression of Nav1.5 for INa";
		Value  @INa_GX;
	}
	
	@# ICaL
	Variable Variable( Cav1_2 )
	{
		Name   "Relative expression of Cav1.2 for ICaL";
		Value  @ICaL_GX;
	}

	@# ICaT
	Variable Variable( Cav3_1 )
	{
		Name   "Relative expression of Cav3.1 for ICaT";
		Value  @ICaT_GX;
	}

	@# Ist
	Variable Variable( ST_gene )
	{
		Name   "Relative expression for Ist";
		Value  @Ist_GX;
	}

	@# Iha
	Variable Variable( HCN )
	{
		Name	"Relative expression of HCN for Iha";
		Value	@Iha_GX;
	}

	@# IK1
	Variable Variable( Kir2_1 )
	{
		Name   "Relative expression of Kir2.1 for IK1";
		Value  @IK1_GX;
	}

	@# IKr
	Variable Variable( erg1 )
	{
		Name   "Relative expression of erg1 for IKr";
		Value  @IKr_GX;
	}

	@# IKs
	Variable Variable( KCNQ1 )
	{
		Name   "Relative expression of KCNQ1 for IKs";
		Value  @IKs_GX;
	}

	@# Ito
	Variable Variable( Kv1_4 )
	{
		Name   "Relative expression of Kv1.4 for Ito";
		Value  @Ito_GX;
	}

	@# IKACh
	Variable Variable( KACh_gene )
	{
		Name   "Relative expression for IKACh";
		Value  @IKACh_GX;
	}

	@# INaK
	Variable Variable( NaK_ATPase )
	{
		Name	"Relative expression of Na/K ATPase for Na/K pump";
		Value	@INaK_GX;
	}

	@# INaCa
	Variable Variable( NCX1 )
	{
		Name	"Relative expression of NCX1 for Na/Ca exchanger";
		Value	@INaCa_GX;
	}

	@# IPMCA
	Variable Variable( PMCA_gene )
	{
		Name   "Relative expression of IPMCA";
		Value  @IPMCA_GX;
	}

	@# ILCCa
	Variable Variable( LCCa_gene )
	{
		Name   "Relative expression for ILCCa";
		Value  @ILCCa_GX;
	}

	@# IKATP
	Variable Variable( Kir6_2 )
	{
		Name   "Relative expression of Kir6.2 for IKATP";
		Value  @IKATP_GX;
	}

	@# IKpl
	Variable Variable( Kpl_gene )
	{
		Name   "Relative expression for IKpl";
		Value  @IKpl_GX;
	}

	@# IbNSC
	Variable Variable( bNSC_gene )
	{
		Name   "Relative expression for IbNSC";
		Value  @IbNSC_GX;
	}

	@# ICab
	Variable Variable( Cab_gene )
	{
		Name   "Relative expression for ICab";
		Value  @ICab_GX;
	}

	@# IClb
	Variable Variable( Clb_gene )
	{
		Name   "Relative expression for IClb";
		Value  @IClb_GX;
	}

	@# NKCC
	Variable Variable( NKCC_gene )
	{
		Name   "Relative expression for NKCC";
		Value  @NKCC_GX;
	}

	@# IVRCC

	@# ICFTR

	@# IRyR
	Variable Variable( RyR1 )
	{
		Name	"Relative expression of RyR1 for IRyR";
		Value	@IRyR_GX;
	}

	@# leak

	@# ISRCA
	Variable Variable( SERCA )
	{
		Name	"Relative expression of SERCA for ISRCA";
		Value	@ISRCA_GX;
	}




	@# ion

	Variable Variable( Na )
	{
		Name "Intracellular Na+";
		MolarConc 4.525403436246333e-3;
		# Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Intracellular K+";
		MolarConc 141.30901963578947e-3;
		# Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Intracellular Ca2+";
		MolarConc 6.974558029735137e-8;
		# Fixed 1;
	}

	Variable Variable( CaTotal )
	{
		Name "Intracellular total Ca2+";
		MolarConc 0.0014934603565921552e-3;
		# Fixed 1;
	}

	Variable Variable( Cl )
	{
		Name "Intracellular Cl-";
		MolarConc 30.03218912074857e-3;
		# Fixed 1;
	}

	Variable Variable( LA )
	{
		Name "Intracellular large anionic compound";
		MolarConc 122.33527932034539e-3;
	}

	@# <TotalVolume name="Vt">

	Variable Variable( Vt )
	{
		Name "Vt";
		Value @( Vt0 );  # (L)
	}

	Process CytoplasmAssignmentProcess( Cytoplasm ) 
	{
		Name "Total cell volume";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ Vi           :.:SIZE                   0 ]
			[ Vt           :.:Vt                     1 ]
			[ Volume_ratio :.:Volume_ratio           1 ]
			[ Proton       :.:Proton                 0 ]
			[ pH           :.:pH                     1 ]
			[ Mg           :.:Mg                     0 ]
			[ ATPtotal     :.:ATPtotal               0 ]
			[ ATPfree      :.:ATPfree                1 ]
			[ ATPmg        :.:ATPmg                  1 ]
			[ ADPtotal     :.:ADPtotal               0 ]
			[ ADPfree      :.:ADPfree                1 ]
			[ ADPmg        :.:ADPmg                  1 ]
			[ cAMP         :.:cAMPtot                0 ]
			[ AMP          :.:AMP                    1 ]
			[ PCr          :.:PCr                    0 ]
			[ Creatine     :.:Creatine               1 ]
			[ Pi           :.:Pi                     1 ]
			[ PiTotal      :.:PiTotal                0 ]
			[ ATPtotal_mt  :./MITOCHONDRIA:ATPtotal  0 ]
			[ ADPtotal_mt  :./MITOCHONDRIA:ADPtotal  0 ]
			[ Pi_mt        :./MITOCHONDRIA:Pi        0 ]
			[ totalIonin   :.:TotalIon               1 ]
			[ Na           :.:Na                     0 ]
			[ K            :.:K                      0 ]
			[ Cl           :.:Cl                     0 ]
			[ CaTotal      :.:CaTotal                0 ]
			[ Ca           :.:Ca                     1 ]
			[ LA           :.:LA                     0 ]
			[ totalIonex   :/:TotalIon               0 ]
			[ Cm           :../MEMBRANE:Cm           0 ]
			[ WaterFlux    :.:WaterFlux              1 ]
			[ vAK          :.:vAK                    1 ]
			[ vCK          :.:vCK                    1 ]
			[ calmodulin   :.:calmodulin             1 ]
			[ Tt           :.:Tt                     0 ]
			[ T            :.:T                      1 ]
			[ TCa          :.:TCa                    0 ]
			[ TCaCB        :.:TCaCB                  0 ]
			[ TCB          :.:TCB                    0 ];


		# Vn              3200.0;          # the osmotically inactive cell volume (um^3)
		Vn_L              1005.3e-15;      # (L)
		Vt0i              @( 1.0 / Vt0 );
		ActivityFactor    1.0;
		kD_ATP            0.024e-3;        # units="M"
		kD_ADP            0.347e-3;        # units="M"
		TotalAdenosine    7.0e-3;          # (M)
		TotalCreatine     25.0e-3;         # (M)
		f                 1.3743e-17;      # hydraulic conductivity [L/pF/M/ms]
		kfAK              783.0;           #  (1/M/ms)
		kbAK              683.0;           #  (1/M/ms)
		kfCK              16.05e+6;        #  (1/M^2/ms)
		kbCK              9.67e-3;         #  (1/mM/ms)
		Km_calmodulin     2.38e-06;        # units="M"
		calmodulin_total  5e-05;           # units="M"
	}



	@# <VolumeRatio name="Volume ratio">

	Variable Variable( Volume_ratio )
	{
		Name "Volume ratio";
		Value 1.0000868769890798;
	}

	@# <Acidity name="pH">

	Variable Variable( Proton )
	{
		Name "Proton";
		MolarConc 1.0e-7;
	}

	Variable Variable( pH )
	{
		Name "pH";
		Value 7.0;
	}


	Variable Variable( Mg )
	{
		Name "Intracellular Mg2+";
		MolarConc 6.0e-4;
	}

	Variable Variable( ATPtotal )
	{
		Name "Total ATP";
		MolarConc 6.957362600457599e-3;
		# Fixed 1;
	}


	@# <freeconcentration name="ATPfree">

	Variable Variable( ATPfree )
	{
		Name "Free ATP";
		MolarConc 2.675908712522642e-4;
	}


	@# <massconservation name="ATPmg">
	@# ゼロ補正に関しては未実装

	Variable Variable( ATPmg )
	{
		Name "ATP-Mg";
		MolarConc 6.689771781306605e-3;
	}


	@# <freeconcentration name="ADPfree">

	Variable Variable( ADPtotal )
	{
		Name "Total ADP";
		MolarConc 4.1887567578669e-5;
		# Fixed 1;
	}

	Variable Variable( ADPfree )
	{
		Name "Free ADP";
		MolarConc 1.5348434984701155e-5;
	}


	@# <freeconcentration name="ADPfree">

	Variable Variable( ADPmg )
	{
		Name "ADP-Mg";
		MolarConc 2.653908066518932e-5;
	}


	@# <AMPconcentration name="AMP">

	Variable Variable( AMP )
	{
		Name "AMP";
		MolarConc 6.980325566097179e-8;
	}


	@# <massconservation name="Creatine">

	Variable Variable( PCr )
	{
		Name "Phospho creatine";
		MolarConc 1.235991139533046e-2;
	}

	Variable Variable( Creatine )
	{
		Name "Creatine";
		MolarConc 1.2640089731056461e-2;
	}


	@# <massconservationPI name="Pi" className="org.simBio.bio.matsuoka_et_al_2004.function.ConcentrationPi">

	Variable Variable( Pi )
	{
		Name "Inorganic phosphate";
		MolarConc 2.3924637162927436e-3;
		# Fixed 1;
	}

	Variable Variable( PiTotal )
	{
		MolarConc 46.0e-3;
		# Fixed 1;
	}

#	Process ExpressionAssignmentProcess( Pi ) 
#	{
#		Name "Mass conservation of Pi";
#
#		StepperID	PSV;
#		Priority	3;
#
#		VariableReferenceList
#			[ Pi       :.:Pi                    1 ]
#			[ PCr      :.:PCr                   0 ]
#			[ ATPtcell :.:ATPtotal              0 ]
#			[ ADPtcell :.:ADPtotal              0 ]
#			[ AMP      :.:AMP                   0 ]
#			#[ Rcm      :./MITOCHONDRIA:Rcm      0 ]
#			[ ATPtmit  :./MITOCHONDRIA:ATPtotal 0 ]
#			[ ADPtmit  :./MITOCHONDRIA:ADPtotal 0 ]
#			[ Pimit    :./MITOCHONDRIA:Pi       0 ];
#
#		PiTotal 46.0e-3;  # (M)
#
#		Expression "PiTotal * self.getSuperSystem().SizeN_A - PCr.Value - 3.0 * ATPtcell.Value - 2.0 * ADPtcell.Value - AMP.Value - 3.0 * ATPtmit.Value - 2.0 * ADPtmit.Value - Pimit.Value";
#	}
	@# 体積の変動を表現しているのに、総イオン濃度が変化しないと仮定しているのは厳密には不適切。無視して差し支えない程度かもしれないが。


@# simBioと未照合 要確認！
	Variable Variable( TotalIon )
	{
		Name "Intracellular total ion";
		MolarConc 298.2019607001986e-3;
	}


	@# <WaterFlux name="WaterFlux" className="org.simBio.bio.terashima_et_al_2006.complex.WaterFlux">

	Variable Variable( WaterFlux )
	{
		Name "Water Flux";
		Value 8.622688905371488e-22;
	}

	Process ZeroVariableAsFluxProcess( WaterFlux ) 
	{
		Name "Intracellular total ion";

		Priority	4;

		VariableReferenceList
			[ WaterFlux :.:WaterFlux      0 ]
			[ volumeint  :.:SIZE          1 ]
			[ volumeext  :/:SIZE         -1 ];
	}



	Variable Variable( halfSarcomereLength )
	{
		Name "Half sarcomere length (um)";
		Value 0.9692930040410533;
	}


	@# <AdenylateKinase name="vAK" className="org.simBio.bio.matsuoka_et_al_2004.molecule.enzyme.AK" >

	Variable Variable( vAK )
	{
		Name "vAK";
		Value @( vAK * 1.0e-3 * Cytoplasm_SIZE * N_A );
		@# <AdenylateKinase name="vAK" initial_value="2.974768800484851E-9" units="mM/ms" className="org.simBio.bio.matsuoka_et_al_2004.molecule.enzyme.AK" >
	}

	Process ZeroVariableAsFluxProcess( vAK ) 
	{
		Name "Adenylate Kinase";

		Priority	15;

		VariableReferenceList
			[ vAK    :.:vAK     0 ]
			[ ADPtotal :.:ADPtotal -2 ]
			#[ ADPfree  :.:ADPfree   0 ]
			#[ ADPmg    :.:ADPmg     0 ]
			[ ATPtotal :.:ATPtotal  1 ];
			#[ ATPmg    :.:ATPmg     0 ]
			#[ AMP      :.:AMP       0 ];
	}


	@# <CreatineKinase name="vCK" className="org.simBio.bio.matsuoka_et_al_2004.molecule.enzyme.CK">

	Variable Variable( vCK )
	{
		Name "Creatine Kinase";
		Value @( vCK * 1.0e-3 * Cytoplasm_SIZE * N_A );
		@# <CreatineKinase name="vCK" initial_value="-1.944599969721096E-5" units="mM/ms" className="org.simBio.bio.matsuoka_et_al_2004.molecule.enzyme.CK" >
	}

	Process ZeroVariableAsFluxProcess( vCK ) 
	{
		Name "Creatine Kinase";

		Priority	15;

		VariableReferenceList
			[ vCK       :.:vCK  0 ]
			#[ Cr       :.:Creatine  0 ]
			[ PCr      :.:PCr      -1 ]
			[ ADPtotal :.:ADPtotal -1 ]
			[ ATPtotal :.:ATPtotal  1 ];
			#[ Proton   :.:Proton    0 ];
	}


	@# <analyticCaBuffer name="calmodulin" className="org.simBio.bio.matsuoka_et_al_2003.molecule.buffer.Ca.Analytic_RK">

	Variable Variable( calmodulin )
	{
		Name "Calmodulin";
		MolarConc 1.4235270155867653e-6;
	}

	@#analyticCaBuffer( 'calmodulin', ':.:CaTotal', ':.:Ca', ':.:calmodulin', 0.00238, 0.05 )

	
	Variable Variable( crossBridgeLength )
	{
		Name "Cross Bridge Length";
		Value 0.004999522658667099;
	}


	@# <Troponin name="troponin" className="org.simBio.bio.kuzumoto_et_al_2007.contraction.Troponinmit">

	Variable Variable( Tt )
	{
		MolarConc 0.07e-3;
		# Fixed 1;
	}

	Variable Variable( T )
	{
		MolarConc 0.0067552349390963004e-3;
	}

	Variable Variable( TCa )
	{
		Name "fraction of contraction unit with troponin C bound to Ca2+";
		MolarConc 2.3554044978188124e-7;
	}

	Variable Variable( TCaCB )
	{
		Name "fraction of contraction unit with troponin C bound to Ca2+ and attached cross bridge (force generator)";
		MolarConc 7.167284984657933e-9;
	}

	Variable Variable( TCB )
	{
		Name "fraction of contraction unit with attached cross bridge and with free troponin C (force generator)";
		MolarConc 2.075825271345359e-9;
	}


	Variable Variable( cAMPtot )
	{
		Name "Total cyclic AMP";
		MolarConc 6.800285357609005E-7;
	}

	Variable Variable( cAMP )
	{
		Name "Cyclic AMP";
		MolarConc 2.939586447984879E-7;
	}

	Variable Variable( PKA )
	{
		Name "protein kinase A";
		MolarConc 1.3643052199162304E-7;
	}

	@# ICalでのみ使用化→property
#	Variable Variable( PKA0 )
#	{
#		Name "protein kinase A, initial value?";
#		MolarConc 1.3644055081894695e-7;
#	}

	Variable Variable( AC )
	{
		Name "adenylate cyclase";
		MolarConc 4.969917926882254E-8;
	}

	Variable Variable( Gs_alpha_GTP_AC )
	{
		Name "adenylate cyclase-bound Gs alpha GTP";
		MolarConc 8.207311774643955E-13;
	}

	Variable Variable( Gs_alpha_GTPtot )
	{
		Name "total GTP-bound alpha subunit of Gs";
		MolarConc 5.202723912788444E-9;
	}

# 	<BetaAR_Gs name="BetaAR" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.BetaAR_Gs">
# 		<parameter name="LRG" initial_value="0.0" units="mM" />
# 		<parameter name="RG" initial_value="3.2516235164698E-7" units="mM" />
# 		<parameter name="LR" initial_value="0.0" units="mM" />
# 		<parameter name="L" initial_value="0.0" units="mM" />
# 		<parameter name="beta1_AR" initial_value="3.7991044019474952E-6" units="mM" />
# 		<parameter name="Gstot" initial_value="0.00383" units="mM" />
# 		<parameter name="Gs" initial_value="0.0028244439923392865" units="mM" />
# 		<parameter name="KL" initial_value="0.0010" units="mM" />
# 		<parameter name="KR" initial_value="6.2E-5" units="mM" />
# 		<parameter name="KC" initial_value="0.033" units="mM" />
# 		<parameter name="k_betaARK_plus" initial_value="1.1E-6" units="1/ms" />
# 		<parameter name="k_betaARK_minus" initial_value="2.2E-6" units="1/ms" />
# 		<parameter name="k_PKA_plus" initial_value="0.0036" units="1/(ms*mM)" />
# 		<parameter name="k_PKA_minus" initial_value="2.232E-7" units="1/ms" />
# 		<parameter name="beta1_ARtot" initial_value="1.32E-5" units="mM" />
# 		<parameter name="k_gact" initial_value="0.016" units="1/ms" />
# 		<parameter name="k_hyd" initial_value="0.0010" units="1/ms" />
# 		<parameter name="k_reassoc" initial_value="1200.0" units="1/(ms*mM)" />
# 		<variable name="beta1_ARact" initial_value="4.124266728915964E-6" units="mM" />
# 		<variable name="beta1_AR_S464" initial_value="0.0" units="mM" />
# 		<variable name="beta1_AR_S301" initial_value="9.075733271084037E-6" units="mM" />
# 		<variable name="Gs_beta_gamma" initial_value="0.001005230845247631" units="mM" />
# 		<variable name="Gs_alpha_GDP" initial_value="4.312937712225446E-9" units="mM" />
# 		<link name="Iso" initial_value="../../../isoproterenol" units="mM" />
# 		<link name="PKA" initial_value="../../PKA" units="mM" />
# 		<link name="Gs_alpha_GTPtot" initial_value="../Gs_alpha_GTPtot" units="mM" />
# 	</BetaAR_Gs>

	Variable Variable( LRG )
	{
		Name "beta1-adrenergic receptor bound with ligand and Gs";
		MolarConc 0.0;
	}

	Variable Variable( RG )
	{
		Name "beta1-adrenergic receptor bound with Gs";
		MolarConc 3.2517024454936596E-10;
	}

	Variable Variable( LR )
	{
		Name "beta1-adrenergic receptor bound with ligand";
		MolarConc 0.0;
	}

	Variable Variable( L )
	{
		Name "isoproterenol (ligand)";
		MolarConc 0.0;
	}

	Variable Variable( beta1_AR )
	{
		Name "beta1-adrenergic receptor";
		MolarConc 3.799196800697939E-9;
	}

	Variable Variable( Gstot )
	{
		Name "total Gs";
		MolarConc 3.83e-6;
	}

	Variable Variable( Gs )
	{
		Name "aipha, beta and gamma subunit of Gs";
		MolarConc 2.8244438582801998e-6;
	}

	Variable Variable( beta1_ARact )
	{
		Name "? activated beta1-adrenergic receptor";
		MolarConc 4.124366842309315E-9;
	}

	Variable Variable( beta1_AR_S464 )
	{
		Name "? beta1-adrenergic receptor S464";
		MolarConc 0.0;
	}

	Variable Variable( beta1_AR_S301 )
	{
		Name "? beta1-adrenergic receptor S301";
		MolarConc 9.075633157690742E-9;
	}

	Variable Variable( Gs_beta_gamma )
	{
		Name "beta and gamma subunit of Gs";
		MolarConc 1.0052309715914828-6;
	}

	Variable Variable( Gs_alpha_GDP )
	{
		Name "GDP-bound alpha subunit of Gs";
		MolarConc 4.31304186120818E-12;
	}

	Variable Variable( PDE )
	{
		Name "phosphodiesterase";
		MolarConc 3.9e-8;
	}

# 	<CAMP name="CAMP" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.CAMP">
# 		<parameter name="ACtot" initial_value="4.97E-5" units="mM" />
# 		<parameter name="K_Gs_alpha" initial_value="0.315" units="mM" />
# 		<parameter name="Gs_alpha_GTP" initial_value="5.201776915103961E-6" units="mM" />
# 		<link name="Gs_alpha_GTP_AC" initial_value="../Gs_alpha_GTP_AC" units="mM" />
# 		<link name="AC" initial_value="../AC" units="mM" />
# 		<link name="Gs_alpha_GTPtot" initial_value="../Gs_alpha_GTPtot" units="mM" />
# 		<parameter name="PDEtot" initial_value="3.9E-5" units="mM" />
# 		<link name="PDE" initial_value="../PDE" units="mM" />
# 		<link name="cAMPtot" initial_value="../../cAMPtot" units="mM" />
# 		<link name="cAMP" initial_value="../../cAMP" units="mM" />
# 		<link name="ATP" initial_value="../../ATPtotal" units="mM" />
# 		<parameter name="k_AC_basal" initial_value="0.0035" units="1/ms" />
# 		<parameter name="k_PDE" initial_value="0.031" units="1/ms" />
# 		<parameter name="k_AC_Gs_alpha" initial_value="91.0" units="1/ms" />
# 		<parameter name="Km_basal" initial_value="1.03" units="mM" />
# 		<parameter name="Km_PDE" initial_value="0.0013" units="mM" />
# 		<parameter name="Km_Gs_alpha_GTP" initial_value="0.315" units="mM" />
# 	</CAMP>

	Variable Variable( ACtot )
	{
		Name "total adenylate cyclase";
		MolarConc 4.97e-8;
	}

	Variable Variable( Gs_alpha_GTP )
	{
		Name "alpha GTP-bound alpha subunit of Gs";
		MolarConc 5.20190318161098E-9;
	}

	Variable Variable( PDEtot )
	{
		Name "total phosphodiesterase";
		MolarConc 3.9e-8;
	}

# 	<PKA_NR name="PKA" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.PKA">
# 		<parameter name="KA" initial_value="0.0080" units="mM" />
# 		<parameter name="KB" initial_value="0.0080" units="mM" />
# 		<parameter name="KD" initial_value="0.0090" units="mM" />
# 		<parameter name="PKItot" initial_value="1.8E-4" units="mM" />
# 		<parameter name="KPKI" initial_value="0.0010" units="mM" />
# 		<link name="PKA" initial_value="../../PKA" units="mM" />
# 		<link name="cAMP" initial_value="../../cAMP" units="mM" />
# 		<parameter name="ARCI" initial_value="6.520090177298568E-5" units="mM" />
# 		<parameter name="A2RCI" initial_value="2.3958850773161374E-6" units="mM" />
# 		<parameter name="A2RI" initial_value="1.5804532257104254E-4" units="mM" />
# 		<parameter name="RCI" initial_value="0.0017743578906433443" units="mM" />
# 		<parameter name="PKACI_PKI" initial_value="2.1609992850022038E-5" units="mM" />
# 		<parameter name="PKI" initial_value="1.5623401026755668E-4" units="mM" />
# 		<link name="cAMPtot" initial_value="../../cAMPtot" units="mM" />
# 		<parameter name="PKAtot" initial_value="0.0010" units="mM" />
# 	</PKA_NR>

	Variable Variable( PKItot )
	{
		Name "total protein kinase inhibitor";
		MolarConc 1.8e-7;
	}

	Variable Variable( ARCI )
	{
		Name "complex of cAMP, PKA and regulatory subunit";
		MolarConc 6.519876602659327E-8;
	}

	Variable Variable( A2RCI )
	{
		Name "complex of 2 cAMP, PKA and regulatory subunit";
		MolarConc 2.3957176129638817E-9;
	}

	Variable Variable( A2RI )
	{
		Name "complex of 2 cAMP and regulatory subunit";
		MolarConc 1.58039844764347E-7;
	}

	Variable Variable( RCI )
	{
		Name "regulatory subunit-bound PKA";
		MolarConc 1.7743656716416771-6;
	}

	Variable Variable( PKACI_PKI )
	{
		Name "PKA inhibited by PKI";
		MolarConc 2.1609322772723953E-8;
	}

	Variable Variable( PKI )
	{
		Name "protein kinase inhibitor";
		MolarConc 1.5623401026755668e-7;
	}

	Variable Variable( PKAtot )
	{
		Name "total protein kinase A (dimer)";
		MolarConc 1.0e-6;
	}

	Variable Variable( Spermine )
	{
		Name "Spermine";
		MolarConc 5.0e-6;
	}

	Variable Variable( ACh )
	{
		Name "Acetylcholine";
		MolarConc 0.0;
	}
}



@# 細胞膜
System System( /CELL/MEMBRANE )
{
	StepperID	ODE;

	@# 10^-15 * Jx * zx * F / N_A / Cm (V/sec)
	Variable Variable( Vm )
	{
		Name "membrane potential (mV)";
		Value -42.19217154323346;
		# Fixed 1;
	}

	@{'''
	Ki.Value        1.29317049242e+12
	Nai.Value       58676396930.7
	CaTotali.Value  14788475.5229
	Cli.Value       460248058512.0
	LAi.Value       945041868058.0

	'''}


	Variable Variable( Cm )
	{
		Name "membrane capacitance (pF)";
		Value @Cm0;
	}

	Variable Variable( EK )
	{
		Name "equilibrium potential for K+ (mV)";
		Value -87.20537963562452;
	}

	@{'''
	<reversalPotential name="K reversal potential" initial_value="-86.93058752466963" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2003.function.ReversalPotential">
		<link name="in" initial_value="../K" units="mM" />
		<link name="out" initial_value="../../K" units="mM" />
		<link name="R" initial_value="/Gas constant" />
		<link name="T" initial_value="/absolute temperature" units="K" />
		<link name="F" initial_value="/Faraday constant" units="Coulomb/mM" />
		<parameter name="valence" initial_value="1.0" units="dimension_less" />
	</reversalPotential>
	'''}
	Process MembraneAssignmentProcess( Membrane ) 
	{
		Name "K reversal potential";

		StepperID	PSV;
		Priority	29;

		VariableReferenceList
			[ Vm        :.:Vm             0 ]
			[ T         :/:T              0 ]
			[ R         :/:R              0 ]
			[ F         :/:F              0 ]
			[ zK        :/:zK             0 ]
			[ zNa       :/:zNa            0 ]
			[ zCa       :/:zCa            0 ]
			[ zCl       :/:zCl            0 ]
			[ EK        :.:EK             1 ]
			[ Ke        :/:K              0 ]
			[ Ki        :../CYTOPLASM:K   0 ]
			[ CFNa      :.:CFNa           1 ]
			[ Nae       :/:Na             0 ]
			[ Nai       :../CYTOPLASM:Na  0 ]
			[ CFK       :.:CFK            1 ]
			[ CFCa      :.:CFCa           1 ]
			[ Cae       :/:Ca             0 ]
			[ Cai       :../CYTOPLASM:Ca  0 ]
			[ CFCl      :.:CFCl           1 ]
			[ Cle       :/:Cl             0 ]
			[ Cli       :../CYTOPLASM:Cl  0 ]
			[ vrtf      :.:_vrtf          1 ]
			[ current   :.:current        1 ]
			[ currentNa :.:currentNa      1 ]
			[ currentK  :.:currentK       1 ]
			[ currentCa :.:currentCa      1 ]
			[ currentCl :.:currentCl      1 ];
	}

	Variable Variable( CFNa )
	{
		Name "dependency of Na+ flux on Vm (constant field equation)";
		Value -278.70632881279937;
	}


	Variable Variable( CFK )
	{
		Name "dependency of K+ flux on Vm (constant field equation)";
		Value 47.17553040670116;
	}


	Variable Variable( CFCa )
	{
		Name "dependency of Ca2+ flux on Vm (constant field equation)";
		Value -5.9397119225578345;
	}


	Variable Variable( CFCl )
	{
		Name "dependency of Cl- flux on Vm (constant field equation)";
		Value 2.3740455256410056;
	}


	@# ICaLで計算
	Variable Variable( CaDiadic )
	{
		Name  "CICRfactor (mM)";
		Value -3.829497696421197E-4;
		Fixed 0;
	}

	Variable Variable( _vrtf )
	{
		Name "Vm / ( R * T / F )";
		Value -3.24670533581;
	}


	Variable Variable( current )
	{
		Name "total current of ion channels and ion exchangers (pA)";
		#Value -6.478364362434306;
		Value 0.0;
	}

	Variable Variable( currentNa )
	{
		Name "sum of current components carried by Na+ (pA)";
		#Value 8.527754933250288;
		Value 0.0;
	}

	Variable Variable( currentK )
	{
		Name "sum of current components carried by K+ (pA)";
		#Value -12.921790997431073;
		Value 0.0;
	}

	Variable Variable( currentCa )
	{
		Name "sum of current components carried by Ca2+ (pA)";
		#Value -2.0834682851511794;
		Value 0.0;
	}

	Variable Variable( currentCl )
	{
		Name "sum of current components carried by Cl- (pA)";
		#Value -8.600131023456715E-4;
		Value 0.0;
	}

}

System System( /CELL/CYTOPLASM/SRREL )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value 3.0177162616707722e-15;  #  units="L"
	}

	Process SRrelAssignmentProcess( volume ) 
	{
		Name "SRrel volume";

		StepperID	PSV;
		Priority	4;

		VariableReferenceList
			[ volume        :.:SIZE                1 ]
			[ total         :/CELL/CYTOPLASM:SIZE  0 ]
			[ CaTotal       :.:CaTotal             1 ]
			[ Ca            :.:Ca                  1 ]
			[ calsequestrin :.:calsequestrin       1 ];

		ratio                 6.0E-4;
		Km_calsequestrin    0.0008;	# units="M"
		calsequestrin_total   0.01;	# units="M"
	}

	Variable Variable( Ca )
	{
		Name "SRrel Ca2+";
		MolarConc 1.365953702510355e-3;
		# Fixed 1;
	}

	Variable Variable( CaTotal )
	{
		Name "SRrel total Ca2+";
		MolarConc 7.672344593892949e-3;
	}

	Variable Variable( calsequestrin )
	{
		Name "Calsequestrin";
		MolarConc 6.306476915583216e-3;
	}

}


System System( /CELL/CYTOPLASM/SRUP )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value 7.5442906541769315e-15;
	}

	Process SRupAssignmentProcess( volume ) 
	{
		Name "SRup volume";

		StepperID	PSV;
		Priority	4;

		VariableReferenceList
			[ volume :.:SIZE   1 ]
			[ total  :..:SIZE  0 ];

		ratio 0.0015;
	}

	Variable Variable( Ca )
	{
		Name "SRup Ca2+";
		MolarConc 1.3688642754961744e-3;
		# Fixed 1;
	}

	Variable Variable( PLBphos )
	{
		Name "phosphorylated phospholamban";
		MolarConc 0.07919690848147495e-3;
	}

	@include( 'PLB.em' )

}

@{'''
<compartment name="separator" initial_value="0.0">
	<diffusion name="transfer" initial_value="42.66230178693931">
		<link name="Cm" initial_value="../../membrane capacitance" />
		<link name="Cai" initial_value="../../SRrel/Ca" units="mM" />
		<link name="Cao" initial_value="../../SRup/Ca" units="mM" />
		<link name="current" initial_value="/dummy" />
		<link name="currentNa" initial_value="/dummy" />
		<link name="currentK" initial_value="/dummy" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="/dummy" />
		<parameter name="permeabilityCa" initial_value="5.0" units="pA/mM" />
	</diffusion>
	<current name="currentCa" initial_value="42.66230178693931" units="pA">
		<link name="in" initial_value="../../SRup/Ca" units="mM" />
		<link name="out" initial_value="../../SRrel/CaTotal" units="mM" />
		<link name="Vi" initial_value="../../SRup/volume" />
		<link name="Vo" initial_value="../../SRrel/volume" />
		<link name="F" initial_value="/Faraday constant" />
		<parameter name="valence" initial_value="2.0" units="dimension_less" />
	</current>
</compartment>

'''}
System System( /CELL/CYTOPLASM/SEPARATOR )
{
	StepperID	ODE;

#	Variable Variable( SIZE )
#	{
#		Value 4.266230178693931e-14;
#	}

	Variable Variable( transfer )
	{
		Value 0.4689225564841948;
	}

	Process SRDiffusionAssignmentProcess( transfer ) 
	{
		Name "transfer Ca2+ current";

		StepperID	PSV;
		Priority	11;

		VariableReferenceList
			[ I   :.:transfer         1 ]
			[ Cai :../SRREL:Ca        0 ]
			[ Cao :../SRUP:Ca         0 ]
			[ Cm  :../../MEMBRANE:Cm  0 ];

		permeabilityCa	5.0e+3;  #  pA/M
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ in  :../SRUP:Ca       -1 ]  # Cao = in
			[ out :../SRREL:CaTotal  1 ]
			[ i   :.:transfer        0 ]
			[ N_A :/:N_A             0 ]
			[ F   :/:F               0 ]
			[ z   :/:zCa             0 ];
	}

#	Process PythonProcess( transfer ) 
#	{
#		Name "transfer Ca2+ current";
#
#		IsContinuous 1;
#		StepperID    ODE;
#		Priority	10;
#
#		VariableReferenceList
#			[ Cai :../SRREL:Ca        0 ]
#			[ Cao :../SRUP:Ca        -1 ]  # Cao = in
#			[ out :../SRREL:CaTotal   1 ]
#			[ Cm  :../../MEMBRANE:Cm  0 ];
#
#		permeabilityCa	5.0;	# pA/mM
#
#		InitializeMethod '''
#from KyotoModel import *
#_pA2flux = 1.0e-15 * N_A / zCa / F
#'''; 
#
#		FireMethod '''
#cCa = permeabilityCa * ( Cao.MolarConc - Cai.MolarConc) * 1000.0 * Cm.Value
#self.setFlux( cCa * _pA2flux )
#self.Activity = cCa
#''';
#	}

}


@# ミトコンドリア｛ /CELL/CYTOPLASM/MITOCHONDRIA ｝
@include( 'Mitochondria.em' )
@#include( 'Mitochondria.EP.em' )

@# 筋収縮
@include( 'IsotonicContraction.em' )

@# 細胞膜上のイオンチャネル
@include( 'INa.em' )     @# Na, K
@include( 'ICaL.em' )    @# Na, K, Ca
@include( 'ICaT.em' )    @#        Ca
@include( 'Ist.em' )     @# Na, K
@include( 'Iha.em' )     @# Na, K
@include( 'IK1.em' )     @#     K
@include( 'IKr.em' )     @#     K
@include( 'IKs.em' )     @# Na, K
@include( 'Ito.em' )     @# Na, K
@include( 'IKACh.em' )   @#     K
@include( 'INaK.em' )    @# Na, K
@include( 'INaCa.em' )   @# Na,    Ca
@include( 'IPMCA.em' )   @#        Ca
@include( 'ILCCa.em' )   @# Na, K
@include( 'IKATP.em' )   @#     K
@include( 'IKpl.em' )    @#     K
@include( 'IbNSC.em' )   @# Na, K
@include( 'ICab.em' )    @#        Ca
@include( 'IClb.em' )    @#            Cl
@include( 'NKCC.em' )    @# Na, K,     Cl
@# include( 'IVRCC.em' )   @#            Cl
@# include( 'ICFTR.em' )   @#            Cl

@# 筋小胞体
@include( 'IRyR.em' )
@include( 'leak.em' )
@include( 'ISRCA.em' )


@# 実験装置 /Pipette
@# include( 'CurrentClamp.em' )

@# 記録装置 /Recorder
System System( /Recorder )
{
	StepperID	PSV;
}

@# 膜電位記録 /Recorder/Vm
@#include( 'VmRecorder.em' )
