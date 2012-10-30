

	Variable Variable( VLDH_maxf )
	{
		Value 1120.0;
	}

	Variable Variable( VLDH_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process LDH_Process( V_LDH )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VLDH_maxf     :.:VLDH_maxf   0 ]
			[ PYR           :.:PYR        -1 ]
#			[ NADH          :.:NADH       -1 ]
			[ NADH          :.:NADH        0 ]
			[ LAC           :.:LAC         1 ]
			[ GX            :.:VLDH_GX     0 ]
			[ NAD           :.:NAD         1 ];
#			[ NAD           :.:NAD         0 ];
	
			KLDH_PYR 0.335;
			KLDH_NADH 0.002;
			KLDH_LAC 17;
			KLDH_NAD 0.849;
			KLDH_eq 16198;
	}




