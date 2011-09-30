@{
IbNSC_I = -57.13324953461715

IbNSC_permeabilityNa = {
	"V" : 5.69E-4,
	"EMB" : 5.69E-4,
	"LAT" : 5.69E-4,
	"NEO" : 5.69E-4,
	"SAN" : 0.0023

}

#IbNSC_permeabilityNa = {
#	"V" : 7.544e-5,
#	"EMB" : 2.013e-3
#}

#		permeabilityNa  5.69E-4;
#		permeabilityK   @( 5.69E-4 * 0.4 );	# 2.276E-4
#                permeabilityNa  0.0000754356060606061;
#                permeabilityK   @( 0.0000754356060606061 * 0.4 );     # 2.276E-4
}

System System(/CELL/MEMBRANE/IbNSC)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IbNSC_I;
	}

	Variable Variable( i )
	{
		Value 211.2;
	}

	Variable Variable( cNa )
	{
		Value -57.1399019601;
	}

	Variable Variable( cK )
	{
		Value 0.00665242529949;
	}

	Variable Variable( GX ){
		Value @( bNSC_gene[SimulationMode]);
	}

	Process IbNSCAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ i    :.:i                        1 ]
			[ GX   :.:GX                       0 ]
			[ Cm   :..:Cm                      0 ]
			[ cNa  :.:cNa                      1 ]
			[ CFNa :..:CFNa                    0 ]
			[ cK   :.:cK                       1 ]
			[ CFK  :..:CFK                     0 ]
			[ I    :.:I                        1 ];

		permeabilityNa  @( IbNSC_permeabilityNa[SimulationMode] );
		permeabilityK   @( IbNSC_permeabilityNa[SimulationMode] * 0.4 );

		pOpen           1.0;
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}


@{'''
Author Maria Takeuchi
Author Yasuhiro Naito

Version 0.2 2008-11-30 01:54:55 +0900

	<backGroundCurrent name="IbNSC" initial_value="-57.13324953461715"
		className="org.simBio.bio.terashima_et_al_2006.current.cf.CfChannel">
		<parameter name="permeabilityNa" initial_value="5.69E-4" units="pA/mM" />
		<parameter name="permeabilityK" initial_value="2.276E-4" units="pA/mM" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCa" initial_value="../constantFieldCa" units="mM" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="../currentCl" />
	</backGroundCurrent>
'''}
