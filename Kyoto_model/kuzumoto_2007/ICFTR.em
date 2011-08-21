@{'''
Author Maria Takeuchi
AUthor Yasuhiro Naito

Version 0.2 2008-11-30 05:05:29 +0900

	<ICFTR name="ICFTR" initial_value="-0.28563318299805246"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.cf.ICFTR">
		<parameter name="permeabilityCl" initial_value="-0.0040" units="pA/mM" />
		<link name="PKA" initial_value="../PKA" units="mM" />
		<link name="ATP" initial_value="../ATPtotal" units="mM" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentCl" initial_value="../currentCl" />
	</ICFTR>
'''}

System System(/CELL/MEMBRANE/ICFTR)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.28563318299805246;
	}

	Variable Variable( _CPKA )
	{
		Value -0.28563318299805246;
	}

	Process ICFTRAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ PKA   :../../CYTOPLASM:PKA       0 ]
			[ I     :.:I                       1 ]
			[ CFCl  :..:CFCl                   0 ]
			[ ATP   :../../CYTOPLASM:ATPtotal  0 ]
			[ CPKA  :.:_CPKA                   0 ]
			[ Cm    :..:Cm                     0 ]
			[ Vm    :..:Vm                     0 ];

		permeabilityCl   -0.0040;
		
		alpha1  0.0756e+3;    #  rate constant for free ADP-bound closed state->ADP,ATP-bound closed state [/M/msec]
		alpha2  0.000109e+3;  #  rate constant for 2ADP-bound open state->ADP,ATP-bound open state [/M/msec]
		beta1   0.0065;       #  rate constant for ADP,ATP-bound closed state->ADP-bound closed state [/msec]
		beta2   0.00003;      #  rate constant for ADP,ATP-bound open state->2ADP-bound open state [/msec]
		k2      0.00385;      #  rate constant for channel closure (Pi and ADP release) [/msec]
	}

	@setCurrents( [ 'I' ], [ 'Cl', 'I' ] )

}


