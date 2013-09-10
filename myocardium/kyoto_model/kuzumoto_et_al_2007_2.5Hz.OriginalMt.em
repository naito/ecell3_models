@# Kuzumoto et al. 2007

@{SimulationMode = 'V'}
# EMB, LAT, NEO, V, SAN

@include('SetOptions.em')

@{
MitFactor = {
	"V"   : 1.0, #0.23
	"EMB" : 0.1, #0.23/10
	"LAT" : 0.5, #0.23/2
	"NEO" : 0.5, #0.23/2
	"SAN" : 1.0 #0.23
}

SRFactor = {
	"V"   : 1.0,
	"EMB" : 0.04,
	"LAT" : 0.3,
	"NEO" : 0.3,
	"SAN" : 0.03
}

Vi_SIZE = {
#	"V"   : 12800.0e-15,
	"V"   : 15353.339029443347e-15,
#	"EMB" : 12800.0e-15,
	"EMB" : 1697.0e-15,
	"LAT" : 2121.2e-15,
	"NEO" : 2424.2e-15,
	"SAN" : 5029.0e-15
}

active_volume = 0.8
Vt_SIZE = Vi_SIZE[SimulationMode] / active_volume
Vn_SIZE = Vt_SIZE - Vi_SIZE[SimulationMode]

# kuzumoto

Vt_SIZE = 18553.33902944335e-15
Vn_SIZE = 3200.0e-15

SRREL_SIZE_init = Vi_SIZE[SimulationMode] * 0.02 * SRFactor[SimulationMode]
SRUP_SIZE_init  = Vi_SIZE[SimulationMode] * 0.05 * SRFactor[SimulationMode]

MITOCHONDRIA_SIZE_init = Vi_SIZE[SimulationMode] * 0.23 * MitFactor[SimulationMode]

Mit_volumeRatio = 0.23 * MitFactor[SimulationMode]
Mit_Rcm_init = 1.0 / Mit_volumeRatio

Cm = {
	"V"   : 211.2,
	"EMB" : 28.0,
	"LAT" : 35.0,
	"NEO" : 40.0,
	"SAN" : 32.0
}

Cm_V = {
	"V"   : 211.2,
	"EMB" : 211.2,
	"LAT" : 211.2,
	"NEO" : 211.2,
	"SAN" : 32.0
}
}

@{

PKA0   = 1.3644055081894695e-7
amplitudePKAf = 0.0

IsotonicContraction_X = 0.9567533837638065
IsotonicContraction_dXdt = 1.1936490127522834E-5

#INa
Nav1_5 = {
	"V"   : 1.0,
	"EMB" : 0.07,
#	"EMB" : 0.0769,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	
}

#ICaL
Cav1_2 = {
	"V"   : 1.0,
	"EMB" : 0.46,
	"LAT" : 0.78,
	"NEO" : 0.78,
	"SAN" : 1.0	
}

#ICaT
Cav3_1 = {
	"V"   : 1.0,
	"EMB" : 4.5,
	"LAT" : 4.5,
	"NEO" : 1.0,
	"SAN" : 1.0	
}

## Ist
iStGene = {
	"V"   : 0,
	"EMB" : 1.0,
	"LAT" : 0,
	"NEO" : 0,
	"SAN" : 1.0	
}

#Iha
HCN = {
	"V"   : 0,
	"EMB" : 1.0,
	"LAT" : 0,
	"NEO" : 0,
	"SAN" : 1.0	
}

#IK1
Kir2_1 = {
	"V"   : 1.0,
	"EMB" : 0.11,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	
}

#IKr
erg1 = {
	"V"   : 1.0,
	"EMB" : 2.0,
	"LAT" : 2.0,
	"NEO" : 1.5,
	"SAN" : 1.0
}

#IKs
KCNQ1 = {
	"V"   : 1.0,
	"EMB" : 0.01,
	"LAT" : 0.01,
	"NEO" : 2.0,
	"SAN" : 1.0
}

#Ito
Kv1_4 = {
	"V"   : 1.0,
	"EMB" : 0.01,
	"LAT" : 0.27,
	"NEO" : 1.0,
	"SAN" : 1.0
}

#IKACh
Kir3_1 = {
	"V"   : 0,
	"EMB" : 0,
#      "EMB" : 1.0,
	"LAT" : 0,
	"NEO" : 0,
	"SAN" : 1.0
}

#INaK
NaK_ATPase = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0
}

