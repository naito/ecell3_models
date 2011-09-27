System System(/CELL/MEMBRANE/INaK)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( GX ){
		Value @( NaK_ATPase[SimulationMode]);
	}

	Process INaKAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	20;

		VariableReferenceList
			[ Vm       :..:Vm                       0 ]
			[ RTF     :..:_rtf                 0 ]

			[ Ko       :/:K                         0 ]
			[ Ki       :../../CYTOPLASM:K           0 ]
			[ Nao      :/:Na                        0 ]
			[ Nai      :../../CYTOPLASM:Na          0 ]

			[ GX       :.:GX                        0 ]

			[ I        :.:I                         1 ];

#Process NaKPump_Flux_LRd_Process( NaKPump_LRd_K_j )
		  	a0 -7.0;
		  	a1 7.0;
		  	a2 0.0;
		  	a3 67.3;
  
		  	b0 1.0;
	  		b11 0.1245;
  			b12 0.0;
	  		b13 -0.1;
		  	b21 0.0365;
		  	b22 0.0;
		  	b23 -1.0;
		  	b3 1.0;
  
		  	I_NaK 2.25;
		  	Km_K_e 1.5;
		  	Km_Na_i 10.0;    
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                       0 ]
			[ Ki  :../../CYTOPLASM:K         2 ]
			[ Nae :/:Na                      0 ]
			[ Nai :../../CYTOPLASM:Na       -3 ]
			[ i   :.:I                       0 ]
			[ A_cap :/:A_cap            0 ]
			[ N_A :/:N_A                     0 ]
			[ F   :/:F                       0 ]
			[ z   :/:zNa                     0 ];
	}


	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentNa', 'I', 3 )

	@addToTotalCurrent( 'currentK', 'I', -2 )

	@addToTotalCurrent( 'current', 'I' )
}

