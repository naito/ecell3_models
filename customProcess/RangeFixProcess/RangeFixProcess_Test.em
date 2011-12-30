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

	Variable Variable( x1 )
	{
		Value	100.0;
	}

	Variable Variable( x2 )
	{
		Value	100.0;
	}

	Variable Variable( x3 )
	{
		Value	100.0;
	}

	Variable Variable( x4 )
	{
		Value	100.0;
	}

	Variable Variable( x5 )
	{
		Value	100.0;
	}

	Variable Variable( x6 )
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
		VariableReferenceList
			[ x1 :.:x1 1 ]
			[ x2 :.:x2 1 ]
			[ x3 :.:x3 1 ]
			[ x4 :.:x4 1 ]
			[ x5 :.:x5 1 ]
			[ x6 :.:x6 1 ];
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

		VariableReferenceList       # cefficient
			[ max    :.:max 0 ]   # 0: 制御対象外
			[ min    :.:min 0 ]
			[ target :.:x1  1 ]   # 1: 領域内 Fix、      領域外 Not Fix
			[ x2     :.:x2  2 ]   # 2: 領域内 Fix、      領域外 No Change
			[ x3     :.:x3  3 ]   # 3: 領域内 Not Fix、  領域外 Fix
			[ x4     :.:x4  4 ]   # 4: 領域内 Not Fix、  領域外 No Change
			[ x5     :.:x5  5 ]   # 5: 領域内 No Change、領域外 Fix
			[ x6     :.:x6  6 ];  # 6: 領域内 No Change、領域外 Not Fix
	}
}