#INaCa
NCX1 = {
	"V"   : 1.0,
	"EMB" : 4.95,
	"LAT" : 1.74,
	"NEO" : 1.0,
	"SAN" : 1.0
}

#ILCCA
LCCa_gene = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0
}

Kir6_2 = {
	"V"   : 1.0,
	"EMB" : 0.32,
	"LAT" : 0.88,
	"NEO" : 1.0,
	"SAN" : 1.0
}

Kpl_gene = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0
}

#IbNSC 
bNSC_gene = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	  
}

#ICab
Cab_gene = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	  
}

#IClb
Clb_gene = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	  
}

#NKCC
NKCC_gene = {
	"V"   : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	  
}

#IRyR
RyR1 = {
	"V"   : 1.0,
	"EMB" : 0.05,
	"LAT" : 0.4,
	"NEO" : 0.4,
	"SAN" : 1.0	  
}

#ISRCa
SERCA = {
	"V"   : 1.0,
	"EMB" : 0.03,
	"LAT" : 0.21,
	"NEO" : 0.21,
	"SAN" : 1.0  
}

#Ileak
leak_act = {
	"V"   : 1.0,
	"EMB" : 0.04,
	"LAT" : 0.3,
	"NEO" : 0.3,
	"SAN" : 1.0  
}

transfer_act = {
	"V"   : 1.0,
	"EMB" : 0.04,
	"LAT" : 0.3,
	"NEO" : 0.3,
	"SAN" : 1.0  
}

diadicFactor = {
	"V"   : -150.0,
	"EMB" : -3.0,
	"LAT" : -60.0,
	"NEO" : -60.0,
	"SAN" : -150.0
}

SRtrans_permeabilityCa = {
	"V"   : 5.0e+3,
	"EMB" : 5.0e+3,
	"LAT" : 5.0e+3,
	"NEO" : 5.0e+3,
	"SAN" : 0.99e+3,
}

CurrentClamp_setting = {        # [ amplitude, onset, offset, interval ]
	"V"   : [ -8000.0, 50.0, 52.0, 400.0 ],
	"EMB" : [     0.0, 50.0, 52.0, 400.0 ],
	"LAT" : [     0.0, 50.0, 52.0, 400.0 ],
	"NEO" : [     0.0, 50.0, 52.0, 400.0 ],
	"SAN" : [     0.0, 50.0, 52.0, 400.0 ],
}

CurrentClamp_amplitude =  CurrentClamp_setting[ SimulationMode ][ 0 ]
CurrentClamp_onset     =  CurrentClamp_setting[ SimulationMode ][ 1 ]
CurrentClamp_offset    =  CurrentClamp_setting[ SimulationMode ][ 2 ]
CurrentClamp_interval  =  CurrentClamp_setting[ SimulationMode ][ 3 ]


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
#Stepper ODEStepper( ODE2 ){}
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
		Name "Gas constant (C mV/K/mol)";  # (mJ/K/mol)
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
#		Value 15353.339029443347e-15;  # units="L"
#		Value 1.99593407382764e-12;

		Value @(Vi_SIZE[SimulationMode] );
	}

	Variable Variable( active_volume )
	{
#		Value 80.0;	# percentage(dimensionless)
		Value @(active_volume);	# percentage(dimensionless)
	}


	@# 遺伝子発現

	@# INa
#	Variable Variable( Nav1_5 )
#	{
#		Name   "Relative expression of Nav1.5 for INa";
#		Value  @( Nav1_5[SimulationMode]);
#	}
	
	@# ICaL
#	Variable Variable( Cav1_2 )
#	{
#		Name   "Relative expression of Cav1.2 for ICaL";
#		Value  @( Cav1_2[SimulationMode]);
#	}

	@# ICaT
#	Variable Variable( Cav3_1 )
#	{
#		Name   "Relative expression of Cav3.1 for ICaT";
#		Value  1.0;
#	}

	@# Ist
#	Variable Variable( ST_gene )
#	{
#		Name   "Relative expression for Ist";
#		Value  0.0;
#	}

	@# IK1
#	Variable Variable( Kir2_1 )
#	{
#		Name   "Relative expression of Kir2.1 for IK1";
#		Value  1.0;
#	}

	@# IKr
#	Variable Variable( erg1 )
#	{
#		Name   "Relative expression of erg1 for IKr";
#		Value  1.0;
#	}

	@# IKs
#	Variable Variable( KCNQ1 )
#	{
#		Name   "Relative expression of KCNQ1 for IKs";
#		Value  1.0;
#	}

	@# Ito
