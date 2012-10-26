Stepper FixedODE1Stepper( ODE )
{
	# no property
}

Stepper DiscreteTimeStepper( DT )
{
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

		t_start   5.0;
		t_end     6.0;
		I_test   -8.0;

		Expression "and( geq( t.Value, t_start ), leq( t.Value, t_end )) * I_test";
	}

}

System System(/CELL)
{
	StepperID	ODE;


	Variable Variable( SIZE )
	{
		Value	1.0;
	}

	Variable Variable( EmptySet )
	{
		Value	0.0;
	}

	Variable Variable( Per )
	{
		Value	5.0E-16;
	}	

	Variable Variable( dClk )
	{
		Value	1.0E-16;
	}	

	Variable Variable( free_dClk )
	{
		Value	0.0;
	}	

	Variable Variable( dClkF_tau1 )
	{
		Name "free dClk at time t-tau1";
		Value	0.0;
	}	

	Variable Variable( dClkF_tau2 )
	{
		Name "free dClk at time t-tau2";
		Value	0.0;
	}	

	Variable Variable( tau1 )
	{
		Value	10.0;
	}	

	Variable Variable( tau2 )
	{
		Value	10.0;
	}	

	Variable Variable( Vsp )
	{
		Value	0.5;
	}	

	Variable Variable( K1 )
	{
		Value	0.3;
	}	

	Variable Variable( Vsc )
	{
		Value	0.25;
	}	

	Variable Variable( K2 )
	{
		Value	0.1;
	}	

	Variable Variable( kdc )
	{
		Value	0.5;
	}	

	Variable Variable( kdp )
	{
		Value	0.5;
	}	

	#delay
	Variable Variable( delay_dClk_tau1 )
	{
		Value	0.0;
	}

	Variable Variable( delay_dClk_tau2 )
	{
		Value	0.0;
	}

	Variable Variable( delay_Per_tau1 )
	{
		Value	0.0;
	}

	Variable Variable( delay_Per_tau2 )
	{
		Value	0.0;
	}

	Process DelayProcess( delay_dClk_tau1 )
	{
		StepperID	DT;

		VariableReferenceList
			[ original :.:dClk            0 ]
			[ delayed  :.:delay_dClk_tau1 1 ];

		tau  10.0;
	}

	Process DelayProcess( delay_dClk_tau2 )
	{
		StepperID	DT;

		VariableReferenceList
			[ original :.:delay_dClk_tau1 0 ]
			[ delayed  :.:delay_dClk_tau2 1 ];

		tau  0.0;
	}

	Process DelayProcess( delay_Per_tau1 )
	{
		StepperID	DT;

		VariableReferenceList
			[ original :.:Per            0 ]
			[ delayed  :.:delay_Per_tau1 1 ];

		tau  10.0;
	}

	Process DelayProcess( delay_Per_tau2 )
	{
		StepperID	DT;

		VariableReferenceList
			[ original :.:delay_Per_tau1 0 ]
			[ delayed  :.:delay_Per_tau2 1 ];

		tau  10.0;
	}

	#nomal
	Process ExpressionAssignmentProcess( free_dClk )
	{
		StepperID	PSV;

		VariableReferenceList
			[ dCLK      :.:dClk      0 ]
			[ Per       :.:Per       0 ]
			[ free_dClk :.:free_dClk 1 ];


		Expression "gt(dCLK.Value - Per.Value, 0) * (dCLK.Value - Per.Value)";
	}

Process ExpressionAssignmentProcess( dClkF_tau1 )
	{
		StepperID	PSV;

		VariableReferenceList
			[ dCLK            :.:dClk            0 ]
			[ delay_dClk_tau1 :.:delay_dClk_tau1 0 ]
			[ delay_Per_tau1  :.:delay_Per_tau1  0 ]
			[ dCLKF_tau1      :.:dClkF_tau1      1 ]
			[ Per             :.:Per             0 ];

		Expression "gt((delay_dClk_tau1.Value - delay_Per_tau1.Value), 0) * (delay_dClk_tau1.Value - delay_Per_tau1.Value)";

	}

	Process ExpressionAssignmentProcess( dClkF_tau2 )
	{
		StepperID	PSV;

		VariableReferenceList
			[ dCLK            :.:dClk            0 ]
			[ delay_dClk_tau2 :.:delay_dClk_tau2 0 ]
			[ delay_Per_tau2  :.:delay_Per_tau2  0 ]
			[ dCLKF_tau2      :.:dClkF_tau2      1 ]
			[ Per             :.:Per             0 ];

		Expression "gt((delay_dClk_tau2.Value - delay_Per_tau2.Value), 0) * (delay_dClk_tau2.Value - delay_Per_tau2.Value)";

	}

	Process ExpressionFluxProcess( Per_production)
	{
		VariableReferenceList
			[ SIZE     :.:SIZE     0 ]
			[ Per      :.:Per      1 ]
			[dClkF_tau1 :.:dClkF_tau1 0];

		Vsp 0.5;
		K1 0.3;

		Expression "Vsp * (dClkF_tau1.Value / (K1 + dClkF_tau1.Value)) * SIZE.Value";
	}

	Process ExpressionFluxProcess( dClk_production)
	{
		VariableReferenceList
			[ SIZE       :.:SIZE       0 ]
			[ EmptySet   :.:EmptySet   0 ]
			[ dClkF_tau2 :.:dClkF_tau2 0 ]
			[ dClk       :.:dClk       1 ];

		Vsc 0.25;
		K2 0.1;

		Expression "SIZE.Value * Vsc * (K2 / (K2 + dClkF_tau2.Value))";
	}

	Process ExpressionFluxProcess( Per_degradation)
	{
		VariableReferenceList
			[ Per      :.:Per      -1 ]
			[ SIZE     :.:SIZE      0 ];

		kdc 0.5;

		Expression "kdc * Per.Value * SIZE.Value";
	}

	Process ExpressionFluxProcess( dClk_degradation )
	{
		VariableReferenceList
			[ dClk     :.:dClk     -1 ]
			[ SIZE     :.:SIZE      0 ];

		kdp 0.5;

		Expression "kdp * dClk.Value * SIZE.Value";
	}
}
