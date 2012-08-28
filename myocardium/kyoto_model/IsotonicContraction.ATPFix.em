
System System( /CELL/CYTOPLASM/Contraction )
{
	StepperID	ODE;

	Variable Variable( X )
	{
		Name "half length of thick filament + thin filament length over the non-overlap zone";

		@# halfSarcomereLengthと完全に同じ値を初期値にすると、Secant Methodの求根過程でゼロ除算が発生する
		Value @IsotonicContraction_X;    # units="um"
		# Value 0.9568;    # units="um"
	}

	Variable Variable( dXdt )
	{
		Name "derivative value of inextensibleLength";
		Value @IsotonicContraction_dXdt;    # units="um/ms" ?
	}

	Variable Variable( qb )
	{
		Name  "Q1"
		Value 11682.9802486;
	}

	Variable Variable( qa1 )
	{
		Name  "1st term of Q2"
		Value 27934.9978915;
	}

	Variable Variable( ATPfactor )
	{
		Value 0.99999703717561594;
	}

	Variable Variable( qa2 )
	{
		Name  "2nd term of Q2"
		Value 3020.27474759;
	}

	Variable Variable( qr )
	{
		Name  "Q3"
		Value 25998.2753404;
	}

	Variable Variable( qd )
	{
		Name  "1st term of Q4"
		Value 26291.9677744;
	}

	Variable Variable( cbFactor )
	{
		Value 2.8495959312890017e-12;
	}

	Variable Variable( qd1 )
	{
		Name  "2nd term of Q4"
		Value 0.00499476562636;
	}

	Variable Variable( qd2 )
	{
		Name  "Q5"
		Value 0.0176544874505;
	}

	Process IsotonicContractionAssignmentProcess( IsotonicContractionAssignment ) 
	{
		Name "Isotonic Contraction Assignment";

		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ L         :..:halfSarcomereLength  1 ]
			[ X         :.:X                     0 ]
			[ CBL       :..:crossBridgeLength    1 ]
			#[ h        :..:crossBridgeLength    0 ]
			[ dXdt      :.:dXdt                  1 ]
			[ forceExt  :/:forceExt              0 ]
			[ TCaCB     :..:TCaCB                0 ]
			[ TCB       :..:TCB                  0 ]
			[ qb        :.:qb                    1 ]    # Q1
			[ T         :..:T                    1 ]
			[ Tt        :..:Tt                   0 ]
			[ TCa       :..:TCa                  0 ]
			[ Ca        :..:Ca                   0 ]
			[ CaTotal   :..:CaTotal              0 ]
			[ qa1       :.:qa1                   1 ]
			[ Pi        :..:Pi                   0 ]
			[ ATPfactor :.:ATPfactor             0 ]
			[ ATP       :..:ATPtotal             0 ]
			[ qa2       :.:qa2                   1 ]
			[ ADP       :..:ADPtotal             0 ]
			[ qr        :.:qr                    1 ]
			[ qd        :.:qd                    1 ]
			[ cbFactor  :.:cbFactor              0 ]
			[ qd1       :.:qd1                   1 ]
			[ qd2       :.:qd2                   1 ];

		B          1.2;                    # turn over rate of cross bridge sliding 1200/s=1200/1000ms=1.2/ms
		hc         0.005;                  # lower limit of cross bridge lendgth 0.005 um

		A          3.06e+6;                # force of cross bridge and parallel elastic comp.
		L0         0.97;
		K          140000;
		Kl         200;

		Y1         @( 39 * 0.8 * 1000.0);
		Z1         @( 0.03 * 2.0 );

		Y2         @( 0.0013 * 3.0 );
		La         1.17;
		KmPi       1.83e-3;                #  (M)

		KmATP      0.1e-3;                 #  (M)

		Z2         @( 0.0013 * 3.0 );

		Y3         @( 0.03 * 2.0 );
		Z3         @( 1560.0 * 0.8 * 1000.0 );

		Y4         @( 0.04 * 3.0 );

		dXdtFactor 50.0;

		Yd         8000.0;
	}

	Process ZeroVariableAsFluxProcess( crossBridgeLength_X ) 
	{
		Name "Cross Bridge Length";

		Priority	15;

		VariableReferenceList
			[ dXdt :.:dXdt  0 ]
			[ X    :.:X     1 ];
	}


	Process ZeroVariableAsFluxProcess( qb ) 
	{
		Priority	15;

		VariableReferenceList
			[ qb       :.:qb        0 ]
			[ TCa     :..:TCa       1 ]
			# [ Ca      :..:Ca       -1 ]    @{''' 物質収支で代数計算 '''}
			[ CaTotal :..:CaTotal  -1 ];
	}

	Process ZeroVariableAsFluxProcess( qa1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qa1   :.:qa1     0 ]
			[ TCa   :..:TCa   -1 ]
			[ TCaCB :..:TCaCB  1 ];
	}

	Process ZeroVariableAsFluxProcess( qa2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qa2   :.:qa2         0 ]
			[ TCa   :..:TCa        1 ]
			[ TCaCB :..:TCaCB     -1 ]
			[ ATP   :..:ATPtotal   0 ]
			[ ADP   :..:ADPtotal   0 ];
			#[ Pi   :..:Pi         0 ];
	}

	Process ZeroVariableAsFluxProcess( qr ) 
	{
		Priority	15;

		VariableReferenceList
			[ qr      :.:qr        0 ]
			[ TCaCB   :..:TCaCB   -1 ]
			[ TCB     :..:TCB      1 ]
			#[ Ca      :..:Ca       1 ]    @{''' 物質収支で代数計算 '''}
			[ CaTotal :..:CaTotal  1 ];
	}

	Process ZeroVariableAsFluxProcess( qd ) 
	{
		Priority	15;

		VariableReferenceList
			[ qd  :.:qd          0 ]
			[ TCB :..:TCB       -1 ]
			[ ATP :..:ATPtotal   0 ]
			[ ADP :..:ADPtotal   0 ];
			#[ Pi :..:Pi         0 ];
	}

	Process ZeroVariableAsFluxProcess( qd1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qd1 :.:qd1         0 ]
			[ TCB :..:TCB       -1 ]
			[ ATP :..:ATPtotal   0 ]
			[ ADP :..:ADPtotal   0 ];
			#[ Pi :..:Pi         0 ];
	}

	Process ZeroVariableAsFluxProcess( qd2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qd2     :.:qd2         0 ]
			[ TCaCB   :..:TCaCB     -1 ]
			#[ Ca      :..:Ca         1 ]    @{''' 物質収支で代数計算 '''}
			[ CaTotal :..:CaTotal    1 ]
			[ ATP     :..:ATPtotal   0 ]
			[ ADP     :..:ADPtotal   0 ];
			#[ Pi     :..:Pi         0 ];
	}

}

