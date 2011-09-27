System System(/Pipette)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value 0.0;
	}

	@{'''
	NextOffsetの値に基づいてNextOnset, NextOffsetを更新するため、
	Priorityは NextOnset > NextOffset でなければならない。
	'''}
	Process CurrentClampAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ I :.:I  1 ]
			[ t :/:t  0 ];

		amplitude  @CurrentClamp_amplitude;  #  (pA)
		onset      @CurrentClamp_onset;  #  (pA)
		offset     @CurrentClamp_offset;  #  (pA)
		interval   @CurrentClamp_interval;  #  (pA)

#	currentApplied 0.0;
#	stimulusCycle 0.3;
#	stimulusOnset 0.01;
#	stimulusDuration 5.0e-4;
#	stimulusAmplitude -80.0;
#	EGTApip 0;

#	VariableReferenceList
#		[Vm  :.:Vm 0]
#		[Cm  :.:Cm 0]
#		[CmFactor  :.:Cm 0]
#		[K_e :../..:K 0]
#		[K_i :../CYTOPLASM:K -1];


	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ki  :/CELL/CYTOPLASM:K -1 ]			
			[ i   :.:I                0 ]
			[ A_cap :/:A_cap          0 ]
			[ N_A :/:N_A              0 ]
			[ F   :/:F                0 ]
			[ z   :/:zK               0 ];
	}

	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentK', 'I' )

	@addToTotalCurrent( 'current', 'I' )

}
