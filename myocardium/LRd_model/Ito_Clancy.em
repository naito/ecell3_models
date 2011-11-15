
System System(/CELL/MEMBRANE/Ito)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0.0;
	}

	Variable Variable( i )
	{
		Value 0.0;
	}

	Variable Variable( Right_GIto )
	{
		Name  "Right ventricular epicardium";
		Value 1.1;
	}

	Variable Variable( Left_GIto )
	{
		Name  "left ventricular epicardium";
		Value 0.5;
	}

	Variable Variable( v )
	{
		Name  "transmembrane voltage";
		Value 0.0;
	}

        Variable Variable( alpha_z )
        {
                Name  "auxiliaty alpha_z";
                Value 0.0;
        }

        Variable Variable( beta_z )
        {
                Name  "auxiliary beta_z";
                Value 0.0;
        }

        Variable Variable( alpha_y )
        {
                Name  "auxiliary alpha_y";
                Value 0.0;
        }

        Variable Variable( beta_y )
        {
                Name  "auxiliary beta_y";
                Value 0.0;
	}

	 Variable Variable( R )
        {
                Name  "ouwtard rectification factor for the channel";
                Value 0.0;
	}

	Variable Variable( z_open )
	{
		Name  "Open State of Z"
		Value 0.0;
	}

	Variable Variable( y_open )
	{
		Name  "Open State of Y"
		Value 0.0;
	}

        Process ExpressionFluxProcess( Oz_Cz ) 
        {
                Priority        0;

                VariableReferenceList
                        [ alpha_z :.:alpha_z       0 ]
                        [ beta_z  :.:beta_z       -1 ]
                        [ z_open  :.:z_open        1 ];

                Expression "beta_z.Value * ( 1 - z_open.Value ) - alpha_z.Value * z_open.Value";
        }

        Process ExpressionFluxProcess( Oy_Cy ) 
        {
                Priority        0;

                VariableReferenceList
                        [ alpha_y :.:alpha_y       0 ]
                        [ beta_y  :.:beta_y       -1 ]
                        [ y_open  :.:y_open        1 ];

                Expression "beta_y.Value * ( 1 - y_open.Value ) - alpha_y.Value * y_open.Value";
        }


        Process ExpressionAssignmentProcess( I ) 
        {
                StepperID       PSV;
                Priority        0;

                VariableReferenceList
                        [ I      :.:I              1 ]  
                        [ GIto   :.:GIto           0 ]
                        [ Z      :.:z_open         0 ]  
                        [ Y      :.:y_open         0 ]  
                        [ v      :..:v             0 ]		
			[ R      :..:R             0 ]  
                        [ EK     :..:EK            0 ];

                Expression "GIto.Value * Z.Value^3 * Y.Value * R.Value * ( v.Value - EK.Value ) ";
                
        }




}