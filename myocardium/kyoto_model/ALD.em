

	Variable Variable( VALD_maxf )
	{
		Value 104.0;
	}

	Variable Variable( VALD_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process ALD_Process( V_ALD )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VALD_maxf     :.:VALD_maxf   0 ]
			[ FBP           :.:FBP        -1 ]
			[ GAP           :.:GAP         1 ]
			[ FBP           :.:FBP         0 ]
			[ GAP           :.:GAP         0 ]
			[ GX            :.:VALD_GX     0 ]
			[ DHAP          :.:DHAP        1 ];
	
			KALD_FBP 0.05;
			KALD_DHAP 2;
			KALD_GAP 1;
#			KALD_eq 1/9.5E-8;
			KALD_eq @(1.0/(9.5E-8));
#			KALD_eq 0.000095;
	}




