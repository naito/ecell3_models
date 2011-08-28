@{'''
Author Aoi Miyabe
Author Yasuhiro Naito

Version 0.2 2008-11-24 12:18:55 +0900

simBio 1.0 className	"org.simBio.bio.terashima_et_al_2006.current.cf.ICaT"
'''}

System System(/CELL/MEMBRANE/ICaT)
{
	StepperID	ODE;




	Variable Variable( I )
	{
		Value @ICaT_I;
	}

	Variable Variable( POpen )
	{
		Value 1.285699651743902E-5;
	}

	Variable Variable( activation )
	{
		Value @ICaT_activation;
	}

	Variable Variable( inactivation )
	{
		Value @ICaT_inactivation;
	}

	Variable Variable( v_activation )
	{
		Value -1.42658286626e-10;
	}

	Variable Variable( v_inactivation )
	{
		Value 7.31376837008e-05;
	}

	Process ICaTAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ dy1   :.:v_activation          0 ]
			[ dy2   :.:v_inactivation        0 ]
			[ v     :..:Vm                   0 ]
			[ y1    :.:activation            0 ]
			[ y2    :.:inactivation          0 ]
			[ pOpen :.:POpen                 1 ]
			[ GX    :../../CYTOPLASM:Cav3_1  0 ]
			[ Cm    :..:Cm                   0 ]
			[ CFCa  :..:CFCa                 0 ]
			[ I     :.:I                     1 ];

		permeabilityCa    4.636;  # pA/mM
	}

	Process ZeroVariableAsFluxProcess( activation ) 
	{
		Priority	15;

		VariableReferenceList
			[ y :.:activation    1 ]
			[ v :.:v_activation  0 ];
	}

	Process ZeroVariableAsFluxProcess( inactivation ) 
	{
		Priority	15;

		VariableReferenceList
			[ y :.:inactivation    1 ]
			[ v :.:v_inactivation  0 ];
	}

	@setCurrents( [ 'I' ], [ 'Ca', 'I' ] )

}
