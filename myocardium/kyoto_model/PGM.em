

	Variable Variable( VPGM_maxf )
	{
		Value 1120.0;
	}

	Variable Variable( VPGM_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process PGM_Process( V_PGM )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VPGM_maxf     :.:VPGM_maxf   0 ]
			[ GX            :.:VPGM_GX     0 ]
			[ PG3           :.:PG3        -1 ]
			[ PG2           :.:PG2         1 ];
	
			KPGM_3PG 0.2;
			KPGM_2PG 0.014;
			KPGM_eq 0.18;
	}




