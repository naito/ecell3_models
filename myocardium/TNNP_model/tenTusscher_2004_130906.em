Stepper FixedODE1Stepper( ODE )
{
	StepInterval 0.001;
	# no property
}

Stepper PassiveStepper( PSV )
{
	# no property
}


System System( / )
{
	StepperID	ODE;

	Variable Variable( K_o ) #checked
	{
		Value	5.4; #same as 2006
	}

	Variable Variable( Na_o )#checked
	{
		Value	140.0; #same as 2006
	}

	Variable Variable( Ca_o )#checked
	{
		Value	2.0; #same as 2006
	}

	Variable Variable( R )#checked
	{
		Value	8314.472; #Membrane Components J/(mol * K), same as 2006
	}

	Variable Variable( T )#checked
	{
		Value	310.0; #Membrane Components mV, same as 2006
	}

	Variable Variable( F )#checked
	{
		Value	96485.3415; #Membrane Components C/mmol, same as 2006
	}

	Variable Variable( I )
	{
		Name "applied current";
		Value	0.0;
	}	

	Variable Variable( t )
	{
		Name "current time";
		Value	0.0;
	}	

	Process ExpressionFluxProcess( clock )
	{
		Priority 15;
		VariableReferenceList
			[ t :.:t 1 ];
		
		Expression "1.0";
	}

	Process CurrentClampAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ I :.:I  1 ]
			[ t :.:t  0 ];

		amplitude  -52.0; #-52.0
		onset      10;
		offset     11;
		interval   1000;
	}
}

System System( /CELL )
{
	StepperID	ODE;

	Variable Variable( V_myo ) #V_C, checked
	{
		Value 0.016404; #same as 2006
#		Value 0.0021768;
	}

	Variable Variable( V_sr )
	{
		Value 0.001094;
#		Value 5.80701e-6;	
	}

}

System System( /CELL/MEMBRANE )
{
	StepperID	ODE;

	Variable Variable( V )
	{
		Value	-86.2; #-80.50146;
	}

	Variable Variable( E_Na )
	{
		Value	1.0; #tmp
	}

	Variable Variable( E_K )
	{
		Value	1.0; #tmp
	}

	Variable Variable( E_Ks )
	{
		Value	1.0; #tmp
	}

	Variable Variable( E_Ca )
	{
		Value	1.0;
	}

	Variable Variable( CFNa )
	{
		Name "dependency of Na+ flux on Vm (constant field equation)";
		Value -475.48115680026734;
	}

	Variable Variable( CFK )
	{
		Name "dependency of K+ flux on Vm (constant field equation)";
		Value 0.1383929081707904;
	}


	Variable Variable( CFCa )
	{
		Name "dependency of Ca2+ flux on Vm (constant field equation)";
		Value -11.705853861559248;
	}

	Process ExpressionAssignmentProcess( E_Na )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
			[ Na_o :/:Na_o 0 ]
			[ Na_i :../CYTOPLASM:Na_i 0 ]
	                [ E_Na :.:E_Na 1 ];
				        
		Expression "(R.Value * T.Value / F.Value )* log( Na_o.Value / Na_i.Value )";
	}

	Process ExpressionAssignmentProcess( E_K )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
			[ K_o :/:K_o 0 ]
			[ K_i :../CYTOPLASM:K_i 0 ]
	                [ E_K :.:E_K 1 ];
				        
		Expression "(R.Value * T.Value / F.Value )* log( K_o.Value / K_i.Value )";
	}

	Process ExpressionAssignmentProcess( E_Ks )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
			[ K_o :/:K_o 0 ]
			[ K_i :../CYTOPLASM:K_i 0 ]
			[ Na_o :/:Na_o 0 ]
			[ Na_i :../CYTOPLASM:Na_i 0 ]
	                [ E_Ks :.:E_Ks 1 ];
				        
		P_kna 0.03; #same as 2006
		
		Expression "(R.Value * T.Value / F.Value )* log( (K_o.Value + P_kna * Na_o.Value )/ (K_i.Value + P_kna * Na_i.Value ) )";
	}

	Process ExpressionAssignmentProcess( E_Ca )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
			[ Ca_o :/:Ca_o 0 ]
			[ Ca_i :../CYTOPLASM:Ca_i 0 ]
	                [ E_Ca :.:E_Ca 1 ];
				        
		Expression "(0.5 * R.Value * T.Value / F.Value )* log( Ca_o.Value / Ca_i.Value )";
	}

	Variable Variable( VRTF )
	{
		Value 0; #tmp
	}

	Process ExpressionAssignmentProcess( VRTF )
	{
	        StepperID   PSV;
		Priority 25;

		VariableReferenceList
			[ R :/:R 0 ]
			[ T :/:T 0 ]
			[ F :/:F 0 ]
			[ V :.:V 0 ]
			[ VRTF :.:VRTF 1];

		Expression "(V.Value / T.Value) / (R.Value / F.Value)";
	}
	
	Process ExpressionAssignmentProcess( CFNa )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ Na_o :/:Na_o 0 ]
			[ Na_i :../CYTOPLASM:Na_i 0 ]
	                [ VRTF :.:VRTF 0 ]
	                [ CFNa :.:CFNa 1 ];
				        
		Expression "VRTF.Value * (Na_i.Value - Na_o.Value * exp(-1.0 * VRTF.Value)) / (1.0 - exp(-1.0 * VRTF.Value))";
	}

	Process ExpressionAssignmentProcess( CFK )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ K_o :/:K_o 0 ]
			[ K_i :../CYTOPLASM:K_i 0 ]
	                [ VRTF :.:VRTF 0 ]
	                [ CFK :.:CFK 1 ];
				        
		Expression "VRTF.Value * (K_i.Value - K_o.Value * exp(-1.0 * VRTF.Value)) / (1.0 - exp(-1.0 * VRTF.Value))";
	}

	Process ExpressionAssignmentProcess( CFCa )
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ Ca_o :/:Ca_o 0 ]
			[ Ca_i :../CYTOPLASM:Ca_i 0 ]
	                [ VRTF :.:VRTF 0 ]
	                [ CFCa :.:CFCa 1 ];

		Expression "2.0 * VRTF.Value * (Ca_i.Value - Ca_o.Value * exp(-2.0 * VRTF.Value)) / (1.0 - exp(-2.0 * VRTF.Value))";
	}

	Variable Variable( Cm ) #checked
	{
#		Value	0.028;
		Value	0.185; #same as 2006
#		Value	1.0;
	}

