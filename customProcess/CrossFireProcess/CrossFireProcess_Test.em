# Stepper ODEStepper( DE1 )
Stepper FixedODE1Stepper( ODE )
{
	StepInterval  0.001;
}

Stepper DiscreteTimeStepper( DT )
{
	StepInterval  0.001;
}

System System( / )
{
	StepperID	ODE;

	Variable Variable( t )
	{
		Value	0.0;
	}

	Process ExpressionFluxProcess( clock )
	{
		Priority 10;

		VariableReferenceList
			[ t :.:t 1 ];
		Expression "1.0";
	}

	Variable Variable( x )
	{
		Value	0.0;
	}
	
	Process ExpressionFluxProcess( dxdt )
	{
		VariableReferenceList
			[ t :.:t 0 ]
			[ x :.:x 1 ];
		Expression "cos( t.Value )";
	}
	
	Variable Variable( flag )
	{
		Value	0.0;
	}

	Process CrossFireProcess( flag )
	{
		StepperID  DT;

		VariableReferenceList
			[ target :.:x    0 ]
			[ flag   :.:flag 1 ];

		threshold    0.5;
		isFromBelow  1;
		delay  0.1;
	}

	Variable Variable( y )
	{
		Value	1.0;
	}

	Process ExpressionFluxProcess( dydt )
	{
		Priority 10;

		VariableReferenceList
			[ _ :.:y 1 ];
		Expression "0.5 / pi";
	}

	Process ExpressionFluxProcess( devide_y )
	{
		VariableReferenceList
			[ flag   :.:flag 0 ]
			[ target :.:y    1 ];

		Expression "- eq( flag.Value, 1.0 ) * target.Value * 500.0";
	}

}

