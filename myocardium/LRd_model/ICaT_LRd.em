System System(/CELL/MEMBRANE/ICaT)
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
#Gate
	Variable Variable( bGtv ) 
	{	
		Value 0;
		Name    "CaT b gate";
	}
	Variable Variable( gGtv ) 
	{
		Value 0;
		Name    "CaT g gate";
	}
	
	Variable Variable( bGt ) 
	{	
		Value 0.000994 ;
		Name    "CaT b gate";
	}
	Variable Variable( gGt ) 
	{
		Value 0.994041 ;
		Name    "CaT g gate";
	}

	Variable Variable( GX )
	{
		Value @( Cav3_1[SimulationMode]);
	}

	Variable Variable( POpen )
	{
		Value 0;
	}

	Process ICaTAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ ECa     :..:ECa                 0 ]

			[ Cae     :/:Ca                    0 ]
			[ Cai     :../../CYTOPLASM:Ca      0 ]

			[ dbGt     :.:bGtv                  1 ]
			[ dgGt     :.:gGtv                  1 ]
			[ bGt      :.:bGt                   0 ]
			[ gGt      :.:gGt                   0 ]

			[ pOpen   :.:POpen                 0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cCa      :.:cCa                    1 ]

			[ I       :.:I                     1 ];

#Process CaTGtB_LRd_Process(ICaT_bGt)

		  	a0  1.0;
		  	a11 1.0;
		  	a12 14.0;
		  	a13 -10.8;
		  	a2 1.0;
	
		  	b0 6.1;
		  	b11 1.0;
		  	b12 25.0;
		  	b13 4.5;
		  	b2 1.0;
			b3 3.7;

#Process CaTGtG_LRd_Process(ICaT_gGt)
		  	c0 1.0;
		  	c11 1.0;
		  	c12 60.0;
		  	c13 5.6;
		  	c2 1.0;

			d0 12.0;
			d1 -0.875;
			d2 12.0;

		  	gCaT_amp 0.05;
	}

	Process ZeroVariableAsFluxProcess( bGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ dbGt :.:bGtv  0 ]
			[ bGt  :.:bGt   1 ];
	}

	Process ZeroVariableAsFluxProcess( gGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ dgGt :.:gGtv  0 ]
			[ gGt  :.:gGt   1 ];
	}

	@setCurrents( [ 'I' ], [ 'Ca', 'cCa' ] )
}		

	
