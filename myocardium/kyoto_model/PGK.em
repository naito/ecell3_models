

	Variable Variable( VPGK_maxr )
	{
		Value 1120.0;
	}

	Variable Variable( VPGK_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process PGK_Process( V_PGK )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VPGK_maxr     :.:VPGK_maxr   0 ]
			[ BPG13         :.:BPG13      -1 ]
			[ ADP           :.:ADPtotal        -1 ]
#			[ ADP           :.:ADP         0 ]
			[ PG3           :.:PG3         1 ]
			[ GX            :.:VPGK_GX     0 ]
			[ ATP           :.:ATPtotal         1 ];
#			[ ATP           :.:ATP         0 ];
	
			KPGK_13BPG 0.002;
			KPGK_ADP 0.008;
			KPGK_3PG 1.2;
			KPGK_ATP 0.35;
			KPGK_eq 57109;
	}




