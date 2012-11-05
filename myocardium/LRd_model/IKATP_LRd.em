System System(/CELL/MEMBRANE/IKATP)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( i )
	{
		Value 0;
	}

	Variable Variable( cK )
	{
		Value 0;
	}

	Variable Variable( GX )
	{
		Value @( Kir6_2[SimulationMode]);
	}


	Process IKATPAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ EK      :..:EK                   0 ]
			[ Ko       :/:K                    0 ]
			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cK      :.:cK                    1 ]

			[ I       :.:I                     1 ];

		IKATP_GK_amp 0.000193;

		nATP 0.24;
		nicholsarea 5.0e-5;
		ATPi 3;
		hATP 2;
		kATP 0.00025;		
	}

	@setCurrents( [ 'I' ], [ 'K', 'cK' ] )
}


