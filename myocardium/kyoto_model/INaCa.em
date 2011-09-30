@{
INaCa_I = -12.382208025484562
INaCa_pE1total = 0.1527696589632682
INaCa_inActivation1 = 0.1744224872482831
INaCa_inActivation2 = 0.6724616314101051
INaCa_pE2total = 1.0 - INaCa_pE1total - INaCa_inActivation1 - INaCa_inActivation2

INaCa_amp = {
     	"V" : 110.0,
	"EMB" : 110.0,
	"LAT" : 110.0,
	"NEO" : 110.0,
	"SAN" : 150.0
}

}

System System(/CELL/MEMBRANE/INaCa)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value @INaCa_I;
	}

	Variable Variable( pE1total )
	{
		Value @INaCa_pE1total;
	}

	Variable Variable( pE2total )
	{
		Value @INaCa_pE2total;
	}

	Variable Variable( vInActivation1 )
	{
		Value 2.4577513386e-06;
	}

	Variable Variable( vInActivation2 )
	{
		Value 0.000321955009939;
	}

	Variable Variable( inActivation1 )
	{
		Value @INaCa_inActivation1;
	}

	Variable Variable( inActivation2 )
	{
		Value @INaCa_inActivation2;
	}

	Variable Variable( E1A )
	{
		Value 0.0277077332606;
	}

	Variable Variable( E2A )
	{
		Value 0.644870175642;
	}

	Variable Variable( dE )
	{
		Value 7.6263502799998276e-07;
	}

	Variable Variable( GX ){
		Value @( NCX1[SimulationMode]);
	}

	Process INaCaAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority        20;

		VariableReferenceList
			[ Nai     :../../CYTOPLASM:Na    0 ]
			[ Cai     :../../CYTOPLASM:Ca    0 ]
			[ E1A     :.:E1A                 1 ]
			[ Nao     :/:Na                  0 ]
			[ Cao     :/:Ca                  0 ]
			[ E2A     :.:E2A                 1 ]
			[ vrtf    :..:_vrtf              0 ]
			[ dinact1 :.:vInActivation1      1 ]
			[ dinact2 :.:vInActivation2      1 ]
			[ inact1  :.:inActivation1       0 ]
			[ inact2  :.:inActivation2       0 ]
			[ pE1tot  :.:pE1total            0 ]
			[ pE2tot  :.:pE2total            1 ]
			[ dE      :.:dE                  1 ]
			[ GX      :.:GX                  0 ]
			[ I       :.:I                   1 ]
			[ Cm      :..:Cm                 0 ];

		KmNai      20.74854e-3;  #  Dissociation constant for intracellular Na+ [M]
		nHNa       3.0;          #  experimental index for Hill constant about Na+
		KmCai      0.0184e-3;    #  Dissociation constant for intracellular Ca2+ [M]

		KmNao      87.5e-3;      #  Dissociation constant for extracellular Na+ [M]
		KmCao      1.38e-3;      #  Dissociation constant for extracellular Ca<sup>2+</sup> [M]

		KmCaact    0.004e-3;     #  Dissociation constant for regulatory Ca2+ at the inner side [M]

		partition  0.32;         #  distribution constant

                amplitude  @( INaCa_amp[SimulationMode] );        #  amplitude factor [pA/pF]

		#  rate constants in the presence of regulatory Ca2+ [msec-1]
		a1Caon     0.002;
		b1Caon     0.0012;
		#  rate constants in the absence of regulatory Ca2+ [msec-1]
		a1Caoff    0.0015;
		b1Caoff    5.0E-7;

		# rate constants [msec-1]
		a2Caoff    0.01;
		b2Caoff    1.0E-4;
		a2Caon     3.0E-5;
		b2Caon     0.09;
	}

	Process ZeroVariableAsFluxProcess( E )
	{
		Priority	15;

		VariableReferenceList
			[ dy     :.:dE        0 ]
			[ pE1tot :.:pE1total  1 ];
	}

	Process ZeroVariableAsFluxProcess( E1_inAntivation1 )
	{
		Priority	15;

		VariableReferenceList
			[ inact1   :.:inActivation1    1 ]
			[ pE1tot   :.:pE1total        -1 ]
			[ dinact1  :.:vInActivation1   0 ];
	}

	Process ZeroVariableAsFluxProcess( E1_inAntivation2 )
	{
		Priority	15;

		VariableReferenceList
			[ inact2   :.:inActivation2   1 ]
			[ pE1tot   :.:pE1total       -1 ]
			[ dinact2  :.:vInActivation2  0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae :/:Na                       3 ]
			[ Nai :../../CYTOPLASM:Na        -3 ]
			[ Cae :/:Ca                      -1 ]
			[ Cai :../../CYTOPLASM:CaTotal    1 ]
			[ i   :.:I                        0 ]
			[ N_A :/:N_A                      0 ]
			[ F   :/:F                        0 ]
			[ z   :/:zNa                      0 ];
	}


	@MembranePotential( 'I' )

	@addToTotalCurrent( 'currentNa', 'I',  3 )

	@addToTotalCurrent( 'currentCa', 'I', -2 )

	@addToTotalCurrent( 'current', 'I' )

}

@{'''
Author Yasuhiro Naito

Version 0.1 2008-11-27 08:36:10 +0900

	<INaCa name="INaCa" initial_value="-12.382208025484562"
		className="org.simBio.bio.takeuchi_et_al_2006.current.INaCa">
		<variable name="pE1total" initial_value="0.1527696589632682" />
		<variable name="inActivation1" initial_value="0.1744224872482831" />
		<variable name="inActivation2" initial_value="0.6724616314101051" />
		<parameter name="amplitude" initial_value="110.0" units="pA/pF" />
		<parameter name="stoichiometryNa" initial_value="3.0" units="pA/mM" />
		<parameter name="stoichiometryCa" initial_value="-2.0" units="pA/mM" />
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="Nai" initial_value="../Na" units="mM" />
		<link name="Nao" initial_value="../../Na" units="mM" />
		<link name="Cai" initial_value="../Ca" units="mM" />
		<link name="Cao" initial_value="../../Ca" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="R" initial_value="/Gas constant" />
		<link name="T" initial_value="/absolute temperature" units="K" />
		<link name="F" initial_value="/Faraday constant" units="Coulomb/mM" />
	</INaCa>
'''}
