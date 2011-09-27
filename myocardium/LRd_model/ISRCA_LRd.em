System System(/CELL/CYTOPLASM/NSR/ISRCA)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( GX ){
		Value @( SERCA[SimulationMode]);
	}

	Process ISRCAAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	18;
		
		VariableReferenceList
			[Ca_i_f   :../..:Ca                  0]
			[Ca_nsr   :..:Ca                      0]	

			[ I        :.:I                   1 ]
			[ SR_f     :../..:SR_activity     0 ]
			[ GX       :.:GX                  0 ];

		I_up 0.00875;
		Km_up 0.00092;

	}	
}

