@{
Ito_permeabilityK = {
	"V" : 2.5e-4,
	"EMB" : 2.5e-4,
	"LAT" : 2.5e-4,
	"NEO" : 2.5e-4,
	"SAN" : 0,
	"A" : 2.5e-4,
#	"EMB" : 2.5e-6,
}
	
}


System System(/CELL/MEMBRANE/Ito)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value -1.0239203896445138E-9;
	}

	Variable Variable( vgate1 )
	{
		Value 1.86016106945e-08;
	}

	Variable Variable( vgate2 )
	{
		Value 9.26233516051e-09;
	}

	Variable Variable( gate1 )
	{
		Value 7.689524645841579E-4;
	}

	Variable Variable( gate2 )
	{
		Value 0.9999188299582759;
	}

	Variable Variable( POpen )
	{
		Value @( 7.689524645841579E-4 ** 3.0 * 0.9999188299582759 );
	}

	Process ZeroVariableAsFluxProcess( gate1 )
	{
		Priority	18;

		VariableReferenceList
			[ y  :.:gate1 1 ]
			[ dy  :.:vgate1 0 ];
	}

	Process ZeroVariableAsFluxProcess( gate2 )
	{
		Priority	18;

		VariableReferenceList
			[ y  :.:gate2 1 ]
			[ dy  :.:vgate2 0 ];
	}

	Variable Variable( GX ){
		Value @( Kv1_4[SimulationMode]);
	}

	Process ItoAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	19;

		VariableReferenceList
			[ Vm :..:Vm   0 ]
			[ dy1    :.:vgate1                0 ]
			[ dy2    :.:vgate2                0 ]
			[ y1    :.:gate1                0 ]
			[ y2    :.:gate2                0 ]
			[ pOpen :.:POpen                1 ]
			[ i     :.:i                    1 ]
			[ GX    :.:GX                   0 ]
			[ Cm    :..:Cm                  0 ]
			[ cK    :.:cK                   1 ]
			[ CFK   :..:CFK                 0 ]
			[ cNa   :.:cNa                  1 ]
			[ CFNa  :..:CFNa                0 ]
			[ I     :.:I                    1 ];

                permeabilityK  @( Ito_permeabilityK[SimulationMode] );	
                permeabilityNa   @( Ito_permeabilityK[SimulationMode] * 0.09 );
	}

	Variable Variable( i )
	{
		Value 2.5661147156641411;
	}

	Variable Variable( cK )
	{
		Value 3.32208686491e-12;
	}

	Variable Variable( cNa )
	{
		Value -1.02724247652e-09;
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}

@{'''
Author Hiromi KUMAMOTO
Author Yasuhiro Naito

Version 0.2 2008-11-27 06:12:24 +0900

simBio 1.0 className   "org.simBio.bio.terashima_et_al_2006.current.cf.Ito"
'''}
