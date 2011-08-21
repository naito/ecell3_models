@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-30 02:27:23 +0900

	<backGroundCurrent name="ICab" initial_value="-0.7490997296750779">
		<parameter name="permeabilityCa" initial_value="3.03E-4" />
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

System System(/CELL/MEMBRANE/ICab)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @ICab_I;
	}

	Process ICabAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ I    :.:I                       1 ]
			[ GX   :../../CYTOPLASM:Cab_gene  0 ]
			[ CFCa :..:CFCa                   0 ]
			[ Cm   :..:Cm                     0 ];

		permeabilityCa   3.03E-4;
		pOpen            1.0;
	}

	@setCurrents( [ 'I' ], [ 'Ca', 'I' ] )

}


