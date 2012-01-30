@{
IKr_I = 0.09486894729445249
IKr_gate1 = 0.0011801183298905053
IKr_gate2 = 0.1621809652686286
IKr_gate3 = 0.969315526153146
IKr_POpen = 0.063568155284470809

IKr_amp = {
	"V" : 0.035,
	"EMB" : 0.035,
	"LAT" : 0.035,
	"NEO" : 0.035,
	"SAN" : 0.07,
	"A" : 0.07,
}# 	amplitude  0.00928030303030303;
}

System System(/CELL/MEMBRANE/IKr)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IKr_I;
	}

	Variable Variable( POpen )
	{
		Value @IKr_POpen;
	}

	Variable Variable( vgate1 )
	{
		Value -1.57812176308e-05;
	}

	Variable Variable( vgate2 )
	{
		Value -0.00131940244958;
	}

	Variable Variable( vgate3 )
	{
		Value 1.0760828538e-07;
	}

	Variable Variable( gate1 )
	{
		Value @IKr_gate1;
	}

	Variable Variable( gate2 )
	{
		Value @IKr_gate2;
	}

	Variable Variable( gate3 )
	{
		Value @IKr_gate3;
	}

	Variable Variable( GX ){
		Value @( erg1[SimulationMode]);
	}

	Process IKrAssignmentProcess( I )
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ dy1   :.:vgate1              1 ]
			[ dy2   :.:vgate2              1 ]
			[ dy3   :.:vgate3              1 ]
			[ y1    :.:gate1               0 ]
			[ y2    :.:gate2               0 ]
			[ y3    :.:gate3               0 ]
			[ pOpen :.:POpen               1 ]
			[ I     :.:I                   1 ]
			[ GX    :.:GX                  0 ]
			[ Ko    :/:K                   0 ]
			[ EK    :..:EK                 0 ]
			[ Vm    :..:Vm                 0 ]
			[ Cm    :..:Cm                 0 ];

                amplitude  @( IKr_amp[SimulationMode] );

		constant   5.4;
		power      0.2;
	}

	Process ZeroVariableAsFluxProcess( gate1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate1  1 ]
			[ dy  :.:vgate1 0 ];
	}

	Process ZeroVariableAsFluxProcess( gate2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate2  1 ]
			[ dy  :.:vgate2 0 ];
	}

	Process ZeroVariableAsFluxProcess( gate3 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate3  1 ]
			[ dy  :.:vgate3 0 ];
	}

	@setCurrents( [ 'I' ], [ 'K', 'I' ] )

}

# Author Yasuhiro NAITO
# Version 0.1 2008-08-20 06:55:43 +0900

#simBio 1.0 className	"org.simBio.bio.terashima_et_al_2006.current.potassium.IKr"
