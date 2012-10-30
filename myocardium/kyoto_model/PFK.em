

	Variable Variable( VPFK_maxf )
	{
		Value 56.0;
	}

	Variable Variable( VPFK_GX )
	{
		Value @( Lambeth[Glycolysis]);
#		Value 1.0;
	}

	Process PFK_Process( V_PFK )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VPFK_maxf     :.:VPFK_maxf   0 ]
			[ F6P           :.:F6P        -1 ]
			[ ATP           :.:ATPtotal        -1 ]
#			[ ATP           :.:ATP         0 ]
			[ AMP           :.:AMP         0 ]
			[ ADP           :.:ADPtotal         1 ]
#			[ ADP           :.:ADP         0 ]
			[ GX            :.:VPFK_GX     0 ]
			[ FBP           :.:FBP         1 ];
	
			KPFK_F6P 0.18;
			KPFK_F6P2 20;
			KPFK_ATP 0.08;
			KPFK_ATP2 0.25;
			KPFK_FBP 4.02;
			KPFK_FBP2 4.02;
			KPFK_ADP 2.7;
			KPFK_ADP2 2.7;
			KPFK_iATP 0.87;
			KPFK_aAMP 0.06;
			d_PFK 0.01;
			e_PFK 0.01;
			Lo_PFK 13.0;
			KPFK_eq 242.0;
	}




#		delta1 = (1 + F6P.getValue() / KPFK_F6P) * (1 + ATP.getValue() / KPFK_ATP)+ ADP.getValue() / KPFK_ADP + FBP.getValue() / KPFK_FBP * (1 + ADP.getValue() / KPFK_ADP);
#		delta2 = (1 + F6P.getValue() / KPFK_F6P2) * (1 + ATP.getValue() / KPFK_ATP2)+ ADP.getValue() / KPFK_ADP2 + FBP.getValue() / KPFK_FBP2 * (1 + ADP.getValue() / KPFK_ADP2);
#		alpha = KPFK_F6P * KPFK_ATP / KPFK_F6P2 / KPFK_ATP2;
#		L = Lo_PFK * Math.pow(((1+ATP.getValue()/KPFK_iATP) / (1 + d_PFK * ATP.getValue()/KPFK_iATP)) * ((1 + e_PFK * AMP.getValue()/KPFK_aAMP) / (1 + AMP.getValue()/KPFK_aAMP)), 4);

#		VPFK_maxr = VPFK_maxf * KPFK_ADP * KPFK_FBP / KPFK_ATP / KPFK_F6P / KPFK_eq;

#		PFK_a = (1 + alpha * L * Math.pow(delta2/delta1, 3))*(VPFK_maxf * ATP.getValue() * F6P.getValue() /(KPFK_ATP * KPFK_F6P) - VPFK_maxr * ADP.getValue() * FBP.getValue() /(KPFK_ADP * KPFK_FBP));
#		PFK_b = delta1 * (1 + L * Math.pow(delta2/delta1, 4));

#		V_PFK.setValue(PFK_a / PFK_b / unit);
