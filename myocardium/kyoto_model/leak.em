@{
leak_I = 110.65094623284274

leak_permeabilityCa = {
	"V" : 0.3e+3,
	"EMB" : 0.3e+3,
	"LAT" : 0.3e+3,
	"NEO" : 0.3e+3,
	"SAN" : 0.0594e+3,
	"A" : 0.3e+3,
}

}

System System(/CELL/CYTOPLASM/SRUP/leak)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @leak_I;
	}

	Variable Variable( GX ){
		Value @( leak_act[SimulationMode]);
	}

	Process SRleakDiffusionAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ I   :.:I                   1 ]
			[ SR_f:../..:SR_activity     0 ]
			[ act :.:GX                  0 ]
			[ Cai :../..:Ca              0 ]
			[ Cao :..:Ca                 0 ]  # Cao = in
			[ Cm  :../../../MEMBRANE:Cm  0 ];

		permeabilityCa	@(leak_permeabilityCa[SimulationMode]);  #  pA/M
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ in  :..:Ca         -1 ]  # Cao = in
			[ out :../..:CaTotal  1 ]
			[ i   :.:I            0 ]
			[ N_A :/:N_A          0 ]
			[ F   :/:F            0 ]
			[ z   :/:zCa          0 ];
	}

}

@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-30 17:13:45 +0900

### Priority rate may have to be modified depending on /CELL/MEMBRANE/ICaL:CICRFactor

	<diffusion name="leak" initial_value="110.65094623284274"
		className="org.simBio.bio.terashima_et_al_2006.current.Diffusion">
		<link name="Cm" initial_value="../../membrane capacitance" />
		<link name="Cai" initial_value="../../Ca" units="mM" />
		<link name="Cao" initial_value="../Ca" units="mM" />
		<link name="current" initial_value="/dummy" />
		<link name="currentNa" initial_value="/dummy" />
		<link name="currentK" initial_value="/dummy" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="/dummy" />
		<parameter name="permeabilityCa" initial_value="0.3" units="pA/mM" />
	</diffusion>
	<current name="currentCa" initial_value="11.903628470056404" units="pA">
		<link name="in" initial_value="../Ca" units="mM" />
		<link name="out" initial_value="../../CaTotal" units="mM" />
		<link name="Vi" initial_value="../volume" />
		<link name="Vo" initial_value="../../volume" />
		<link name="F" initial_value="/Faraday constant" />
		<parameter name="valence" initial_value="2.0" units="dimension_less" />
	</current>
'''}
