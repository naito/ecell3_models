Process SRLeakProcess( SRLeak )
{
#	StepperID	SRM_02;
	Name	"SR Leak";
	VariableReferenceList
		[SR_factor  :..:SR_factor 0]
		[Ca_i_f :../..:Ca 1]
		[Ca_nsr :../NSR:Ca -1];

	I_up 0.00875;
	Ca_NSR_max 15.0;
}
