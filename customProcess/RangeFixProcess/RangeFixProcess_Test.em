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

	Variable Variable( x )
	{
		Value	100.0;
	}

	Variable Variable( max )
	{
		Value	0.0;
	}

	Variable Variable( min )
	{
		Value	-200.0;
	}
	
	Process ExpressionFluxProcess( x )
	{
		VariableReferenceList	[ x :.:x 1 ];
		Expression "0.5";
	}
	
	Process ExpressionFluxProcess( range_mover )
	{
		VariableReferenceList
			[ max :.:max 1 ]
			[ min :.:min 1 ];
		Expression "1.0";
	}

	Process RangeFixProcess( fix )
	{
		StepperID	DT;

		VariableReferenceList
			[ max    :.:max 0 ]
			[ min    :.:min 0 ]
			[ target :.:x   1 ];

		mode  1;
	}
}

