Stepper FixedODE1Stepper( ODE ){}

System System( / )
{
	StepperID	ODE;

	Variable Variable( time )
	{
		Value  0.0;
	}

	Process ExpressionFluxProcess( clock )
	{
		VariableReferenceList [ t :/:time -1 ];
		Expression  "2.0";
	}
}