@{'''
<IsotonicContraction name="isotonicContraction"
	className="org.simBio.bio.kuzumoto_et_al_2007.contraction.IsotonicContraction">
	<link name="L" initial_value="../halfSarcomereLength" />
	<ForceEquilibrium name="forceEquilibrium" initial_value="8.060219158778636E-14"
		className="org.simBio.bio.kuzumoto_et_al_2007.contraction.ForceEquilibrium">
		<parameter name="forceExt" initial_value="0.0" />
		<CrossbridgeForce name="Fb" initial_value="1.6473391396703374"
			className="org.simBio.bio.kuzumoto_et_al_2007.contraction.CrossBridgeForce">
			<link name="X" initial_value="../../../crossBridgeLength/X" />
			<link name="TCaCB" initial_value="../../../troponin/TCaCB" />
			<link name="TCB" initial_value="../../../troponin/TCB" />
		</CrossbridgeForce>
		<ParallelElementForce name="Fp" initial_value="-1.6473391396703203"
			className="org.simBio.bio.kuzumoto_et_al_2007.contraction.ParallelElementForce" />
	</ForceEquilibrium>
</IsotonicContraction>
<CrossBridgeLength name="crossBridgeLength" initial_value="0.005009947075106269"
	className="org.simBio.bio.kuzumoto_et_al_2007.contraction.CrossBridgeLength">
	<variable name="X" initial_value="0.9567533837638065" units="um" />
	<parameter name="dXdt" initial_value="1.1936490127522834E-5" units="" />
	<link name="L" initial_value="../halfSarcomereLength" units="um" />
</CrossBridgeLength>
<Troponin name="troponin" className="org.simBio.bio.kuzumoto_et_al_2007.contraction.Troponinmit">
	<parameter name="KmPi" initial_value="1.83" units="mM" />
	<parameter name="KmADP" initial_value="0.1" units="mM" />
	<parameter name="T" initial_value="0.0672942681114029" />
	<variable name="TCa" initial_value="0.0025982764372710202" />
	<variable name="TCaCB" initial_value="8.375865245910036E-5" />
	<variable name="TCB" initial_value="2.369679886697068E-5" />
	<link name="L" initial_value="../halfSarcomereLength" />
	<link name="dXdt" initial_value="../crossBridgeLength/dXdt" />
	<link name="Ca" initial_value="../Ca" units="mM" />
	<link name="CaTotal" initial_value="../CaTotal" units="mM" />
	<link name="ATP" initial_value="../ATPtotal" units="mM" />
	<link name="ADP" initial_value="../ADPtotal" units="mM" />
	<link name="Pi" initial_value="../Pi" units="mM" />
	<parameter name="dATP" initial_value="-4.43837473140563E-5" units="mM/ms" />
</Troponin>
'''}

