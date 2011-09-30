@{'''
Author Yasuhiro Naito

Version 0.1 2008-12-05 01:41:34 +0900

	<currentClamp name="pipette" className="org.simBio.bio.matsuoka_et_al_2003.current.pipette.CurrentClamp">
		<link name="elapsedTime" initial_value="/elapsedTime" />
		<link name="current" initial_value="../cell/current" />
		<link name="currentK" initial_value="../cell/currentK" />
		<parameter name="interval" initial_value="400.0" units="msec" />
		<parameter name="onset" initial_value="50.0" units="msec" />
		<parameter name="offset" initial_value="52.0" units="msec" />
		<parameter name="amplitude" initial_value="-8000.0" units="pA" />
	</currentClamp>
'''}

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
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ki  :/CELL/CYTOPLASM:K -1 ]
			[ i   :.:I                0 ]
			[ N_A :/:N_A              0 ]
			[ F   :/:F                0 ]
			[ z   :/:zK               0 ];
	}

	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentK', 'I' )

	@addToTotalCurrent( 'current', 'I' )

}

