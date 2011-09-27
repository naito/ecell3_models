System System(/CELL/MEMBRANE/IKs)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0;
	}

	Variable Variable( i )
	{
#		Value 2.5661147156641411;
		Value 0;
	}

	Variable Variable( cK )
	{
#		Value 0.00888036354663;
		Value 0;
	}

#Gate
	Variable Variable( vXs1Gt ) 
	{
		Value 0;
		Name    "Ks Xs1 gate";
	}

	Variable Variable( vXs2Gt ) 
	{
		Value 0;
		Name    "Ks Xs2 gate";
	}

	Variable Variable( Xs1Gt ) 
	{
		Value 0.004504 ;
		Name    "Ks Xs1 gate";
	}

	Variable Variable( Xs2Gt ) 
	{
		Value 0.004504 ;
		Name    "Ks Xs2 gate";
	}

	Variable Variable( GX )
	{
		Value @( KCNQ1[SimulationMode]);
	}

	Variable Variable( POpen )
	{
		Value 0;
	}

	Process IKsAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList		
			[ Vm      :..:Vm                   0 ]
			[ RTF     :..:_rtf                 0 ]

			[ Cai     :../../CYTOPLASM:Ca      0 ]
			[ Ke      :/:K                     0 ]
			[ Ki      :../../CYTOPLASM:K       0 ]
			[ Nae     :/:Na                    0 ]
			[ Nai     :../../CYTOPLASM:Na      0 ]

			[ ds1     :.:vXs1Gt                1 ]
			[ ds2     :.:vXs2Gt                1 ]
			[ s1      :.:Xs1Gt                 0 ]
			[ s2      :.:Xs2Gt                 0 ]

			[ pOpen   :.:POpen                 0 ]

			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]

			[ cK      :.:cK                    1 ]

			[ I       :.:I                     1 ];

#Process KsGtXs1_LRd_Process(IKs_Xs1Gt)
			s1_ka0 0.0000719;
			s1_a0 30.0;	
			s1_a11 -1.0;
			s1_a12 30.0;
			s1_a13 -0.148;
			s1_a2 1.0;
	
			s1_kb0 0.000131;
			s1_b0 30.0;
			s1_b11 1.0;
			s1_b12 30.0;
			s1_b13 0.0687;
			s1_b2 -1.0;

			s1_c0 1.0;
			s1_c11 1.0;
			s1_c12 -1.5;
			s1_c13 -16.7;
			s1_c2 1.0;

#Process KsGtXs2_LRd_Process(IKs_Xs2Gt)
			s2_ka0 0.0000719;
			s2_a0 30.0;
			s2_a11 -1.0;
			s2_a12 30.0;
			s2_a13 -0.148;
			s2_a2 1.0;
	
			s2_kb0 0.000131;
			s2_b0 30.0;
			s2_b11 1.0;
			s2_b12 30.0;
			s2_b13 0.0687;
			s2_b2 -1.0;

			s2_c0 1.0;
			s2_c11 1.0;
			s2_c12 -1.5;
			s2_c13 -16.7;
			s2_c2 1.0;

			PR_NaK 0.01833;
	}

	Process ZeroVariableAsFluxProcess( Xs1Gt ) 
	{
		Priority	15;

		VariableReferenceList
			[ ds1 :.:vXs1Gt  0 ]
			[ s1  :.:Xs1Gt   1 ];
	}

	Process ZeroVariableAsFluxProcess( Xs2Gt ) 
	{
		Priority	15;

		VariableReferenceList
			[ ds2 :.:vXs2Gt  0 ]
			[ s2  :.:Xs2Gt   1 ];
	}

	@setCurrents( [ 'I' ], [ 'K', 'cK' ] )
}
