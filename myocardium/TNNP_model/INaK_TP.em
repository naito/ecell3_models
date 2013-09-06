System System(/CELL/MEMBRANE/INaK)
{
	StepperID ODE;

	Variable Variable( I )
	{
		Value 0; #tmp
	}

	Variable Variable( i_NaK )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_NaK )
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Na_i :../../CYTOPLASM:Na_i 0 ]
			[ K_o :/:K_o 0 ]
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
	                [ i_NaK :.:I 1 ];
        
		P_NaK 1.362; #2.724 in 2006
		K_mk 1.0; #same as 2006
		K_mNa 40.0; #same as 2006
		GX 1.0;	
	
		Expression "GX * ((((P_NaK * K_o.Value)/(K_o.Value + K_mk)) * Na_i.Value)/(Na_i.Value + K_mNa))/(1.0 + 0.1245 * (exp(((-0.1*V.Value*F.Value)/(R.Value*T.Value))))+ 0.0353*(exp(((-V.Value*F.Value)/(R.Value*T.Value)))))";

#i_NaK = P_NaK * K_o / (K_o + K_mk) * Na_i / (Na_i + K_mNa) / (1 {unit: dimensionless} + 0.1245 {unit: dimensionless} * exp(-(0.1 {unit: dimensionless}) * V * F / (R * T)) + 0.0353 {unit: dimensionless} * exp(-(V) * F / (R * T)))
	}


	Process ExpressionFluxProcess( Na_i )
	{
		Priority 5;

		VariableReferenceList
			[ Na_i :../../CYTOPLASM:Na_i 1]
			[ V_c :../..:V_myo 0]
			[ i_NaK :.:I 0]
			[ F :/:F 0]
			[ Cm :..:Cm 0];

#d(Na_i)/d(time) = -(1 {unit: mA_pA}) * (i_Na + i_b_Na + 3 {unit: dimensionless} * i_NaK + 3 {unit: dimensionless} * i_NaCa) * Cm / (1 {unit: litre_micrometre3} * V_c * F);

		Expression "((-1.0 * 3.0 * i_NaK.Value)/( V_c.Value * F.Value)) * Cm.Value";

#		Expression "((-1.0 * (i_Na.Value + i_ha.Value + i_st.Value + i_b_Na.Value + 3.0 * i_NaK.Value + 3.0 * i_NaCa.Value))/( V_c.Value * F.Value)) * Cm.Value";

	}

	Process ExpressionFluxProcess( K_i )
        {
                Priority 5;

                VariableReferenceList
                        [ K_i :../../CYTOPLASM:K_i 1]
                        [ V_c :../..:V_myo 0]
                        [ i_NaK :.:I 0]
                        [ F :/:F 0]
                        [ Cm :..:Cm 0]
                        [ V :..:V 0 ];

#d(K_i)/d(time) = -(1 {unit: mA_pA}) * (i_K1 + i_to + i_Kr + i_Ks + i_p_K + i_Stim - 2 {unit: dimensionless} * i_NaK) * Cm / (1 {unit: litre_micrometre3} * V_c * F);

                Expression "(2.0 * i_NaK.Value )/( 1.0 * V_c.Value * F.Value)*Cm.Value";
        }	

	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_NaK :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_NaK.Value ";
	}
}