#	Variable Variable( Kv1_4 )
#	{
#		Name   "Relative expression of Kv1.4 for Ito";
#		Value  1.0;
#	}

	@# IKACh
#	Variable Variable( Kir3_1 )
#	{
#		Name   "Relative expression for IKACh";
#		Value  0.0;
#	}

	@# INaK
#	Variable Variable( NaK_ATPase )
#	{
#		Name	"Relative expression of Na/K ATPase for Na/K pump";
#		Value	1.0;
#	}

#	@# INaCa
#	Variable Variable( NCX1 )
#	{
#		Name	"Relative expression of NCX1 for Na/Ca exchanger";
#		Value	1.0;
#	}

	@# IPMCA

#	@# ILCCa
#	Variable Variable( LCCa_gene )
#	{
#		Name   "Relative expression for ILCCa";
#		Value  1.0;
#	}

	@# IKATP
#	Variable Variable( Kir6_2 )
#	{
#		Name   "Relative expression of Kir6.2 for IKATP";
#		Value  1.0;
#	}

	@# IKpl
#	Variable Variable( Kpl_gene )
#	{
#		Name   "Relative expression for IKpl";
#		Value  1.0;
#	}

#	@# IbNSC
#	Variable Variable( bNSC_gene )
#	{
#		Name   "Relative expression for IbNSC";
#		Value  1.0;
#	}

#	@# ICab
#	Variable Variable( Cab_gene )
#	{
#		Name   "Relative expression for ICab";
#		Value  1.0;
#	}

#	@# IClb
#	Variable Variable( Clb_gene )
#	{
#		Name   "Relative expression for IClb";
#		Value  1.0;
#	}

#	@# NKCC
#	Variable Variable( NKCC_gene )
#	{
#		Name   "Relative expression for NKCC";
#		Value  1.0;
#	}

	@# IVRCC

	@# ICFTR

	@# Iha
#	Variable Variable( HCN )
#	{
#		Name	"Relative expression of HCN for Iha";
#		Value	1.0;
#	}

	@# IRyR

	Variable Variable( SR_activity )
	{
		Name	"Relative expression of SR";
		Value	1.0;
	}

#	Variable Variable( RyR1 )
#	{
#		Name	"Relative expression of RyR1 for IRyR";
#		Value	1.0;
#	}

	@# leak
#	Variable Variable( leak_activity )
#	{
#		Name	"Relative activity of SR leak current";
#		Value	1.0;
#	}

	@# ISRCA
