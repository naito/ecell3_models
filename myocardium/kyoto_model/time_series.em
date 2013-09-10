System System(/CELL/CYTOPLASM/TIME_SERIES)
{
    StepperID	    ODE;
    Variable Variable( Na1 )
    {
        MolarConc 6.346144960767133e-3;
    }

    Variable Variable( judge )
    {
	Value 0.0;
    }

    Process ExpressionAssignmentProcess( Na1 )
    {
        StepperID       PSV;

        VariableReferenceList
		[ judge :.:judge 1 ]
                [ Na    :..:Na   0 ]
                [ Na1   :.:Na1   0 ];
        Expression "geq(abs(Na1.MolarConc - Na.MolarConc),1.0e-7)";
    }    

}                                                
