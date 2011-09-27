System System(/CELL/CYTOPLASM/SEPARATOR)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( GX ){
		Value @( transfer_act[SimulationMode]);
	}

	Process SRDiffusionAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	18;
		
		VariableReferenceList
			[Ca_jsr   :../JSR:Ca              0]
			[Ca_nsr   :../NSR:Ca              0]	

			[ I        :.:I                   1 ]
			[ SR_f     :..:SR_activity     0 ]
			[ GX       :.:GX                  0 ];
	

			Itr_tau 180.0;
	}	
}

