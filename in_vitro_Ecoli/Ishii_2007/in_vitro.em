### In Vitro Glycolysis model

@{
N_A  = 6.02214 * 1.0e+23	#アボガドロ数
Voli = 1.0e-13 	 		#サイズ
}

Stepper FixedODE1Stepper( DE1 )
{
	#no property
}

System System( / )
{
	StepperID	DE1;
}

System System( /CELL )
{
	StepperID	DE1;
	
	Variable Variable( SIZE )
	{
		Value	@( Voli );
	}
}

System System( /CELL/IN_VITRO )
{
	StepperID	DE1;

	Variable Variable( SIZE )
	{
		Value	@( Voli );
	}

	Variable Variable( ADP )
	{
		Value	0;
	}

	Variable Variable( ATP )
	{
		Value	@( 2.0e-3 * Voli * N_A );
	}

	Variable Variable( Glucose )
	{
		Value	@( 1.0e-3 * Voli * N_A);
	}
	
	Variable Variable( G6P )
	{
		Value	0;
	}

	Variable Variable( F6P )
	{
		Value	0;
	}

	Variable Variable( FDP )
	{
		Value	0;
	}

	Variable Variable( Glk_active )
	{
		Value	@(0.05e-6 * Voli * 34717);	# g
	}

	Variable Variable( Glk_inactive )
	{
		Value	0;	# g
	}


## In vitro Glycolytic Reactions ##

	Process ExpressionFluxProcess( Inactivation_Glk )
	{
		Name	"Inactivation_Glucokinase";
		
		Expression "Kglk * (S0.Value - P0.Value / Keq)";
		
		Kglk	@(0.29 / 60);	# 1/sec
		Keq	2.72;

		VariableReferenceList
		[ S0 :.:Glk_active -1 ]
		[ P0 :.:Glk_inactive 1 ];
	}

      	Process ExpressionFluxProcess( Glk )
	{
		Name	"Glucokinase";
		
		Expression "(C0.Value * Vm * S0.MolarConc * S1.MolarConc)/((KmGlucose+S0.MolarConc)*(KmATP+S1.MolarConc)) * N_A";
		
		Vm	   @(255.0e-3 / 60);	# mol/g/sec
		KmGlucose  1.2e-4;    #M
		KmATP	   5.0e-4;    #M

		VariableReferenceList
		[ S0 :.:Glucose -1 ]
		[ S1 :.:ATP -1]
		[ P0 :.:G6P 1 ]
		[ C0 :.:Glk_active 0 ];
	}

	Process ExpressionFluxProcess( Pgi ) 
	{
		Name	"Phosphoglucoisomerase";

		Expression "( Pgi * Vm * (S0.MolarConc - P0.MolarConc / Keq) / (KmG6P*(1+P0.MolarConc/KmF6P)+ S0.MolarConc)) * N_A";

		Keq	   0.30;
		
		Pgi	@(5.0e-8 * Voli * 61517);	# g
		Vm	@(1511.0e-3 / 60);		# mol/g/sec
		KmG6P	3.0e-3; #M
		KmF6P	1.6e-4;	#M
		
		VariableReferenceList
		[ S0 :.:G6P -1 ]
		[ P0 :.:F6P 1 ];
	}

	Process ExpressionFluxProcess( PfkA )
	{
		Name	"Phosphofructokinase";

		Expression "(PfkA * Vm * pow(S0.MolarConc, n) * S1.MolarConc / ((pow(KmF6P, n) + pow(S0.MolarConc, n)) * (KmATP + S1.MolarConc))) * N_A";

		PfkA	   @(5.0e-8 * Voli * 34834);	   #g
		Vm	   @(145.0e-3 / 60); # mol/g/sec
		KmF6P	   4.6e-4;    # M
		KmATP	   4.0e-5;    # M
		n	   1.9;

		VariableReferenceList
		[ S0 :.:F6P -1 ]
		[ S1 :.:ATP -1]
		[ P0 :.:FDP 1 ];
	}
}