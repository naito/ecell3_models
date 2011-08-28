@{'''
Author  Maria TAKEUCHI
Author  Hiromi KUMAMOTO
Author  Hiromi KUMAMOTO

Version 0.2 2008-11-30 01:39:43 +0900

	<IKATP name="IKATP" initial_value="0.004398611578760137" units="pA"
		className="org.simBio.bio.terashima_et_al_2006.current.potassium.IKATP">
		<KoDependency2 name="permeabilityK" initial_value="0.6252120113178323" units="pA/mV"
			className="org.simBio.bio.terashima_et_al_2006.function.KoDependency2">
			<parameter name="amplitude" initial_value="0.0236" />
			<parameter name="number" initial_value="2333.0" />
			<parameter name="constant" initial_value="1.0" units="mM" />
			<parameter name="power" initial_value="0.24" units="dimension_less" />
			<link name="Ko" initial_value="../../../K" />
		</KoDependency2>
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="ATPi" initial_value="../ATPtotal" units="mM" />
		<link name="reversalPotential" initial_value="../K reversal potential" units="mV" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="../currentCl" />
	</IKATP>
'''}

System System(/CELL/MEMBRANE/IKATP)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IKATP_I;
	}

	Variable Variable( POpen )
	{
		Value 0.000164995;
	}

	Process IKATPAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	13;

		VariableReferenceList
			[ ATPi  :../../CYTOPLASM:ATPtotal  0 ]
			[ pOpen :.:POpen                   1 ]
			[ I     :.:I                       1 ]
			[ GX    :../../CYTOPLASM:Kir6_2    0 ]
			[ Ko    :/:K                       0 ]
			[ EK    :..:EK                     0 ]
			[ Vm    :..:Vm                     0 ]
			[ Cm    :..:Cm                     0 ];

		amplitude  0.0236;
		number     @IKATP_number;
		constant   1.0e-3;
		power      0.24;
		Cm0        @IKATP_Cm0;
	}

	@setCurrents( [ 'I' ], [ 'K', 'I' ] )

}

