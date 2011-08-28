@{'''
Author Yasuhiro Naito

Version 0.2 2008-11-30 04:57:04 +0900

	<IVRCC name="IVRCC" initial_value="-3.3097598013710625"
		className="org.simBio.bio.terashima_et_al_2006.current.cf.IVRCC">
		<parameter name="halfMaxVm" initial_value="-100.0" units="mV" />
		<parameter name="slope" initial_value="50.0" units="/mV" />
		<parameter name="halfMaxVt" initial_value="21700.0" units="um^3" />
		<parameter name="compliance" initial_value="0.0010" units="um^-3" />
		<parameter name="maxFactor" initial_value="200.0" units="dimension_less" />
		<parameter name="permeabilityCl" initial_value="-2.0E-5" units="pA/pF/mM" />
		<link name="Vt" initial_value="../Vt" units="um^3" />
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" units="pF" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCl" initial_value="../currentCl" />
	</IVRCC>
'''}

System System(/CELL/MEMBRANE/IVRCC)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -3.3097598013710625;
	}

	Process IVRCCAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ I     :.:I                 1 ]
			[ CFCl  :..:CFCl             0 ]
			[ Cm    :..:Cm               0 ]
			[ Vt    :../../CYTOPLASM:Vt  0 ]
			[ Vm    :..:Vm               0 ];

		maxFactor  200.0;
		compliance  0.001;
		halfMaxVt  21700.0;
		slope  50.0;
		halfMaxVm  -100.0;
		permeabilityNa   0.0;
		permeabilityK    0.0;
		permeabilityCa   0.0;
		permeabilityCl   -2.0E-5;
	}

	@setCurrents( [ 'I' ], [ 'Cl', 'I' ] )

}


