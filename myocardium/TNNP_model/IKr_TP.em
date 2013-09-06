System System(/CELL/MEMBRANE/IKr)
{
	StepperID ODE;
#I_Kr
	Variable Variable( alpha_xr1 )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_xr1 )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_xr1 )
	#alpha_xr1 = 450 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(45 {unit: millivolt}) - V) / 10 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_xr1 :.:alpha_xr1 1 ];

		Expression "450.0 / (1.0 + exp(((-45.0 - V.Value )/10.0)))";
	}

	Process ExpressionAssignmentProcess( beta_xr1 )
	#beta_xr1 = 6 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V + 30 {unit: millivolt}) / 11.5 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_xr1 :.:beta_xr1 1 ];

		Expression "6.0 /(1.0 + exp(((V.Value + 30.0)/11.5)))";
	}

	Variable Variable( xr1_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_xr1 )
	{
		Value	1.0;
	}

	Process ExpressionAssignmentProcess( xr1_inf )
	#xr1_inf = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(26 {unit: millivolt}) - V) / 7 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ xr1_inf :.:xr1_inf 1 ];
		
		Expression "1.0 / (1.0 + exp(((-26.0 - V.Value )/7.0)))";
	}

	Process ExpressionAssignmentProcess( tau_xr1 )
	#tau_xr1 = 1 {unit: millisecond} * alpha_xr1 * beta_xr1
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ alpha_xr1 :.:alpha_xr1 0 ]
			[ beta_xr1 :.:beta_xr1 0 ]
	                [ tau_xr1 :.:tau_xr1 1 ];

		Expression "alpha_xr1.Value * beta_xr1.Value";
	}

	Variable Variable( xr1 )
	{
#		Value 0; #0.00621 in 2006
		Value 0.00621;
	}

	Process ExpressionFluxProcess( xr1 )
	#d(Xr1)/d(time) = (xr1_inf - Xr1) / tau_xr1
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ t :/:t 0]
			[ xr1_inf :.:xr1_inf 0 ]
			[ tau_xr1 :.:tau_xr1 0 ]
			[ xr1 :.:xr1 1 ];
				
		Expression "(xr1_inf.Value - xr1.Value) / tau_xr1.Value";
	}

	Variable Variable( alpha_xr2 )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_xr2 )
	{
		Value	1.0; #tmp
	}


	Process ExpressionAssignmentProcess( alpha_xr2 )
	#alpha_xr2 = 3 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(60 {unit: millivolt}) - V) / 20 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_xr2 :.:alpha_xr2 1 ];

		Expression "3.0 /(1.0 + (exp(((-60.0 - V.Value)/20.0))))";
	}

	Process ExpressionAssignmentProcess( beta_xr2 )
	#beta_xr2 = 1.12 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V - 60 {unit: millivolt}) / 20 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_xr2 :.:beta_xr2 1 ];

		Expression "1.12/(1.0+(exp(((V.Value - 60.0)/20.0))))";
	}

	Variable Variable( xr2_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_xr2 )
	{
		Value	0.00621;
	}

	Process ExpressionAssignmentProcess( xr2_inf )
	#xr2_inf = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V + 88 {unit: millivolt}) / 24 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ xr2_inf :.:xr2_inf 1 ];

		Expression "1.0 / (1.0 + (exp(((V.Value + 88.0)/24.0))))";
	}

	Process ExpressionAssignmentProcess( tau_xr2 )
	#tau_xr2 = 1 {unit: millisecond} * alpha_xr2 * beta_xr2
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
			[ alpha_xr2 :.:alpha_xr2 0 ]
			[ beta_xr2 :.:beta_xr2 0 ]
	                [ tau_xr2 :.:tau_xr2 1 ];

		Expression " alpha_xr2.Value * beta_xr2.Value";
	}

	Variable Variable( xr2 )
	{
		Value 1.0; #0.4712 in 2006
#		Value 0.4712;
	}

	Process ExpressionFluxProcess( xr2 )
	#d(Xr2)/d(time) = (xr2_inf - Xr2) / tau_xr2
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ xr2_inf :.:xr2_inf 0 ]
			[ tau_xr2 :.:tau_xr2 0 ]
			[ xr2 :.:xr2 1 ];
				
		Expression "(xr2_inf.Value - xr2.Value) / tau_xr2.Value";	
	}

	Variable Variable( I )
#	Variable Variable( i_Kr )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_Kr )
	#i_Kr = g_Kr * root(K_o / 5.4 {unit: millimolar}) * Xr1 * Xr2 * (V - E_K);
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
			[ K_o :/:K_o 0 ]
			[ Xr1  :.:xr1 0 ]
			[ Xr2  :.:xr2 0 ]
	                [ i_Kr :.:I 1 ];
        
		g_Kr 0.096; #0.153 in 2006
#		g_Kr 0.153;
		GX 1.0;
		
		Expression "GX * g_Kr * pow((K_o.Value/5.4),0.5) * Xr1.Value * Xr2.Value * (V.Value - E_K.Value)";
	}

	Process ExpressionFluxProcess( K_i )
        {
                Priority 5;

                VariableReferenceList
                        [ K_i :../../CYTOPLASM:K_i 1]
                        [ V_c :../..:V_myo 0]
                        [ i_Kr :.:I 0]
                        [ F :/:F 0]
                        [ Cm :..:Cm 0]
                        [ V :..:V 0 ];

                Expression "(-1.0 * i_Kr.Value )/( 1.0 * V_c.Value * F.Value)*Cm.Value";
        }	

	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_Kr :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_Kr.Value ";
	}
}
