Process SRTransferProcess( SRTransfer )
{
#	StepperID	SRM_02;
	Name	"SR Transfer";
	VariableReferenceList
		[SR_factor  :..:SR_factor 0]
		[Ca_jsr :../JSR:Ca 1]
		[Ca_nsr :../NSR:Ca -1];

	Itr_tau 180.0;
}
