System System(/CELL/MEMBRANE/IKr)
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

	Variable Variable( cK )
	{
#		Value 0.00888036354663;
		Value 0;
	}

# Gate
	Variable Variable( vXrGt ) 
	{
		Value 0;
		Name    "Kr Xr gate";
	}

	Variable Variable( XrGt ) 
	{	
		Value 0.000129 ;
		Name    "Kr Xr gate";
	}	

	Variable Variable( GX )
	{
		Value @( erg1[SimulationMode]);
	}

	Variable Variable( POpen )
	{
		Value 0;
	}


	Process IKrAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ EK      :..:EK                 0 ]

			[ Ke      :/:K                     0 ]
			[ Ki      :../../CYTOPLASM:K       0 ]

			[ dr      :.:vXrGt                1 ]
			[ r       :.:XrGt                 0 ]

			[ pOpen   :.:POpen                 0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cK      :.:cK                    1 ]
			[ I       :.:I                     1 ];

#Process KrGtXr_LRd_Process(IKr_XrGt){
			ka0 0.00138;
			a0 14.2;
			a11 -1.0;
			a12 14.2;
			a13 -0.123;
			a2 1.0;
	
			kb0 0.00061;
			b0 38.9;
			b11 1.0;
			b12 38.9;
			b13 0.145;
			b2 -1.0;

			c0 1.0;
			c11 1.0;
			c12 21.5;
			c13 -7.5;
			c2 1.0;

#Process Kr_Flux_LRd_Process( iKr_LRd_K_j )
			k0 1.0;
			k11 1.0;
			k12 9.0;
			k13 22.4;
			k2 1.0;
	}

	Process ZeroVariableAsFluxProcess( XrGt ) 
	{
		Priority	15;

		VariableReferenceList
			[ dr :.:vXrGt  0 ]
			[ r  :.:XrGt   1 ];
	}

	@setCurrents( [ 'I' ], [ 'K', 'cK' ] )
}		






