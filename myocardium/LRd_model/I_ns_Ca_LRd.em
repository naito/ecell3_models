System System(/CELL/MEMBRANE/I_ns_Ca)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( i )
	{
		Value 0;
	}

	Variable Variable( cCa )
	{
		Value 0;
	}
	Variable Variable( cK )
	{
		Value 0;
	}
	Variable Variable( cNa )
	{
		Value 0;
	}

	Variable Variable( GX )
	{
		Value @( ns_Ca[SimulationMode]);
	}

	Process I_ns_CaAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ RTF     :..:_rtf                 0 ]
			[ F       :/:F                 0 ]

			[ Cae     :/:Ca                    0 ]
			[ Cai     :../../CYTOPLASM:Ca      0 ]
			[ Ke      :/:K                    0 ]
			[ Ki      :../../CYTOPLASM:K      0 ]
			[ Nae     :/:Na                    0 ]
			[ Nai     :../../CYTOPLASM:Na      0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cCa      :.:cCa                    1 ]
			[ cK      :.:cK                    1 ]
			[ cNa      :.:cNa                    1 ]

			[ I       :.:I                     1 ];

		      	g0 -1.0;
 		     	g2 0.0;
		      	g3_NaK 1.0;

		      	h11 1.0;
		      	h12 0.0;
		      	h13_NaK 1.0;
		      	h2 -1.0;

		       	P_ns_Ca 0.000000175;
		       	K_m_ns_Ca 0.0012;

		      	e_gamma_Ca 0.341;
		      	i_gamma_Ca 1.0;
			Z_Ca 2.0;

		  	e_gamma_Na 0.75;
		      	i_gamma_Na 0.75;
			Z_Na 1.0;
		
		  	e_gamma_K 0.75;
		      	i_gamma_K 0.75;
			Z_K 1.0;
	}
	
	@setCurrents( [ 'I' ], [ 'Ca', 'cCa' ], [ 'K', 'cK' ], [ 'Na', 'cNa' ]  )
}
