Variable Variable( t_jsrol )
{
	Value	1000.0;
	Name	"Counter for t_jsrol";
}

Process CaBufAssignmentProcess( CaBuf )
{
	StepperID	PSV;
	Priority	5; # lowest in LRd

	VariableReferenceList
			[Vm	:../MEMBRANE:Vm        0]
			[ICaL   :../MEMBRANE/ICaL:cCa  0]
			[ICaT   :../MEMBRANE/ICaT:I    0]
			[INaCa  :../MEMBRANE/INaCa:I   0]
			[IPCa   :../MEMBRANE/IPCa:I    0]
			[Ibg    :../MEMBRANE/Ibg:cCa   0]

			[IRyR        :./JSR/IRyR:I     0]
			[ISRTransfer :./SEPARATOR:I    0]
			[ISRLeak     :./NSR/leak:I     0]
			[ISRCA       :./NSR/ISRCA:I    0]

			[Ca_i_f      :.:Ca             1]
			[Ca_sr_f     :./JSR:Ca         1]
			[Ca_nsr_f    :./NSR:Ca         1]
			[TRPN_i_f    :.:TRPNf          1]
			[CMDN_i_f    :.:CMDNf          1]
			[CSQN_sr_f   :./JSR:CSQNf      1]
			[TRPN_i_t    :.:TRPNt          1]
			[CMDN_i_t    :.:CMDNt          1]
			[CSQN_sr_t   :./JSR:CSQNt      1]

			[t_jsrol :.:t_jsrol 1];

			#Const
			KmTRPN 0.0005;
			#Const
			KmCMDN 0.00238;
			#Const	
			KmCSQN 0.8;
	
}
