@{'''
Author Maria Takeuchi
Author Yasuhiro Naito

Version 0.2 2008-11-24 04:41:45 +0900

	<ICaL name="ICaL" initial_value="-0.021540284879286362" units="pA"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.cf.ICaL">
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cai" initial_value="../Ca" units="mM" />
		<link name="ATP" initial_value="../ATPtotal" units="mM" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCa" initial_value="../constantFieldCa" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="Cm" initial_value="../membrane capacitance" units="pF" />
		<link name="PKA" initial_value="../PKA" />
		<link name="PKA0" initial_value="../PKA0" />
		<variable name="pRP" initial_value="0.9986559554086973" units="dimension_less" />
		<variable name="pAP" initial_value="1.0689156140294714E-6" units="dimension_less" />
		<variable name="pAI" initial_value="3.097435461749658E-4" units="dimension_less" />
		<variable name="pU" initial_value="0.18248096326453925" units="dimension_less" />
		<variable name="pUCa" initial_value="8.751644952667154E-5" units="dimension_less" />
		<variable name="pC" initial_value="0.44939265821991975" units="dimension_less" />
		<variable name="gate" initial_value="0.9994680498831937" units="dimension_less" />
		<parameter name="MAX" initial_value="3.0" />
		<parameter name="permeabilityCa" initial_value="45.0" units="pA/mM" />
		<parameter name="CaDiadic" initial_value="-1.5309723748693796E-7" units="dimension_less" />
	</ICaL>
'''}

