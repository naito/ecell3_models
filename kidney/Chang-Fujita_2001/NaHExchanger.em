#
# Chang H, Fujita T.
# A numerical model of acid-base transport in rat distal tubule.
# Am J Physiol Renal Physiol. 2001 Aug;281(2):F222-43.
# PubMed PMID:11457714.
#

Stepper FixedODE1Stepper( ODE ){}

Stepper PassiveStepper( PSV ){}

System System( / )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		Value  1.0;  @# 適切な数値に変更する
	}

}

System System( /Cytoplasm )
{
	StepperID	ODE;

	###### Variable #####

	Variable Variable( SIZE )
	{
		Value  1.0;  @# 適切な数値に変更する
	}

	Variable Variable( Na )
	{
		MolarConc 0.005;  @# 適切な数値に変更する
	}

	Variable Variable( H )
	{
		MolarConc 1.0E-7;  @# 適切な数値に変更する
	}

	Variable Variable( NH4 )
	{
		MolarConc 0.0;  @# 適切な数値に変更する
	}

	Variable Variable( NaHExchanger )
	{
		MolarConc 0.0;  @# 適切な数値に変更する　このVariableは不要かもしれない
	}

}

System System( /Cytoplasm/NaHExchanger )
{
	StepperID	ODE;


	Variable Variable( SIZE )
	{
		Value  1.0;  @# 適切な数値に変更する
	}

	Variable Variable( E )
	{
		Value  1.0;
	}

	Variable Variable( ENa )
	{
		Value  0.0;
	}

	Process ExpressionFluxProcess( k1 )
	{
		VariableReferenceList
			[ Na  :..:Na -1 ]
			[ E   :.:E   -1 ]
			[ ENa :.:ENa  1 ];

		k1  1.0E8;

		Expression  "1.0E-8 * k1 * Na.MolarConc * E.Value";
	}

	Process ExpressionFluxProcess( k2 )
	{
		VariableReferenceList
			[ ENa :.:ENa -1 ]
			[ E   :.:E    1 ]
			[ Na  :..:Na  1 ];

		k2  3.27E6;

		Expression  "1.0E-8 * k2 * ENa.Value";
	}

}
