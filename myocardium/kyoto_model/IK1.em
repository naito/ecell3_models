@{'''
Author Maria Takeuchi
Author Yasuhiro Naito
Version 0.2 2008-11-24 13:40:48 +0900

<IK1 name="IK1" initial_value="24.29288398159507" units="pA"
	className="org.simBio.bio.kuzumoto_et_al_2007.current.IK1">
	<KoDependencyIK1 name="permeabilityK" initial_value="2.5449343128168245" units="pA/mV"
		className="org.simBio.bio.kuzumoto_et_al_2007.function.KoDependency_IK1">
		<parameter name="amplitude" initial_value="2.6" />
		<parameter name="constant" initial_value="5.4" units="mM" />
		<parameter name="power" initial_value="0.6" units="dimension_less" />
		<parameter name="A" initial_value="-0.6" units="dimension_less" />
		<parameter name="B" initial_value="3.1" units="dimension_less" />
		<link name="Ko" initial_value="../../../K" />
	</KoDependencyIK1>
	<variable name="Pspm" initial_value="0.6373407661728812" />
	<parameter name="Phi" initial_value="0.9" />
	<link name="Vm" initial_value="../Vm" units="mV" />
	<link name="Cm" initial_value="../membrane capacitance" />
	<link name="Mg" initial_value="../Mg" />
	<link name="SPM" initial_value="../Spermine" />
	<link name="reversalPotential" initial_value="../K reversal potential" units="mV" />
	<link name="current" initial_value="../current" />
	<link name="currentK" initial_value="../currentK" />
</IK1>
'''}

System System(/CELL/MEMBRANE/IK1)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IK1_I;
	}

	Variable Variable( POpen )
	{
		Value 4.26E-01;
	}

	Variable Variable( vPspm )
	{
		Value -3.73433916526e-07;
	}

	Variable Variable( Pspm )
	{
		Value @IK1_Pspm;
	}

	Variable Variable( fracO )
	{
		Value 0.414217508395;
	}


	Process IK1AssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ Vm    :..:Vm                     0 ]
			[ EK    :..:EK                     0 ]
			[ Mg    :../../CYTOPLASM:Mg        0 ]
			[ SPM   :../../CYTOPLASM:Spermine  0 ]
			[ vPspm :.:vPspm                   1 ]
			[ Pspm  :.:Pspm                    0 ]
			[ fracO :.:fracO                   1 ]
			[ pOpen :.:POpen                   1 ]
			[ GX    :../../CYTOPLASM:Kir2_1    0 ]
			[ Ko    :/:K                       0 ]
			[ Cm    :..:Cm                     0 ]
			[ I     :.:I                       1 ];

		Phi        0.9;

		amplitude  2.6;
		constant   5.4;
		power      0.6;
		A         -0.6;
		B          3.1;
	}


	@{''' Vm.getValue() - EK.getValue() + 8000.0 * Mg.getMolarConc() の
	計算手続きの関係でExpressionProcessモデルとの間に若干の誤差が生じる。
	Priorityを上げても解消しないので、単純に計算順序の問題ではない？
	'''}

	Process ZeroVariableAsFluxProcess( Pspm ) 
	{
		Priority	15;

		VariableReferenceList
			[ Pspm   :.:Pspm   1 ]
			[ vPspm  :.:vPspm  0 ];
	}

	@setCurrents( [ 'I' ], [ 'K', 'I' ] )

}

