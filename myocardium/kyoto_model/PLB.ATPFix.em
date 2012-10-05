@{

PLB_Inhib1ptot = 1.0531940250521041e-7
PLB_PLBp = 0.008395558810715353e-3
PLB_Inhib1tot = 3.0E-7
PLB_PP1tot = 8.9E-7
PLB_PLB = 0.09760444118928464e-3
PLB_Inhib1 = 1.9468059749478957E-7
PLB_Inhib1p = 1.3402576051448544E-10
PLB_PP1_Inhib1p = 1.0518537674469592E-7
PLB_PP1 = 7.84814623255304E-7
PLB_PLBItot = 0.106e-3


}

@# System System(/CELL/CYTOPLASM/SRUP)
@# {
@#	StepperID	ODE;


	Variable Variable( Inhib1ptot )
	{
		Name "total phosphorylated inhibitor-1 of PP1";
		MolarConc @PLB_Inhib1ptot;
	}

	Variable Variable( PLBp )
	{
		Name "phosphorylated phospholamban";
		MolarConc @PLB_PLBp;
	}

	Variable Variable( PLB )
	{
		Name "phospholamban";
		MolarConc @PLB_PLB;
	}

	Variable Variable( PP1 )
	{
		MolarConc @PLB_PP1;
	}

	Variable Variable( Inhib1 )
	{
		MolarConc @PLB_Inhib1;
	}

	Variable Variable( Inhib1p )
	{
		MolarConc @PLB_Inhib1p;
	}

	Variable Variable( PP1_Inhib1p )
	{
		MolarConc @PLB_PP1_Inhib1p;
	}

	Variable Variable( dATP_PLB )
	{
		Value 1.2363598668;
	}

	Variable Variable( dATP_Inhib1 )
	{
		Value 0.463547103573;
	}

	Process PLBAssignmentProcess( PLB ) 
	{
		StepperID	PSV;
		Priority	6;

		VariableReferenceList
			[ plb  :.:PLB   1 ]
			[ plbp :.:PLBp  0 ]
			[ phos :.:PLBphos  1 ]
			[ pp1     :.:PP1          1 ]
			[ pp1_i1p :.:PP1_Inhib1p  0 ]
			[ i1   :.:Inhib1      1 ]
			[ i1pt :.:Inhib1ptot  0 ]
			[ i1p     :.:Inhib1p      1 ]
			[ pka  :..:PKA       0 ]
			[ dATP_PLB  :.:dATP_PLB       0 ]
			[ dATP_Inhib1   :.:dATP_Inhib1       0 ];

		PLBItot    @PLB_PLBItot;   # PLB total concentration (M)
		PP1tot     @PLB_PP1tot;     # total protein phosphatase 1 (M)
		Inhib1tot    @PLB_Inhib1tot;   # inhibitor-1 concentration (M)
		b_i1pt     @( PLB_PP1tot + 1.0E-9 );  #  b - i1pt (M) = PP1tot + KInhib1(=1.0E-9)

		KmPKA_PLB  0.021e-3;   # (M)
		kPKA_PLB   0.0324e+3;
		KmPP1_PLB  0.0070e-3;  # (M)
		kPP1_PLB   0.0085e+3;

		KmPKA_Inhib1  0.0010e-3;   # (M)
		kPKA_Inhib1   0.06e+3;
		VmaxPP2A_Inhib1  1.4E-5;     # total protein phosphatase 1 (M)
		KmPP2A_Inhib1    0.0010e-3;   # (M)
	}

	@# simBioの実装では、SRUPでのPLBp, Inhib1ptotの濃度変化とATP, ADPの濃度変化が同じ。容積比に応じて代えるのが本来と思われるので、ここではそうしている。変動が小さいので、シミュレーション結果には大きな変化はない。
	Process ZeroVariableAsFluxProcess( dATP_PLB ) 
	{
		Priority	5;

		VariableReferenceList
			[ dATP_PLB  :.:dATP_PLB       0 ]
			[ ATP  :..:ATPtotal  0 ]
			[ ADP  :..:ADPtotal  0 ]
			[ plbp :.:PLBp          1 ];
	}


	Process ZeroVariableAsFluxProcess( dATP_Inhib1 ) 
	{
		Priority	5;

		VariableReferenceList
			[ dATP_Inhib1   :.:dATP_Inhib1       0 ]
			[ i1pt :.:Inhib1ptot   1 ]
			[ ATP  :..:ATPtotal    0 ]
			[ ADP  :..:ADPtotal    0 ];
	}


@# }

@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-30 13:24:18 +0900

	<PLB name="PLB" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.PLB">
		<link name="PKA" initial_value="../../PKA" units="mM" />
		<link name="ATP" initial_value="../../ATPtotal" units="mM" />
		<link name="ADP" initial_value="../../ADPtotal" units="mM" />
		<variable name="Inhib1ptot" initial_value="1.0531940250521041E-4" units="mM" />
		<variable name="PLBp" initial_value="0.008395558810715353" units="mM" />
		<parameter name="Inhib1tot" initial_value="3.0E-4" units="mM" />
		<parameter name="PP1tot" initial_value="8.9E-4" units="mM" />
		<parameter name="KInhib1" initial_value="1.0E-6" units="mM" />
		<parameter name="PLB" initial_value="0.09760444118928464" units="mM" />
		<parameter name="Inhib1" initial_value="1.9468059749478957E-4" units="mM" />
		<parameter name="Inhib1p" initial_value="1.3402576051448544E-7" units="mM" />
		<parameter name="PP1_Inhib1p" initial_value="1.0518537674469592E-4" units="mM" />
		<parameter name="PP1" initial_value="7.84814623255304E-4" units="mM" />
		<parameter name="PLBItot" initial_value="0.106" />
		<parameter name="PLBphos" initial_value="0.07920338500674862" />
		<parameter name="PLBphosMAX" initial_value="0.09236678351643977" />
		<parameter name="kPKA_PLB" initial_value="0.0324" />
		<parameter name="KmPKA_PLB" initial_value="0.021" />
		<parameter name="kPP1_PLB" initial_value="0.0085" />
		<parameter name="KmPP1_PLB" initial_value="0.0070" />
		<parameter name="kPKA_Inhib1" initial_value="0.06" />
		<parameter name="KmPKA_Inhib1" initial_value="0.0010" />
		<parameter name="VmaxPP2A_Inhib1" initial_value="1.4E-5" />
		<parameter name="KmPP2A_Inhib1" initial_value="0.0010" />
	</PLB>
'''}
