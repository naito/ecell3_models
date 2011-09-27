Variable Variable( dcaiont )
{
	Value	0;
	Name	"Rate of change of Ca(2+) entry";
}
Variable Variable( caiontold )
{
	Value	0;
	Name	"Total Ca(2+) ion flow";
}
Variable Variable( tcirc )
{
	Value	1000;
	Name	"t=0 at time of CICR (ms)";
}


Process RyRProcess( iRyR )
{
#	StepperID	SRM_02;
	Name	"RyR";
	VariableReferenceList
		[dcaiont :.:dcaiont 1]
		[caiontold :.:caiontold 1]
		[tcirc :.:tcirc 1]	
		[SR_factor  :..:SR_factor 0]
		[Ca_i_f  :../..:Ca 1]
		[Ca_jsr :../JSR:Ca -1]
		[Vm	:../../../MEMBRANE:Vm 0];

	SingleCaLfullPN "Process:/CELL/MEMBRANE:iCaL_LRd_Ca_j:SingleCaL";
	SingleCabfullPN "Process:/CELL/MEMBRANE:Ibg_LRd_Ca_j:SingleCab";
	SinglePCafullPN "Process:/CELL/MEMBRANE:PCaPump_LRd_Ca_j:SinglePCa";
	SingleCaTfullPN "Process:/CELL/MEMBRANE:ICaT_LRd_Ca_j:SingleCaT";
	SingleNaCaExfullPN "Process:/CELL/MEMBRANE:NaCaEx_LRd_Ca_j:SingleNaCaEx";
}
