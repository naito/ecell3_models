@{
Iha_I = 0.0
Iha_closedState1 = 0.9960236629731324
Iha_closedState2 = 0.0024941594071041704
Iha_openState1 = 0.001052970622591984
Iha_openState2 = 3.29452497062116E-4

Iha_permeabilityK = {
	"V" : 0.05635,
	"EMB" : 0.05635,
	"LAT" : 0.05635,
	"NEO" : 0.05635,
	"SAN" : 0.05635
}
Iha_permeabilityNa = {
	"V" : 0.01379,
	"EMB" : 0.01379,
	"LAT" : 0.01379,
	"NEO" : 0.01379,
	"SAN" : 0.01379,
}

}


System System(/CELL/MEMBRANE/Iha)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @Iha_I;
	}

	Variable Variable( closedState1 )
	{
		Value @Iha_closedState1;
	}

	Variable Variable( closedState2 )
	{
		Value @Iha_closedState2;
	}

	Variable Variable( openState1 )
	{
		Value @Iha_openState1;
	}

	Variable Variable( openState2 )
	{
		Value @Iha_openState2;
	}

	Variable Variable( vC1_C2 )
	{
		Value -0.00143342514945;
	}

	Variable Variable( vC2_O1 )
	{
		Value -0.000170414753418;
	}

	Variable Variable( vO1_O2 )
	{
		Value -7.19808602705e-05;
	}

	Variable Variable( vO2_O3 )
	{
		Value -2.25223489708e-05;
	}

	Variable Variable( POpen )
	{
		Value 0.00148217761976;
	}

	Variable Variable( i )
	{
		Value 0.0;
	}


	Variable Variable( cK )
	{
		Value 0.0;
	}

	Variable Variable( cNa )
	{
		Value 0.0;
	}

	Variable Variable( GX ){
		Value @( HCN[SimulationMode]);
	}

	Process IhaAssignmentProcess( assignment ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ cAMP   :../../CYTOPLASM:cAMP  0 ]
			[ Vm     :..:Vm                 0 ]
			[ vC1_C2 :.:vC1_C2              1 ]
			[ vC2_O1 :.:vC2_O1              1 ]
			[ vO1_O2 :.:vO1_O2              1 ]
			[ vO2_O3 :.:vO2_O3              1 ]
			[ pC1    :.:closedState1        0 ]
			[ pC2    :.:closedState2        0 ]
			[ pO1    :.:openState1          0 ]
			[ pO2    :.:openState2          0 ]
			[ pOpen  :.:POpen               1 ]
			[ i      :.:i                   1 ]
			[ GX     :.:GX                  0 ]
			[ Cm     :..:Cm                 0 ]
			[ cK     :.:cK                  1 ]
			[ CFK    :..:CFK                0 ]
			[ cNa    :.:cNa                 1 ]
			[ CFNa   :..:CFNa               0 ]
			[ I      :.:I                   1 ];

		cAMP0           @cAMP0 ;  # M
		hill_n          1.0;

		Vshift          0.0;
		amplitudecAMPf  1.0;
		KmcAMP_hill_n   @( pow( 0.0002, 1.0 ));

                permeabilityK   @( Iha_permeabilityK[SimulationMode] );
                permeabilityNa  @( Iha_permeabilityNa[SimulationMode] );
	}

	Process ZeroVariableAsFluxProcess( vC1_C2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vC1_C2 :.:vC1_C2        0 ]
			[ pC1    :.:closedState1  1 ]
			[ pC2    :.:closedState2 -1 ];
	}

	Process ZeroVariableAsFluxProcess( vC2_O1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vC2_O1 :.:vC2_O1        0 ]
			[ pC2    :.:closedState2  1 ]
			[ pO1    :.:openState1   -1 ];
	}

	Process ZeroVariableAsFluxProcess( vO1_O2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vO1_O2 :.:vO1_O2      0 ]
			[ pO1    :.:openState1  1 ]
			[ pO2    :.:openState2 -1 ];
	}

	Process ZeroVariableAsFluxProcess( vO2_O3 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vO2_O3 :.:vO2_O3        0 ]
			#[ pC1   :.:closedState1  0 ]
			#[ pC2   :.:closedState2  0 ]
			#[ pO1   :.:openState1    0 ]
			[ pO2    :.:openState2    1 ];
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}

@{'''
Author Yasuhiro Naito
Version 0.1 2009-01-09 14:55:56 +0900

<Iha name="Iha" units="pA" className="org.simBio.bio.himeno_et_al_2008.Iha">
	<link name="Vm" initial_value="../Vm" units="mV" />
	<link name="Cm" initial_value="../membrane capacitance" />
	<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
	<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
	<link name="current" initial_value="../current" />
	<link name="currentNa" initial_value="../currentNa" />
	<link name="currentK" initial_value="../currentK" />
	<link name="cAMP" initial_value="../cAMP" />
	<link name="cAMP0" initial_value="../cAMP0" />
	<parameter name="permeabilityNa" initial_value="0.01379" />
	<parameter name="permeabilityK" initial_value="0.05635" />
	<parameter name="cAMP_Vshift" initial_value="0.0" />
	<variable name="closedState1" initial_value="0.9960236629731324" />
	<variable name="closedState2" initial_value="0.0024941594071041704" />
	<variable name="openState1" initial_value="0.001052970622591984" />
	<variable name="openState2" initial_value="3.29452497062116E-4" />
</Iha>
'''}
