

	Variable Variable( VTPI_maxf )
	{
		Value 12000.0;
	}

	Variable Variable( VTPI_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process TPI_Process( V_TPI )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VTPI_maxf     :.:VTPI_maxf   0 ]
			[ GX            :.:VTPI_GX     0 ]
			[ GAP           :.:GAP         -1 ]
			[ DHAP          :.:DHAP        1 ];
	
			KTPI_GAP 0.32;
			KTPI_DHAP 0.61;
			KTPI_eq 0.052;
	}




