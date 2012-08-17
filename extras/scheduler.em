Stepper FixedODE1Stepper( ODE )
{
	StepInterval @( 0.001 / 60.0 );
}

Stepper PassiveStepper( PSV ){}

System System( / )
{
	StepperID  ODE;

	Variable Variable( SIZE )
	{
		# no property
	}

	Variable Variable( currentTime )
	{
		Name    "Current Time";
		Value   1.0;
	}

	Process ExpressionFluxProcess( clock )
	{
		Name    "Clock";
		VariableReferenceList  [ t :.:currentTime 1 ];
		Expression  "1.0";
	}

	Variable Variable( X )
	{
		Name    "Variable X";
		Value   0.0;
	}

	Process ExpressionFluxProcess( X )
	{
		VariableReferenceList
			[ t :.:currentTime 0 ]
			[ x :.:X           1 ];

		# E-Cell Fundamentals p.49
		Expression  "leq( t.Value, 30.0 ) * 1.0 + and( gt( t.Value, 30.0 ), leq( t.Value, 60.0 )) * (-1.0) + gt( t.Value, 60.0 ) * 2.0";
	}

	Variable Variable( Y )
	{
		Name    "Variable Y";
		Value   0.0;
	}

	Process ExpressionAssignmentProcess( Y )
	{
		StepperID  PSV;
		VariableReferenceList
			[ t :.:currentTime 0 ]
			[ x :.:Y           1 ];

		# E-Cell Fundamentals p.49
		Expression  "leq( t.Value, 30.0 ) * 1.0 + and( gt( t.Value, 30.0 ), leq( t.Value, 60.0 )) * (-1.0) + gt( t.Value, 60.0 ) * 2.0";
	}

}

