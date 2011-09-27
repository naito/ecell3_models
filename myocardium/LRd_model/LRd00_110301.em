
@include('SetOptions.em')

@{SimulationMode = 'V'}

@{
CYTOPLASM_SIZE   = 2.584e-11
JSR_SIZE         = 1.82e-13
NSR_SIZE         = 2.098e-12
}

@{

#INa
Nav1_5 = {
	"V" : 1.0,
	"EMB" : 0.07,
#	"EMB" : 0.0769,
	"LAT" : 1.0,
	"NEO" : 1.0,
}

#ICaL
Cav1_2 = {
	"V" : 1.0,
	"EMB" : 0.46,
	"LAT" : 0.78,
	"NEO" : 0.78,
}

#ICaT
Cav3_1 = {
	"V" : 1.0,
	"EMB" : 4.5,
	"LAT" : 4.5,
	"NEO" : 1.0,
}

#IK1
Kir2_1 = {
	"V" : 1.0,
	"EMB" : 0.11,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0	
}

#IKr
erg1 = {
       "V" : 1.0,
       "EMB" : 2.0,
       "LAT" : 2.0,
       "NEO" : 1.5,
       "SAN" : 1.0
}

#IKs
KCNQ1 = {
       "V" : 1.0,
       "EMB" : 0.01,
       "LAT" : 0.01,
       "NEO" : 2.0,
       "SAN" : 1.0
}

#INaK
NaK_ATPase = {
	"V" : 1.0,
	"EMB" : 1.0,
	"LAT" : 1.0,
	"NEO" : 1.0,
	"SAN" : 1.0
}

#INaCa
NCX1 = {
     	"V" : 1.0,
	"EMB" : 4.95,
	"LAT" : 1.74,
	"NEO" : 1.0,
	"SAN" : 1.0
}

#Ibg
Ibg_gene = {
	 "V" : 1.0,
	 "EMB" : 1.0,
	 "LAT" : 1.0,
	 "NEO" : 1.0,
	 "SAN" : 1.0
}

#Ibg
PCaPump_gene = {
	 "V" : 1.0,
	 "EMB" : 1.0,
	 "LAT" : 1.0,
	 "NEO" : 1.0,
	 "SAN" : 1.0
}

#KPlateau
Kpl_gene = {
	 "V" : 1.0,
	 "EMB" : 1.0,
	 "LAT" : 1.0,
	 "NEO" : 1.0,
	 "SAN" : 1.0
}

#IRyR
RyR1 = {
	  "V" : 1.0,
	  "EMB" : 0.05,
	  "LAT" : 0.4,
	  "NEO" : 0.4,
	  "SAN" : 1.0	  
}

#ISRCa
SERCA = {
	  "V" : 1.0,
	  "EMB" : 0.03,
	  "LAT" : 0.21,
	  "NEO" : 0.21,
	  "SAN" : 1.0  
}


#Ileak
leak_act = {
	  "V" : 1.0,
	  "EMB" : 0.04,
	  "LAT" : 0.3,
	  "NEO" : 0.3,
	  "SAN" : 1.0  
}

transfer_act = {
	  "V" : 1.0,
	  "EMB" : 0.04,
	  "LAT" : 0.3,
	  "NEO" : 0.3,
	  "SAN" : 1.0  
}


CurrentClamp_amplitude = -80.0
CurrentClamp_onset     =  10.0
CurrentClamp_offset    =  10.5
CurrentClamp_interval  =  300.0

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
			[ %se  :/:%s                0 ]
			[ %si  :../../CYTOPLASM:%s -1 ]
			[ i   :.:%s                 0 ]
			[ A_cap :/:A_cap            0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:z%s                0 ];
	}
