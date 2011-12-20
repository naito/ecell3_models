
System System(/CELL/MEMBRANE/INa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 1.0;
	}

	Variable Variable( openState )
	{
		Value 0.1;
	}

	Variable Variable( lower_closedState1 )
	{
		Value 0.05;
	}

	Variable Variable( lower_closedState2 )
	{
		Value 0.05;
	}

	Variable Variable( lower_closedState3 )
	{
		Value 0.05;
	}

	Variable Variable( lower_openState )
	{
		Value 0.05;
	}

	Variable Variable( upper_closedState1 )
	{
		Value 0.05;
	}

	Variable Variable( upper_closedState2 )
	{
		Value 0.05;
	}

	Variable Variable( upper_closedState3 )
	{
		Value 0.05;
	}

	Variable Variable( upper_openState )
	{
		Value 0.05;
	}
	
	Variable Variable( upper_fast_inactivationState )
	{
		Value 0.05;
	}
	
	Variable Variable( upper_closed_inactivationState2 )
	{
		Value 0.05;
	}

	Variable Variable( upper_closed_inactivationState3 )
	{
		Value 0.05;
	}

	Variable Variable( upper_intermediate_inactivationState1 )
	{
		Value 0.05;
	}

	Variable Variable( upper_intermediate_inactivationState2 )
	{
		Value 0.05;
	}

#	Variable Variable( UIM2 )
# 	{
#		Value 0.0;
#	}

	Process ExpressionAssignmentProcess( UIM2 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ UIM2   :.:upper_intermediate_inactivationState2  1 ]
