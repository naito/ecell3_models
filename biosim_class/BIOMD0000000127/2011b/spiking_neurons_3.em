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
}

System System( /CELL )
{
	StepperID	ODE;

	Variable Variable( t )
	{
		Value	0.0;
	}

	Variable Variable( a )
	{
		Value	0.02;
	}

	Variable Variable( b )
	{
		Value	0.2;
	}	

	Variable Variable( c )
	{
		Value	-65.0;
	}	

	Variable Variable( d )
	{
		Value	8.0;
	}

	Variable Variable( Vthresh )
	{
		Value	30.0;
	}

	Variable Variable( i )
	{
                Value   0.0;
	}

	Variable Variable( v )
	{
		Value	-70.0;
	}

	Variable Variable( U )
	{
		Value	-14.0;
	}



	Process ExpressionFluxProcess( dv_dt )
	{

	  VariableReferenceList
	    [v	:.:v	1]
	    [U	:.:U	0]
	    [i	:.:i	0];

	  Expression  
	    "0.04 * pow(v.Value , 2) + 5 * v.Value + 140 - U.Value + i.Value";
	}

	Process ExpressionFluxProcess( dU_dt )
	{

	  VariableReferenceList
	    [v	:.:v	0]
	    [U	:.:U	1]
	    [a	:.:a	0]
	    [b	:.:b	0];

	  Expression  
	  "a.Value * (b.Value * v.Value - U.Value) "; 

	}



	Process ExpressionFluxProcess( clock )
	{

          VariableReferenceList
	    [t	:.:t	1];

	  Expression "1.0";

	}



	Process ExpressionAssignmentProcess( Stimulus )
	{

	  StepperID	PSV;
	
	  VariableReferenceList
	    [i	:.:i	1]
	    [t	:.:t	0];

	  Expression
	  "gt( t.Value , 10 ) * 10";

	}



	Process ExpressionAssignmentProcess( event_0000001_v )
	{
	Priority -1;
	  StepperID	PSV;
	
	  VariableReferenceList
	    [v	:.:v	1]
	    [c	:.:c	0]
	    [Vthresh	:.:Vthresh	0];

	  Expression"@
	     gt(v.Value,       Vthresh.Value) * c.Value + @
	     gt(Vthresh.Value,       v.Value) * v.Value";
	}



	Process ExpressionAssignmentProcess( event_0000001_U )
	{
#		Priority -1;
	  StepperID	PSV;
	
	  VariableReferenceList
	    [v	:.:v	0]
	    [U	:.:U	1]
	    [d	:.:d	0]
	    [Vthresh	:.:Vthresh	0];

            Expression "U.Value + gt(v.Value , Vthresh.Value) * d.Value";

	}



}




#	Process ExpressionAssignmentProcess( I_ext )
#	{
#		StepperID	PSV;
#
#		VariableReferenceList
#			[ I :.:I 1 ]
#			[ t :.:t 0 ];
#
#		t_start  5.0;
#		t_end    6.0;
#		I_test   -8.0;
#
#  Expression "and( geq( t.Value, t_start ), leq( t.Value, t_end )) * I_test";
#	}

