System System(/CELL/MEMBRANE/INa){

	StepperID ODE;
#I_Na
	Variable Variable( mGt )
	{
		Value	0; #0.00172 in 2006
#		Value	0.00172;
	}

	Variable Variable( hGt )
	{
		Value	0.75; #0.7444 in 2006
#		Value	0.7444;
	}

	Variable Variable( jGt )
	{
		Value	0.75; #0.7045 in 2006
#		Value	0.7045;
	}

	Variable Variable( alpha_m )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_m )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_m )
	#alpha_m = 1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((-(60 {unit: millivolt}) - V) / 5 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_m :.:alpha_m 1 ];

		Expression "1.0 / (1.0 +(exp(((-60.0 - V.Value) / 5.0))))"; #	m Gate alpha_m

	}

	Process ExpressionAssignmentProcess( beta_m )
	#beta_m = 0.1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V + 35 {unit: millivolt}) / 5 {unit: millivolt})) + 0.1 {unit: dimensionless} / (1 {unit: dimensionless} + exp((V - 50 {unit: millivolt}) / 200 {unit: millivolt}))
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_m :.:beta_m 1 ];

		Expression "(0.1/(1.0 + (exp((V.Value + 35.0)/5.0))))+(0.1/(1.0+(exp((V.Value - 50.0)/200.0))))";	#m Gate	beta_m
	}

	Variable Variable( m_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_m )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( m_inf )
	#m_inf = 1 {unit: dimensionless} / power(1 {unit: dimensionless} + exp((-(56.86 {unit: millivolt}) - V) / 9.03 {unit: millivolt}), 2 {unit: dimensionless})
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ m_inf :.:m_inf 1 ];
	
		Expression "1.0 / pow((1.0 + ( exp(((-56.86 - V.Value)/9.03)))),2.0)"; #	m Gate			m_inf

	}

	Process ExpressionAssignmentProcess( tau_m )
	#tau_m = 1 {unit: millisecond} * alpha_m * beta_m
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_m :.:alpha_m 0 ]
	                [ beta_m :.:beta_m 0 ]
	                [ tau_m :.:tau_m 1 ];

		Expression "alpha_m.Value * beta_m.Value";

	}

	Process ExpressionFluxProcess( mGt )
	#d(m)/d(time) = (m_inf - m) / tau_m
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ m_inf :.:m_inf 0 ]
			[ tau_m :.:tau_m 0 ]
			[ mGt :.:mGt 1 ];
				
		Expression "(m_inf.Value - mGt.Value) / tau_m.Value";
	}

#hGt
	Variable Variable( alpha_h )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_h )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( alpha_h )
	# alpha_h = piecewise(
	#   case V < -(40 {unit: millivolt}) then
      	#    0.057 {unit: per_millisecond} * exp(-((V + 80 {unit: millivolt})) / 6.8 {unit: millivolt}) 
   	# else
	#    0 {unit: per_millisecond}

	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_h :.:alpha_h 1 ];

		Expression "(1.0 - geq(V.Value, -40.0)) * 0.057 * ( exp((-(V.Value + 80.0)/6.8 )))";#	h Gate	alpha_h
	}

	Process ExpressionAssignmentProcess( beta_h )
	#beta_h = piecewise(
   	# case V < -(40 {unit: millivolt}) then
      	#	2.7 {unit: per_millisecond} * exp(0.079 {unit: per_millivolt} * V) + 310000 {unit: per_millisecond} * exp(0.3485 {unit: per_millivolt} * V) 
	#   else
      	#0.77 {unit: per_millisecond} / (0.13 {unit: dimensionless} * (1 {unit: dimensionless} + exp((V + 10.66 {unit: millivolt}) / -(11.1 {unit: millivolt})))))

	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_h :.:beta_h 1 ];

		Expression "(1.0 - geq(V.Value, -40.0)) * (2.7 * exp( 0.079 * V.Value) + 310000.0 *exp(0.3485 * V.Value)) + (geq(V.Value,-40.0) * 0.77/( 0.130*(1.0 + (exp(((V.Value+10.66)/ - 11.1))))))";	#h Gate beta_h
	}

	Variable Variable( h_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_h )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( h_inf )
	#h_inf = 1 {unit: dimensionless} / power(1 {unit: dimensionless} + exp((V + 71.55 {unit: millivolt}) / 7.43 {unit: millivolt}), 2 {unit: dimensionless})
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ h_inf :.:h_inf 1 ];
				        
		Expression "1.0 / pow(( 1.0 + (exp(((V.Value + 71.55)/7.43)))),2.0)";#	h Gate	h_inf
	}

	Process ExpressionAssignmentProcess( tau_h )
	#tau_h = 1 {unit: dimensionless} / (alpha_h + beta_h)
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_h :.:alpha_h 0 ]
	                [ beta_h :.:beta_h 0 ]
	                [ tau_h :.:tau_h 1 ];
				
		Expression "1.0 / (alpha_h.Value + beta_h.Value)";
	}

	Process ExpressionFluxProcess( hGt )
	#d(h)/d(time) = (h_inf - h) / tau_h
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ h_inf :.:h_inf 0 ]
			[ tau_h :.:tau_h 0 ]
			[ hGt :.:hGt 1 ];
				
		Expression "(h_inf.Value - hGt.Value) / tau_h.Value";
	}

