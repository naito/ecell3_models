@{'''# Author Maria Takeuchi
Author Yasuhiro Naito
Version 0.2 2008-11-24 04:23:13 +0900

	<INa name="INa" initial_value="-22.37340068433973" units="pA"
		className="org.simBio.bio.terashima_et_al_2006.current.cf.INa">
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCa" initial_value="../constantFieldCa" units="mM" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="../currentCl" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<parameter name="permeabilityNa" initial_value="21.666666666667" units="pA/mM" />
		<parameter name="rerativePK" initial_value="0.1" units="pK/pNa" />
		<variable name="pRP" initial_value="0.39171609519888434" units="dimension_less" />
		<variable name="pAP" initial_value="1.5971760039227196E-5" units="dimension_less" />
		<variable name="pAI" initial_value="0.368385053951178" units="dimension_less" />
		<variable name="gate" initial_value="0.6438319698769808" units="dimension_less" />
	</INa>
'''}

System System(/CELL/MEMBRANE/INa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @INa_I;
	}

	Variable Variable( POpen )
	{
		Value 1.028312972845809e-05;
	}

	Variable Variable( pRP )
	{
		Value @INa_pRP;
	}

	Variable Variable( pAP )
	{
		Value @INa_pAP;
	}

	Variable Variable( pAI )
	{
		Value @INa_pAI;
	}

	Variable Variable( pRI )
	{
		Value @INa_pRI;
	}

	Variable Variable( vRPAP )
	{
		Value -1.59939860247e-05;
	}

	Variable Variable( vAPAI )
	{
		Value -1.61606418138e-05;
	}

	Variable Variable( vAIRI )
	{
		Value 0.00067476444273;
	}

	Variable Variable( vRPRI )
	{
		Value -0.00109716431175;
	}


	Variable Variable( vgate )
	{
		Value 9.69484197675e-05;
	}

	Variable Variable( gate )
	{
		Value @INa_gate;
	}

	Variable Variable( i )
	{
		Value 0.00217179699865;
	}

	Variable Variable( cNa )
	{
		Value -22.3740519006;
	}

	Variable Variable( cK )
	{
		Value 0.000651216154604;
	}

	Process INaAssignmentProcess( pOpen ) 
	{
		StepperID  PSV;
		Priority   20;

		VariableReferenceList
			[ pAP      :.:pAP                   0 ]
			[ pRP      :.:pRP                   0 ]
			[ pAI      :.:pAI                   0 ]
			[ pRI      :.:pRI                   1 ]
			[ vRPAP    :.:vRPAP                 1 ]
			[ vAPAI    :.:vAPAI                 1 ]
			[ vAIRI    :.:vAIRI                 1 ]
			[ vRPRI    :.:vRPRI                 1 ]
			[ v        :..:Vm                   0 ]
			[ dy       :.:vgate                 1 ]
			[ y        :.:gate                  0 ]
			[ pOpen    :.:POpen                 1 ]
			[ i        :.:i                     1 ]
			[ GX       :../../CYTOPLASM:Nav1_5  0 ]
			[ Cm       :..:Cm                   0 ]
			[ cNa      :.:cNa                   1 ]
			[ CFNa     :..:CFNa                 0 ]
			[ cK       :.:cK                    1 ]
			[ CFK      :..:CFK                  0 ]
			[ I        :.:I                     1 ];

		kAIAP           0.0000875;

		permeabilityNa  21.666666666667;
		permeabilityK   @( 21.666666666667 * 0.1 );
				
	}

	Process ZeroVariableAsFluxProcess( vRPAP ) 
	{
		Priority  15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			[ pAP   :.:pAP    1 ]
			[ vRPAP :.:vRPAP  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAPAI ) 
	{
		Priority  15;

		VariableReferenceList
			[ pAP   :.:pAP   -1 ]
			[ pAI   :.:pAI    1 ]
			[ vAPAI :.:vAPAI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAIRI ) 
	{
		Priority  15;

		VariableReferenceList
			[ pAI   :.:pAI   -1 ]
			#[ pRI  :.:pRI    0 ]
			[ vAIRI :.:vAIRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vRPRI ) 
	{
		Priority  15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			#[ pRI  :.:pRI    0 ]
			[ vRPRI :.:vRPRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( gate ) 
	{
		Priority  15;

		VariableReferenceList
			[ dy :.:vgate 0 ]
			[ y  :.:gate  1 ];
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}