#Iha
	Variable Variable( i_ha )
	{
		Value	0; #tmp
	}

#Ist
	Variable Variable( i_st )
	{
		Value	0; #tmp
	}
#ICaT
	Variable Variable( i_CaT )
	{
		Value	0; #tmp
	}

#dVdt
	Process ExpressionFluxProcess( V )
	{
		Priority 5;

		VariableReferenceList
			[ i_ha :.:i_ha 0]
			[ i_st :.:i_st 0]
			[ i_CaT :.:i_CaT 0]
			[ i_Stim :/:I 0]
			[ Cm :.:Cm 0]
	                [ V :.:V 1 ];

		Expression "(-1.0) * (i_ha.Value + i_st.Value + i_CaT.Value + i_Stim.Value )";
	}
	#( - 1/1)*( i_K1 + i_to+i_Kr+i_Ks+i_CaL+i_NaK+i_Na+i_b_Na+i_NaCa+i_b_Ca+i_p_K+i_p_Ca+i_Stim)
}

@#include('Iha.em')
@#include('Iha_LRd.em')
@#include('Ist.em')
@#include('ICaT.em')

System System( /CELL/CYTOPLASM )
{
	StepperID	ODE;



	Variable Variable( V_ss )
	{
		Value 0.00005468;
	}

	Variable Variable( cAMP )
	{
		Name "Cyclic AMP";
		Value 2.939695632625512e-7;
		#MolarConc 2.939695632625512e-7;
	}

	Variable Variable( PKA )
	{
		Name "protein kinase A";
		Value 1.364353297210205e-7;
		#MolarConc 1.364353297210205e-7;
	}

	Variable Variable( K_i )
	{
		Value	138.3; #136.89 in 2006
#		Value	136.89;
	}

	Process ExpressionFluxProcess( K_i )
	{
		Priority 5;

		VariableReferenceList
			[ K_i :.:K_i 1]
			[ V_c :..:V_myo 0]
#			[ i_ha :../MEMBRANE/Iha:cK 0]
#			[ i_st :../MEMBRANE/Ist:cK 0]
#			[ i_K1 :../MEMBRANE:i_K1 0]
#			[ i_p_K :../MEMBRANE:i_p_K 0]
#			[ i_NaK :../MEMBRANE:i_NaK 0]
			[ i_Stim :/:I 0]
			[ F :/:F 0]
			[ Cm :../MEMBRANE:Cm 0]
	                [ V :../MEMBRANE:V 0 ];

#d(K_i)/d(time) = -(1 {unit: mA_pA}) * (i_K1 + i_to + i_Kr + i_Ks + i_p_K + i_Stim - 2 {unit: dimensionless} * i_NaK) * Cm / (1 {unit: litre_micrometre3} * V_c * F);

		Expression "((-1.0 * i_Stim.Value)/( 1.0 * V_c.Value * F.Value))*Cm.Value";
#		Expression "((-1.0 * ((i_ha.Value + i_st.Value + i_K1.Value + i_to.Value + i_Kr.Value + i_Ks.Value + i_p_K.Value + i_Stim.Value) -  2.0 * i_NaK.Value))/( 1.0 * V_c.Value * F.Value))*Cm.Value";
	}

	Variable Variable( Na_i )
	{
		Value	11.6; #8.604 in 2006
#		Value	8.604;
	}

	Variable Variable( Ca_i )
	{
		Value	0.0002; #0.000126 in 2006
#		Value	0.000126;
	}

#	Variable Variable( Ca_ss )
#	{
#		Value	0.00036;
#	}

	Variable Variable( Ca_SR )
	{
		Value	0.2; #3.64 in 2006
#		Value	3.64;
	}

	Variable Variable( g_inf )
	{
		Value	0; #tmp
	}

	Variable Variable( tau_g )
	{
		Value	2.0; 
	}

	Variable Variable( gGt )
	{
		Value	1.0;
	}

	Process ExpressionAssignmentProcess( g_inf )
	#g_inf = piecewise(
   	#case Ca_i < 0.00035 {unit: millimolar} then
	#1 {unit: dimensionless} / (1 {unit: dimensionless} + power(Ca_i / 0.00035 {unit: millimolar}, 6 {unit: dimensionless})) 
	#   else
        #1 {unit: dimensionless} / (1 {unit: dimensionless} + power(Ca_i / 0.00035 {unit: millimolar}, 16 {unit: dimensionless}))
	{
	        StepperID   PSV;
		Priority 20;

		VariableReferenceList
			[ Ca_i :.:Ca_i 0 ]
	                [ g_inf :.:g_inf 1 ];

		Expression "1.0 / (1.0 + pow(Ca_i.Value / 0.00035, 6.0 + 10.0 * geq(Ca_i.Value, 0.00035)))";
	}

	Process ExpressionFluxProcess( gGt )
	#d(g)/d(time) = piecewise(
	#   case g_inf > g and V > -(60 {unit: millivolt}) then
	#      0 {unit: per_millisecond} 
	#   else
	#      d_g = (g_inf - g) / tau_g;
	{
	        StepperID   ODE;
		Priority 15;

		VariableReferenceList
			[ V :../MEMBRANE:V 0 ]
			[ g_inf :.:g_inf 0 ]
			[ tau_g :.:tau_g 0 ]
			[ gGt :.:gGt 1 ];
				
		Expression "(1.0 - gt(V.Value, -60.0) * gt(g_inf.Value, gGt.Value)) * ((g_inf.Value - gGt.Value)/ tau_g.Value)";
	}

	Variable Variable (i_rel)
	{
		 Value 0;
	}

	Process ExpressionAssignmentProcess( i_rel )
	{
		Priority 5; #may have to fix

		VariableReferenceList
			[ t :/:t 0]
			[ i_rel :.:i_rel 1 ]
			[ Ca_SR :.:Ca_SR 0 ]
			[ dGt :../MEMBRANE/ICaL:dGt 0 ]
			[ gGt :.:gGt 0 ];
	
		a_rel 0.016464;
		b_rel 0.25;
		c_rel 0.008232;

		GX 1.0;

		Expression "GX * (a_rel * pow(Ca_SR.Value, 2.0) / (pow(b_rel, 2.0) + pow(Ca_SR.Value, 2.0)) + c_rel) * dGt.Value * gGt.Value";
#		Expression "GX * V_rel * O.Value * (Ca_SR.Value - Ca_ss.Value)";

#i_rel = (a_rel * power(Ca_SR, 2 {unit: dimensionless}) / (power(b_rel, 2 {unit: dimensionless}) + power(Ca_SR, 2 {unit: dimensionless})) + c_rel) * d * g;

	}		

	Variable Variable (i_leak)
	{
		 Value 0;
	}

	Process ExpressionAssignmentProcess( i_leak )
	{
		Priority 5; #may have to fix

		VariableReferenceList
			[ i_leak :.:i_leak 1 ]
			[ Ca_SR :.:Ca_SR 0 ]
			[ Ca_i :.:Ca_i 0 ];
	
		V_leak 0.00008; #0.00036 in 2006
		GX 1.0;

		Expression "GX * V_leak * (Ca_SR.Value - Ca_i.Value)";

#i_leak = V_leak * (Ca_SR - Ca_i);

	}

	Variable Variable (i_up)
	{
		 Value 0;
	}

	Process ExpressionAssignmentProcess( i_up )
	{
		Priority 5; #may have to fix

		VariableReferenceList
			[ i_up :.:i_up 1 ]
			[ Ca_SR :.:Ca_SR 0 ]
			[ Ca_i :.:Ca_i 0 ];
	
		Vmax_up 0.000425; #0.006375 in 2006
		K_up 0.00025; #same as 2006
		GX 1.0;

		Expression "GX * Vmax_up/(1.0+pow(K_up, 2.0)/pow(Ca_i.Value, 2.0))";
#i_up = Vmax_up / (1 {unit: dimensionless} + power(K_up, 2 {unit: dimensionless}) / power(Ca_i, 2 {unit: dimensionless}));
	}		

#	Variable Variable (i_xfer)
#	{
#		 Value 0;
#	}

#	Process ExpressionAssignmentProcess( i_xfer )
#	{
#		Priority 5; #may have to fix

#		VariableReferenceList
#			[ i_xfer :.:i_xfer 1 ]
#			[ Ca_ss :.:Ca_ss 0 ]
#			[ Ca_i :.:Ca_i 0 ];
	
#		V_xfer 0.0038;

#		Expression "V_xfer * (Ca_ss.Value - Ca_i.Value )";
#	}		

	Variable Variable (Ca_sr_bufsr)
	{
		 Value 0;
	}

	Process ExpressionAssignmentProcess( Ca_sr_bufsr )
	{
		Priority 5; #may have to fix

		VariableReferenceList
			[ Ca_sr_bufsr :.:Ca_sr_bufsr 1 ]
			[ Ca_SR :.:Ca_SR 0 ];

		Buf_sr 10; #same as 2006
		K_buf_sr 0.3; #same as 2006

		Expression "1.0/(1.0 +( Buf_sr * K_buf_sr)/(pow((Ca_SR.Value + K_buf_sr), 2.0)))";
	
#Ca_sr_bufsr = 1 {unit: dimensionless} / (1 {unit: dimensionless} + Buf_sr * K_buf_sr / power(Ca_SR + K_buf_sr, 2 {unit: dimensionless}));
	}		

	Variable Variable (Ca_i_bufc)
	{
		 Value 0;
	}

	Process ExpressionAssignmentProcess( Ca_i_bufc )
	{
		Priority 5; #may have to fix

		VariableReferenceList
			[ Ca_i_bufc :.:Ca_i_bufc 1 ]
			[ Ca_i :.:Ca_i 0 ];

		Buf_c 0.15; #0.2 in 2006
		K_buf_c 0.001; #same as 2006

		Expression "1.0/(1.0 + (Buf_c * K_buf_c)/(pow((Ca_i.Value + K_buf_c), 2.0)))";
		
#Ca_i_bufc = 1 {unit: dimensionless} / (1 {unit: dimensionless} + Buf_c * K_buf_c / power(Ca_i + K_buf_c, 2 {unit: dimensionless}));
	}		

	Variable Variable (Ca_ss_bufss)
	{
		 Value 0;
	}

#	Process ExpressionAssignmentProcess( Ca_i_bufss )
#	{
#		Priority 5; #may have to fix#
#
#		VariableReferenceList
#			[ Ca_ss_bufss :.:Ca_ss_bufss 1 ]
#			[ Ca_ss :.:Ca_ss 0 ];
#
#		Buf_ss 0.4;
#		K_buf_ss 0.00025;
#
#		Expression "1.0/(1.0 + ( Buf_ss * K_buf_ss)/(pow((Ca_ss.Value + K_buf_ss), 2.0)))";
#	}		

	Process ExpressionFluxProcess( Ca_SR )
	{
		Priority 1; #may have to fix

		VariableReferenceList
			[ Ca_sr_bufsr :.:Ca_sr_bufsr 0 ]
			[ V_c :..:V_myo 0 ]
			[ V_sr :..:V_sr 0 ]
			[ i_up :.:i_up 0 ]
			[ i_rel :.:i_rel 0 ]
			[ i_leak :.:i_leak 0 ]
			[ Ca_SR :.:Ca_SR 1 ];

			
		#d(Ca_SR)/d(time) = Ca_sr_bufsr * V_c / V_sr * (i_up - (i_rel + i_leak));
		Expression "Ca_sr_bufsr.Value * V_c.Value / V_sr.Value * (i_up.Value - (i_rel.Value + i_leak.Value ))";
#		Expression "Ca_sr_bufsr.Value * (i_up.Value - (i_rel.Value + i_leak.Value ))";
	}		

#	Process ExpressionFluxProcess( Ca_ss )
#	{
#		Priority 1; #may have to fix

#		VariableReferenceList
#			[ Ca_ss_bufss :.:Ca_ss_bufss 0 ]
#			[ i_CaL :../MEMBRANE:i_CaL 0 ]
#			[ i_rel :.:i_rel 0 ]
#			[ i_xfer :.:i_xfer 0 ]
#			[ V_sr :.:V_sr 0 ]
#			[ V_ss :.:V_ss 0 ]
#			[ V_c :.:V_myo 0 ]
#			[ Cm :../MEMBRANE:Cm 0 ]
#			[ F :/:F 0 ]
#			[ Ca_ss :.:Ca_ss 1 ];

#		Expression "Ca_ss_bufss.Value * (((-1.0 * i_CaL.Value * Cm.Value)/( 2.0 * V_ss.Value * F.Value)+( i_rel.Value * V_sr.Value )/V_ss.Value) - ( i_xfer.Value * V_c.Value )/V_ss.Value)";
#	}


	Process ExpressionFluxProcess( Ca_i )
	{
		Priority 1; #may have to fix

		VariableReferenceList
			[ Ca_i_bufc :.:Ca_i_bufc 0 ]
			[ i_CaT :../MEMBRANE:i_CaT 0 ]
#			[ i_b_Ca :../MEMBRANE:i_b_Ca 0 ]
#			[ i_p_Ca :../MEMBRANE:i_pCa 0 ]			
#			[ i_NaCa :../MEMBRANE:i_NaCa 0 ]
			[ i_leak :.:i_leak 0 ]
			[ i_rel :.:i_rel 0 ]
#			[ i_xfer :.:i_xfer 0 ]
			[ i_up :.:i_up 0 ]
			[ V_sr :..:V_sr 0 ]
			[ V_ss :.:V_ss 0 ]
			[ V_c :..:V_myo 0 ]
			[ Cm :../MEMBRANE:Cm 0 ]
			[ F :/:F 0 ]
			[ Ca_i :.:Ca_i 1 ];

#d(Ca_i)/d(time) = Ca_i_bufc * (i_leak - i_up + i_rel - 1 {unit: mA_pA} * (i_CaL + i_b_Ca + i_p_Ca - 2 {unit: dimensionless} * i_NaCa) / (2 {unit: dimensionless} * 1 {unit: litre_micrometre3} * V_c * F) * Cm);

#		Expression "Ca_i_bufc.Value * (i_leak.Value - i_up.Value + i_rel.Value - (i_CaL.Value + i_b_Ca.Value + i_p_Ca.Value - 2.0 * i_NaCa.Value) / (2.0 * V_c.Value * F.Value) * Cm.Value)";
#		Expression "Ca_i_bufc.Value * (i_leak.Value + i_rel.Value - i_up.Value + ( 2.0 * i_NaCa.Value) / (2.0 * V_c.Value * F.Value) * Cm.Value)";

		Expression "Ca_i_bufc.Value * (i_leak.Value + i_rel.Value - i_up.Value )";

#		Expression "Ca_i_bufc.Value *((( (i_leak.Value - i_up.Value)*V_sr.Value)/V_c.Value + i_xfer.Value) - (((i_CaT.Value + i_b_Ca.Value + i_pCa.Value) - 2.0 * i_NaCa.Value) * Cm.Value)/( 2.0 * V_c.Value * F.Value))";
	}

#free diadic subspace Ca2+ concentration	state	[['value', '0.00036']]	dCa_ss_dt = 
#cytosolic Ca2+	state	[['value', '0.000126']]	dCa_i_dt = 

}

#INa
#Ito

@include('Ito_TP.em')
@include('IKr_TP.em')
@include('IKs_TP.em')
@include('ICaL_TP.em')
@include('INaCa_TP.em')
@include('INaK_TP.em')
@include('Ibg_TP.em')
@include('INa_TP.em')
@include('IK1_TP.em')
