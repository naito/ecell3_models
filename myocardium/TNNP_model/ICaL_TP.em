System System(/CELL/MEMBRANE/ICaL)
{
	StepperID ODE;

#I_CaL
	Variable Variable( alpha_d )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_d )
	{
		Value	1.0; #tmp
	}

	Variable Variable( gamma_d )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_d )
	#alpha_d = 1.4 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(35 {unit: millivolt}) - V) / 13 {unit: millivolt})) + 0.25 {unit: dimensionless};
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_d :.:alpha_d 1 ];

		Expression "(1.4 /(1.0 + (exp(((-35.0 - V.Value)/13.0))))) + 0.25";
	}

	Process ExpressionAssignmentProcess( beta_d )
	#beta_d = 1.4 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V + 5 {unit: millivolt}) / 5 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_d :.:beta_d 1 ];

		Expression "1.4/(1.0 + (exp(((V.Value + 5.0)/5.0))))";
	}

	Process ExpressionAssignmentProcess( gamma_d )
#gamma_d = 1 {unit: millisecond} / (1 {unit: dimensionless} + exp((50 {unit: millivolt} - V) / 20 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ gamma_d :.:gamma_d 1 ];

		Expression "1.0 / (1.0 + (exp(((50.0 - V.Value)/20.0))))";
	}

	Variable Variable( d_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_d )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( d_inf ) #diff
	#d_inf = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(5 {unit: millivolt}) - V) / 7.5 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ d_inf :.:d_inf 1 ];
	
		Expression "1.0/(1.0 + (exp(((-5.0 - V.Value)/7.5))))";
#		Expression "1.0/(1.0 + (exp(((-8.0 - V.Value)/7.5))))";
	}

	Process ExpressionAssignmentProcess( tau_d )
	#tau_d = 1 {unit: millisecond} * alpha_d * beta_d + gamma_d;
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_d :.:alpha_d 0 ]
	                [ beta_d :.:beta_d 0 ]
	                [ gamma_d :.:gamma_d 0 ]
	                [ tau_d :.:tau_d 1 ];

		Expression "alpha_d.Value * beta_d.Value + gamma_d.Value";
	}

	Variable Variable( dGt )
	{
		Value 0; #3.373e-5 in 2006
#		Value 3.373e-5;
	}

	Process ExpressionFluxProcess( dGt )
	#d(d)/d(time) = (d_inf - d) / tau_d;
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ d_inf :.:d_inf 0 ]
			[ tau_d :.:tau_d 0 ]
			[ dGt :.:dGt 1 ];
				
		Expression "(d_inf.Value - dGt.Value) / tau_d.Value";
	}

	Variable Variable( f_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_f )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( f_inf )
	#f_inf = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V + 20 {unit: millivolt}) / 7 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ f_inf :.:f_inf 1 ];
	
		Expression "1.0/(1.0 + (exp(((V.Value + 20.0)/7.0))))";
	}

	Process ExpressionAssignmentProcess( tau_f ) #diff
	#tau_f = 1125 {unit: millisecond} * exp(-(power(V + 27 {unit: millivolt}, 2 {unit: dimensionless})) / 240 {unit: millivolt_square}) + 80 {unit: millisecond} + 165 {unit: millisecond} / (1 {unit: dimensionless} + exp((25 {unit: millivolt} - V) / 10 {unit: millivolt}));
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ tau_f :.:tau_f 1 ];

		Expression "1125.0 * (exp((-(pow((V.Value + 27.0),2.0))/240.0))) + 165.0/(1.0 + (exp(((25.0 - V.Value)/10.0)))) + 80.0";
#		Expression "1102.5 * (exp((-(pow((V.Value + 27.0),2.0))/225.0))) + 200.0/(1.0 + (exp(((13.0 - V.Value)/10.0)))) + 180.0 / (1.0 + (exp(((V.Value + 30.0)/10.0))))+20.0";
	}

	Variable Variable( fGt )
	{
		Value 1.0; #0.7888 in 2006
#		Value 0.7888;
	}

	Process ExpressionFluxProcess( fGt )
