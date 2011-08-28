@{'''
Author Yasuhiro Naito

Version 0.1 2009-07-10 03:47:48 +0900

	<Ist name="Ist" initial_value="-11.854337592615822" units="pA" className="org.simBio.bio.himeno_et_al_2008.Ist" >
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="Cai" initial_value="../Ca" units="mM" />
		<link name="PKA" initial_value="../PKA" />
		<link name="PKA0" initial_value="../PKA0" />
		<parameter name="max" initial_value="1.0" />
		<parameter name="permeabilityNa" initial_value="0.007375" units="pA/pF/mM" />
		<parameter name="permeabilityK" initial_value="0.0043125" units="pA/pF/mM" />
		<variable name="activation" initial_value="0.3141402829962753" />
		<variable name="inactivation" initial_value="0.7679681596792866" />
		<variable name="slowInactivation" initial_value="0.8299423547898264" />
	</Ist>
'''}

System System(/CELL/MEMBRANE/Ist)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @Ist_I;
	}

	Variable Variable( dactivation )
	{
		Value 0.0;
	}

	Variable Variable( dinactivation )
	{
		Value 0.0;
	}

	Variable Variable( dslowInactivation )
	{
		Value 0.0;
	}

	Variable Variable( activation )
	{
		Name	"the open probability of activation gate";
		Value @Ist_activation;
	}

	Variable Variable( inactivation )
	{
		Name	"the open probability of inactivation gate";
		Value @Ist_inactivation;
	}

	Variable Variable( slowInactivation )
	{
		Name	"the C2 state probability of slow inactivation gate";
		Value @Ist_slowInactivation;
	}

	Process IstAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	19;

		VariableReferenceList
			[ Vm     :..:Vm     0 ]
			[ Cm     :..:Cm                  0 ]
			[ CFNa   :..:CFNa                0 ]
			[ CFK    :..:CFK                 0 ]
			[ Cai :../../CYTOPLASM:Ca  0 ]
			[ PKA    :../../CYTOPLASM:PKA     0 ]
			[ activation     :.:activation                0 ]
			[ inactivation     :.:inactivation                0 ]
			[ slowInactivation    :.:slowInactivation               0 ]
			[ dactivation     :.:dactivation                0 ]
			[ dinactivation     :.:dinactivation                0 ]
			[ dslowInactivation    :.:dslowInactivation               0 ]
			[ pOpen  :.:POpen                1 ]
			[ i      :.:i                    1 ]
			[ GX     :../../CYTOPLASM:ST_gene  0 ]
			[ cK     :.:cK                   1 ]
			[ cNa    :.:cNa                  1 ]
			[ I      :.:I                    1 ];

		PKA0            @PKA0;   #  (M)
		max             @Ist_max;
		permeabilityNa  0.007375;  # pA/pF/mM
		permeabilityK   0.0043125; # pA/pF/mM
	}

	Process ZeroVariableAsFluxProcess( activation ) 
	{
		Priority	16;

		VariableReferenceList
			[ y     :.:activation   1 ]
			[ dy     :.:dactivation   0 ];
	}

	Process ZeroVariableAsFluxProcess( inactivation ) 
	{
		Priority	16;

		VariableReferenceList
			[ y     :.:inactivation   1 ]
			[ dy     :.:dinactivation   0 ];
	}

	Process ZeroVariableAsFluxProcess( slowInactivation ) 
	{
		Priority	16;

		VariableReferenceList
			[ y     :.:slowInactivation   1 ]
			[ dy     :.:dslowInactivation   0 ];
	}


	Variable Variable( POpen )
	{
		Value 0.0;
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

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}
