Stepper FixedODE1Stepper( ODE )
{
		# no property
}

Stepper PassiveStepper( PSV )
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

				t_start  11.0;
				I_test   10.0;

				Expression " geq( t.Value, t_start ) * I_test";
		}

																	
}

System System( /CELL )
{
		StepperID	ODE;
	Variable Variable( SIZE )
		{
			Value	1.0;
		}

	Variable Variable( v )
		{
			Value	-70.0;
		}	

	Variable Variable( U )
		{
			Value	-14.0;
		}	

	Variable Variable( i )
		{
			Value	0.0;
		}	

	Process ExpressionFluxProcess( dv_dt )
	{
			VariableReferenceList
					[ v :.:v 1 ]
					[ U :.:U 0 ]
					[ i :..:I 0 ];
				
			Expression "0.04 * pow(v.Value,2.0) + 5.0 * v.Value + 140.0 - U.Value + i.Value";
	}

	 Process ExpressionFluxProcess( dU_dt )
    {
            VariableReferenceList
					[ v :.:v 0 ]
					[ U :.:U 1 ];
					
	         a   0.02;
		     b   0.2;

		     Expression "a * (b * v.Value - U.Value)";
	}

	Process ExpressionAssignmentProcess( v )
	{
	        StepperID   DT;
			Priority -1;
			VariableReferenceList
	                [ v :.:v 1 ];
												   
	        c  -65.0;
	         Expression "geq(v.Value, 30.0) * c + lt(v.Value, 30.0) * v.Value";
    }
	Process ExpressionAssignmentProcess( U )
	    {
			StepperID   DT;
			Priority -1;
			VariableReferenceList
			        [ U :.:U 1 ]
                    [ v :.:v 0 ];
			d  8.0;
			 Expression "geq(v.Value, 30.0) * d + U.Value";
	     }

}