#			[ UIM2 :..:UIM2  1 ]                                          
			[ UIM1   :.:upper_intermediate_inactivationState1  0 ]
			[ pUO     :.:upper_openState 0 ]
			[ pLO     :.:lower_openState 0 ]
			[ pUC1     :.:upper_closedState1 0 ]
			[ pLC1     :.:lower_closedState1 0 ]
			[ pUC2     :.:upper_closedState2 0 ]
			[ pLC2     :.:lower_closedState2 0 ]
			[ pUC3     :.:upper_closedState3 0 ]
			[ pLC3     :.:lower_closedState3 0 ]
			[ pUIC2    :.:upper_closed_inactivationState2        0 ]
			[ pUIC3    :.:upper_closed_inactivationState3        0 ]
			[ pUIF     :.:upper_fast_inactivationState           0 ];
		
		Expression "( 1.0 - ( pUO.Value + pUC1.Value + pUC2.Value + pUC3.Value + pLO.Value + pLC1.Value + pLC2.Value + pLC3.Value + pUIC2.Value + pUIC3.Value + pUIF.Value + UIM1.Value ))"; 
	}

	Variable Variable( alpha11 )
	{
		Value 1.0;
	}

	Variable Variable( alpha12 )
	{
		Value 1.0;
	}

	Variable Variable( alpha13 )
	{
		Value 1.0;
	}

	Variable Variable( alpha3 )
	{
		Value 1.0;
	}

	Variable Variable( beta11 )
	{
		Value 1.0;
	}

	Variable Variable( beta12 )
	{
		Value 1.0;
	}

	Variable Variable( beta13 )
	{
		Value 1.0;
	}

	Variable Variable( beta3 )
	{
		Value 1.0;
	}

	Process ExpressionAssignmentProcess( alpha11 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ alpha11 :.:alpha11  1 ];

		Expression "3.802 / ( 0.1027 * exp( -v.Value / 17.0 ) + 0.20 * exp( -v.Value / 150.0 ))"; 
	}

	Process ExpressionAssignmentProcess( alpha12 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ alpha12 :.:alpha12  1 ];

		Expression "3.802 / ( 0.1027 * exp( -v.Value / 15.0 ) + 0.23 * exp( -v.Value / 150.0 ))"; 
	}

	Process ExpressionAssignmentProcess( alpha13 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ alpha13 :.:alpha13  1 ];

		Expression "3.802 / ( 0.1027 * exp( -v.Value / 12.0 ) + 0.25 * exp( -v.Value / 150.0 ))"; 
	}	


	Process ExpressionAssignmentProcess( beta11 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ beta11 :.:beta11  1 ];

		Expression "0.1917 * exp( -v.Value / 20.3 )"; 
	}

	Process ExpressionAssignmentProcess( beta12 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ beta12 :.:beta12  1 ];

		Expression "0.20 * exp( -( v.Value - 5.0 ) / 20.3 )"; 
	}

	Process ExpressionAssignmentProcess( beta13 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                
			[ beta13 :.:beta13  1 ];

		Expression "0.22 * exp( -( v.Value - 10.0 ) / 20.3 )"; 
	}

	Process ExpressionAssignmentProcess( alpha3 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm          0 ]               
			[ alpha3 :.:alpha3  1 ];

		Expression "( 3.7933 * pow( 10.0, -7.0 ) * exp( -v.Value / 7.7 )) / 2.5"; 
	}	

	Process ExpressionAssignmentProcess( beta3 ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ beta3 :.:beta3  1 ];

		Expression "( 0.0084 + 0.00002 * v.Value )"; 
	}	

	Process ExpressionFluxProcess( vLC3_LC2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha11 :.:alpha11             0 ]
			[ beta11  :.:beta11              0 ]
			[ pLC3    :.:lower_closedState3  1 ]
			[ pLC2    :.:lower_closedState2 -1 ];

		Expression "beta11.Value * pLC2.Value - alpha11.Value * pLC3.Value";
	}

	Process ExpressionFluxProcess( vLC2_LC1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha12 :.:alpha12              0 ]
			[ beta12  :.:beta12               0 ]
			[ pLC2   :.:lower_closedState2    1 ]
			[ pLC1   :.:lower_closedState1   -1 ];

		Expression "beta12.Value * pLC1.Value - alpha12.Value * pLC2.Value";
	}

	Process ExpressionFluxProcess( vLC1_LO ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha13 :.:alpha13               0 ]
			[ beta13  :.:beta13                0 ]
			[ pLC1    :.:lower_closedState1    1 ]
			[ pLO     :.:lower_openState      -1 ];

		Expression "beta13.Value * pLO.Value - alpha13.Value * pLC1.Value";
	}

	Process ExpressionFluxProcess( vUC3_UC2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha11 :.:alpha11             0 ]
			[ beta11  :.:beta11              0 ]
			[ pUC3    :.:upper_closedState3  1 ]
			[ pUC2    :.:upper_closedState2 -1 ];

		Expression "beta11.Value * pUC2.Value - alpha11.Value * pUC3.Value";
	}

	Process ExpressionFluxProcess( vUC2_UC1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha12 :.:alpha12              0 ]
			[ beta12  :.:beta12               0 ]
			[ pUC2   :.:upper_closedState2    1 ]
			[ pUC1   :.:upper_closedState1   -1 ];

		Expression "beta12.Value * pUC1.Value - alpha12.Value * pUC2.Value";
	}

	Process ExpressionFluxProcess( vUC1_UO ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha13 :.:alpha13               0 ]
			[ beta13  :.:beta13                0 ]
			[ pUC1    :.:upper_closedState1    1 ]
			[ pUO     :.:upper_openState      -1 ];

		Expression "beta13.Value * pUO.Value - alpha13.Value * pUC1.Value";
	}

	Process ExpressionFluxProcess( vUIC3_UIC2 )  
	{
		Priority	0;

		VariableReferenceList
			[ alpha11 :.:alpha11       0 ]
			[ beta11  :.:beta11        0 ]
			[ pUIC3     :.:upper_closed_inactivationState3  1 ]
			[ pUIC2     :.:upper_closed_inactivationState2 -1 ];

		Expression "beta11.Value * pUIC2.Value - alpha11.Value * pUIC3.Value";
	}

	Process ExpressionFluxProcess( vUIC2_UIF ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha12 :.:alpha12       0 ]
			[ beta12  :.:beta12        0 ]
			[ pUIC2     :.:upper_closed_inactivationState2  1 ]
			[ pUIF     :.:upper_fast_inactivationState -1 ];

		Expression "beta12.Value * pUIF.Value - alpha12.Value * pUIC2.Value";
	}

	Process ExpressionFluxProcess( vUIF_UO ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]                
			[ alpha13 :.:alpha13       0 ]
			[ alpha3  :.:alpha3        0 ]
			[ beta13  :.:beta13        0 ]
			[ beta3  :.:beta3        0 ]
			[ pUIF     :.:upper_fast_inactivationState  1 ]
			[ pUO      :.:upper_openState -1 ];

		Expression "( 9.178 * exp( v.Value / 29.68)) * pUO.Value - (alpha13.Value * ( 9.178 * exp( v.Value / 29.68)) * alpha3.Value ) / ( beta13.Value * beta3.Value ) * pUIF.Value";
	}

	Process ExpressionFluxProcess( vUIF_UC1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pUIF     :.:upper_fast_inactivationState 1 ]
			[ pUC1     :.:upper_closedState1 -1 ];

		Expression "beta3.Value * pUC1.Value - alpha3.Value * pUIF.Value";
	}

	Process ExpressionFluxProcess( vUIC2_UC2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pUIC2   :.:upper_closed_inactivationState2 1 ]
			[ pUC2    :.:upper_closedState2 -1 ];

		Expression "beta3.Value * pUC2.Value - alpha3.Value * pUIC2.Value";
	}

	Process ExpressionFluxProcess( vUIC3_UC3 ) 
	{
		Priority	0;

		VariableReferenceList
			[ alpha3 :.:alpha3       0 ]
			[ beta3  :.:beta3        0 ]
			[ pUIC3   :.:upper_closed_inactivationState3 1 ]
			[ pUC3    :.:upper_closedState3 -1 ];

		Expression "beta3.Value * pUC3.Value - alpha3.Value * pUIC3.Value";
	}


	Process ExpressionFluxProcess( vUIF_UIM1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ alpha3 :.:alpha3       0 ]
			[ pUIF     :.:upper_fast_inactivationState 1 ]
			[ UM1     :.:upper_intermediate_inactivationState1 -1 ];

		Expression "alpha3.Value * UM1.Value - ( 9.178 * exp( v.Value / 29.68)) / 100.0 * pUIF.Value";
	}

	Process ExpressionFluxProcess( vUIM1_UIM2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v        :..:Vm                                    0 ]               
			[ alpha3   :.:alpha3                                 0 ]
			[ beta3    :.:beta3                                  0 ]
			[ UIM2     :.:upper_intermediate_inactivationState2  1 ]
