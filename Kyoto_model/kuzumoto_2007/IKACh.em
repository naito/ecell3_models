# Author Yasuhiro NAITO
# Version 0.1 2009-07-10 14:47:15 +0900

#simBio 1.0 className	"org.simBio.bio.himeno_et_al_2008.IKACh"

System System(/CELL/MEMBRANE/IKACh)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value @IKACh_I;
	}

	Variable Variable( dgate )
	{
		Value 0.0;
	}

	Variable Variable( gate )
	{
		Value @IKACh_gate;
	}

	Variable Variable( pOpen )
	{
		Value 0.0;
	}

	Process IKAChAssignmentProcess( I )
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ I     :.:I                        1 ]
			[ Vm    :..:Vm                      0 ]
			[ EK    :..:EK                      0 ]
			[ ACh   :../../CYTOPLASM:ACh        0 ]
			[ dgate :.:dgate                    1 ]
			[ gate  :.:gate                     0 ]
			[ pOpen :.:pOpen                    1 ]
			[ GX    :../../CYTOPLASM:KACh_gene  0 ]
			[ Cm    :..:Cm                      0 ];

		Km             0.0042e-3;  # M
		permeabilityK  0.135;  # pA/mV
	}

	Process ZeroVariableAsFluxProcess( gate ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate  1 ]
			[ dy  :.:dgate 0 ];
	}

	@setCurrents( [ 'I' ], [ 'K', 'I' ] )

}

