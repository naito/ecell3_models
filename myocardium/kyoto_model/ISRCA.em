@{
ISRCA_I = -49.37365888139317
ISRCA_gate = 0.02932301538170902

ISRCA_amp = {
	"V" : 19.0,
	"EMB" : 19.0,
	"LAT" : 19.0,
	"NEO" : 19.0,
	"SAN" : 3.762,
}

}

System System(/CELL/CYTOPLASM/SRUP/ISRCA)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @ISRCA_I;
	}

	Variable Variable( gate )
	{
		Value @ISRCA_gate;
	}

	Variable Variable( GX ){
		Value @( SERCA[SimulationMode]);
	}

	Process ISRCAAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	16;

		VariableReferenceList
			[ Cao     :..:Ca                ]  #  Ca2+ concentration in SR (uptake site compartment)
			[ Cai     :../..:Ca             ]  #  Ca2+ concentration in cytoplasm
			[ PLBphos :..:PLBphos           ]
			[ dE      :.:dE                 ]
			[ y       :.:gate               ]
			[ ATP     :../..:ATPtotal       ]
			[ I       :.:I                 1]
			[ SR_f     :../..:SR_activity    0 ]
			[ GX      :.:GX          ]
			[ Cm      :../../../MEMBRANE:Cm ];

		KmCaSR  3.0e-3;          #  (M)
		hill  2.0;
		amplitudePKAf   1.0;       #  to modulate PKA effect
		a               -3.93e-4;  #  (mM) dimensionless?
		b               6.85e-7;   #  (M)
		kmcacp_minimum 1e-8;  #  (M)
		KmATP   0.1e-3;          #  (M)
		k1    0.01;			
		k3   1.0;
		k4   0.01;

		amplitude @(ISRCA_amp[SimulationMode]);

#		amplitude  19.0;
#               amplitude  0.0755681818181818;
#               amplitude  4.29942857142857;
#                amplitude  0.57;
	}
	
#	Variable Variable( dEA )
#	{
#		Value 0.0123040417866;
#	}

	Variable Variable( dE )
	{
		Value -1.55351689138e-05;
	}
	
	Process ZeroVariableAsFluxProcess( E ) 
	{
		Priority	12;

		VariableReferenceList
			[ y   :.:gate  1 ]
			[ dy :.:dE     0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ out :../..:CaTotal   2 ]  #  Ca2+ concentration in cytoplasm
			[ in  :..:Ca          -2 ]  #  Ca2+ concentration in SR (uptake site compartment)
			[ ATP :../..:ATPtotal  1 ]
			[ ADP :../..:ADPtotal -1 ]
			#[ Pi :../..:Pi       -1 ]
			[ i   :.:I             0 ]
			[ N_A :/:N_A           0 ]
			[ F   :/:F             0 ]
			[ z   :/:zCa           0 ];
			@# stoichiometryCa = 2.0 がここに反映されている
	}

}

@{'''
Author Hitomi I. SANO
Author Yasuhiro Naito

Version 0.2 2008-11-30 17:24:45 +0900

	<ICaPump name="ISRCA" initial_value="-49.37365888139317"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.carrier.ICaPump">
		<link name="Cm" initial_value="../../membrane capacitance" />
		<link name="Vi" initial_value="../../volume" />
		<link name="F" initial_value="/Faraday constant" />
		<link name="Cai" initial_value="../../Ca" units="mM" />
		<link name="Cao" initial_value="../Ca" units="mM" />
		<link name="ATP" initial_value="../../ATPtotal" units="mM" />
		<link name="ADP" initial_value="../../ADPtotal" units="mM" />
		<link name="Pi" initial_value="../../Pi" units="mM" />
		<link name="current" initial_value="/dummy" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="PLBphos" initial_value="../PLB/PLBphos" units="mM" />
		<variable name="gate" initial_value="0.02932301538170902" />
		<parameter name="amplitude" initial_value="19.0" />
		<parameter name="stoichiometryCa" initial_value="2.0" units="pA/mM" />
		<parameter name="KmCaSR" initial_value="3.0" units="mM" />
		<parameter name="a" initial_value="-3.93E-4" units="mM" />
		<parameter name="b" initial_value="6.85E-4" units="mM" />
		<parameter name="hill" initial_value="2.0" />
	</ICaPump>
	<current name="currentCa" initial_value="11.903628470056404" units="pA">
		<link name="in" initial_value="../Ca" units="mM" />
		<link name="out" initial_value="../../CaTotal" units="mM" />
		<link name="Vi" initial_value="../volume" />
		<link name="Vo" initial_value="../../volume" />
		<link name="F" initial_value="/Faraday constant" />
		<parameter name="valence" initial_value="2.0" units="dimension_less" />
	</current>
'''}
