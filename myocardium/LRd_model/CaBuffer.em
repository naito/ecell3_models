Variable Variable( t_jsrol )
{
	Value	1000.0;
	Name	"Counter for t_jsrol";
}

Process CaBufferProcess( CaBuf )
{
#	StepperID	DT_01;
	Name	"Ca Buffer";
	VariableReferenceList
		[t_jsrol :.:t_jsrol 1]
		[Ca_i_f    :../..:Ca 1]
		[Ca_sr_f   :../JSR:Ca 1]
		[Ca_nsr_f   :../NSR:Ca 1]
		[TRPN_i_f  :../..:TRPNf 1]
		[CMDN_i_f  :../..:CMDNf 1]
		[CSQN_sr_f :../JSR:CSQNf 1]
		[TRPN_i_t  :../..:TRPNt 1]
		[CMDN_i_t  :../..:CMDNt 1]
		[CSQN_sr_t :../JSR:CSQNt 1];
		
		#Const
		KmTRPN 0.0005;
		#Const
		KmCMDN 0.00238;
		#Const
		KmCSQN 0.8;

	SingleCaLfullPN "Process:/CELL/MEMBRANE:iCaL_LRd_Ca_j:SingleCaL";
	SingleCabfullPN "Process:/CELL/MEMBRANE:Ibg_LRd_Ca_j:SingleCab";
	SinglePCafullPN "Process:/CELL/MEMBRANE:PCaPump_LRd_Ca_j:SinglePCa";
	SingleCaTfullPN "Process:/CELL/MEMBRANE:ICaT_LRd_Ca_j:SingleCaT";
	SingleNaCaExfullPN "Process:/CELL/MEMBRANE:NaCaEx_LRd_Ca_j:SingleNaCaEx";	
	SingleRyRfullPN "Process:/CELL/CYTOPLASM/SR/JSRMEM:iRyR:SingleRyR";
	SingleSRTransferfullPN "Process:/CELL/CYTOPLASM/SR/NSRMEM:SRTransfer:SingleSRTransfer";
	SingleSRLeakfullPN "Process:/CELL/CYTOPLASM/SR/NSRMEM:SRLeak:SingleSRLeak";
	SingleSRUptakefullPN "Process:/CELL/CYTOPLASM/SR/NSRMEM:SRUptake:SingleSRUptake";



	
#	SingleCaLfullPN "Process:/CELL/MEMBRANE:iCaL:SingleCaL";
#	SingleCabfullPN "Process:/CELL/MEMBRANE:iCab:SingleCab";
#	SinglePCafullPN "Process:/CELL/MEMBRANE:PCaPump:SinglePCa";
#	SingleCaTfullPN "Process:/CELL/MEMBRANE:iCaT:SingleCaT";
#	SingleNaCaExfullPN "Process:/CELL/MEMBRANE:NaCaEx:SingleNaCaEx";	
#	SingleRyRfullPN "Process:/CELL/CYTOPLASM/SR/JSRMEM:iRyR:SingleRyR";
#	SingleSRTransferfullPN "Process:/CELL/CYTOPLASM/SR/NSRMEM:SRTransfer:SingleSRTransfer";
#	SingleSRLeakfullPN "Process:/CELL/CYTOPLASM/SR/NSRMEM:SRLeak:SingleSRLeak";
#	SingleSRUptakefullPN "Process:/CELL/CYTOPLASM/SR/NSRMEM:SRUptake:SingleSRUptake";
}
