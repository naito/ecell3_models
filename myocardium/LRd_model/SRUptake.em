Process SRUptakeProcess( SRUptake )
{
#	StepperID	SRM_02;
	Name	"SR Uptake";
	VariableReferenceList
		[SR_factor  :..:SR_factor 0]
		[Ca_i_f :../..:Ca -1]
		[Ca_nsr :../NSR:Ca 1];

	I_up 0.00875;
	Km_up 0.00092;
}