System System(/CELL/MEMBRANE/ICaL)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @ICaL_I;
	}

	@# Voltage-dependent gate
	Variable Variable( pRP )
	{
		Value @ICaL_pRP;
	}

	Variable Variable( pAP )
	{
		Value @ICaL_pAP;
	}

	Variable Variable( pAI )
	{
		Value @ICaL_pAI;
	}

	Variable Variable( pRI )
	{
		Value @ICaL_pRI;
	}

	Variable Variable( vRPAP )
	{
		Value -3.11032857788e-07;
	}

	Variable Variable( vAPAI )
	{
		Value -3.05467883719e-07;
	}

	Variable Variable( vAIRI )
	{
		Value 9.19580075465e-06;
	}

	Variable Variable( vRPRI )
	{
		Value -3.98996407608e-05;
	}

	@# Ca2+-dependent gate
	Variable Variable( pU )
	{
		Value @ICaL_pU;
	}

	Variable Variable( pUCa )
	{
		Value @ICaL_pUCa;
	}

	Variable Variable( pC )
	{
		Value @ICaL_pC;
	}

	Variable Variable( pCCa )
	{
		Value @ICaL_pCCa;
	}

	Variable Variable( vCU )
	{
		Value 0.00039481298286;
	}

	Variable Variable( vUCaU )
	{
		Value 7.98993896509e-05;
	}

	Variable Variable( vCCaUCa )
	{
		Value 7.97809012855e-05;
	}

	Variable Variable( vCCaC )
	{
		Value 0.00154496996709;
	}

	@# Ultra-slow gate
	Variable Variable( vgate )
	{
		Value 1.57021018524e-05;
	}

	Variable Variable( gate )
	{
		Value @ICaL_gate;
	}

	Variable Variable( POpen )
	{
		Value 1.9347175017002756e-7;
	}

	Variable Variable( i )
	{
		Value 4.08612336359e-05;
	}

	Variable Variable( cNa )
	{
		Value -1.61744315758e-05;
	}

	Variable Variable( cK )
	{
		Value 9.28818137278e-08;
	}

	Variable Variable( cCa )
	{
		Value -0.0215242033295;
	}


	Process @( ICaL_AssignmentProcess_Name )( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ vAPAI    :.:vAPAI                  1 ]
			[ vRPAP    :.:vRPAP                  1 ]
			[ vAIRI    :.:vAIRI                  1 ]
			[ vRPRI    :.:vRPRI                  1 ]
			[ v        :..:Vm                    0 ]
			[ pRI      :.:pRI                    1 ]
			[ pRP      :.:pRP                    0 ]
			[ pAP      :.:pAP                    0 ]
			[ pAI      :.:pAI                    0 ]

			[ Cai      :../../CYTOPLASM:Ca       0 ]
			[ vCU      :.:vCU                    1 ]
			[ vUCaU    :.:vUCaU                  1 ]
			[ vCCaUCa  :.:vCCaUCa                1 ]
			[ vCCaC    :.:vCCaC                  1 ]

			[ pCCa     :.:pCCa                   1 ]
			[ pU       :.:pU                     0 ]
			[ pUCa     :.:pUCa                   0 ]
			[ pC       :.:pC                     0 ]

			[ dy       :.:vgate                  1 ]
			[ y        :.:gate                   0 ]

			[ PKA      :../../CYTOPLASM:PKA      0 ]
			[ ATP      :../../CYTOPLASM:ATPtotal 0 ]
			[ pOpen    :.:POpen                  1 ]
			[ CaDiadic :..:CaDiadic              1 ]
			[ i        :.:i                      1 ]
			[ GX       :../../CYTOPLASM:Cav1_2   0 ]
			[ Cm       :..:Cm                    0 ]
			[ cNa      :.:cNa                    1 ]
			[ CFNa     :..:CFNa                  0 ]
			[ cK       :.:cK                     1 ]
			[ CFK      :..:CFK                   0 ]
			[ cCa      :.:cCa                    1 ]
			[ CFCa     :..:CFCa                  0 ]
			[ I        :.:I                      1 ];


		kAPAI             0.004;
		kAIAP             0.001;

		kUUCa             6.954;
		kCCCa             6.954;

		kCU               0.143;
		kUC               0.35;
		kUCaU             2.0020000000000002;
		kCCaUCa           0.0003;
		kUCaCCa           0.35;
		kCCaC             0.0042;

		PKA0              @PKA0;   #  (M)
		KmPKA             @ICaL_KmPKA;  #  (M)
		hill_n            @ICaL_hill_n;
		MAX               @ICaL_MAX;
		#PKA_factor0       @( 1.0 - ICaL_MAX / ( 1.0 + pow( ICaL_KmPKA / PKA0, ICaL_hill_n )));

		permeabilityNa    @( 0.0000185 * 45.0 );
		permeabilityK     @( 0.000365 * 45.0 );
		permeabilityCa    45.0;
		
		kSingleCurrentAmp @ICaL_kSingleCurrentAmp;
		amplitudePKAf     @amplitudePKAf;

	}

	Process ZeroVariableAsFluxProcess( vRPAP ) 
	{
		Priority	15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			[ pAP   :.:pAP    1 ]
			[ vRPAP :.:vRPAP  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAPAI ) 
	{
		Priority	15;

		VariableReferenceList
			[ pAP :.:pAP   -1 ]
			[ pAI :.:pAI    1 ]
			[ vAPAI   :.:vAPAI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAIRI ) 
	{
		Priority	15;

		VariableReferenceList
			[ pAI   :.:pAI   -1 ]
			#[ pRI   :.:pRI    0 ]
			[ vAIRI :.:vAIRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vRPRI ) 
	{
		Priority	15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			#[ pRI   :.:pRI    0 ]
			[ vRPRI :.:vRPRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vCU ) 
	{
		Priority	15;

		VariableReferenceList
			[ pC   :.:pC   -1 ]
			[ pU   :.:pU    1 ]
			[ vCU :.:vCU   0 ];
	}

	Process ZeroVariableAsFluxProcess( vUCaU ) 
	{
		Priority	15;

		VariableReferenceList
			[ pUCa   :.:pUCa    -1 ]
			[ pU   :.:pU       1 ]
			[ vUCaU :.:vUCaU    0 ];
	}

	Process ZeroVariableAsFluxProcess( vCCaUCa ) 
	{
		Priority	15;

		VariableReferenceList
			#[ pCCa   :.:pCCa     0 ]
			[ pUCa   :.:pUCa     1 ]
			[ vCCaUCa :.:vCCaUCa  0 ];
	}

	Process ZeroVariableAsFluxProcess( vCCaC ) 
	{
		Priority	15;

		VariableReferenceList
			#[ pCCa   :.:pCCa     0 ]
			[ pC   :.:pC       1 ]
			[ vCCaC :.:vCCaC    0 ];
	}

	Process ZeroVariableAsFluxProcess( gate ) 
	{
		Priority	15;

		VariableReferenceList
			[ dy :.:vgate  0 ]
			[ y  :.:gate   1 ];
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ], [ 'Ca', 'cCa' ] )

}
