System System(/CELL/MEMBRANE/Iha)
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

	Variable Variable( cNa )
	{
		Value 0;
	}

#Gate
	Variable Variable( vHCNGt )
	{
		Value 0;
		#Name	"Opened ultra slow gate fruction of Na channel";
		Name	"ha HCN gate";
	}

	Variable Variable( HCNGt )
	{
		Value 0.1;
		Name	"Opened ultra slow gate fruction of Na channel";
	}

	Variable Variable( GX )
	{
		Value @( HCN[SimulationMode]);
	}

	Variable Variable( POpen )
	{
		Value 0;
	}


	Process IhaAssignmentProcess_Zhang( I )
	{
		StepperID	PSV;
		Priority	20;
	
		VariableReferenceList
			[Vm	:..:Vm			0]
			[ENa	:..:ENa 		0]
			[EK	:..:EK 			0]

			[Ke	:/:K  			0]
			[Ki	:../../CYTOPLASM:K  	0]
			[Nae	:/:Na  			0]
			[Nai	:../../CYTOPLASM:Na 	0]

			[dvHCNGt	:.:vHCNGt	    1]
			[HCNGt		:.:HCNGt	    0]

			[pOpen	:.:POpen	    	0]

			[i	:.:i		    	1]
			[GX	:.:GX		    	0]
			[Cm	:..:Cm		    	0]

			[cK	:.:cK		    	1]
			[cNa	:.:cNa		    	1]
			[I	:.:I		    	1];
						
#Process TwoStateGatingKurataProcess( HCN_gating )
			a11 78.91;
			a12 -26.62;

			b11 75.13;
			b12 21.25;

#Process HCNChannelFluxProcess( Iha_Na_j )
	 		P_Na 0.0069;

#Process HCNChannelFluxProcess( Iha_K_j )
	 		P_K 0.0069;

	}

#	Process ZeroVariableAsFluxProcess( HCNGt )
#	{
#		Priority	15;
		
#		VariableReferenceList
#			[dvHCNGt	:.:vHCNGt	0]
#			[HCNGt		:.:HCNGt	1];
#	}

#	@setCurrents([ 'I' ], [ 'K' , 'cK' ], [ 'Na' , 'cNa' ] )
}

