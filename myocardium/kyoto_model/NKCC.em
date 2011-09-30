@{
NKCC_ClFlux = 0.6550976711989519

NKCC_P = {
       "V" : 0.0359,
       "EMB" : 0.0359,
       "LAT" : 0.0359,
       "NEO" : 0.0359,
       "SAN" : 2.3687E-5,
}
}

System System(/CELL/MEMBRANE/NKCC)
{
	StepperID       ODE;

	Variable Variable( ClFlux )  # = cCl
	{
		Value @NKCC_ClFlux;  # units="pA"      
	}

	Variable Variable( _I )  # = cNa = cK
	{
		Value @( -0.5 * NKCC_ClFlux );  # units="pA"      
	}

	Variable Variable( GX ){
		Value @( NKCC_gene[SimulationMode]);
	}

	Process NKCCAssignmentProcess( ClFlux ) 
	{
		StepperID	PSV;
		Priority	16;

		VariableReferenceList
			[ Clo    :/:Cl                0 ]
			[ Ko     :/:K                 0 ]
			[ Nao    :/:Na                0 ]
			[ Cli    :../../CYTOPLASM:Cl  0 ]
			[ Ki     :../../CYTOPLASM:K   0 ]
			[ Nai    :../../CYTOPLASM:Na  0 ]
			[ ClFlux :.:ClFlux            1 ]
			[ I     :.:_I                 1 ]
			[ GX    :.:GX  0 ]
			[ F     :/:F                  0 ];

		KK      @( 0.00116 * 1000.0 );  #  binding constant for K+ [M^-1]
		KCl     @( 0.05735 * 1000.0 );  #  binding constant for Cl- [M^-1]
		KNa     @( 0.08445 * 1000.0 );  #  binding constant for Na+ [M^-1]

		kbEmpty 79.522;  
		kfEmpty 37.767; 
		kbFull  1.456;   
		kfFull  3.065; 
		P       @(NKCC_P[SimulationMode]); # amol
#		P       0.0359; # amol
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Clo :/:Cl                2 ]
			[ Ko  :/:K                 1 ]
			[ Nao :/:Na                1 ]
			[ Cli :../../CYTOPLASM:Cl -2 ]
			[ Nai :../../CYTOPLASM:Na -1 ]
			[ Ki  :../../CYTOPLASM:K  -1 ]
			[ i   :.:_I                0 ]
			[ N_A :/:N_A               0 ]
			[ F   :/:F                 0 ]
			[ z   :/:zNa               0 ];
	}


	@addToTotalCurrent( 'currentNa', 'ClFlux', -0.5 )

	@addToTotalCurrent( 'currentK', 'ClFlux', -0.5 )

	@addToTotalCurrent( 'currentCl', 'ClFlux', 1.0 )

}

@{'''
Author Hiromi KUMAMOTO
Author Yasuhiro Naito

Version 0.2 2008-11-30 02:38:32 +0900

	<NKCC name="NKCC" initial_value="0.003394756330141625" units="amol/ms"
		className="org.simBio.bio.terashima_et_al_2006.current.carrier.NKCC">
		<parameter name="ClFlux" initial_value="0.6550976711989519" units="pA" />
		<parameter name="P" initial_value="0.0359" units="amol" />
		<parameter name="kbEmpty" initial_value="79.522" units="/ms" />
		<parameter name="kfEmpty" initial_value="37.767" units="/ms" />
		<parameter name="kbFull" initial_value="1.456" units="/ms" />
		<parameter name="kfFull" initial_value="3.065" units="/ms" />
		<parameter name="KK" initial_value="0.00116" units="/mM" />
		<parameter name="KCl" initial_value="0.05735" units="/mM" />
		<parameter name="KNa" initial_value="0.08445" units="/mM" />
		<link name="currentNa" initial_value="../currentNa" units="pA" />
		<link name="currentK" initial_value="../currentK" units="pA" />
		<link name="currentCl" initial_value="../currentCl" units="pA" />
		<link name="Clo" initial_value="../../Cl" units="mM" />
		<link name="Ko" initial_value="../../K" units="mM" />
		<link name="Nao" initial_value="../../Na" units="mM" />
		<link name="Cli" initial_value="../Cl" units="mM" />
		<link name="Ki" initial_value="../K" units="mM" />
		<link name="Nai" initial_value="../Na" units="mM" />
		<link name="F" initial_value="/Faraday constant" units="Coulomb/mM" />
	</NKCC>
'''}