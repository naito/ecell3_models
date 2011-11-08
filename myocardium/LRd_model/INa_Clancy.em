
System System(/CELL/MEMBRANE/INa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0.0;
	}

	Variable Variable( closedState1 )
	{
		Value 0.000273824;
	}

	Variable Variable( closedState2 )
	{
		Value 0.0205469;
	}

	Variable Variable( closedState3 )
	{
		Value 0.623756;
	}

	Variable Variable( openState )
	{
		Value 6.72982e-07;
	}

	Variable Variable( fast_inactivationState )
	{
		Value 0.000150999;
	}
	
	Variable Variable( intermediate_inactivationState1 )
	{
		Value 0.7.58487e-05;
	}

	Variable Variable( closed_inactivationState2 )
	{
		Value 0.0113273;
	}

	Variable Variable( closed_inactivationState3 )
	{
		Value 0.343868;
	}

	Variable Variable( alpha11 )
	{
		Value 0.0;
	}

	Variable Variable( alpha12 )
	{
		Value 0.0;
	}

	Variable Variable( alpha13 )
	{
		Value 0.0;
	}

	Variable Variable( alpha3 )
	{
		Value 0.0;
	}

	Variable Variable( beta11 )
	{
		Value 0.0;
	}

	Variable Variable( beta12 )
	{
		Value 0.0;
	}

	Variable Variable( beta13 )
	{
		Value 0.0;
	}

	Variable Variable( beta3 )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess( alpha11 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ alpha11 :.:alpha11  1 ];

		Expression "3.802 / ( 0.1027 * exp( -v.Value / 17.0 ) + 0.20 * exp( -v.Value / 150))"; 
	}

	Process ExpressionAssignmentProcess( alpha12 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ alpha12 :.:alpha12  1 ];

		Expression "3.802 / ( 0.1027 * exp( -v.Value / 15.0 ) + 0.23 * exp( -v.Value / 150))"; 
	}

	Process ExpressionAssignmentProcess( alpha13 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ alpha13 :.:alpha13  1 ];

		Expression "3.802 / ( 0.1027 * exp( -v.Value / 12.0 ) + 0.25 * exp( -v.Value / 150))"; 
	}	


	Process ExpressionAssignmentProcess( beta11 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ beta11 :.:beta11  1 ];

		Expression "0.1917 * exp( -v.Value / 20.3 )"; 
	}

	Process ExpressionAssignmentProcess( beta12 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ beta12 :.:beta12  1 ];

		Expression "0.20 * exp( -( v.Value - 5 ) / 20.3 )"; 
	}

	Process ExpressionAssignmentProcess( beta13 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ beta13 :.:beta13  1 ];

		Expression "0.22 * exp( -( v.Value - 10 ) / 20.3 )"; 
	}

	Process ExpressionAssignmentProcess( alpha3 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ alpha3 :.:alpha3  1 ];

		Expression "3.7933 * 1.0e-7 * exp( -v.Value / 7.7 )"; 
	}	

	Process ExpressionAssignmentProcess( beta3 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ beta3 :.:beta3  1 ];

		Expression "( 0.0084 + 0.00002 * v.Value )"; 
	}	


	Process ExpressionFluxProcess( vC3_C2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha11 :.:alpha11       0 ]
			[ beta11  :.:beta11        0 ]
			[ pC3     :.:closedState3  1 ]
			[ pC2     :.:closedState2 -1 ];

		Expression "beta11.Value * pC2.Value - alpha11.Value * pC3.Value";
	}

	Process ExpressionFluxProcess( vC2_C1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha12 :.:alpha12       0 ]
			[ beta12  :.:beta12        0 ]
			[ pC2   :.:closedState2    1 ]
			[ pC1   :.:closedState1   -1 ];

		Expression "beta12.Value * pC1.Value - alpha12.Value * pC2.Value";
	}

	Process ExpressionFluxProcess( vC1_O ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha13 :.:alpha13       0 ]
			[ beta13  :.:beta13        0 ]
			[ pC1   :.:closedState1    1 ]
			[ pO   :.:openState       -1 ];

		Expression "beta13.Value * pO.Value - alpha13.Value * pC1.Value";
	}


	Process ExpressionFluxProcess( vIC3_IC2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha11 :.:alpha11       0 ]
			[ beta11  :.:beta11        0 ]
			[ pIC3     :.:closed_inactivationState3  1 ]
			[ pIC2     :.:closed_inactivationState2 -1 ];

		Expression "beta11.Value * pIC2.Value - alpha11.Value * pIC3.Value";
	}


	Process ExpressionFluxProcess( vIC2_IF ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha12 :.:alpha12       0 ]
			[ beta12  :.:beta12        0 ]
			[ pIC2     :.:closed_inactivationState2  1 ]
			[ pIF     :.:fast_inactivationState -1 ];

		Expression "beta12.Value * pIF.Value - alpha12.Value * pIC2.Value";
	}

	Process ExpressionFluxProcess( vIF_O ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
@#			[ v     :.:v      0 ]
			[ alpha13 :.:alpha13       0 ]
			[ alpha3  :.:alpha3        0 ]
			[ pIF     :.:fast_inactivationState  1 ]
			[ pO      :.:openState -1 ];

		Expression "( 9.178 * exp( v.Value / 29.68)) * pO.Value - (alpha13.Value * ( 9.178 * exp( v.Value / 29.68)) * alpha3.Value ) * pIF.Value";
	}

	Process ExpressionFluxProcess( vIF_C1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pIF     :.:fast_inactivationState 1 ]
			[ pC1     :.:closedState1 -1 ];

		Expression "beta3.Value * pC1.Value - alpha3.Value * pIF.Value";
	}

	Process ExpressionFluxProcess( vIC2_C2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pIC2   :.:closed_inactivationState2 1 ]
			[ pC2    :.:closedState2 -1 ];

		Expression "beta3.Value * pC2.Value - alpha3.Value * pIC2.Value";
	}

	Process ExpressionFluxProcess( vIC3_C3 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pIC3   :.:closed_inactivationState3 1 ]
			[ pC3    :.:closedState3 -1 ];

		Expression "beta3.Value * pC3.Value - alpha3.Value * pIC3.Value";
	}


	Process ExpressionFluxProcess( vIF_M1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ alpha3 :.:alpha3       0 ]
			[ pIF     :.:fast_inactivationState 1 ]
			[ M1     :.:intermediate_inactivationState1 -1 ];

		Expression "alpha3.Value * M1.Value - ( 9.178 * exp( v.Value / 29.68)) / 100 * pIF.Value";
	}


	Process ExpressionFluxProcess( vM1_M2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                @# ←←←本来のVmに戻す
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pC1     :.:closedState1 1 ]
			[ pC2     :.:closedState1 1 ]
			[ pC3     :.:closedState1 1 ]
			[ pIC2     :.:closed_inactivationState2 1 ]
			[ pIC3     :.:closed_inactivationState3 1 ]
			[ pIF     :.:fast_inactivationState 1 ]
			[ pO   :.:openState       1 ]
			[ M1    :.:intermediate_inactivationState1 -1 ];

		Expression "alpha3.Value / 50 * ( 1 - ( pC1.Value + pC2.Value + pC3.Value + pIC2.Value + pIC3.Value + pIF.Value + pO.Value + M1.Value)) - ( 9.178 * exp( v.Value / 29.68)) / ( 9.5 * 1.0e4 ) * M1.Value";
	}

	Variable Variable( GNa )
	{
            Name "Gene expression for Na+";
		Value 23.5;
	}

	Variable Variable( ENa )
	{
		Name "equilibrium potential for Na+ (mV)";
		Value 0.0;
        }

	Process ExpressionAssignmentProcess( ENa ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ ENa    :.:ENa               1 ]
			[ R      :/:R                 0 ]  @# ←←←親EMファイルに記述されているR
			[ T      :/:T                 0 ]  @# ←←←親EMファイルに記述されているT
			[ F      :/:F                 0 ]  @# ←←←親EMファイルに記述されているF
        		[ Nai    :/:Na                0 ]
			[ Nae    :../../CYTOPLASM:Na  0 ];

		Expression "( R.Value * T.Value / F.Value ) * log( Nai.Value / Nae.Value )";    @# lnではなくlog、直後のスペースも不要
		
	}


	Process ExpressionAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ I     :.:I                  1 ]  @# ←←← I に変更
			[ GNa   :.:GNa   			0 ]
			[ pOpen :.:openState          0 ]  @# ←←← openState に変更
			[ v     :..:Vm                0 ]  @# ←←←本来のVmに戻す
			[ ENa   :..:ENa               0 ];

		Expression "GNa.Value * pOpen.Value * ( v.Value - ENa.Value ) ";
		
	}

	Process ExpressionFluxProcess( jNa ) 
	{
		Priority	0;

		VariableReferenceList
			[ Nae :/:Na                 1 ]
			[ Nai :../../CYTOPLASM:Na  -1 ]
			[ cNa :.:I                0 ];      @# ←←← I に変更

		Expression "cNa.Value * @_pA2J_Na";
		
	}

	@MembranePotential( 'I' )                  @# ←←← このへんはすべて I でＯＫ

	@addToTotalCurrent( 'currentNa', 'I' )     @# ←←← このへんはすべて I でＯＫ

	@addToTotalCurrent( 'current', 'I' )       @# ←←← このへんはすべて I でＯＫ

}