#	Variable Variable( SERCA )
#	{
#		Name	"Relative expression of SERCA for ISRCA";
#		Value	1.0;
#	}

	@# ion

	Variable Variable( Na )
	{
		Name "Intracellular Na+";
		MolarConc 6.346144960767133e-3;
		# Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Intracellular K+";
		MolarConc 139.86283809432015e-3;
		# Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Intracellular Ca2+";
		MolarConc 7.485309995633807e-8;
		# Fixed 1;
	}

	Variable Variable( CaTotal )
	{
		Name "Intracellular total Ca2+";
		MolarConc 0.0015994473813345231e-3;
		# Fixed 1;
	}

	Variable Variable( Cl )
	{
		Name "Intracellular Cl-";
		MolarConc 49.77812289122723e-3;
		# Fixed 1;
	}

	Variable Variable( LA )
	{
		Name "Intracellular large anionic compound";
		MolarConc 102.2109911720549e-3;
	}

	@# <TotalVolume name="Vt">

	Variable Variable( Vt )
	{
		Name "Vt";
		Value @( Vt_SIZE );  # (L)
	}

	Process CytoplasmAssignmentProcess( Cytoplasm ) 
	{
		Name "Total cell volume";

		StepperID	PSV;
#		Priority	200;
		Priority	3;

		VariableReferenceList
#			[ Vi           :.:SIZE                   0 ]
			[ Vi           :.:SIZE                   1 ]
			[ Vt           :.:Vt                     1 ]
			[ active_volume :.:active_volume          0 ]
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
			[ NAD          :.:NAD                    0 ]
			[ NADH         :.:NADH                   1 ]
			[ Creatine     :.:Creatine               1 ]
			[ Pi           :.:Pi                     1 ]
			[ PiTotal      :.:PiTotal                0 ]
			[ ATPtotal_mt  :./MITOCHONDRIA:ATPtotal  0 ]
			[ ADPtotal_mt  :./MITOCHONDRIA:ADPtotal  0 ]
			[ Pi_mt        :./MITOCHONDRIA:Pi        0 ]
			[ T            :.:T                      1 ]
			[ Tt           :.:Tt                     0 ]
			[ TCa          :.:TCa                    0 ]
			[ TCaCB        :.:TCaCB                  0 ]
			[ TCB          :.:TCB                    0 ]
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
			[ calmodulin   :.:calmodulin             1 ];


		# Vn              3200.0;          # the osmotically inactive cell volume (um^3)
#		Vn_L              3200.0e-15;      # (L)
#		Vn_L              7.072e-14;      # (L)
		Vn_L              @( Vn_SIZE );
		Vt0i              @( 1.0 / Vt_SIZE );

		ActivityFactor    1.0;
		kD_ATP            0.024e-3;        # units="M"
		kD_ADP            0.347e-3;        # units="M"
		TotalAdenosine    7.0e-3;          # (M)
		TotalCreatine     25.0e-3;         # (M)
		NAD_H_total       0.000594;         # ducky 121026
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
		Value 1.1579897648525994;
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
		Value 6.999999999999999;
	}


	Variable Variable( Mg )
	{
		Name "Intracellular Mg2+";
		MolarConc 6.0e-4;
	}

	Variable Variable( ATPtotal )
	{
		Name "Total ATP";
		MolarConc 6.96248492200143e-3;
		# Fixed 1;
	}


	@# <freeconcentration name="ATPfree">

	Variable Variable( ATPfree )
	{
		Name "Free ATP";
		MolarConc 2.677878816154396e-4;
	}


	@# <massconservation name="ATPmg">
	@# ゼロ補正に関しては未実装

	Variable Variable( ATPmg )
	{
		Name "ATP-Mg";
		MolarConc 6.69469704038599e-3;
	}


	@# <freeconcentration name="ADPfree">

	Variable Variable( ADPtotal )
	{
		Name "Total ADP";
		MolarConc 3.6781238986170604e-5;
		# Fixed 1;
	}

	Variable Variable( ADPfree )
	{
		Name "Free ADP";
		MolarConc 1.3477391687646462e-5;
	}


	@# <freeconcentration name="ADPfree">

	Variable Variable( ADPmg )
	{
		Name "ADP-Mg";
		MolarConc 2.3303847298524142e-5;
	}


	@# <AMPconcentration name="AMP">

	Variable Variable( AMP )
	{
		Name "AMP";
		MolarConc 5.378613206818983e-8;
	}


	@# <massconservation name="Creatine">

	Variable Variable( PCr )
	{
		Name "Phospho creatine";
		MolarConc 1.2752455383511842e-2;
	}

	Variable Variable( Creatine )
	{
		Name "Creatine";
		MolarConc 1.2247544616488158e-2;
	}


	@# <massconservationPI name="Pi" className="org.simBio.bio.matsuoka_et_al_2004.function.ConcentrationPi">

	Variable Variable( Pi )
	{
		Name "Inorganic phosphate";
		MolarConc 2.1272277723005484e-3;
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
		MolarConc 298.1981719770164e-3;
	}


	@# <WaterFlux name="WaterFlux" className="org.simBio.bio.terashima_et_al_2006.complex.WaterFlux">

	Variable Variable( WaterFlux )
	{
		Name "Water Flux";
		Value -5.30589229565e-21;
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
		Value 0.9617633308389127;
	}


	@# <AdenylateKinase name="vAK" className="org.simBio.bio.matsuoka_et_al_2004.molecule.enzyme.AK">

	Variable Variable( vAK )
	{
		Name "vAK";
		Value -139.834886511;
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
		Value -663549.73707;
	}

#amano et al (2009)
#<massconservation name="NAD" initial_value="2.075109324838782" units="mM">
	Variable Variable( NAD )
	{
		MolarConc 0.0004150218649677564;
		#2.075109324838782 / 5.0
	}

