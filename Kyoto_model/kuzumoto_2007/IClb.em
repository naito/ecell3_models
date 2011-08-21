@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-30 02:27:23 +0900

	<backGroundCurrent name="IClb" initial_value="-0.5756468538907918">
		<parameter name="permeabilityCl" initial_value="-1.82E-5" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCa" initial_value="../constantFieldCa" units="mM" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="../currentCl" />
	</backGroundCurrent>
'''}

System System(/CELL/MEMBRANE/IClb)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IClb_I;
	}

	Process IClbAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ I     :.:I                       1 ]
			[ GX    :../../CYTOPLASM:Clb_gene  0 ]
			[ CFCl  :..:CFCl                   0 ]
			[ Cm    :..:Cm                     0 ];

		permeabilityCl  -1.82E-5;
		pOpen            1.0;
	}

	@setCurrents( [ 'I' ], [ 'Cl', 'I' ] )

}


