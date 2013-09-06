System System(/CELL/MEMBRANE/Ito)
{
	StepperID ODE;

	Variable Variable( I )
	{
		Value 0; #tmp
	}

	Variable Variable( s_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_s )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( s_inf )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ s_inf :.:s_inf 1 ];
	
		Expression "(1.0/(1.0 + exp((V.Value + 20.0)/5.0)))"; #s Gate	s_inf
	}

	Process ExpressionAssignmentProcess( tau_s )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ tau_s :.:tau_s 1 ];

		Expression "85.0 * exp(-1.0 * pow((V.Value + 45.00),2.0)/320.0 )+ 5.0/(1.0 + exp((V.Value - 20.0)/5.0))+ 3.0";
	}

	Variable Variable( sGt )
	{
		Value	1.0; #0.999998 in 2006
#		Value	0.999998;
	}

	Process ExpressionFluxProcess( sGt )
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ s_inf :.:s_inf 0 ]
			[ tau_s :.:tau_s 0 ]
			[ sGt :.:sGt 1 ];
				
		Expression "(s_inf.Value - sGt.Value) / tau_s.Value";	
	}

	Variable Variable( r_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_r )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( r_inf )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ r_inf :.:r_inf 1 ];
	
		Expression "1.0 / (1.0 + (exp(((20.0 - V.Value)/6.0))))";
	}

	Process ExpressionAssignmentProcess( tau_r )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ tau_r :.:tau_r 1 ];

		Expression "9.5 * (exp((-1.0 * (pow((V.Value + 40.0),2.0))/1800.0)))+ 0.8";
	}

	Variable Variable( rGt )
	{
		Value 0; #2.42e-8 in 2006
#		Value 2.42e-8;
	}

	Process ExpressionFluxProcess( rGt )
	#d(r)/d(time) = (r_inf - r) / tau_r
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ r_inf :.:r_inf 0 ]
			[ tau_r :.:tau_r 0 ]
			[ rGt :.:rGt 1 ];
				
		Expression "(r_inf.Value - rGt.Value) / tau_r.Value";	
	}

	Variable Variable( i_to )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_to )
	#i_to = g_to * r * s * (V - E_K);
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
			[ rGt  :.:rGt 0 ]
			[ sGt  :.:sGt 0 ]
	                [ i_to :.:I 1 ];
        
		g_to 0.294; #same as 2006
		GX 1.0;		

		Expression "GX * g_to * rGt.Value * sGt.Value * ( V.Value - E_K.Value )";
	}

	Process ExpressionFluxProcess( K_i )
        {
                Priority 5;

                VariableReferenceList
                        [ K_i :../../CYTOPLASM:K_i 1]
                        [ V_c :../..:V_myo 0]
                        [ i_to :.:I 0]
                        [ F :/:F 0]
                        [ Cm :..:Cm 0]
                        [ V :..:V 0 ];

#d(K_i)/d(time) = -(1 {unit: mA_pA}) * (i_K1 + i_to + i_Kr + i_Ks + i_p_K + i_Stim - 2 {unit: dimensionless} * i_NaK) * Cm / (1 {unit: litre_micrometre3} * V_c * F);

                Expression "(-1.0 * i_to.Value )/( 1.0 * V_c.Value * F.Value)*Cm.Value";
        }	

	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_to :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_to.Value ";
	}
}
