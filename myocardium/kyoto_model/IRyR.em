@{
IRyR_I = 8.513204629271943
IRyR_open = 1.1813918231968055e-4
IRyR_close = 0.18962058256879352

IRyR_permeabilityCa = {
	"V" : 200.0e+3,
	"EMB" : 200.0e+3,
	"LAT" : 200.0e+3,
	"NEO" : 200.0e+3,
	"SAN" : 59.0e+3,
}
#		permeabilityCa  200.0e+3;  # 200 pA/pF/mM -> pA/pF/M

}

System System(/CELL/CYTOPLASM/SRREL/IRyR)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IRyR_I;
	}

	Variable Variable( open )
	{
		Value @IRyR_open;
	}

	Variable Variable( close )
	{
		Value @IRyR_close;
	}

	Variable Variable( k1 )
	{
		Value 8.08377469561e-06;
	}

	Variable Variable( k2 )
	{
		Value 7.80432436175e-06;
	}

	Variable Variable( k3_k4 )
	{
		Value 0.000728121009439;
	}

	Variable Variable( GX ){
		Value @( RyR1[SimulationMode]);
	}

	Process IRyRAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ pOpen    :.:open                      0 ]
			[ pClose   :.:close                     0 ]
			[ CaDiadic :../../../MEMBRANE:CaDiadic  0 ]
			[ Cai      :../..:Ca                    0 ]
			[ Cao      :..:Ca                       0 ]
			[ k1       :.:k1                        1 ]
			[ k2       :.:k2                        1 ]
			[ k3_k4    :.:k3_k4                     1 ]
			[ I        :.:I                         1 ]
			[ GX       :.:GX                        0 ]
			[ SR_f     :../..:SR_activity		0 ]
			[ Cm       :../../../MEMBRANE:Cm        0 ];

		diadicFactor  @(diadicFactor[SimulationMode]);
		k3_1      3.77e-4;
		k3_hill   2.0;
		k4        8.49e-4;
	
		permeabilityCa @(IRyR_permeabilityCa[SimulationMode]);  # 200 pA/pF/mM -> pA/pF/M

	}

	Process ZeroVariableAsFluxProcess( k1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ pOpen  :.:open   1 ]
			[ pClose :.:close -1 ]
			[ dy     :.:k1     0 ];
	}

	Process ZeroVariableAsFluxProcess( k2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ pOpen :.:open  -1 ]
			[ dy    :.:k2     0 ];
	}

	Process ZeroVariableAsFluxProcess( k3_k4 ) 
	{
		Priority	15;

		VariableReferenceList
			[ pClose :.:close  1 ]
			[ dy     :.:k3_k4  0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ out :../..:CaTotal  1 ]
			[ in  :..:CaTotal    -1 ]
			[ i   :.:I            0 ]
			[ N_A :/:N_A          0 ]
			[ F   :/:F            0 ]
			[ z   :/:zCa          0 ];
	}


}

@{'''
Author Hitomi I. SANO
Author Yasuhiro Naito

Version 0.2 2008-11-30 12:33:15 +0900

### Priority rate may have to be modified depending on /CELL/MEMBRANE/ICaL:CICRFactor

	<IRyR name="IRyR" initial_value="8.513204629271943"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.IRyR">
		<link name="CaDiadicinitial_value="../../ICaL/CaDiadic" units="mM" />
		<link name="Cm" initial_value="../../membrane capacitance" />
		<link name="Cai" initial_value="../../Ca" units="mM" />
		<link name="Cao" initial_value="../Ca" units="mM" />
		<link name="current" initial_value="/dummy" />
		<link name="currentCa" initial_value="../currentCa" />
		<parameter name="permeabilityCa" initial_value="200.0" units="pA/pF/mM" />
		<variable name="close" initial_value="0.18962058256879352" />
		<variable name="open" initial_value="1.1813918231968055E-4" />
		<parameter name="diadicFactor" initial_value="-150.0" />
		<parameter name="k2_1" initial_value="0.08" />
		<parameter name="k2_2" initial_value="0.36" />
		<parameter name="k3_1" initial_value="3.77E-4" />
		<current name="currentCa" initial_value="8.513204629271943" units="pA"
			className="org.simBio.bio.matsuoka_et_al_2003.function.Current">
			<link name="in" initial_value="../CaTotal" units="mM" />
			<link name="out" initial_value="../../CaTotal" units="mM" />
			<link name="Vi" initial_value="../volume" />
			<link name="Vo" initial_value="../../volume" />
			<link name="F" initial_value="/Faraday constant" />
			<parameter name="valence" initial_value="2.0" units="dimension_less" />
		</current>
	</IRyR>
'''}
