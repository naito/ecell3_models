@{
IKpl_I = 3.2585916791737464E-6

IKpl_amp = {
	 "V" : 8.333E-7,
	 "EMB" : 8.333E-7,
	 "LAT" : 8.333E-7,
	 "NEO" : 8.333E-7,
	 "SAN" : 2.187E-4,
	 "A" : 2.187E-4,
}
}

System System(/CELL/MEMBRANE/IKpl)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IKpl_I;
	}

	Variable Variable( GX ){
		Value @( Kpl_gene[SimulationMode]);
	}

	Process IKplAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	20;

		VariableReferenceList
			[ I   :.:I                       1 ]
			[ GX  :.:GX                      0 ]
			[ Cm  :..:Cm                     0 ]
			[ Vm  :..:Vm                     0 ]
			[ Ko  :/:K                       0 ]
			[ CFK :..:CFK                    0 ];

		amplitude  @(IKpl_amp[SimulationMode]);
#		amplitude  8.333E-7;
#        	amplitude  0.0000001104753787879;
		constant   5.4;
		power      0.16;
		pOpen      1.0;
	}

	@setCurrents( [ 'I' ], [ 'K', 'I' ] )

}

@{'''

Author Yasuhiro Naito
Version 0.2 2008-11-30 02:02:56 +0900

	<IKpl name="IKpl" initial_value="3.2585916791737464E-6" units="pA"
		className="org.simBio.bio.terashima_et_al_2006.current.cf.IKpl">
		<KoDependency name="GK" initial_value="8.333E-7" units="pA/mV">
			<parameter name="amplitude" initial_value="8.333E-7" />
			<parameter name="constant" initial_value="5.4" units="mM" />
			<parameter name="power" initial_value="0.16" units="dimension_less" />
			<link name="Ko" initial_value="../../../K" />
		</KoDependency>
		<link name="Vm" initial_value="../Vm" units="mV" />
		<link name="Cm" initial_value="../membrane capacitance" />
		<link name="constantFieldNa" initial_value="../constantFieldNa" units="mM" />
		<link name="constantFieldK" initial_value="../constantFieldK" units="mM" />
		<link name="constantFieldCa" initial_value="../constantFieldCa" units="mM" />
		<link name="constantFieldCl" initial_value="../constantFieldCl" units="mM" />
		<link name="current" initial_value="../current" />
		<link name="currentNa" initial_value="../currentNa" />
		<link name="currentK" initial_value="../currentK" />
		<link name="currentCa" initial_value="../currentCa" />
		<link name="currentCl" initial_value="../currentCl" />
	</IKpl>
'''}