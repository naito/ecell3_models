System System(/CELL/MEMBRANE/IKNa)
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
		Value @( KNa[SimulationMode]);
	}


	Process IKNaAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	15;

		VariableReferenceList
			[ Vm      :..:Vm                   0 ]
			[ EK      :..:EK                   0 ]
			[ Nai      :/CELL/CYTOPLASM:Na   0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cK      :.:cK                    1 ]

			[ I       :.:I                     1 ];


		g_K_Na 0.12848;

		nKNa 2.8;
		kdKNa 66;

	}

	@setCurrents( [ 'I' ], [ 'K', 'cK' ] )
}


