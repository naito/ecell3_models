Stepper FixedODE1Stepper( ODE )
{
	# no property
}

Stepper PassiveStepper( PSV )
{
	# no property
}

System System( / )
{
	StepperID	ODE;

}

System System( /Extracellular )
{
	StepperID	ODE;

	Variable Variable ( SIZE )
	{
		Value	1.0;
	}

	Variable Variable( Extracellular_Glucose )
	{
		MolarConc 50.0;
	}

}

System System ( /cytosol )
{
	StepperID	ODE;

	Variable Variable ( SIZE )
	{
		Value	1.0;
	}

	Variable Variable( Glucose_in_Cytosol )
	{
		MolarConc 0.087;
	}

	Variable Variable( Glucose_6_Phosphate )
	{
		MolarConc 2.45;
	}

	Variable Variable( Fructose_6_Phosphate )
	{
		MolarConc 0.62;
	}

	Variable Variable( Fructose_16_bisphosphate )
	{
		MolarConc 5.51;
	}

	Variable Variable( Triose_phosphate )
	{
		MolarConc 0.96;
	}

	Variable Variable( bisphosphoglycreate_13 )
	{
		MolarConc 0.0;
	}

	Variable Variable( phosphoglycreate_3 )
	{
		MolarConc 0.9;
	}

	Variable Variable( phosphoglycreate_2 )
	{
		MolarConc 0.12;
	}

	Variable Variable( Phosphoenolpyruvate )
	{
		MolarConc 0.07;
	}

	Variable Variable( Pyruvate )
	{
		MolarConc 1.85;
	}

	Variable Variable( Acetaldehyde )
	{
		MolarConc 0.17;
	}

	Variable Variable( High_energy_phosphates )
	{
		MolarConc 6.31;
	}

	Variable Variable( NAD )
	{
		MolarConc 1.2;
	}

	Variable Variable( NADH )
	{
		MolarConc 0.39;
	}

	Variable Variable( Glycogen )
	{
		MolarConc 0.0;
	}

	Variable Variable( Trehalose )
	{
		MolarConc 0.0;
	}

	Variable Variable( CO2 )
	{
		MolarConc 1.0;
	}

	Variable Variable( Succinate )
	{
		MolarConc 0.0;
	}

	Variable Variable( Ethanol )
	{
		MolarConc 50.0;
	}

	Variable Variable( Glycerol )
	{
		MolarConc 0.15;
	}

	Variable Variable( ATP_concentration )
	{
		Value 0.0;
	}

	Variable Variable( ADP_concentration )
	{
		Value 0.0;
	}

	Variable Variable( AMP_concentration )
	{
		Value 0.0;
	}

	Variable Variable( sum_of_AXP_conc )
	{
		MolarConc 4.1;
	}

	Variable Variable( F26P )
	{
		MolarConc 0.02;
	}

	Variable Variable( gR )
	{
		Value	5.12;
	}

	Variable Variable( KmPFKF6P )
	{
		Value	0.1;
	}

	Variable Variable( KmPFKATP )
	{
		Value	0.71;
	}

	Variable Variable( Lzero )
	{
		Value	0.66;
	}

	Variable Variable( CiPFKATP )
	{
		Value	100.0;
	}

	Variable Variable( KiPFKATP )
	{
		Value	0.65;
	}

	Variable Variable( CPFKAMP )
	{
		Value	0.0845;
	}

	Variable Variable( KPFKAMP )
	{
		Value	0.0995;
	}

	Variable Variable( CPFKF26BP )
	{
		Value	0.0174;
	}

	Variable Variable( KPFKF26BP )
	{
		Value	6.82e-4;
	}

	Variable Variable( CPFKF16BP )
	{
		Value	0.397;
	}

	Variable Variable( KPFKF16BP )
	{
		Value	0.111;
	}

	Variable Variable( CPFKATP )
	{
		Value	3.0;
	}

	Variable Variable( AKeq_constant )
	{
		Value	0.45;
	}

	Variable Variable( TPIeq_constant )
	{
		Value	0.045;
	}


	Process ExpressionFluxProcess( Hexokinase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Glucose_in_Cytosol  :.:Glucose_in_Cytosol -1]
			[ High_energy_phosphates :.:High_energy_phosphates -1]
			[ Glucose_6_Phosphate  :.:Glucose_6_Phosphate 1]
			[ ATP_concentration  :.:ATP_concentration 0]
			[ ADP_concentration  :.:ADP_concentration 0];

		VmGLK  226.452;
		KmGLKGLCi  0.08;
		KmGLKATP  0.15;
		KeqGLK  3800.0;
		KmGLKG6P  30.0;
		KmGLKADP  0.23;

                Expression "self.getSuperSystem().SizeN_A * SIZE.Value * VmGLK / (KmGLKGLCi * KmGLKATP) * (Glucose_in_Cytosol.MolarConc * ATP_concentration.Value - Glucose_6_Phosphate.MolarConc * ADP_concentration.Value / KeqGLK) / ((1 + Glucose_in_Cytosol.MolarConc / KmGLKGLCi + Glucose_6_Phosphate.MolarConc / KmGLKG6P) * (1 + ATP_concentration.Value / KmGLKATP + ADP_concentration.Value / KmGLKADP))";
	}

 	Process ExpressionFluxProcess( Glucose_6_phosphate_isomerase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Glucose_6_Phosphate   :.:Glucose_6_Phosphate -1]
			[ Fructose_6_Phosphate  :.:Fructose_6_Phosphate 1];

		VmPGI_2  339.677;
		KmPGIG6P_2  1.4;
		KeqPGI_2  0.314;
		KmPGIF6P_2  0.3;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmPGI_2 / KmPGIG6P_2 * (Glucose_6_Phosphate.MolarConc - Fructose_6_Phosphate.MolarConc / KeqPGI_2) / (1 + Glucose_6_Phosphate.MolarConc / KmPGIG6P_2 + Fructose_6_Phosphate.MolarConc / KmPGIF6P_2)";
	}

	Process ExpressionFluxProcess( Glycogen_synthesis )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Glucose_6_Phosphate  :.:Glucose_6_Phosphate -1]
			[ High_energy_phosphates  :.:High_energy_phosphates -1]
			[ Glycogen  :.:Glycogen 1];

		KGLYCOGEN_3  6.0;

		Expression "SIZE.Value * KGLYCOGEN_3";
	}

	Process ExpressionFluxProcess( Trehalose_6_phosphate_synthase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Glucose_6_Phosphate  :.:Glucose_6_Phosphate -2]
			[ High_energy_phosphates  :.:High_energy_phosphates -1]
			[ Trehalose  :.:Trehalose 1];

		KTREHALOSE  2.4;

		Expression "SIZE.Value + KTREHALOSE";
	}

	Process ExpressionFluxProcess( Phosphofructokinase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Fructose_6_Phosphate  :.:Fructose_6_Phosphate -1]
			[ High_energy_phosphates  :.:High_energy_phosphates -1]
			[ Fructose_16_bisphosphate  :.:Fructose_16_bisphosphate 1]
			[ AMP_concentration  :.:AMP_concentration 0]
			[ ATP_concentration  :.:ATP_concentration 0]
			[ F26P  :.:F26P 0]
			[ gR  :.:gR 0]
			[ KmPFKF6P  :.:KmPFKF6P 0]
			[ KmPFKATP  :.:KmPFKATP 0]
			[ Lzero  :.:Lzero 0]
			[ CiPFKATP  :.:CiPFKATP 0]
			[ KiPFKATP  :.:KiPFKATP 0]
			[ CPFKAMP  :.:CPFKAMP 0]
			[ KPFKAMP  :.:KPFKAMP 0]
			[ CPFKF26BP  :.:CPFKF26BP 0]
			[ KPFKF26BP  :.:KPFKF26BP 0]
			[ CPFKF16BP  :.:CPFKF16BP 0]
			[ KPFKF16BP  :.:KPFKF16BP 0]
			[ CPFKATP  :.:CPFKATP 0];

		VmPFK  182.903;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmPFK * gR.Value * (Fructose_6_Phosphate.MolarConc / KmPFKF6P.Value) * (ATP_concentration.Value / KmPFKATP.Value) * (1 + Fructose_6_Phosphate.MolarConc / KmPFKF6P.Value + ATP_concentration.Value / KmPFKATP.Value + gR.Value * (Fructose_6_Phosphate.MolarConc / KmPFKF6P.Value) * (ATP_concentration.Value / KmPFKATP.Value)) / (pow((1 + Fructose_6_Phosphate.MolarConc / KmPFKF6P.Value + ATP_concentration.Value / KmPFKATP.Value + gR.Value * (Fructose_6_Phosphate.MolarConc / KmPFKF6P.Value) * (ATP_concentration.Value / KmPFKATP.Value)), 2) + (SIZE.Value * pow((1 + CiPFKATP.Value * (ATP_concentration.Value / KiPFKATP.Value)) / (1 + ATP_concentration.Value / KiPFKATP.Value), 2) * pow((1 + CPFKAMP.Value * (AMP_concentration.Value / KPFKAMP.Value)) / (1 + AMP_concentration.Value / KPFKAMP.Value), 2)  * pow((1 + CPFKF26BP.Value * F26P.Value / KPFKF26BP.Value + CPFKF16BP.Value * Fructose_16_bisphosphate.MolarConc / KPFKF16BP.Value) / (1 + F26P.Value / KPFKF26BP.Value + Fructose_16_bisphosphate.MolarConc / KPFKF16BP.Value), 2)) * pow((1 + CPFKATP.Value * (ATP_concentration.Value / KmPFKATP.Value)), 2))";
	}

	Process ExpressionFluxProcess( Aldolase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Fructose_16_bisphosphate  :.:Fructose_16_bisphosphate -1]
			[ Triose_phosphate  :.:Triose_phosphate 2]
			[ TPIeq_constant  :.:TPIeq_constant 0];

		VmALD  322.258;
		KmALDF16P  0.3;
		KeqALD  0.069;
		KmALDGAP  2.0;
		KmALDDHAP  2.4;
		KmALDGAPi  10.0;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmALD / KmALDF16P * (Fructose_16_bisphosphate.MolarConc - TPIeq_constant.Value / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc * (1 / (1 + TPIeq_constant.Value)) * Triose_phosphate.MolarConc / KeqALD) / (1 + Fructose_16_bisphosphate.MolarConc / KmALDF16P + TPIeq_constant.Value / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc / KmALDGAP + 1 / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc / KmALDDHAP + TPIeq_constant.Value / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc * (1 / (1 + TPIeq_constant.Value)) * Triose_phosphate.MolarConc / (KmALDGAP * KmALDDHAP) + Fructose_16_bisphosphate.MolarConc * (TPIeq_constant.Value / (1 + TPIeq_constant.Value)) * Triose_phosphate.MolarConc / (KmALDGAPi * KmALDF16P))";
	}

	Process ExpressionFluxProcess( Glyceraldehyde_3_phosphate_dehydrogenase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Triose_phosphate  :.:Triose_phosphate -1]
			[ NAD  :.:NAD -1]
			[ bisphosphoglycreate_13  :.:bisphosphoglycreate_13 1]
			[ NADH  :.:NADH 1]
			[ TPIeq_constant  :.:TPIeq_constant 0];

		VmGAPDHf  1184.52;
		KmGAPDHGAP  0.21;
		KmGAPDHNAD  0.09;
		VmGAPDHr  6549.8;
		KmGAPDHBPG  0.0098;
		KmGAPDHNADH  0.06;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * (VmGAPDHf * (TPIeq_constant.Value / (1 + TPIeq_constant.Value)) * Triose_phosphate.MolarConc * NAD.MolarConc / (KmGAPDHGAP * KmGAPDHNAD) - VmGAPDHr * bisphosphoglycreate_13.MolarConc * NADH.MolarConc / (KmGAPDHBPG * KmGAPDHNADH)) / ((1 + TPIeq_constant.Value / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc / KmGAPDHGAP + bisphosphoglycreate_13.MolarConc / KmGAPDHBPG) * (1 + NAD.MolarConc / KmGAPDHNAD + NADH.MolarConc / KmGAPDHNADH))";
	}

	Process ExpressionFluxProcess( Phosphoglycreate_kinase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ bisphosphoglycreate_13  :.:bisphosphoglycreate_13 -1]
			[ phosphoglycreate_3  :.:phosphoglycreate_3 1]
			[ High_energy_phosphates  :.:High_energy_phosphates 1]
			[ ADP_concentration  :.:ADP_concentration 0]
			[ ATP_concentration  :.:ATP_concentration 0];

		VmPGK  1306.45;
		KmPGKP3G  0.53;
		KmPGKATP  0.3;
		KeqPGK  3200.0;
		KmPGKBPG  0.0030;
		KmPGKADP  0.2;

		Expression "(  (    (SIZE.Value * VmPGK) / (KmPGKP3G * KmPGKATP)  ) *  (   (KeqPGK * bisphosphoglycreate_13.MolarConc * ADP_concentration.Value - phosphoglycreate_3.MolarConc * ATP_concentration.Value)  )) / (  (1+ bisphosphoglycreate_13.MolarConc / KmPGKBPG + phosphoglycreate_3.MolarConc / KmPGKP3G) *  (1 + ATP_concentration.Value / KmPGKATP + ADP_concentration.Value / KmPGKADP))";
	}

	Process ExpressionFluxProcess( Phosphoglycreate_mutase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ phosphoglycreate_3  :.:phosphoglycreate_3 -1]
			[ phosphoglycreate_2  :.:phosphoglycreate_2 1];

		VmPGM  2525.81;
		KmPGMP3G  1.2;
		KeqPGM  0.19;
		KmPGMP2G  0.08;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmPGM / KmPGMP3G * (phosphoglycreate_3.MolarConc - phosphoglycreate_2.MolarConc / KeqPGM) / (1 + phosphoglycreate_3.MolarConc / KmPGMP3G + phosphoglycreate_2.MolarConc / KmPGMP2G)";
	}

	Process ExpressionFluxProcess( Enolase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ phosphoglycreate_2  :.:phosphoglycreate_2 -1]
			[ Phosphoenolpyruvate  :.:Phosphoenolpyruvate 1];

		VmENO 365.806;
		KmENOP2G  0.04;
		KeqENO  6.7;
		KmENOPEP  0.5;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmENO / KmENOP2G * (phosphoglycreate_2.MolarConc - Phosphoenolpyruvate.MolarConc / KeqENO) / (1 + phosphoglycreate_2.MolarConc / KmENOP2G + Phosphoenolpyruvate.MolarConc / KmENOPEP)";

	}
	Process ExpressionFluxProcess( Pyruvate_kinase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Phosphoenolpyruvate  :.:Phosphoenolpyruvate -1]
			[ Pyruvate  :.:Pyruvate 1]
			[ High_energy_phosphates  :.:High_energy_phosphates 1]
			[ ATP_concentration  :.:ATP_concentration 0]
			[ ADP_concentration  :.:ADP_concentration 0];

		VmPYK  1088.71;
		KmPYKPEP  0.14;
		KmPYKADP  0.53;
		KeqPYK  6500.0;
		KmPYKPYR  21.0;
		KmPYKATP  1.5;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmPYK / (KmPYKPEP * KmPYKADP) * (Phosphoenolpyruvate.MolarConc * ADP_concentration.Value - Pyruvate.MolarConc * ATP_concentration.Value / KeqPYK) / ((1 + Phosphoenolpyruvate.MolarConc / KmPYKPEP + Pyruvate.MolarConc / KmPYKPYR) * (1 + ATP_concentration.Value / KmPYKATP + ADP_concentration.Value / KmPYKADP))";
	}

	Process ExpressionFluxProcess( Pyruvate_decarboxylase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Pyruvate  :.:Pyruvate -1]
			[ Acetaldehyde  :.:Acetaldehyde 1]
			[ CO2  :.:CO2 1];

		VmPDC  174.194;
		nPDC  1.9;
		KmPDCPYR  4.33;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmPDC * (pow(Pyruvate.MolarConc, nPDC) / pow(KmPDCPYR, nPDC)) / (1 + pow(Pyruvate.MolarConc, nPDC) / pow(KmPDCPYR, nPDC))";
	}

	Process ExpressionFluxProcess( Succinate_synthesis )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Acetaldehyde  :.:Acetaldehyde -2]
			[ NAD  :.:NAD -3]
			[ High_energy_phosphates  :.:High_energy_phosphates -4]
			[ NADH  :.:NADH  3]
			[ Succinate  :.:Succinate 1];

		KSUCC  21.4;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * KSUCC * Acetaldehyde.MolarConc";
	}

	Process ExpressionFluxProcess( Glucose_transport )
	{
		StepperID	ODE;

		VariableReferenceList
			[ Extracellular_Glucose  :../Extracellular:Extracellular_Glucose -1]
			[ Glucose_in_Cytosol  :.:Glucose_in_Cytosol 1];

		VmGLT  97.264;
		KmGLTGLCo  1.1918;
		KeqGLT  1.0;
		KmGLTGLCi  1.1918;

		Expression "self.getSuperSystem().SizeN_A * (VmGLT / KmGLTGLCo * (Extracellular_Glucose.MolarConc - Glucose_in_Cytosol.MolarConc / KeqGLT) / (1 + Extracellular_Glucose.MolarConc / KmGLTGLCo + Glucose_in_Cytosol.MolarConc / KmGLTGLCi + 0.91 * Extracellular_Glucose.MolarConc * Glucose_in_Cytosol.MolarConc / (KmGLTGLCo * KmGLTGLCi)) )";
	}

	Process ExpressionFluxProcess( Alcohol_dehydrogenase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Acetaldehyde  :.:Acetaldehyde -1]
			[ NADH  :.:NADH -1]
			[ NAD  :.:NAD 1]
			[ Ethanol  :.:Ethanol 1];

		VmADH  810.0;
		KiADHNAD  0.92;
		KmADHETOH  17.0;
		KeqADH  6.9E-5;
		KmADHNAD  0.17;
		KmADHNADH  0.11;
		KiADHNADH  0.031;
		KmADHACE  1.11;
		KiADHACE  1.1;
		KiADHETOH  90.0;

		Expression "-1 * SIZE.Value * self.getSuperSystem().SizeN_A * (VmADH / (KiADHNAD * KmADHETOH) * (NAD.MolarConc * Ethanol.MolarConc - NADH.MolarConc * Acetaldehyde.MolarConc / KeqADH) / (1 + NAD.MolarConc / KiADHNAD + KmADHNAD * Ethanol.MolarConc / (KiADHNAD * KmADHETOH) + KmADHNADH * Acetaldehyde.MolarConc / ( KiADHNADH * KmADHACE) + NADH.MolarConc / KiADHNADH + NAD.MolarConc * Ethanol.MolarConc / (KiADHNAD * KmADHETOH) + KmADHNADH * NAD.MolarConc * Acetaldehyde.MolarConc / (KiADHNAD * KiADHNADH * KmADHACE) + KmADHNAD * Ethanol.MolarConc * NADH.MolarConc / (KiADHNAD * KmADHETOH * KiADHNADH) + NADH.MolarConc * Acetaldehyde.MolarConc / (KiADHNADH * KmADHACE) + NAD.MolarConc * Ethanol.MolarConc * Acetaldehyde.MolarConc / (KiADHNAD * KmADHETOH * KiADHACE) + Ethanol.MolarConc * NADH.MolarConc * Acetaldehyde.MolarConc / (KiADHETOH * KiADHNADH * KmADHACE)))";
	}

	Process ExpressionFluxProcess( Glycerol_3_phosphate_dehydrogenase )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ Triose_phosphate  :.:Triose_phosphate -1]
			[ NADH  :.:NADH -1]
			[ NAD  :.:NAD 1]
			[ Glycerol  :.:Glycerol 1]
			[ TPIeq_constant  :.:TPIeq_constant 0];

		VmG3PDH  70.15;
		KmG3PDHDHAP  0.4;
		KmG3PDHNADH  0.023;
		KeqG3PDH  4300.0;
		KmG3PDHGLY  1.0;
		KmG3PDHNAD  0.93;

		Expression "SIZE.Value * self.getSuperSystem().SizeN_A * VmG3PDH / (KmG3PDHDHAP * KmG3PDHNADH) * (1 / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc * NADH.MolarConc - Glycerol.MolarConc * NAD.MolarConc / KeqG3PDH) / ((1 + 1 / (1 + TPIeq_constant.Value) * Triose_phosphate.MolarConc / KmG3PDHDHAP + Glycerol.MolarConc / KmG3PDHGLY) * (1 + NADH.MolarConc / KmG3PDHNADH + NAD.MolarConc / KmG3PDHNAD))";
	}

	Process ExpressionFluxProcess( ATPase_activity )
	{
		StepperID	ODE;

		VariableReferenceList
			[ SIZE  :.:SIZE 0]
			[ High_energy_phosphates  :.:High_energy_phosphates -1]
			[ ATP_concentration  :.:ATP_concentration 0];

		KATPASE  33.7;

		Expression "SIZE.Value * KATPASE * ATP_concentration.Value";
	}

	Process ExpressionAssignmentProcess( ADP_concentration )
	{
		StepperID	PSV;

		VariableReferenceList
			[ sum_of_AXP_conc  :.:sum_of_AXP_conc 0]
			[ High_energy_phosphates  :.:High_energy_phosphates 0]
			[ ADP_concentration  :.:ADP_concentration 1]
			[ AKeq_constant  :.:AKeq_constant 0];

		Expression "self.getSuperSystem().SizeN_A * (sum_of_AXP_conc.MolarConc - pow(pow(High_energy_phosphates.MolarConc, 2) * (1 - 4 * AKeq_constant.Value) + 2 * sum_of_AXP_conc.MolarConc * High_energy_phosphates.MolarConc * (4 * AKeq_constant.Value -1) + pow(sum_of_AXP_conc.MolarConc, 2), 0.5) / (1 - 4 * AKeq_constant.Value) )";
	}

	Process ExpressionAssignmentProcess( ATP_concentration )
	{
		StepperID	PSV;

		VariableReferenceList
			[ High_energy_phosphates  :.:High_energy_phosphates 0]
			[ ADP_concentration  :.:ADP_concentration 0]
			[ ATP_concentration  :.:ATP_concentration 1];

		Expression "self.getSuperSystem().SizeN_A * (High_energy_phosphates.MolarConc - ADP_concentration.Value) / 2";
	}

	Process ExpressionAssignmentProcess( AMP_concentration )
	{
		StepperID	PSV;

		VariableReferenceList
			[ sum_of_AXP_conc  :.:sum_of_AXP_conc 0]
			[ ATP_concentration  :.:ATP_concentration 0]
			[ ADP_concentration  :.:ADP_concentration 0]
			[ AMP_concentration  :.:AMP_concentration 1];

		Expression "self.getSuperSystem().SizeN_A * (sum_of_AXP_conc.MolarConc - ATP_concentration.Value - ADP_concentration.Value)";
	}

}

