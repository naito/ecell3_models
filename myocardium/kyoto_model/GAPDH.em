

	Variable Variable( VGAPDH_maxf )
	{
		Value 1265.0;
	}

	Variable Variable( VGAPDH_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process GAPDH_Process( V_GAPDH )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VGAPDH_maxf   :.:VGAPDH_maxf 0 ]
			[ GAP           :.:GAP        -1 ]
			[ NAD           :.:NAD        -1 ]
#			[ NAD           :.:NAD         0 ]
#			[ Pi            :.:PiTotal         -1 ]
			[ Pi            :.:Pi          -1 ]
			[ BPG13         :.:BPG13       1 ]
			[ GX            :.:VGAPDH_GX   0 ]
			[ NADH          :.:NADH        1 ];
#			[ NADH          :.:NADH        0 ];
	
			KGAPDH_GAP 0.0025;
			KGAPDH_NAD 0.09;
			KGAPDH_Pi 0.29;
			KGAPDH_13BPG 0.0008;
			KGAPDH_NADH 0.0033;
			KGAPDH_eq 0.089;
	}




