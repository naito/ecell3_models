@{

IPMCA_I =2.9355898549522
IPMCA_gate = 0.47231826638070495

}

System System(/CELL/MEMBRANE/IPMCA)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value @IPMCA_I;
	}

	Variable Variable( gate )
	{
		Value @IPMCA_gate;
	}

	Variable Variable( E1A )
	{
		Value 0.656321655384;
	}

	Variable Variable( E2A )
	{
		Value 0.421631000578;
	}

	Variable Variable( dE )
	{
		Value 0.00019295063214;
	}


	Process IPMCAAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority        20;

		VariableReferenceList
			[ Cai   :../../CYTOPLASM:Ca          0 ]
			[ CaCaM :../../CYTOPLASM:calmodulin  0 ]
			[ E1A   :.:E1A                       1 ]
			[ Cao   :/:Ca                        0 ]
			[ E2A   :.:E2A                       1 ]
			[ ATP   :../../CYTOPLASM:ATPtotal    0 ]
			[ y     :.:gate                      0 ]
			[ dE    :.:dE                        1 ]
			[ PKA   :../../CYTOPLASM:PKA         0 ]
			[ I     :.:I                         1 ]
			[ Cm    :..:Cm                       0 ];
		
		KmCaCp0        0.0019e-3;   #  Dissociation constant for Ca binding within cytoplasm (M)
		KmCaCaM        0.00005e-3;  #  (M)
		hill           1.0;

		KmCao          2.0e-3;  #  Dissociation constant for Ca binding outside (M)
		
		k2             0.01;
		k3             0.01;
		k4             1.0;
		KmATP          0.1e-3;  #  Model adjusted. (M)

		amplitude      0.045815939110831344;  #  amplitude factor [pA/pF]
		amplitude0     0.0055;
		amplitudePKAf  1.0;
	}

	Process ZeroVariableAsFluxProcess( E )
	{
		Priority	15;

		VariableReferenceList
			[ dy  :.:dE   0 ]
			[ y   :.:gate  1 ];
	}

	Process IonFluxProcess( jCa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cae :/:Ca                      1 ]
			[ Cai :../../CYTOPLASM:CaTotal  -1 ]
			[ ATP :../../CYTOPLASM:ATPtotal  0 ]
			[ ADP :../../CYTOPLASM:ADPtotal  0 ]
			#[ Pi  :../../CYTOPLASM:Pi        1 ]
			[ i   :.:I                       0 ]
			[ N_A :/:N_A                     0 ]
			[ F   :/:F                       0 ]
			[ z   :/:zCa                     0 ];
	}

	@#setCurrents( [ 'I' ], [ 'Ca', 'I' ] )

	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentCa', 'I', 1 )

	@addToTotalCurrent( 'current', 'I' )

}

@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-30 01:21:33 +0900

	<IPMCA name="IPMCA" initial_value="2.9355898549522" units="pA"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.carrier.IPMCA">
		<variable name="gate" initial_value="0.47231826638070495" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="Vi" initial_value="../volume" />
		<link name="F" initial_value="/Faraday constant" />
		<link name="Cai" initial_value="../Ca" units="mM" />
		<link name="Cao" initial_value="../../Ca" units="mM" />
		<link name="ATP" initial_value="../ATPtotal" units="mM" />
		<link name="ADP" initial_value="../ADPtotal" units="mM" />
		<link name="PKA" initial_value="../PKA" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="CaCaM" initial_value="../calmodulin" />
		<parameter name="stoichiometryCa" initial_value="1.0" />
		<parameter name="KmCaCp0" initial_value="0.0019" />
		<parameter name="amplitude" initial_value="0.045815939110831344" units="A/F" />
		<label name="Phosphorylation" initial_value="true" />
	</IPMCA>
'''}