#<variable name="NADH" initial_value="0.8948906751612181" units="mM" />
	Variable Variable( NADH )
	{
		MolarConc 0.00017897813503224363;
		#0.8948906751612181 / 5.0
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
		MolarConc 1.524594281378185e-6;
	}

	@#analyticCaBuffer( 'calmodulin', ':.:CaTotal', ':.:Ca', ':.:calmodulin', 0.00238, 0.05 )

	
	Variable Variable( crossBridgeLength )
	{
		Name "Cross Bridge Length";
		Value 0.005009947075106269;
	}


	@# <Troponin name="troponin" className="org.simBio.bio.kuzumoto_et_al_2007.contraction.Troponinmit">

	Variable Variable( Tt )
	{
		MolarConc 0.07e-3;
		# Fixed 1;
	}

	Variable Variable( T )
	{
		MolarConc 0.0672942681114029e-3;
	}

	Variable Variable( TCa )
	{
		Name "fraction of contraction unit with troponin C bound to Ca2+";
		MolarConc 2.5982764372710202e-6;
	}

	Variable Variable( TCaCB )
	{
		Name "fraction of contraction unit with troponin C bound to Ca2+ and attached cross bridge (force generator)";
		MolarConc 8.375865245910036e-8;
	}

	Variable Variable( TCB )
	{
		Name "fraction of contraction unit with attached cross bridge and with free troponin C (force generator)";
		MolarConc 2.369679886697068e-8;
	}


	Variable Variable( cAMPtot )
	{
		Name "Total cyclic AMP";
		MolarConc 6.800528803316611e-7;
	}

	Variable Variable( cAMP )
	{
		Name "Cyclic AMP";
		MolarConc 2.939695632625512e-7;
	}

	Variable Variable( PKA )
	{
		Name "protein kinase A";
		MolarConc 1.364353297210205e-7;
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
		MolarConc 4.969917928875104e-8;
	}

	Variable Variable( Gs_alpha_GTP_AC )
	{
		Name "adenylate cyclase-bound Gs alpha GTP";
		MolarConc 8.207112489611035e-13;
	}

	Variable Variable( Gs_alpha_GTPtot )
	{
		Name "total GTP-bound alpha subunit of Gs";
		MolarConc 5.202597626352922e-9;
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
		MolarConc 3.2516235164698e-10;
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
		MolarConc 3.7991044019474952e-9;
	}

	Variable Variable( Gstot )
	{
		Name "total Gs";
		MolarConc 3.83e-6;
	}

	Variable Variable( Gs )
	{
		Name "aipha, beta and gamma subunit of Gs";
		MolarConc 2.8244439923392865e-6;
	}

	Variable Variable( beta1_ARact )
	{
		Name "? activated beta1-adrenergic receptor";
		MolarConc 4.124266728915964e-9;
	}

	Variable Variable( beta1_AR_S464 )
	{
		Name "? beta1-adrenergic receptor S464";
		MolarConc 0.0;
	}

	Variable Variable( beta1_AR_S301 )
	{
		Name "? beta1-adrenergic receptor S301";
		MolarConc 9.075733271084037e-9;
	}

	Variable Variable( Gs_beta_gamma )
	{
		Name "beta and gamma subunit of Gs";
		MolarConc 1.005230845247631e-6;
	}

	Variable Variable( Gs_alpha_GDP )
	{
		Name "GDP-bound alpha subunit of Gs";
		MolarConc 4.312937712225446e-12;
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
		MolarConc 5.201776915103961e-9;
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
		MolarConc 6.520090177298568e-8;
	}

	Variable Variable( A2RCI )
	{
		Name "complex of 2 cAMP, PKA and regulatory subunit";
		MolarConc 2.3958850773161374e-9;
	}

	Variable Variable( A2RI )
	{
		Name "complex of 2 cAMP and regulatory subunit";
		MolarConc 1.5804532257104254e-7;
	}

	Variable Variable( RCI )
	{
		Name "regulatory subunit-bound PKA";
		MolarConc 1.7743578906433443e-6;
	}

	Variable Variable( PKACI_PKI )
	{
		Name "PKA inhibited by PKI";
		MolarConc 2.1609992850022038e-8;
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
		Value -86.72869394206137;
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
		Value @(Cm[SimulationMode]);
	}

	Variable Variable( EK )
	{
		Name "equilibrium potential for K+ (mV)";
		Value -86.93058752466963;
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
		Value -475.48115680026734;
	}


	Variable Variable( CFK )
	{
		Name "dependency of K+ flux on Vm (constant field equation)";
		Value 0.1383929081707904;
	}


	Variable Variable( CFCa )
	{
		Name "dependency of Ca2+ flux on Vm (constant field equation)";
		Value -11.705853861559248;
	}


	Variable Variable( CFCl )
	{
		Name "dependency of Cl- flux on Vm (constant field equation)";
		Value 149.75827659080292;
	}


	@# ICaLで計算
	Variable Variable( CaDiadic )
	{
		Name  "CICRfactor (mM)";
		Value -1.5309723748693796E-7;
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
		#Value 0.047652741143697386;
		Value 0.0;
	}

	Variable Variable( currentNa )
	{
		Name "sum of current components carried by Na+ (pA)";
		#Value 94.88482988241198;
		Value 0.0;
	}

	Variable Variable( currentK )
	{
		Name "sum of current components carried by K+ (pA)";
		#Value -118.10325682749983;
		Value 0.0;
	}

	Variable Variable( currentCa )
	{
		Name "sum of current components carried by Ca2+ (pA)";
		#Value 26.782021853292502;
		Value 0.0;
	}

	Variable Variable( currentCl )
	{
		Name "sum of current components carried by Cl- (pA)";
		#Value -3.5159421670609547;
		Value 0.0;
	}

}

