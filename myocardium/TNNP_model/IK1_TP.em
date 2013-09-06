System System(/CELL/MEMBRANE/IK1)
{
	StepperID ODE;


#I_K1
	Variable Variable( alpha_K1 )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_K1 )
	#alpha_K1 = 0.1 {unit: per_millisecond} / (1 {unit: dimensionless} + exp(0.06 {unit: per_millivolt} * (V - E_K - 200 {unit: millivolt})))
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
	                [ alpha_K1 :.:alpha_K1 1 ];

		Expression "0.1 / ( 1.0 + exp( 0.06 * (V.Value - E_K.Value - 200.0)))"; 
	}

	Variable Variable( beta_K1 )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( beta_K1 )
	#beta_K1 = (3 {unit: per_millisecond} * exp(0.0002 {unit: per_millivolt} * (V - E_K + 100 {unit: millivolt})) + 1 {unit: per_millisecond} * exp(0.1 {unit: per_millivolt} * (V - E_K - 10 {unit: millivolt}))) / (1 {unit: dimensionless} + exp(-(0.5 {unit: per_millivolt}) * (V - E_K)))
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
	                [ beta_K1 :.:beta_K1 1 ];

		Expression "( 3.0 * exp( 0.0002 * (V.Value - E_K.Value + 100.0))+(exp((0.1*((V.Value - E_K.Value) - 10.0)))))/(1.0 + (exp((-0.5 * (V.Value - E_K.Value)))))"; 
	}

	Variable Variable( xK1_inf )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( xK1_inf )
	#xK1_inf = alpha_K1 / (alpha_K1 + beta_K1)
	{
	        StepperID   PSV;
		Priority 15;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
	                [ alpha_K1 :.:alpha_K1 0 ]
	                [ beta_K1 :.:beta_K1 0 ]
	                [ xK1_inf :.:xK1_inf 1 ];

		Expression "alpha_K1.Value/(alpha_K1.Value + beta_K1.Value)";
	}

	Variable Variable( I )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_K1 )
	#i_K1 = g_K1 * xK1_inf * root(K_o / 5.4 {unit: millimolar}) * (V - E_K)
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
			[ K_o :/:K_o 0 ]
			[ xK1_inf  :.:xK1_inf 0 ]
	                [ i_K1 :.:I 1 ];
				        
		g_K1 5.405; #same as 2006
		GX 1.0;
		
		Expression "GX * g_K1 * xK1_inf.Value * pow((K_o.Value/5.4), 0.5 ) * (V.Value - E_K.Value)";
	}

	Process ExpressionFluxProcess( K_i )
        {
                Priority 5;

                VariableReferenceList
                        [ K_i :../../CYTOPLASM:K_i 1]
                        [ V_c :../..:V_myo 0]
                        [ i_K1 :.:I 0]
                        [ F :/:F 0]
                        [ Cm :..:Cm 0]
                        [ V :..:V 0 ];

                Expression "(-1.0 * i_K1.Value )/( 1.0 * V_c.Value * F.Value)*Cm.Value";
        }	

	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_K1 :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_K1.Value ";
	}
}