'''
	if Ion == 'Ca':
		Xi = 'CaDummy'
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
		Value 1.0;
		Fixed 1;
	}

	@# 物理・化学定数

	Variable Variable( A_cap )
	{
		Name "A_cap";
		Value 0.0001534;
	}

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

	@# 細胞外液

	Variable Variable( Na )
	{
		Name "Extracellular Na+";
		MolarConc 0.140;
		Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Extracellular K+";
		MolarConc 0.0045;
		Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Extracellular Ca2+";
		MolarConc 0.0018;
		Fixed 1;
	}

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
		Value @( CYTOPLASM_SIZE );
	}

	Variable Variable( SR_activity )
	{
		Name	"Relative expression of SR";
		Value	1.0;
	}

	Variable Variable( Na )
	{
		Name "Intracellular Na+";
		MolarConc 0.012236437;
		# Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Intracellular K+";
		MolarConc 0.13689149;
		# Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Intracellular Ca2+";
		MolarConc 0.000000079;
		# Fixed 1;
	}

	Variable Variable( CaDummy )
	{
		Name "Dummy Ca";
		MolarConc 0.000000079;
		# Fixed 1;
	}

	Variable Variable( TRPNt )
	{
		MolarConc	7.0e-5;
		Name	"TRPN total";
	}

	Variable Variable( TRPNf )
	{
		MolarConc	1.43923e-5;
		Name	"TRPN free";
	}

	Variable Variable( CMDNt )
	{
		MolarConc	5.0e-5;
		Name	"CMDN total";
	}
	Variable Variable( CMDNf )
	{
		MolarConc	2.57849e-6;
		Name	"CMDN free";
	}

	@include( 'CaBuffer_LRd.em' )
}

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

	Variable Variable( Cm )
	{
		Name "membrane capacitance (pF)";
		Value 1.0;
	}

	Variable Variable( EK )
	{
		Name "equilibrium potential for K+ (mV)";
		Value -86.93058752466963;
	}

	Variable Variable( ENa )
	{
		Name "equilibrium potential for Na+ (mV)";
		Value 0;
	}

	Variable Variable( ECa )
	{
		Name "equilibrium potential for Ca2+ (mV)";
		Value 0;
	}

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
			[ ECa       :.:ECa            1 ]
			[ EK        :.:EK             1 ]
			[ ENa       :.:ENa            1 ]
			[ Ke        :/:K              0 ]
			[ Ki        :../CYTOPLASM:K   0 ]
			[ CFNa      :.:CFNa           1 ]
			[ Nae       :/:Na             0 ]
			[ Nai       :../CYTOPLASM:Na  0 ]
			[ CFK       :.:CFK            1 ]
			[ CFCa      :.:CFCa           1 ]
			[ Cae       :/:Ca             0 ]
			[ Cai       :../CYTOPLASM:Ca  0 ]
			[ vrtf      :.:_vrtf          1 ]
			[ rtf      :.:_rtf            1 ]
			[ current   :.:current        1 ]
			[ currentNa :.:currentNa      1 ]
			[ currentK  :.:currentK       1 ]
			[ currentCa :.:currentCa      1 ];
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

	Variable Variable( _rtf )
	{
		Name " R * T / F";
		Value 0;
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

}

System System( /CELL/CYTOPLASM/JSR )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value @( JSR_SIZE );
	}

	Variable Variable( Ca )
	{
		Name "Ca in Junctional SR";
		MolarConc 0.001179991;
		# Fixed 1;
	}

	Variable Variable( CSQNt )
	{
		Name "CSQN total";
		MolarConc 1.0e-2;
	}

	Variable Variable( CSQNf )
	{
		Name "CSQN free";
		MolarConc 6.97978e-3;
	}
}


System System( /CELL/CYTOPLASM/NSR )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value @( NSR_SIZE );
	}

	Variable Variable( Ca )
	{
		Name "Ca in Network SR";
		MolarConc 0.001179991;
		# Fixed 1;
	}
}


@# 細胞膜上のイオンチャネル
@include( 'INa_LRd.em' )     @# Na
@include( 'ICaL_LRd.em' )    @# Na, K, Ca
@include( 'ICaT_LRd.em' )    @#        Ca

@include( 'IK1_LRd.em' )     @#     K

@include( 'IKr_LRd.em' )     @# K
@include( 'IKs_LRd.em' )     @# K
@include( 'IKpl_LRd.em' )    @# K

@include( 'INaCa_LRd.em' )   @# Na, Ca
@include( 'INaK_LRd.em' )    @# Na, K

@include( 'Ibg_LRd.em' )   @# Na, Ca
@include( 'IPCa_LRd.em' )  @# Ca 

@# 筋小胞体
@include( 'IRyR_LRd.em' )
@include( 'leak_LRd.em' )
@include( 'transfer_LRd.em' )
@include( 'ISRCA_LRd.em' )

@include( 'CurrentClamp_LRd.em' )

System System( /Recorder )
{
	StepperID	PSV;
}

@#include( 'VmRecorder.em' )
