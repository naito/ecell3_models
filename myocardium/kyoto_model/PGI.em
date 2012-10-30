

	Variable Variable( VPGI_maxr )
	{
		Value 880.0;
	}

	Variable Variable( VPGI_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process PGI_Process( V_PGI )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VPGI_maxr     :.:VPGI_maxr   0 ]
			[ G6P           :.:G6P        -1 ]
			[ GX            :.:VPGI_GX     0 ]
			[ F6P           :.:F6P         1 ];
	
			KPGI_G6P 0.48;
			KPGI_F6P 0.03;
			KPGI_eq 16.62;
	}