#jGt
	Variable Variable( alpha_j )
	{
		Value	1.0; #tmp
	}

	Variable Variable( beta_j )
	{
		Value	1.0; #tmp
	}


	Process ExpressionAssignmentProcess( alpha_j )
#	alpha_j = piecewise(
	#   case V < -(40 {unit: millivolt}) then
      	# (-(25428 {unit: per_millisecond}) * exp(0.2444 {unit: per_millivolt} * V) - 6.948E-6 {unit: per_millisecond} * exp(-(0.04391 {unit: per_millivolt}) * V)) * (V + 37.78 {unit: millivolt}) / 1 {unit: millivolt} / (1 {unit: dimensionless} + exp(0.311 {unit: per_millivolt} * (V + 79.23 {unit: millivolt}))) 
  	# else
	#      0 {unit: per_millisecond}

	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ alpha_j :.:alpha_j 1 ];

		Expression "(1.0 - geq(V.Value, -40.0)) * ((((-25428.0*exp(0.2444*V.Value)) - (6.948e-6*exp(-0.04391*V.Value)) )*(V.Value + 37.78) ) / (1.0 + exp( 0.311*(V.Value + 79.23)) ))"; #j Gate	alpha_j
	}

	Process ExpressionAssignmentProcess( beta_j )
	#beta_j = piecewise(
   	#case V < -(40 {unit: millivolt}) then
      	#0.02424 {unit: per_millisecond} * exp(-(0.01052 {unit: per_millivolt}) * V) / (1 {unit: dimensionless} + exp(-(0.1378 {unit: per_millivolt}) * (V + 40.14 {unit: millivolt}))) 
	#   else
      	# 0.6 {unit: per_millisecond} * exp(0.057 {unit: per_millivolt} * V) / (1 {unit: dimensionless} + exp(-(0.1 {unit: per_millivolt}) * (V + 32 {unit: millivolt}))))

	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ beta_j :.:beta_j 1 ];

		Expression "((1.0 - geq(V.Value, -40.0))* ( 0.02424*(exp((-0.01052 * V.Value))))/(1.0 + (exp((-0.1378*(V.Value + 40.14)))))) + (geq(V.Value, -40.0) * ( 0.6*(exp((0.057*V.Value))))/(1.0 + (exp((-0.1*(V.Value + 32.0))))))";	#j Gate	beta_j
	}

	Variable Variable( j_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_j )
	{
		Value	1.0; #tmp
	}

	Process ExpressionAssignmentProcess( j_inf )
	#j_inf = 1 {unit: dimensionless} / power(1 {unit: dimensionless} + exp((V + 71.55 {unit: millivolt}) / 7.43 {unit: millivolt}), 2 {unit: dimensionless})
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
	                [ j_inf :.:j_inf 1 ];
				        
		Expression "1.0 / pow((1.0 + (exp(((V.Value + 71.55) / 7.43)))),2.0)";#	j Gate	j_inf
	}

	Process ExpressionAssignmentProcess( tau_j )
	#tau_j = 1 {unit: dimensionless} / (alpha_j + beta_j)
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ V :..:V 0 ]
			[ alpha_j :.:alpha_j 0 ]
			[ beta_j :.:beta_j 0 ]
	                [ tau_j :.:tau_j 1 ];
				 
		Expression "1.0 / (alpha_j.Value + beta_j.Value)";  
	}

	Process ExpressionFluxProcess( jGt )
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ j_inf :.:j_inf 0 ]
			[ tau_j :.:tau_j 0 ]
			[ jGt :.:jGt 1 ];
				
		Expression "(j_inf.Value - jGt.Value) / tau_j.Value";
	}

	Variable Variable( I )
	{
		Value	0; #tmp
	}

	Process ExpressionAssignmentProcess( i_Na )
	#i_Na = g_Na * power(m, 3 {unit: dimensionless}) * h * j * (V - E_Na);
	{
	        StepperID   PSV;
		Priority 10;

		VariableReferenceList
			[ V :..:V 0 ]
			[ E_Na :..:E_Na 0 ]
			[ mGt  :.:mGt 0 ]
			[ hGt  :.:hGt 0 ]
			[ jGt  :.:jGt 0 ]
	                [ i_Na :.:I 1 ];
        
		g_Na 14.838; #same as 2006
		GX 1.0;
		
		Expression "GX * g_Na * pow(mGt.Value, 3.0 ) * hGt.Value * jGt.Value * (V.Value - E_Na.Value)";
	}

	Process ExpressionFluxProcess( Na_i )
	{
		Priority 5;

		VariableReferenceList
			[ Na_i :../../CYTOPLASM:Na_i 1]
			[ V_c :../..:V_myo 0]
			[ i_Na :.:I 0]
			[ F :/:F 0]
			[ Cm :..:Cm 0];

		Expression "((-1.0 * i_Na.Value)/( V_c.Value * F.Value)) * Cm.Value";

#		Expression "((-1.0 * (i_Na.Value + i_ha.Value + i_st.Value + i_b_Na.Value + 3.0 * i_NaK.Value + 3.0 * i_NaCa.Value))/( V_c.Value * F.Value)) * Cm.Value";

	}

	Process ExpressionFluxProcess( V )
	{
		Priority 1;

		VariableReferenceList
	                [ i_Na :.:I 0 ]
	                [ V :..:V 1 ];

		Expression "(-1.0) * ( i_Na.Value )";
	}
}
