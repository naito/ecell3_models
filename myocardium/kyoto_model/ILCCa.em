@{
ILCCa_I = -0.18270158054719257

ILCCa_permeabilityNa = { 
	"V" : 0.0075,
	"EMB" : 0.0075,
	"LAT" : 0.0075,
	"NEO" : 0.0075,
	"SAN" : 0.03,
#	"EMB" : 0.000994318181818182,
}
}


System System(/CELL/MEMBRANE/ILCCa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @ILCCa_I;
	}

	Variable Variable( i )
	{
		Value 0.0512476734476;
	}

	Variable Variable( cNa )
	{
		Value -0.182754772907;
	}

	Variable Variable( cK )
	{
		Value 5.31923591564e-05;
	}

	Variable Variable( GX ){
		Value @( LCCa_gene[SimulationMode]);
	}

	Process ILCCaAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ Cai  :../../CYTOPLASM:Ca         0 ]
			[ GX   :.:GX                       0 ]
			[ i    :.:i                        1 ]
			[ Cm   :..:Cm                      0 ]
			[ cNa  :.:cNa                      1 ]
			[ CFNa :..:CFNa                    0 ]
			[ cK   :.:cK                       1 ]
			[ CFK  :..:CFK                     0 ]
			[ I    :.:I                        1 ];

                permeabilityNa  @( ILCCa_permeabilityNa[SimulationMode] );
                permeabilityK   @( ILCCa_permeabilityNa[SimulationMode] * 1.0 );
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}

@{'''
Author Maria Takeuchi
Author Yasuhiro Naito

Version 0.2 2008-11-30 01:36:19 +0900

	<ILCCa name="ILCCa" initial_value="-0.18270158054719257" units="pA"
		className="org.simBio.bio.terashima_et_al_2006.current.cf.ILCCa">
		<link name="Cai" initial_value="../Ca" units="mV" />
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCa" initial_value="../constantFieldCa" units="mM" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="../currentCl" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<parameter name="permeabilityNa" initial_value="0.0075" units="pA/mM" />
		<parameter name="relativePK" initial_value="1.0" units="/PNa" />
	</ILCCa>
'''}
