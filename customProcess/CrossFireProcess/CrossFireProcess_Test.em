# Stepper ODEStepper( DE1 )
Stepper FixedODE1Stepper( ODE )
{
	# no property
}

Stepper DiscreteTimeStepper( DT )
{
	# no property
}

System System( / )
{
	StepperID	ODE;

	Variable Variable( t )
	{
		Value	0.0;
	}

	Variable Variable( x )
	{
		Value	0.0;
	}
	
	Variable Variable( y )
	{
		Value	0.0;
	}
	
	Process ExpressionFluxProcess( t )
	{
		VariableReferenceList  [ t :.:t 1 ];
		Expression "1.0";
	}
	
	Process ExpressionFluxProcess( cos )
	{
		VariableReferenceList  [ x :.:x 1 ];
		Expression "cos( x.Value )";
	}

	Process CrossFireProcess( switch )
	{
		StepperID	DT;

		VariableReferenceList
			[ object :.:x       0 ]
			[ switch :.:delay_t 1 ];

		threshold    0.5;
		isFromBelow  1;
		delay  1.0;
	}
}

