System System(/CELL/MEMBRANE/IPCa)
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

	Variable Variable( cCa )
	{
		Value 0;
	}

	Variable Variable( GX )
	{
		Value @( PCaPump_gene[SimulationMode]);
	}

	Process IPCaAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]

			[ Cae      :/:Ca                   0 ]
			[ Cai     :../../CYTOPLASM:Ca      0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cCa      :.:cCa                    1 ]

			[ I       :.:I                     1 ];
	
		  	I_pCa 1.15;
			IPCa_Km_pCa 0.0005;

			PCa_KO 1.0;			
	}

	@setCurrents( [ 'I' ], [ 'Ca', 'cCa' ] )
}



