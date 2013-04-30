@{
SystemPath = "/CELL/MEMBRANE/IKr"

IKr_I = 0.09486894729445249
IKr_gate1 = 0.0011801183298905053
IKr_gate2 = 0.1621809652686286
IKr_gate3 = 0.969315526153146
IKr_POpen = 0.063568155284470809

IKr_amp = {
	"V" : 0.035,
	"EMB" : 0.035,
	"LAT" : 0.035,
	"NEO" : 0.035,
	"SAN" : 0.07,
	"A" : 0.07,
}# 	amplitude  0.00928030303030303;
}

System System( @SystemPath )
{
	StepperID	ODE;

	Variable Variable( gate1 )
	{
		Value @IKr_gate1;
	}

	Variable Variable( gate2 )
	{
		Value @IKr_gate2;
	}

	Variable Variable( gate3 )
	{
		Value @IKr_gate3;
	}

	Variable Variable( GX ){
		Value @( erg1[SimulationMode]);
	}

	Process IKrCurrentProcess( current )
	{
		# StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ y1    :.:gate1               0 ]
			[ y2    :.:gate2               0 ]
			[ y3    :.:gate3               0 ]
			# [ pOpen :.:POpen               1 ]
			# [ I     :.:I                   1 ]
			[ GX    :.:GX                  0 ]
			[ Ko    :/:K                   0 ]
			[ EK    :..:EK                 0 ]
			[ Vm    :..:Vm                 1 ]
			[ Cm    :..:Cm                 0 ];

		amplitude  @( IKr_amp[SimulationMode] );

		constant 5.4;
		power    0.2;
		
		dy1      -1.57812176308e-05;
		dy2      -0.00131940244958;
		dy3      1.0760828538e-07;
	}

	Process SpyFluxProcess( I ) 
	{
		Priority	15;

		VariableReferenceList
			[ _ :/CELL/MEMBRANE:VmCm -1 ];

		target  "Process:@(SystemPath):current:I";
	}

	Process SpyFluxProcess( jK ) 
	{
		Priority	15;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ];

		target  "Process:@(SystemPath):current:I";
		k  "@( 1.0e-15 * N_A / zK / ( F * 1.0e+3 ) )";
	}

	Process SpyFluxProcess( gate1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate1  1 ];

		target  "Process:@(SystemPath):current:dy1";
	}

	Process SpyFluxProcess( gate2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate2  1 ];

		target  "Process:@(SystemPath):current:dy2";
	}

	Process SpyFluxProcess( gate3 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate3  1 ];

		target  "Process:@(SystemPath):current:dy3";
	}

#	Process IonFluxProcess( jK ) 
#	{
#		Priority	11;
#
#		VariableReferenceList
#			[ Ke  :/:K                1 ]
#			[ Ki  :../../CYTOPLASM:K -1 ]
#			[ i   :.:I                 0 ]
#			[ N_A :/:N_A                0 ]
#			[ F   :/:F                  0 ]
#			[ z   :/:zK                0 ];
#	}

#	Process ApplyCurrentProcess( Vm ) 
#	{
#		Priority	10;
#
#		VariableReferenceList
#			[ Vm :/CELL/MEMBRANE:Vm  1 ]
#			[ Cm :/CELL/MEMBRANE:Cm   0 ]
#			[ I  :.:I    0 ];
#	}

#	Process CurrentIncrementProcess( currentK ) 
#	{
#		StepperID	PSV;
#		Priority	10;
#
#		VariableReferenceList
#			[ total :/CELL/MEMBRANE:currentK  1 ]
#			[ c     :.:I               0 ];
#
#		n 1.0;
#		
#	}
#
#	Process CurrentIncrementProcess( current ) 
#	{
#		StepperID	PSV;
#		Priority	10;
#
#		VariableReferenceList
#			[ total :/CELL/MEMBRANE:current  1 ]
#			[ c     :.:I               0 ];
#
#		n 1.0;
#		
#	}

}

# Author Yasuhiro NAITO
# Version 0.1 2008-08-20 06:55:43 +0900

#simBio 1.0 className	"org.simBio.bio.terashima_et_al_2006.current.potassium.IKr"
