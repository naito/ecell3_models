@{
INaK_I = 71.0920500406155
INaK_gate = 0.5355938158215787

INaK_amp = {
	"V" : 10.8,
	"EMB" : 10.8,
	"LAT" : 10.8,
	"NEO" : 10.8,
	"SAN" : 14.5,
	"A" : 14.5,
}

}

System System(/CELL/MEMBRANE/INaK)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value @INaK_I;
	}

	Variable Variable( vgate )
	{
		Value 1.76804588672e-06;
	}

	Variable Variable( gate )
	{
		Value @INaK_gate;
	}

	Variable Variable( Couabain )
	{
		MolarConc 0.0;
	}

	Variable Variable( E1A )
	{
		Value 0.209952775275;
	}

	Variable Variable( E2A )
	{
		Value 0.532101004335;
	}

	Variable Variable( GX ){
		Value @( NaK_ATPase[SimulationMode]);
	}

	Process INaKAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	20;

		VariableReferenceList
			[ Nai      :../../CYTOPLASM:Na          0 ]
			[ Ki       :../../CYTOPLASM:K           0 ]
			[ PKA      :../../CYTOPLASM:PKA         0 ]
			[ Vm       :..:Vm                       0 ]
			[ vrtf     :..:_vrtf                    0 ]
			[ T        :/:T                         0 ]
			[ Nao      :/:Na                        0 ]
			[ Ko       :/:K                         0 ]
			[ R        :/:R                         0 ]
			[ F        :/:F                         0 ]
			[ ATP      :../../CYTOPLASM:ATPtotal    0 ]
			[ GX       :.:GX                        0 ]
			[ Couabain :.:Couabain                  0 ]
			[ dy       :.:vgate                     1 ]
			[ y        :.:gate                      0 ]
			[ E1A      :.:E1A                       1 ]
			[ E2A      :.:E2A                       1 ]
			[ I        :.:I                         1 ]
			[ Cm       :..:Cm                       0 ];

		KmNai         4.05e-3;   #  control dissociation constant for intracellular Sodium (M)
		KmKi          32.88e-3;  #  dissociation constant for intracellular Potassium (M)

		nHNa          1.06;      #  Hill coefficient of Sodium
		nHK           1.12;      #  Hill coefficient of Potassium

		amplitudePKAf 1.0;       #  to modulate PKA effect

		# PKA phosphorylation parameter
		ratio         0.35;
		KmPKA         0.0005e-3; #  (M)
		hill          5.0;

		KmNao         69.8e-3;   #  dissociation constant for extracellular Sodium (M)
		KmKo          0.258e-3;  #  dissociation constant for extracellular Potassium (M)

		ramda        -0.82;      #  relative depth of access channel

		k2            0.04;      #  rate constant for the reaction E2Na->E1Na
		k3            0.01;      #  rate constant for the reaction E1K->E2K
		k4            0.165;     #  rate constant for the reaction E2K->E1K

		KmATP         0.094e-3;  #  hydrolysis coefficient of ATP (M)
		amplitude0    @(INaK_amp[SimulationMode]);      #  (pA/pF)
#		amplitude0    10.8;      #  (pA/pF)
#                amplitude0    1.43;      #  (pA/pF)
	}

	Process ZeroVariableAsFluxProcess( gate )
	{
		Priority	15;

		VariableReferenceList
			[ y  :.:gate   1 ]
			[ dy :.:vgate  0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                      -2 ]
			[ Ki  :../../CYTOPLASM:K         2 ]
			[ Nae :/:Na                      3 ]
			[ Nai :../../CYTOPLASM:Na       -3 ]
			[ ATP :../../CYTOPLASM:ATPtotal -1 ]
			[ ADP :../../CYTOPLASM:ADPtotal  1 ]
			#[ Pi :../../CYTOPLASM:Pi        1 ]
			[ i   :.:I                       0 ]
			[ N_A :/:N_A                     0 ]
			[ F   :/:F                       0 ]
			[ z   :/:zNa                     0 ];
	}


	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentNa', 'I', 3 )

	@addToTotalCurrent( 'currentK', 'I', -2 )

	@addToTotalCurrent( 'current', 'I' )

}

@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-27 06:26:40 +0900

	<INaK name="INaK" initial_value="71.0920500406155"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.carrier.INaK">
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="Vi" initial_value="../volume" />
		<link name="Nai" initial_value="../Na" units="mM" />
		<link name="Nao" initial_value="../../Na" units="mM" />
		<link name="Ki" initial_value="../K" units="mM" />
		<link name="Ko" initial_value="../../K" units="mM" />
		<link name="ATP" initial_value="../ATPtotal" units="mM" />
		<link name="ADP" initial_value="../ADPtotal" units="mM" />
		<link name="Pi" initial_value="../Pi" units="mM" />
		<link name="PKA" initial_value="../PKA" units="mM" />
		<link name="R" initial_value="/Gas constant" />
		<link name="T" initial_value="/absolute temperature" units="K" />
		<link name="F" initial_value="/Faraday constant" units="Coulomb/mM" />
		<variable name="gate" initial_value="0.5355938158215787" />
		<parameter name="stoichiometryNa" initial_value="3.0" units="pA/mM" />
		<parameter name="stoichiometryK" initial_value="-2.0" units="pA/mM" />
		<parameter name="amplitude0" initial_value="10.8" units="pA/pF" />
		<parameter name="Couabain" initial_value="0.0" units="mM" />
		<parameter name="amplitude" initial_value="10.8" units="pA/pF" />
	</INaK>
'''}
