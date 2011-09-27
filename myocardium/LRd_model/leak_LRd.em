System System(/CELL/CYTOPLASM/NSR/leak)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( GX ){
		Value @( leak_act[SimulationMode]);
	}

	Process SRleakDiffusionAssignmentProcess( I ) 
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
			Ca_NSR_max 15.0;
	}	
}

