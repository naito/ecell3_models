System System(/CELL/MEMBRANE/INaCa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( GX ){
		Value @( NCX1[SimulationMode]);
	}

	Process INaCaAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority        20;

		VariableReferenceList
			[ Vm       :..:Vm                  0 ]
			[ RTF     :..:_rtf                 0 ]

			[ Cao       :/:Ca                  0 ]
			[ Cai       :../../CYTOPLASM:Ca    0 ]
			[ Nao      :/:Na                   0 ]
			[ Nai      :../../CYTOPLASM:Na     0 ]

			[ GX       :.:GX                   0 ]

			[ I        :.:I                    1 ];
		
	  	coef1 0.00025;
  		coef2 0.0001;
  
	  	INaCa_gamma 0.15;
  	
	  	a0 -1.0;
  		a2 0.0;
  
	  	b12 0.0;
  		b13 1.0;
		b2 1.0;  

  		c2 0.0;
  
	  	d0 0.0;
  		d2 0.0;
	  	d3 1.0;
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae :/:Na                       0 ]
			[ Nai :../../CYTOPLASM:Na        -3 ]
			[ i   :.:I                        0 ]
			[ A_cap :/:A_cap                  0 ]
			[ N_A :/:N_A                      0 ]
			[ F   :/:F                        0 ]
			[ z   :/:zNa                      0 ];
	}


	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentNa', 'I',  3 )

	@addToTotalCurrent( 'currentCa', 'I', -2 )

	@addToTotalCurrent( 'current', 'I' )

}




