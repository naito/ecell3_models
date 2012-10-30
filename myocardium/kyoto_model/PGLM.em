

	Variable Variable( VPGLM_maxf )
	{
		Value 480.0;
	}

	Variable Variable( VPGLM_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process PGLM_Process( V_PGLM )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VPGLM_maxf    :.:VPGLM_maxf  0 ]
			[ G1P           :.:G1P        -1 ]
			[ GX            :.:VPGLM_GX    0 ]
			[ G6P           :.:G6P         1 ];
	
			KPGLM_G1P 0.063;
			KPGLM_G6P 0.03;
			KPGLM_eq 16.62;
	}




