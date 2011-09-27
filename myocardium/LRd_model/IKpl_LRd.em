System System(/CELL/MEMBRANE/IKpl)
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
		Value @( Kpl_gene[SimulationMode]);
	}


	Process IKplAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ EK      :..:EK                   0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cK      :.:cK                    1 ]

			[ I       :.:I                     1 ];

		IKpl_GK_amp 0.00552;

		k0 1.0;
		k11 1.0;
		k12 -7.488;
		k13 -5.98;
		k2 1.0;
	}

	@setCurrents( [ 'I' ], [ 'K', 'cK' ] )
}


