@{
'''
Author Yasuhiro Naito

Version 0.1 2008-11-27 04:37:37 +0900

	<IKs name="IKs" initial_value="-1.2115421550329173" units="pA"
		className="org.simBio.bio.kuzumoto_et_al_2007.current.cf.IKs">
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="Ca" initial_value="../Ca" units="mM" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="PKA" initial_value="../PKA" />
		<link name="PKAtot" initial_value="../Beta1Signaling/PKA/PKAtot" />
		<parameter name="permeabilityK0" initial_value="0.025" units="pA/mM" />
		<parameter name="relativePNa" initial_value="0.04" units="pNa/pK" />
		<variable name="gate1" initial_value="0.15386065638396113" />
		<variable name="gate2" initial_value="0.45916408455111457" />
		<variable name="gateC2" initial_value="0.07834389466278933" />
		<variable name="KCNQ1" initial_value="2.1132650663548235E-5" />
		<parameter name="KCNQ1free" initial_value="1.4550513768928859E-6" />
		<variable name="KCNQ1p" initial_value="2.373203529130647E-6" />
		<parameter name="KCNQ1p_ratio" initial_value="0.09492814116522588" />
		<parameter name="ratio" initial_value="2.3" />
		<label name="Phosphorylation" initial_value="true" />
	</IKs>
'''

def IKs_setKCNQ1pProcessVariableReference():
	if amplitudePKAf:
		return '[ kcnq1 :.:KCNQ1 -1 ]'
	else:
		return ''
}

System System(/CELL/MEMBRANE/IKs)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IKs_I;
	}

	Variable Variable( vgate1 )
	{
		Name	"the open probability of voltage-dependent gate";
		Value -0.000704918007056;
	}

	Variable Variable( vgate2 )
	{
		Name	"the open probability of [Ca2+]i-dependent gate";
		Value -4.44991510009e-05;
	}

	Variable Variable( vgateC2 )
	{
		Name	"the C2 state probability of [Ca2+]i-dependent gate";
		Value -3.78567359532e-05;
	}

	Variable Variable( gate1 )
	{
		Name	"the open probability of voltage-dependent gate";
		Value @IKs_gate1;
	}

	Variable Variable( gate2 )
	{
		Name	"the open probability of [Ca2+]i-dependent gate";
		Value @IKs_gate2;
	}

	Variable Variable( gateC2 )
	{
		Name	"the C2 state probability of [Ca2+]i-dependent gate";
		Value @IKs_gateC2;
	}

	Variable Variable( KCNQ1 )
	{
		MolarConc @IKs_KCNQ1;
	}

	Variable Variable( KCNQ1free )
	{
		MolarConc @IKs_KCNQ1free;
	}

	Variable Variable( vKCNQ1p )
	{
		MolarConc 0.0;
	}

	Variable Variable( KCNQ1p )
	{
		MolarConc @IKs_KCNQ1p;
	}

	Variable Variable( KCNQ1p_ratio )
	{
		Value @IKs_KCNQ1p_ratio;
	}

	Variable Variable( POpen )
	{
		Value @IKs_POpen;
	}

	Variable Variable( i )
	{
		Value 2.5661147156641411;
	}

	Variable Variable( cK )
	{
		Value 0.00888036354663;
	}

	Variable Variable( cNa )
	{
		Value -1.2204225186;
	}

	Process @( IKS_AssignmentProcess_Name )( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ pka     :../../CYTOPLASM:PKA     0 ]
			[ PKAtot  :../../CYTOPLASM:PKAtot  0 ]
			[ vkcnq1p :.:vKCNQ1p               0 ]
			[ Vm      :..:Vm                   0 ]
			[ Ca      :../../CYTOPLASM:Ca      0 ]
			[ dy1     :.:vgate1                1 ]
			[ dy2     :.:vgate2                1 ]
			[ dyC2    :.:vgateC2               1 ]
			[ y1      :.:gate1                 0 ]
			[ y2      :.:gate2                 0 ]
			[ yC2     :.:gateC2                0 ]
			[ pOpen   :.:POpen                 1 ]
			[ i       :.:i                     1 ]
			[ GX      :../../CYTOPLASM:KCNQ1   0 ]
			[ Cm      :..:Cm                   0 ]
			[ kcnq1p  :.:KCNQ1p                0 ]
			[ kcnq1   :.:KCNQ1                 0 ]
			[ cK      :.:cK                    1 ]
			[ CFK     :..:CFK                  0 ]
			[ cNa     :.:cNa                   1 ]
			[ CFNa    :..:CFNa                 0 ]
			[ I       :.:I                     1 ];

		eps             10.0;
		kPKA_KCNQ1      @( 205.2e-3 / 500 );
		KmPKA_KCNQ1     @( 0.2 * 17.64e-3 );
		kPP1_KCNQ1      @( 8.52e-3 / 500 );
		KmPP1_KCNQ1     @( 0.2 * 0.28e-3 * 1.0e-3 );  #  ( M )
		PKAtot_Yot      0.04e-3;
		PP1tot_Yot      0.025e-3;

		F_KCNQ1p0       0.0947077;

		b2              0.000148;
		a3              0.005;
		b3              0.03;

		Yottot          0.025e-3;
		Kyotiao         1.0e-7;

		KCNQ1tot        0.025e-6;  #  ( M )
		permeabilityK0  0.025;  #  ( pA/mM )
		relativePNa     0.04;

		amplitudePKAf   @amplitudePKAf;

		ka11            @IKs_ka11;
		ka12            @IKs_ka12;
		ka13            @IKs_ka13;
		ka14            @IKs_ka14;
		kb11            @IKs_kb11;
		kb12            @IKs_kb12;
		kb13            @IKs_kb13;
		kb14            @IKs_kb14;

	}

	Process ZeroVariableAsFluxProcess( KCNQ1p ) 
	{
		Priority	15;

		VariableReferenceList
			@( IKs_setKCNQ1pProcessVariableReference())  # himeno modelでは[ KCNQ1 -1 ]が追加される
			[ vkcnq1p :.:vKCNQ1p  0 ]
			[ kcnq1p  :.:KCNQ1p   1 ];
	}

	Process ZeroVariableAsFluxProcess( gate1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y1  :.:gate1   1 ]
			[ dy1 :.:vgate1  0 ];
	}

	Process ZeroVariableAsFluxProcess( gate2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ dy2 :.:vgate2  0 ]
			[ yC2 :.:gateC2 -1 ]
			[ y2  :.:gate2   1 ];
	}

	Process ZeroVariableAsFluxProcess( gateC2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ dyC2 :.:vgateC2  0 ]
			[ yC2  :.:gateC2   1 ];
	}

	@setCurrents( [ 'I' ], [ 'Na', 'cNa' ], [ 'K', 'cK' ] )

}
