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
	
	Variable Variable( delay_t )
	{
		Value	0.0;
	}
	
	Process ExpressionFluxProcess( t )
	{
		VariableReferenceList  [ t :.:t 1 ];
		Expression "1.0";
	}

	Process DelayProcess( delay )
	{
		StepperID	DT;

		VariableReferenceList
			[ original :.:t       0 ]
			[ delayed  :.:delay_t 1 ];

		tau  20.0;
	}
}

