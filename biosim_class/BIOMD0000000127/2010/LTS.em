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

	Variable Variable(I)
	{
	        Name "applied current";
		Value 0.0;
	}

	Variable Variable(t)
	{
	        Name "current time";
		Value 0.0;
	}

	Process ExpressionFluxProcess( clock )
	{
		   VariableReferenceList
		   	[t :.:t  1];

          	    Expression "1.0";
	}

	Process ExpressionAssignmentProcess( switch )
	{
		StepperID    PSV;
		   VariableReferenceList
			[I :.:I  1]
		   	[t :.:t  0];

		t_sw   10.0;
                I_on   10.0;
                I_off   0.0;

		Expression "( gt( t.Value, t_sw ) * I_on ) - ( leq( t.Value, t_sw ) * I_off )";

	}

}

System System(/CELL)
{
       StepperID	ODE;

       Variable Variable(SIZE)
       {
       		Value 1.0;
       }

       Variable Variable(v)
       {
		Value -70.0;
       }

       Variable Variable(u)
       {
		Value -14.0; 
       }

       Variable Variable(t_c)
       {
            Name "current time";
		Value 0.0;
       }


       Process ExpressionFluxProcess( clock_2 )
       {
       	         VariableReferenceList
		      [t_c :.:t_c  1];

          	       Expression "1.0";
       }
 
       Process ExpressionFluxProcess( dvdt )
       {
                 VariableReferenceList
	              [v :.:v  1]
	              [u :.:u  0]
	              [I :/:I  0];

                      v_lm 30;
            	      c_sw -65;
               	      step_interval 1.0e-3;
 
                      Expression "lt(v.Value, v_lm)*( 0.04*v.Value*v.Value+5.0*v.Value+140.0-u.Value + I.Value ) + geq(v.Value, v_lm)*(c_sw - v.Value)/step_interval";
        }

       Process ExpressionFluxProcess( dudt )
       {
		 VariableReferenceList
		      [v :.:v  0]
		      [u :.:u  1];


               	      I_2 10.0;
  		      a_2 0.02;
		      b_2 0.25;
		      c_2 -65.0;
		      d_2 1.0;
		      v_lm 30.0;
                      d_sw 1.0;
               step_interval 1.0e-3;
	
                Expression "lt(v.Value, v_lm)*(a_2*(b_2*v.Value-u.Value)) + geq(v.Value, v_lm)*d_sw/step_interval";
     }

}