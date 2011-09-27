System System( /CELL/CYTOPLASM/JSR/IRyR )
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( dcaiont )
	{
		Value	0;
		Name	"Rate of change of Ca(2+) entry";
	}
	Variable Variable( caiontold )
	{
		Value	0;
		Name	"Total Ca(2+) ion flow";
	}
	
	Variable Variable( tcirc )
	{
		Value	1000;
		Name	"t=0 at time of CICR (ms)";
	}

	Variable Variable( GX ){
		Value @( RyR1[SimulationMode]);
	}

	Process IRyRAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	18;

		VariableReferenceList
			[Vm	:../../../MEMBRANE:Vm        0]
			[ICaL   :../../../MEMBRANE/ICaL:cCa  0]
			[ICaT   :../../../MEMBRANE/ICaT:I    0]
			[INaCa  :../../../MEMBRANE/INaCa:I   0]
			[IPCa   :../../../MEMBRANE/IPCa:I    0]
			[Ibg   :../../../MEMBRANE/Ibg:cCa    0]

			[Ca_i_f   :../..:Ca                  0]
			[Ca_jsr  :..:Ca                      0]	

			[dcaiont :.:dcaiont                  1]
			[caiontold :.:caiontold              1]
			[tcirc :.:tcirc                      1]	
			
			[ I        :.:I                      1]
			[ SR_f     :../..:SR_activity        0]
			[ GX       :.:GX                     0];
	}

}