#			[ UIM2     :.:UIM2  1 ]
			[ UIM1     :.:upper_intermediate_inactivationState1 -1 ];

		Expression "alpha3.Value / 20.0 * UIM2.Value - ( 9.178 * exp( v.Value / 29.68)) / ( 3.5 * pow( 10.0, 4.0 )) * UIM1.Value";
	}

	Process ExpressionFluxProcess( vUC3_LC3 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ pUC3     :.:upper_closedState3 1 ]
			[ pLC3     :.:lower_closedState3 -1 ];

		Expression "9.5 * pow( 10.0, -4 ) * pLC3.Value - 1.0 * pow( 10.0, -7 ) * pUC3.Value";
	}

	Process ExpressionFluxProcess( vUC2_LC2 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ pUC2     :.:upper_closedState2 1 ]
			[ pLC2     :.:lower_closedState2 -1 ];

		Expression "9.5 * pow( 10.0, -4 ) * pLC2.Value - 1.0 * pow( 10.0, -7 ) * pUC2.Value";
	}

	Process ExpressionFluxProcess( vUC1_LC1 ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ pUC1     :.:upper_closedState1 1 ]
			[ pLC1     :.:lower_closedState1 -1 ];

		Expression "9.5 * pow( 10.0, -4 ) * pLC1.Value - 1.0 * pow( 10.0, -7 ) * pUC1.Value";
	}

	Process ExpressionFluxProcess( vUO_LO ) 
	{
		Priority	0;

		VariableReferenceList
			[ v :..:Vm  0 ]               
			[ pUO     :.:upper_openState 1 ]
			[ pLO     :.:lower_openState -1 ];

		Expression "9.5 * pow( 10.0, -4.0 ) * pLO.Value - 1.0 * pow( 10.0, -7.0 ) * pUO.Value";
	}

	Variable Variable( GNa )
	{
            Name "Gene expression for Na+";
		Value 23.5;
	}


	Process ExpressionAssignmentProcess( openState ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ OS     :.:openState        1 ]
			[ pUO     :.:upper_openState        0 ]
			[ pLO     :.:lower_openState        0 ];

		Expression "pUO.Value + pLO.Value";
	}

#	Process ExpressionAssignmentProcess( openState ) 
#	{
#		StepperID	PSV;
#		Priority	0;

#		VariableReferenceList
#			[ OS     :.:openState        1 ]
#			[ pUO     :.:upper_openState        0 ]
#			[ pLO     :.:lower_openState        0 ];

#		Expression "pLO.Value";
#	}

	Variable Variable( ENa )
	{
		Name "equilibrium potential for Na+ (mV)";
		Value 0.0;
        }

	Process ExpressionAssignmentProcess( ENa ) 
	{
		StepperID	PSV;
		Priority	1;

		VariableReferenceList
			[ ENa    :.:ENa               1 ]
			[ R      :/:R                 0 ]  
			[ T      :/:T                 0 ]  
			[ F      :/:F                 0 ] 
        		[ Nai    :/:Na                0 ]
			[ Nae    :../../CYTOPLASM:Na  0 ];

		Expression "( R.Value * T.Value / F.Value ) * log( Nai.Value / Nae.Value )";   
		
	}

	Process ExpressionAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	0;

		VariableReferenceList
			[ I     :.:I                  1 ]
			[ GNa   :.:GNa           	0 ]
			[ pOpen :.:openState          0 ] 
			[ v     :..:Vm                0 ] 
#			[ ENa   :.:ENa               0 ]; 
			[ ENa   :..:ENa               0 ];

		Expression "GNa.Value * pOpen.Value * ( v.Value - ENa.Value ) ";
		
	}

	Process ExpressionFluxProcess( jNa ) 
	{
		Priority	0;

		VariableReferenceList
			[ Nae :/:Na                 1 ]
			[ Nai :../../CYTOPLASM:Na  -1 ]
			[ cNa :.:I                0 ];    

		Expression "cNa.Value * @_pA2J_Na";
		
	}

	@MembranePotential( 'I' )                  

	@addToTotalCurrent( 'currentNa', 'I' )    

	@addToTotalCurrent( 'current', 'I' )       
}

