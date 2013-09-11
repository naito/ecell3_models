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

System System( /ENVIRONMENT )
{
	StepperID ODE;

	Variable Variable( SIZE )
	{
		Value	1.0;
	}

	Variable Variable( IPTG ){ Value 5.0; } #IPTG
	Variable Variable( C1 ){ Value 20.0; } #Predator Cells
	Variable Variable( C2 ){ Value 20.0; } #Prey Cells
	Variable Variable( A1 ){ Value 0.1; } #3OC12HSL
	Variable Variable( A2 ){ Value 0.1; } #3OC6HSL
	Variable Variable( sink ){ Value 0.0; } #sink
	Variable Variable( source ){ Value 0.0; } #source

	Process ExpressionFluxProcess( R1 ) #Predator Growth
	{
		kc1 0.8;
		Cm 100.0;
		Expression "self.getSuperSystem().Size * kc1 * C1.Value * ( 1 - ( C1.Value + C2.Value ) / Cm )";

		VariableReferenceList [ C1 :.:C1 1 ] [ C2 :.:C2 0 ] [ source :.:source -1];
	}
	
	Process ExpressionFluxProcess( R2 ) #Predator Death 
	{
		D 0.1125; 
		K1 10.0;
		Expression "self.getSuperSystem().Size * ( D + (0.5 + pow( IPTG.Value, 2) / ( 25 + pow( IPTG.Value, 2))) * K1 / ( K1 + pow( A2.Value, 2))) * C1.Value";

		VariableReferenceList [ C1 :.:C1 -1 ] [ IPTG :.:IPTG 0 ] [ sink :.:sink +1 ] [ A2 :.:A2 0 ];
	}	

	Process ExpressionFluxProcess( R3 ) #Prey Growth
	{
		kc2 0.4;
		Cm 100;
		Expression "self.getSuperSystem().Size * kc2 * C2.Value * ( 1 - ( C1.Value + C2.Value ) / Cm )";
		
		VariableReferenceList [ source :.:source -1 ] [ C2 :.:C2 1 ] [ C1 :.:C1 0 ];				
	}

	Process ExpressionFluxProcess( R4 ) #Prey Death
	{
		D 0.1125;
		d2 0.3;
		K2 10.0;
		
		Expression "self.getSuperSystem().Size * ( D + d2 * pow(A1.Value, 2) / ( K2 + pow(A1.Value, 2))) * C2.Value";
	
		VariableReferenceList [ C2 :.:C2 -1 ] [ sink :.:sink 1 ] [ A1 :.:A1 0 ];
	}

	Process ExpressionFluxProcess( R5 ) #3OC12HSL Synthesis
	{
		kA1 0.1;
		Expression "self.getSuperSystem().Size * kA1 * C1.Value";
	
		VariableReferenceList [ A1 :.:A1 1 ] [ source :.:source -1 ] [ C1 :.:C1 0 ];
	}
	
	Process ExpressionFluxProcess( R6 ) #3OC12HSL Removal
	{
		dAA1 0.017;
		D 0.1125;
		Expression "self.getSuperSystem().Size * ( dAA1 + D ) * A1.Value";
	
		VariableReferenceList [ A1 :.:A1 -1 ] [ sink :.:sink 1 ];
	}
	
	Process ExpressionFluxProcess( R7 ) #3OC6HSL Synthesis
	{
		Expression "self.getSuperSystem().Size * ( 0.02 + 0.03 * pow(IPTG.Value, 2) / ( 25 + pow(IPTG.Value, 2))) * C2.Value";
	
		VariableReferenceList [source :.:source -1 ] [A2 :.:A2 +1 ] [ C2 :.:C2 0 ] [ IPTG :.:IPTG 0];
	}

	Process ExpressionFluxProcess( R8 ) #3OC6HSL Removal
	{
		dAA2 0.11;
		D 0.1125;
		Expression "self.getSuperSystem().Size * (  dAA2 + D ) * A2.Value";
	
		VariableReferenceList [sink :.:sink +1 ] [A2 :.:A2 -1 ];
	}
}