System System( /CELL/CYTOPLASM/SRREL )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
#		Value 307.06678058886695e-15;  #  units="L"
#                Value 1.19756044429658e-14;  #  units="L"
		Value @( SRREL_SIZE_init );
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

#		ratio                 0.02;
		ratio                 @(0.02 * SRFactor[SimulationMode]); 

		Km_calsequestrin    0.0008;	# units="M"
		calsequestrin_total   0.01;	# units="M"
	}

	Variable Variable( Ca )
	{
		Name "SRrel Ca2+";
		MolarConc 1.706059829830171e-3;
		# Fixed 1;
	}

	Variable Variable( CaTotal )
	{
		Name "SRrel total Ca2+";
		MolarConc 8.513797656048734e-3;
	}

	Variable Variable( calsequestrin )
	{
		Name "Calsequestrin";
		MolarConc 6.807737826218563e-3;
	}

}


System System( /CELL/CYTOPLASM/SRUP )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
#		Value 767.6669514721674e-15;
#                Value 2.99390111074145e-14;
		Value @( SRUP_SIZE_init );
	}

	Process SRupAssignmentProcess( volume ) 
	{
		Name "SRup volume";

		StepperID	PSV;
		Priority	8;

		VariableReferenceList
			[ volume :.:SIZE   1 ]
			[ total  :..:SIZE  0 ];

#		ratio 0.05;
		ratio @(0.05 * SRFactor[SimulationMode]);
	}

	Variable Variable( Ca )
	{
		Name "SRup Ca2+";
		MolarConc 1.7464597368253787e-3;
		# Fixed 1;
	}

	Variable Variable( PLBphos )
	{
		Name "phosphorylated phospholamban";
		MolarConc 0.07920338500674862e-3;
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
		Value 42.66230178693931;
	}

	Variable Variable( GX ){
		Value @( transfer_act[SimulationMode]);
	}

	Process SRDiffusionAssignmentProcess( transfer ) 
	{
		Name "transfer Ca2+ current";

		StepperID	PSV;
		Priority	11;

		VariableReferenceList
			[ I   :.:transfer         1 ]
			[ SR_f    :..:SR_activity 0 ]
			[ GX  :.:GX               0 ]
			[ Cai :../SRREL:Ca        0 ]
			[ Cao :../SRUP:Ca         0 ]
			[ Cm  :../../MEMBRANE:Cm  0 ];

                permeabilityCa  @(SRtrans_permeabilityCa[SimulationMode]);  #  pA/M
#		permeabilityCa	5.0e+3;  #  pA/M
#               permeabilityCa  248.579545454545;  #  pA/M
#                permeabilityCa  1508.57142857143;  #  pA/M
#                permeabilityCa  200;  #  pA/M
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
}

@# ミトコンドリア｛ /CELL/CYTOPLASM/MITOCHONDRIA ｝
@include( 'Mitochondria_Original.em' )

@# 筋収縮
@include( 'IsotonicContraction.em' )

@# 細胞膜上のイオンチャネル
@include( 'INa.em' )     @# Na, K
@include( 'ICaL_V.em' )    @# Na, K, Ca
@include( 'ICaT.em' )    @#        Ca
@include( 'Ist.em' )     @# Na, K
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
@include( 'IVRCC.em' )   @#            Cl
@include( 'ICFTR.em' )   @#            Cl

@include( 'Iha.em' )     @# Na, K

@# 筋小胞体
@include( 'IRyR.em' )
@include( 'leak.em' )
@include( 'ISRCA.em' )


@# 実験装置 /Pipette
@include( 'CurrentClamp.em' )

@# 記録装置 /Recorder
System System( /Recorder )
{
	StepperID	PSV;
}

@# 膜電位記録 /Recorder/Vm
@#include( 'VmRecorder.em' )
