

	Variable Variable( VEN_maxf )
	{
		Value 1920.0;
	}

	Variable Variable( VEN_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process EN_Process( V_EN )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VEN_maxf      :.:VEN_maxf    0 ]
			[ PG2           :.:PG2        -1 ]
			[ GX            :.:VEN_GX      0 ]
			[ PEP           :.:PEP         1 ];
	
			KEN_2PG 0.1;
			KEN_PEP 0.37;
			KEN_eq 0.49;
	}




