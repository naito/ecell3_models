System System(/CELL/MEMBRANE/IKs)
{
	StepperID ODE;

	Variable Variable( alpha_xs )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_xs )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_xs )
	#alpha_xs = 1100 {unit: dimensionless} / root(1 {unit: dimensionless} + exp((-(10 {unit: millivolt}) - V) / 6 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_xs :.:alpha_xs 1 ];

		Expression "1100.0 / sqrt((1.0 + (exp(((-10.0 - V.Value)/6.0)))))";
#		Expression "1400.0 / sqrt((1.0 + (exp(((5.0 - V.Value)/6.0)))))";
	}

	Process ExpressionAssignmentProcess( beta_xs )
	#beta_xs = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V - 60 {unit: millivolt}) / 20 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_xs :.:beta_xs 1 ];

		Expression "1.0 / (1.0 + (exp(((V.Value - 60.0)/20.0))))";
#		Expression "1.0 / (1.0 + (exp(((V.Value - 35.0)/15.0))))";
	}

	Variable Variable( xs_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_xs )
	{
		Value 1.0; #tmp
	}

	Process ExpressionAssignmentProcess( xs_inf )
#	xs_inf = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(5 {unit: millivolt}) - V) / 14 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ xs_inf :.:xs_inf 1 ];
		
		Expression "1.0/(1.0 + (exp(((-5.0 - V.Value)/14.0))))";
	}

	Process ExpressionAssignmentProcess( tau_xs )
	#tau_xs = 1 {unit: millisecond} * alpha_xs * beta_xs
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
			[ alpha_xs :.:alpha_xs 0 ]
			[ beta_xs :.:beta_xs 0 ]
	                [ tau_xs :.:tau_xs 1 ];

		Expression "(alpha_xs.Value * beta_xs.Value)";
#		Expression "(alpha_xs.Value * beta_xs.Value) + 80.0";
	}

	Variable Variable( xs )
	{
		Value 0; #0.0095 in 2006
#		Value 0.0095;
	}

	Process ExpressionFluxProcess( xs )
#d(Xs)/d(time) = (xs_inf - Xs) / tau_xs
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ xs_inf :.:xs_inf 0 ]
			[ tau_xs :.:tau_xs 0 ]
			[ xs :.:xs 1 ];
				
		Expression "(xs_inf.Value - xs.Value) / tau_xs.Value";	
	}

	Variable Variable( I )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_Ks )
	#i_Ks = g_Ks * power(Xs, 2 {unit: dimensionless}) * (V - E_Ks)
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_Ks :..:E_Ks 0 ]
			[ Xs  :.:xs 0 ]
	                [ i_Ks :.:I 1 ];
        
		g_Ks 0.245; #0.392 in 2006
#		g_Ks 0.392;
		GX 1.0;		

		Expression "GX * g_Ks * (pow(Xs.Value,2.0)) * (V.Value - E_Ks.Value)";
	}

	Process ExpressionFluxProcess( K_i )
        {
                Priority 5;

                VariableReferenceList
                        [ K_i :../../CYTOPLASM:K_i 1]
                        [ V_c :../..:V_myo 0]
                        [ i_Ks :.:I 0]
                        [ F :/:F 0]
                        [ Cm :..:Cm 0]
                        [ V :..:V 0 ];

                Expression "(-1.0 * i_Ks.Value )/( 1.0 * V_c.Value * F.Value)*Cm.Value";
        }	

	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_Ks :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_Ks.Value ";
	}
}
