System System(/CELL/MEMBRANE/ICaL)
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
#Gate
	Variable Variable( dGtv ) 
	{	
		Value 0;
		Name    "CaL d gate";
	}
	Variable Variable( fGtv ) 
	{
		Value 0;
		Name    "CaL f gate";
	}	
	Variable Variable( dGt )
	{
		Value 0.000003;
		Name	"d gate of CaL channel";
	}
	Variable Variable( fGt )
	{
		Value 0.999745;
		Name	"f gate of CaL channel";
	}

	Variable Variable( GX )
	{
		Value @( Cav1_2[SimulationMode]);
	}

	Variable Variable( POpen )
	{
		Value 0;
	}


	Process ICaLAssignmentProcess( I ) 
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

			[ ddGt     :.:dGtv                  1 ]
			[ dfGt     :.:fGtv                  1 ]
			[ dGt      :.:dGt                   0 ]
			[ fGt      :.:fGt                   0 ]

			[ pOpen   :.:POpen                 1 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cCa      :.:cCa                    1 ]
			[ cK      :.:cK                    1 ]
			[ cNa      :.:cNa                    1 ]

			[ I       :.:I                     1 ];

#Process CaLGtD_LRd_Process(ICaL_dGt)
	      		a0 1.0;
	      		a11 1.0;
      			a12 10.0;
		      	a13 -6.24;
		      	a2 1.0;

		      	b0 1.0;
		      	b1 -1.0;
		      	b2 10.0;
		      	b3 -6.24;
		      	b11 0.035;
		      	b12 10.0;

#Process CaLGtF_LRd_Process(ICaL_fGt)
		      	c0 1.0;
		      	c11 1.0;
		      	c12 32.0;
		      	c13 8.0;
		      	c2 1.0;
 
		      	d0 0.6;
		      	d11 1.0;
		      	d12 -50.0;
		      	d13 -20.0;
		      	d2 1.0;

		      	e0 1.0;
		      	e11 0.0197;
		      	e12 10.0;
		      	e13 0.0337;
		      	e14 2.0;
		      	e15 -1.0;
		      	e2 0.02;

#Process ICaL_Flux_LRd_Process( iCaL_LRd_Ca_j )
			f0 1.0;
		      	f2 1.0;
		      	Km_Ca 0.0006;

		      	g0 -1.0;
 		     	g2 0.0;
		      	g3 2.0;
		      	g3_NaK 1.0;

		      	h11 1.0;
		      	h12 0.0;
		      	h13 2.0;
		      	h13_NaK 1.0;
		      	h2 -1.0;

		      	e_gamma_Ca 0.341;
		      	i_gamma_Ca 1.0;
		       	P_Ca 0.00054;
			Z_Ca 2.0;

		  	e_gamma_Na 0.75;
		      	i_gamma_Na 0.75;
		       	P_Na 0.000000675;		       	
			Z_Na 1.0;
		
		  	e_gamma_K 0.75;
		      	i_gamma_K 0.75;
		       	P_K 0.000000193; 
			Z_K 1.0;
	}
	
	Process ZeroVariableAsFluxProcess( dGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ ddGt :.:dGtv  0 ]
			[ dGt  :.:dGt   1 ];
	}

	Process ZeroVariableAsFluxProcess( fGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ dfGt :.:fGtv  0 ]
			[ fGt  :.:fGt   1 ];
	}

	@setCurrents( [ 'I' ], [ 'Ca', 'cCa' ], [ 'K', 'cK' ], [ 'Na', 'cNa' ]  )
}
