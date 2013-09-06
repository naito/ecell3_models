System System(/CELL/MEMBRANE/Ibg)
{
	StepperID ODE;
#I_b_Ca
	Variable Variable( i_b_Ca )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_b_Ca )
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_Ca :..:E_Ca 0 ]
	                [ i_b_Ca :.:i_b_Ca 1 ];
        
		g_bca 0.000592; #same as 2006
		GX 1.0;
		
		Expression "GX * g_bca * (V.Value - E_Ca.Value)";
	}

#I_pCa
	Variable Variable( i_pCa )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_pCa )
	#i_p_Ca = g_pCa * Ca_i / (Ca_i + K_pCa)
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 0 ]
	                [ i_pCa :.:i_pCa 1 ];
        
		g_pCa 0.825; #0.1238 in 2006
		K_pCa 0.0005; #same as 2006
		GX 1.0;
		
		Expression "GX * (g_pCa * Ca_i.Value)/(Ca_i.Value + K_pCa)";
	}

#I_b_Na
	Variable Variable( i_b_Na )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_b_Na )
#i_b_Na = g_bna * (V - E_Na);
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_Na :..:E_Na 0 ]
	                [ i_b_Na :.:i_b_Na 1 ]; #bugfix 130113
        
		g_bna 0.00029; #same as 2006
		GX 1.0;
		
		Expression "GX * g_bna * (V.Value - E_Na.Value)";
	}

#I_p_K
	Variable Variable( i_p_K )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_p_K )
#	i_p_K = g_pK * (V - E_K) / (1 {unit: dimensionless} + exp((25 {unit: millivolt} - V) / 5.98 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_K :..:E_K 0 ]
	                [ i_p_K :.:i_p_K 1 ];
        
		g_pK 0.0146; #same as 2006
		GX 1.0;
		
		Expression "GX * (g_pK * (V.Value - E_K.Value))/(1.0+(exp(((25.0 - V.Value)/5.98))))";
	}


	Variable Variable( I )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( I )
	{
	        StepperID   PSV;
		Priority 5; 

		VariableReferenceList
			[ i_b_Ca :.:i_b_Ca 0]
			[ i_pCa :.:i_pCa 0]
	                [ i_b_Na :.:i_b_Na 0 ] #bugfix 130113
	                [ i_p_K :.:i_p_K 0 ]
			[ I :.:I 1];

		Expression "i_b_Ca.Value + i_pCa.Value + i_b_Na.Value + i_p_K.Value";
	}

	Process ExpressionFluxProcess( Ca_i )
	{
		Priority 1; #may have to fix

		VariableReferenceList
			[ Ca_i_bufc :../../CYTOPLASM:Ca_i_bufc 0 ]
			[ i_b_Ca :.:i_b_Ca 0]
			[ i_pCa :.:i_pCa 0]
			[ V_sr :../..:V_sr 0 ]
			[ V_c :../..:V_myo 0 ]
			[ Cm :..:Cm 0 ]
			[ F :/:F 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 1 ];

		Expression "Ca_i_bufc.Value * (-1.0) * (i_b_Ca.Value + i_pCa.Value) / (2.0 * V_c.Value * F.Value) * Cm.Value";

	}


	Process ExpressionFluxProcess( K_i )
        {
                Priority 5;

                VariableReferenceList
                        [ K_i :../../CYTOPLASM:K_i 1]
                        [ V_c :../..:V_myo 0]
                        [ i_p_K :.:i_p_K 0]
                        [ F :/:F 0]
                        [ Cm :..:Cm 0]
                        [ V :..:V 0 ];

                Expression "(-1.0 * i_p_K.Value )/( 1.0 * V_c.Value * F.Value)*Cm.Value";
        }	


	Process ExpressionFluxProcess( Na_i )
	{
		Priority 5;

		VariableReferenceList
			[ Na_i :../../CYTOPLASM:Na_i 1]
			[ V_c :../..:V_myo 0]
			[ i_b_Na :.:i_b_Na 0]
			[ F :/:F 0]
			[ Cm :..:Cm 0];

		Expression "((-1.0 * i_b_Na.Value)/( V_c.Value * F.Value)) * Cm.Value";

#		Expression "((-1.0 * (i_Na.Value + i_ha.Value + i_st.Value + i_b_Na.Value + 3.0 * i_NaK.Value + 3.0 * i_NaCa.Value))/( V_c.Value * F.Value)) * Cm.Value";

	}


	Process ExpressionFluxProcess( V )
	{
		Priority 1;

		VariableReferenceList
	                [ i_bg :.:I 0 ]
	                [ V :..:V 1 ];

		Expression "(-1.0) * ( i_bg.Value )";
	}

}
