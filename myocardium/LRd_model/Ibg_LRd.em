System System(/CELL/MEMBRANE/Ibg)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}
	Variable Variable( cCa )
	{
		Value 0;
	}
	Variable Variable( cNa )
	{
		Value 0;
	}

	Process IbgAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ ECa      :..:ECa                 0 ]
			[ ENa      :..:ENa                 0 ]
		
			[ cCa      :.:cCa                    1 ]
			[ cNa      :.:cNa                    1 ]
			[ I       :.:I                     1 ];

		Ibg_Ca_amp 0.003016;
		Ibg_Na_amp 0.004;
	}

	@setCurrents( [ 'I' ], [ 'Ca', 'cCa' ], [ 'Na', 'cNa' ] )
}


