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

	Variable Variable( SIZE )
	{
		Value	1.0;
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
		VariableReferenceList
			[ t :.:t 1 ];

		Expression "1.0";
	}

	Process ExpressionAssignmentProcess( I_ext )
	{
		StepperID	PSV;

		VariableReferenceList
			[ I :.:I 1 ]
			[ t :.:t 0 ];

		t_start  10.0;
		I_test   10.0;
		Expression "gt( t.Value, t_start ) * I_test";
	}

}

System System( /CELL )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value	1.0;
	}

	Variable Variable( a )
	{
		Name "a";
		Value	0.02;
	}

	Variable Variable( b )
	{
		Name  "b";
		Value 0.2;
	}

	Variable Variable( c )
	{
		Name "c";
		Value -65.0;
	}

	Variable Variable( d )
	{
		Name  "d";
		Value 8.0;
	}

	Variable Variable( Vthresh )
	{
		Name "Vthresh";
		Value	30.0;
	}

	Variable Variable( v )
	{
		Name "v";
		Value	-70.0;
	}

	Variable Variable( U )
	{
		Name  "U";
		Value -14.0;
	}


	Process ExpressionAssignmentProcess( U )
	{
		StepperID	PSV;
		VariableReferenceList
			[ U    :.:U    1 ]
			[ d    :.:d    0 ]
			[ Vthresh    :.:Vthresh    0 ]
			[ v    :.:v    0 ];

		Expression "U.Value + d.Value * gt ( v.Value, Vthresh.Value )";
		
	}

	Process ExpressionAssignmentProcess( v )
	{
		StepperID	PSV;
		VariableReferenceList
			[ v    :.:v    1 ]
			[ Vthresh    :.:Vthresh    0 ]
			[ c    :.:c    0 ];

		Expression "v.Value * leq ( v.Value, Vthresh.Value ) + c.Value * gt ( v.Value, Vthresh.Value )";
		
	}


	Process ExpressionFluxProcess( dvdt )
	{
		VariableReferenceList
			[ v    :.:v    1 ]
			[ U    :.:U    0 ]
			[ I    :..:I    0 ];

		Expression "0.04 * pow(v.Value,2) + 5 * v.Value + 140 - U.Value + I.Value";
	}

	Process ExpressionFluxProcess( dUdt )
	{
		VariableReferenceList
			[ v :.:v       0 ]
			[ U :.:U       1 ]
 			[ a :.:a       0 ]
 			[ b :.:b       0 ];

		Expression "a.Value * ( b.Value * v.Value - U.Value )";
	}
}

