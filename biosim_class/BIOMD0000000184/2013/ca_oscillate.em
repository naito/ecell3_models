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
	StepperID ODE;

	Variable Variable( SIZE )
	{
		Value	1.0;
	}
}

System System( /CYTOSOL )
{
	StepperID ODE;

	Variable Variable( SIZE )
	{
		Value	1.0;
	}

	Variable Variable( X ){ Value 0.1; } #Cytoplasmic Calcium
	Variable Variable( Y ){ Value 1.5; } #Calcium in ER
	Variable Variable( Z ){ Value 0.1; } #IP3
	
	Process ExpressionFluxProcess( R1 ) #Uptake of extracellular Ca to Cytosol
	{
		vin 0.05;
		Expression "self.getSuperSystem().Size * vin";

		VariableReferenceList [ X :.:X 1 ];
	}
	
	Process ExpressionFluxProcess( R2 ) #Efflux of cytoplasmic Ca 
	{
		kout 0.5;
		Expression "self.getSuperSystem().Size * kout * X.Value";

		VariableReferenceList [ X :.:X -1 ];
	}	

	Process ExpressionFluxProcess( R3 ) #Stimulation of Ca flow from ER to Cytosol by IP3
	{
		vM3 40.0;
		k_CaA 0.15;
		n 2.02;
		k_CaI 0.15;
		m 2.2;
		kip3 0.1;

		Expression "4 * vM3 * pow(k_CaA, n) * (pow(X.Value, n) / ((pow(X.Value, n) + pow(k_CaA, n)) * (pow(X.Value, n) + pow(k_CaI, n)))) * pow(Z.Value, m) / (pow(Z.Value, m) + pow(kip3, m)) * (Y.Value - X.Value)";
		
		VariableReferenceList [ A :/ER:A 0 ] [ X :.:X 1 ] [ Y :.:Y -1 ] [ Z :.:Z 0 ];				
	}

	Process ExpressionFluxProcess( R4 ) #Uptake of cytoplasmic Ca to ER
	{
		vM2 15.0;
		k2 0.1;
		Expression "self.getSuperSystem().Size * vM2 * pow(X.Value,2) / (pow(X.Value,2) + pow(k2,2))";
	
		VariableReferenceList [ X :.:X -1 ] [ Y :.:Y 1 ];
	}

	Process ExpressionFluxProcess( R5 ) #Release of ER Ca to Cytosol
	{
		kf 0.5;
		Expression "kf * ( Y.Value - X.Value )";
	
		VariableReferenceList [ A :/ER:A 0 ] [ X :.:X 1 ] [ Y :.:Y -1 ];
	}
	
	Process ExpressionFluxProcess( R6 ) #PLC activity
	{
		vp 0.05;
		kp 0.3;
		Expression "self.getSuperSystem().Size * vp * pow(X.Value,2) / (pow(X.Value,2) + pow(kp,2))";
	
		VariableReferenceList [ X :.:X 0 ] [Z :.:Z 1];
	}
	
	Process ExpressionFluxProcess( R7 ) #IP3 Degradation
	{
		kdeg 0.08;
		Expression "self.getSuperSystem().Size * kdeg * Z.Value";
	
		VariableReferenceList [Z :.:Z -1];
	}

}

System System( /ER )
{
	StepperID	ODE;
	
	Variable Variable( A ){ Value 0; }
	Variable Variable( SIZE )
	{
		Value	1.0;
	}




}
