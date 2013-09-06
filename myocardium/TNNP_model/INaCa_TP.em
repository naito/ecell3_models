System System(/CELL/MEMBRANE/INaCa)
{
	StepperID ODE;

	Variable Variable( I )
	{
		Value 0; #tmp
	}

	Variable Variable( i_NaCa )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_NaCa )
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 0 ]
			[ Na_i :../../CYTOPLASM:Na_i 0 ]
			[ Ca_o :/:Ca_o 0 ]
			[ Na_o :/:Na_o 0 ]
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
	                [ i_NaCa :.:I 1 ];
        
		alpha 2.5; #same as 2006
		gamma 0.35; #same as 2006
		K_NaCa 1000.0; #same as 2006
		Km_Ca 1.38; #same as 2006
		Km_Nai 87.5; #same as 2006
		K_sat 0.1; #same as 2006
		GX 1.0;

		Expression "GX * K_NaCa * (exp(gamma * V.Value * F.Value / (R.Value * T.Value)) * pow(Na_i.Value, 3.0) * Ca_o.Value - exp((gamma - 1.0) * V.Value * F.Value / (R.Value * T.Value)) * pow(Na_o.Value, 3.0) * Ca_i.Value * alpha) / ((pow(Km_Nai, 3.0 + pow(Na_o.Value, 3.0)) * (Km_Ca + Ca_o.Value) * (1.0 + K_sat * exp((gamma - 1.0) * V.Value * F.Value / (R.Value * T.Value)))))";
		
		#i_NaCa = K_NaCa * (exp(gamma * V * F / (R * T)) * power(Na_i, 3 {unit: dimensionless}) * Ca_o - exp((gamma - 1 {unit: dimensionless}) * V * F / (R * T)) * power(Na_o, 3 {unit: dimensionless}) * Ca_i * alpha) / ((power(Km_Nai, 3 {unit: dimensionless}) + power(Na_o, 3 {unit: dimensionless})) * (Km_Ca + Ca_o) * (1 {unit: dimensionless} + K_sat * exp((gamma - 1 {unit: dimensionless}) * V * F / (R * T))));

	}


	Process ExpressionFluxProcess( Na_i )
	{
		Priority 5;

		VariableReferenceList
			[ Na_i :../../CYTOPLASM:Na_i 1]
			[ V_c :../..:V_myo 0]
			[ i_NaCa :.:I 0]
			[ F :/:F 0]
			[ Cm :..:Cm 0];

#d(Na_i)/d(time) = -(1 {unit: mA_pA}) * (i_Na + i_b_Na + 3 {unit: dimensionless} * i_NaK + 3 {unit: dimensionless} * i_NaCa) * Cm / (1 {unit: litre_micrometre3} * V_c * F);

		Expression "((-1.0 * 3.0 * i_NaCa.Value)/( V_c.Value * F.Value)) * Cm.Value";

#		Expression "((-1.0 * (i_Na.Value + i_ha.Value + i_st.Value + i_b_Na.Value + 3.0 * i_NaK.Value + 3.0 * i_NaCa.Value))/( V_c.Value * F.Value)) * Cm.Value";

	}


	Process ExpressionFluxProcess( Ca_i )
	{
		Priority 1; #may have to fix

		VariableReferenceList
			[ Ca_i_bufc :../../CYTOPLASM:Ca_i_bufc 0 ]
			[ i_NaCa :.:I 0 ]
			[ V_sr :../..:V_sr 0 ]
			[ V_ss :../../CYTOPLASM:V_ss 0 ]
			[ V_c :../..:V_myo 0 ]
			[ Cm :..:Cm 0 ]
			[ F :/:F 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 1 ];

#d(Ca_i)/d(time) = Ca_i_bufc * (i_leak - i_up + i_rel - 1 {unit: mA_pA} * (i_CaL + i_b_Ca + i_p_Ca - 2 {unit: dimensionless} * i_NaCa) / (2 {unit: dimensionless} * 1 {unit: litre_micrometre3} * V_c * F) * Cm);

#		Expression "Ca_i_bufc.Value * (i_leak.Value - i_up.Value + i_rel.Value - (i_CaL.Value + i_b_Ca.Value + i_p_Ca.Value - 2.0 * i_NaCa.Value) / (2.0 * V_c.Value * F.Value) * Cm.Value)";

		Expression "Ca_i_bufc.Value * ( 2.0 * i_NaCa.Value) / (2.0 * V_c.Value * F.Value) * Cm.Value";

#		Expression "Ca_i_bufc.Value *((( (i_leak.Value - i_up.Value)*V_sr.Value)/V_c.Value + i_xfer.Value) - (((i_CaT.Value + i_b_Ca.Value + i_pCa.Value) - 2.0 * i_NaCa.Value) * Cm.Value)/( 2.0 * V_c.Value * F.Value))";
	}


	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_NaCa :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_NaCa.Value ";
	}
}
