System System(/CELL/MEMBRANE/IK1)
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
		Value 0;
	}

	Variable Variable( GX )
	{
		Value @( Kir2_1[SimulationMode]);
	}

	Process IK1AssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ EK      :..:EK                   0 ]

			[ Ke      :/:K                     0 ]
			[ Ki      :../../CYTOPLASM:K       0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cK      :.:cK                    1 ]
			[ I       :.:I                     1 ];
	
			coef_g 0.75;
			K_normal 5.4;

			a0 1.02;
			a11 1.0;
			a12 59.215;
			a13 0.2385;
			a2 1.0;	
		
			b0 0.0;
			b1 0.49124;
			b2 5.476;
			b3 0.08032;

			c0 0.0;
			c1 1.0;
			c2 594.31;
			c3 0.06175;

			d11 1.0;
			d12 4.753;
			d13 -0.5143;
			d2 1.0;	
	}

	@setCurrents( [ 'I' ], [ 'K', 'cK' ] )
}