#d(f)/d(time) = (f_inf - f) / tau_f;
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ f_inf :.:f_inf 0 ]
			[ tau_f :.:tau_f 0 ]
			[ fGt :.:fGt 1 ];
				
		Expression "(f_inf.Value - fGt.Value) / tau_f.Value";
	}

	Variable Variable( fCa )
	{
		Value 1; #0.9953 as fCass in 2006
#		Value 0.9953;
	}


	Variable Variable( alpha_fCa )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_fCa )
	{
		Value	1.0; #tmp
	}

	Variable Variable( gamma_fCa )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_fCa )
	#alpha_fCa = 1 {unit: dimensionless} / (1 {unit: dimensionless} + power(Ca_i / 0.000325 {unit: millimolar}, 8 {unit: dimensionless}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 0 ]
	                [ alpha_fCa :.:alpha_fCa 1 ];

		Expression "1.0 / (1.0+ pow(Ca_i.Value / 0.000325, 8.0))";
	}

	Process ExpressionAssignmentProcess( beta_fCa )
	#beta_fCa = 0.1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((Ca_i - 0.0005 {unit: millimolar}) / 0.0001 {unit: millimolar}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 0 ]
	                [ beta_fCa :.:beta_fCa 1 ];

		Expression "0.1 / (1.0 + exp((Ca_i.Value - 0.0005 ) / 0.0001))";
	}

	Process ExpressionAssignmentProcess( gamma_fCa )
	#gama_fCa = 0.2 {unit: dimensionless} / (1 {unit: dimensionless} + exp((Ca_i - 0.00075 {unit: millimolar}) / 0.0008 {unit: millimolar}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 0 ]
	                [ gamma_fCa :.:gamma_fCa 1 ];

		Expression "0.2 / (1.0 + exp((Ca_i.Value - 0.00075) / 0.0008))";
	}


	Variable Variable( fCa_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_fCa )
	{
		Value	2.0; #tmp
	}

	Process ExpressionAssignmentProcess( fCa_inf )
	#fCa_inf = (alpha_fCa + beta_fCa + gama_fCa + 0.23 {unit: dimensionless}) / 1.46 {unit: dimensionless}
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
	                [ alpha_fCa :.:alpha_fCa 0 ]
			[ beta_fCa :.:beta_fCa 0 ]
	                [ gamma_fCa :.:gamma_fCa 0 ]
	                [ fCa_inf :.:fCa_inf 1 ];

		Expression "(alpha_fCa.Value + beta_fCa.Value + gamma_fCa.Value + 0.23)/1.46";
	}

	Process ExpressionFluxProcess( d_fCa )
	#d(fCa)/d(time) = piecewise(
	#   case fCa_inf > fCa and V > -(60 {unit: millivolt}) then
	#      0 {unit: per_millisecond} 
	#   else
	#      d_fCa
	#d_fCa = (fCa_inf - fCa) / tau_fCa
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
	                [ V :..:V 0 ]
	                [ fCa_inf :.:fCa_inf 0 ]
			[ tau_fCa :.:tau_fCa 0 ]
	                [ fCa :.:fCa 1 ];

		Expression "(1.0 - geq(V.Value, -60.0) * gt(fCa_inf.Value, fCa.Value)) * ((fCa_inf.Value - fCa.Value)/ tau_fCa.Value)";
		
	}
	
	Variable Variable( I )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_CaL )#diff
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 0 ]
			[ Ca_o :/:Ca_o 0 ]
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
			[ d  :.:dGt 0 ]
			[ f  :.:fGt 0 ]
			[ fCa :.:fCa 0 ]
	                [ i_CaL :.:I 1 ];
        
		g_CaL 0.000175; #0.0000398 in 2006
#		g_CaL 0.0000398;
		GX 1.0;		

		Expression "GX * g_CaL * d.Value * f.Value * fCa.Value * 4.0 * V.Value * pow(F.Value, 2.0) / (R.Value * T.Value) * (Ca_i.Value * exp(2.0 * V.Value * F.Value / (R.Value * T.Value)) - 0.341 * Ca_o.Value) / (exp(2.0 * V.Value * F.Value / (R.Value * T.Value)) - 1.0)";

	}

	Process ExpressionFluxProcess( Ca_i )
	{
		Priority 1; #may have to fix

		VariableReferenceList
			[ Ca_i_bufc :../../CYTOPLASM:Ca_i_bufc 0 ]
			[ i_CaL :.:I 0 ]
			[ V_sr :../..:V_sr 0 ]
			[ V_c :../..:V_myo 0 ]
			[ Cm :..:Cm 0 ]
			[ F :/:F 0 ]
			[ Ca_i :../../CYTOPLASM:Ca_i 1 ];

		Expression "Ca_i_bufc.Value * (-1.0 * i_CaL.Value ) / (2.0 * V_c.Value * F.Value) * Cm.Value";

	}

	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_CaL :.:I 0]
	                [ V :..:V 1 ];

		Expression "(-1.0) * i_CaL.Value ";
	}

}
