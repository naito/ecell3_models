System System(/CELL/MEMBRANE/INa)
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

	Variable Variable( cNa )
	{
		Value 0;
	}
#Gate

	Variable Variable( mGtv ) 
	{	
		Value 0;
		Name    "Na m gate";
	}
	Variable Variable( hGtv ) 
	{
		Value 0;
		Name    "Na h gate";
	}
	Variable Variable( jGtv ) 
	{
		Value 0;
		Name    "Na j gate";
	}

	Variable Variable( mGt ) 
	{	
		Value 0.000838;
		Name    "Na m gate";
	}
	Variable Variable( hGt ) 
	{
		Value 0.993336;
		Name    "Na h gate";
	}
	Variable Variable( jGt ) 
	{
		Value 0.995484;
		Name    "Na j gate";
	}

	Variable Variable( GX )
	{
		Value @( Nav1_5[SimulationMode]);
	}

	Variable Variable( POpen )
	{
		Value 0;
	}

	Process INaAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ ENa     :..:ENa                 0 ]

			[ Nae     :/:Na                    0 ]
			[ Nai     :../../CYTOPLASM:Na      0 ]

			[ dmGt     :.:mGtv                  1 ]
			[ dhGt     :.:hGtv                  1 ]
			[ djGt     :.:jGtv                  1 ]
			[ mGt      :.:mGt                   0 ]
			[ hGt      :.:hGt                   0 ]
			[ jGt      :.:jGt                   0 ]

			[ pOpen   :.:POpen                 0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cNa      :.:cNa                    1 ]

			[ I       :.:I                     1 ];

#Process NaGtM_LRd_Process (INa_m_gating)
	
      			ka0 0.32;
		      	a0 47.13;
		      	a11 -1.0;
		      	a12 47.13;
		      	a13 -0.1;
		      	a2 1.0;

		      	b0 0.0;
		      	b1 0.08;
		      	b2 0.0;
		      	b3 -11.0;

#Process NaGtH_LRd_Process (INa_h_gating)
		      	c0 0.0;
		      	c1 0.135;
		      	c2 80.0;
		      	c3 -6.8;

		      	d0 0.0;
		      	d1 3.56;
		      	d2 0.0;
		      	d3 0.079;
      
		      	e0 0.0;
		      	e1 310000.0;
		      	e2 0.0;
		      	e3 0.35;

		      	f0 1.0;
		      	f11 0.13;
		      	f12 10.66;
		      	f13 -11.1;
		      	f2 0.13;

#Process NaGtJ_LRd_Process (INa_j_gating)
		      	g0 0.0;
		      	g1 -127140.0;
		      	g2 0.0;
		      	g3 0.2444;
      
		      	h0 0.0;
		      	h1 -0.00003474;
		      	h2 0.0;
		      	h3 -0.04391;
      
		      	i0 37.78;
		      	i11 1.0;
		      	i12 79.23;
		      	i13 0.311;
		      	i2 1.0;

		      	j0 0.0;
		      	j1 0.1212;
		      	j2 0.0;
		      	j3 -0.01052;

		      	k11 1.0;
		      	k12 40.14;
		      	k13 -0.1378;
		      	k2 1.0;

		      	l0 0.0;
		      	l1 0.3;
		      	l2 0.0;
		      	l3 -0.0000002535;

		      	m11 1.0;
		      	m12 32.0;
		      	m13 -0.1;
		      	m2 1.0;	

			P 16.0;
	}

	Process ZeroVariableAsFluxProcess( mGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ dmGt :.:mGtv  0 ]
			[ mGt  :.:mGt   1 ];
	}

	Process ZeroVariableAsFluxProcess( hGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ dhGt :.:hGtv  0 ]
			[ hGt  :.:hGt   1 ];
	}

	Process ZeroVariableAsFluxProcess( jGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ djGt :.:jGtv  0 ]
			[ jGt  :.:jGt   1 ];
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ] )
}






