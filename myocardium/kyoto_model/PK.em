

	Variable Variable( VPK_maxf )
	{
		Value 1440.0;
	}

	Variable Variable( VPK_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process PK_Process( V_PK )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VPK_maxf      :.:VPK_maxf    0 ]
			[ GX            :.:VPK_GX      0 ]
			[ PEP           :.:PEP        -1 ]
			[ ADP           :.:ADPtotal        -1 ]
#			[ ADP           :.:ADP         0 ]
			[ PYR           :.:PYR         1 ]
			[ ATP           :.:ATPtotal         1 ];
#			[ ATP           :.:ATP         0 ];
	
			KPK_PEP 0.08;
			KPK_ADP 0.3;
			KPK_PYR 7.05;
			KPK_ATP 1.13;
			KPK_eq 10304.0;
	}




