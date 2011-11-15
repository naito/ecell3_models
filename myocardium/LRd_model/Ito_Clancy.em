
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

#	Variable Variable( Right_GIto )
#	{
#		Name  "Right ventricular epicardium";
#		Value 1.1;
#	}

#	Variable Variable( Left_GIto )
#	{
#		Name  "left ventricular epicardium";
#		Value 0.5;
#	}

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

#        Process ExpressionFluxProcess( Oz_Cz ) 
#        {
#                Priority        0;#

#                VariableReferenceList
#                        [ alpha_z :.:alpha_z       0 ]
#                        [ beta_z  :.:beta_z       -1 ]
#                        [ z_open  :.:z_open        1 ];

#                Expression "beta_z.Value * ( 1 - z_open.Value ) - alpha_z.Value * z_open.Value";
#        }

#        Process ExpressionFluxProcess( Oy_Cy ) 
#        {
#                Priority        0;

#                VariableReferenceList
#                        [ alpha_y :.:alpha_y       0 ]
#                        [ beta_y  :.:beta_y       -1 ]
#                        [ y_open  :.:y_open        1 ];

#                Expression "beta_y.Value * ( 1 - y_open.Value ) - alpha_y.Value * y_open.Value";
#        }

	Process ExpressionAssignmentProcess( R )
	{
		StepperID	PSV;

		VariableReferenceList
			[ R :.:R 1 ]
			[ V :..:Vm      0 ];

		Expression "pow(exp, V.Value / 100.0)"; #####
	}

	Process ExpressionAssignmentProcess( alpha_z )
	{
		StepperID	PSV;

		VariableReferenceList
			[ a :.:alpha_z 1 ]
			[ V :..:Vm      0 ];

		Expression "(10.0 * pow( exp, (( V.Value - 40.0 ) / 25.0 ))) / ( 1.0 + pow( exp, (( V.Value - 40.0 ) / 25.0 )))"; #####
	}

	Process ExpressionAssignmentProcess( beta_z )
	{
		StepperID	PSV;

		VariableReferenceList
			[ b :.:beta_z 1 ]
			[ V :..:Vm      0 ];

		Expression "(10.0 * pow( exp, (-1.0 * ( V.Value + 90.0 ) / 25.0 ))) / ( 1.0 + pow( exp, (-1.0 * ( V.Value + 90.0 ) / 25.0 )))"; #####
	}
	
	Process ExpressionAssignmentProcess( alpha_y )
	{
		StepperID	PSV;

		VariableReferenceList
			[ a :.:alpha_y 1 ]
			[ V :..:Vm      0 ];

		Expression "0.015 / ( 1.0 + pow( exp, (( V.Value + 60.0 ) / 5.0) ))"; #####
	}

	Process ExpressionAssignmentProcess( beta_y )
	{
		StepperID	PSV;

		VariableReferenceList
			[ b :.:beta_y 1 ]
			[ V :..:Vm      0 ];

		Expression "(0.1 * pow( exp, (( V.Value + 25.0 ) / 5.0 ))) / ( 1.0 + pow( exp, (( V.Value + 25.0 ) / 5.0 )))"; #####
	}

	Process ExpressionFluxProcess( dzdt )
	{
		VariableReferenceList
			[ z :.:z_open       1 ]
 			[ a :.:alpha_z 0 ]
 			[ b :.:beta_z  0 ];

		Expression "a.Value * ( 1.0 - z.Value ) - b.Value * z.Value";
	}

	Process ExpressionFluxProcess( dydt )
	{
		VariableReferenceList
			[ y :.:y_open  1 ]
 			[ a :.:alpha_y 0 ]
 			[ b :.:beta_y  0 ];

		Expression "a.Value * ( 1.0 - y.Value ) - b.Value * y.Value";
	}

        Process ExpressionAssignmentProcess( I ) 
        {
                StepperID       PSV;
                Priority        0;

                VariableReferenceList
                        [ I      :.:I              1 ]  
#                        [ GIto   :.:GIto           0 ]
                        [ Z      :.:z_open         0 ]  
                        [ Y      :.:y_open         0 ]  
			[ R      :.:R             0 ]  
                        [ Vm     :..:Vm             0 ]		
                        [ EK     :..:EK            0 ];
			
			g_Ito @( g_Ito[SimulationMode] );

                Expression "g_Ito * pow( Z.Value,3.0) * Y.Value * R.Value * ( Vm.Value - EK.Value ) ";
#                Expression "GIto.Value * pow( Z.Value, 3) * Y.Value * R.Value * ( v.Value - EK.Value ) ";
                
        }


	@MembranePotential( 'I' )                  @# ←←← このへんはすべて I でＯＫ

	@addToTotalCurrent( 'currentK', 'I' )     @# ←←← このへんはすべて I でＯＫ

	@addToTotalCurrent( 'current', 'I' )       @# ←←← このへんはすべて I でＯＫ

}