Stepper FixedODE1Stepper( ODE )
{
	# no property
}

Stepper PassiveStepper( PSV )
{
	# no property
}

System System( / )
{
	StepperID	ODE;
}

System System( /CELL )
{
	StepperID	ODE;

	Variable Variable( SIZE )
        {
		Value 1.41;
 	}
	Variable Variable( AA )
	{
		Value 2.5E-6;
	}
	Variable Variable( AAp )
	{
		Value 0.0;
	}
	Variable Variable( W )
	{
		Value 5.0E-6;
	}
	Variable Variable( WAA )
	{
		Value 0.0;
	}
	Variable Variable( WAAp )
	{
		Value 0.0;
	}
	Variable Variable( WWAA )
	{
		Value 0.0;
	}
	Variable Variable( WWAAp )
	{
		Value 0.0;
	}
	Variable Variable( TT )
	{
		Value 2.5E-6;
	}
	Variable Variable( TTW )
	{
		Value 0.0;
	}
	Variable Variable( TTWW )
	{
		Value 0.0;
	}
	Variable Variable( TTWAA )
	{
		Value 0.0;
	}
	Variable Variable( TTWAAp )
	{
		Value 0.0;
	}
	Variable Variable( TTAA )
	{
		Value 0.0;
	}
	Variable Variable( TTAAp )
	{
		Value 0.0;
	}
	Variable Variable( TTWWAA )
	{
		Value 0.0;
	}
	Variable Variable( TTWWAAp )
	{
		Value 0.0;
	}
	Variable Variable( Y )
	{
		Value 1.0E-5;
	}
	Variable Variable( Yp )
	{
		Value 0.0;
	}
	Variable Variable( Z )
	{
		Value 2.0E-5;
	}
	Variable Variable( B )
	{
		Value 2.0E-6;
	}
	Variable Variable( Bp )
	{
		Value 0.0;
	}
	Variable Variable( setYp )
	{
		Value 1.63E-6;
	}
	Variable Variable( Bias )
	{
		Value 0.0;
	}

	Process ExpressionFluxProcess( complex_r1 )
        {
		VariableReferenceList
			 [ TTW :.:TTW -1]
			 [ TT :.:TT 1]
			 [ W :.:W 1];

			 k1 0.00365;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTW.Value - k2 * TT.Value * W.Value )";
	}

	Process ExpressionFluxProcess( complex_r2 )
        {
		VariableReferenceList
			 [ WAA :.:WAA -1]
			 [ W :.:W 1]
			 [ AA :.:AA 1];

			 k1 0.00894;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * WAA.Value - k2 * W.Value * AA.Value )";
	}

	Process ExpressionFluxProcess( complex_r3 )
        {
		VariableReferenceList
			 [ TTWAA :.:TTWAA -1]
			 [ TT :.:TT 1]
			 [ WAA :.:WAA 1];

			 k1 297.0;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWAA.Value - k2 * TT.Value * WAA.Value )";
	}

	Process ExpressionFluxProcess( complex_r4 )
        {
		VariableReferenceList
			 [ TTWWAA :.:TTWWAA -1]
			 [ TTW :.:TTW 1]
			 [ WAA :.:WAA 1];

			 k1 0.64;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWWAA.Value - k2 * TTW.Value * WAA.Value )";
	}

	Process ExpressionFluxProcess( complex_r5 )
        {
		VariableReferenceList
			 [ TTWWAA :.:TTWWAA -1]
			 [ TTWW :.:TTWW 1]
			 [ AA :.:AA 1];

			 k1 0.112;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWWAA.Value - k2 * TTWW.Value * AA.Value )";
	}

	Process ExpressionFluxProcess( complex_r6 )
        {
		VariableReferenceList
			 [ TTWWAA :.:TTWWAA -1]
			 [ TT :.:TT 1]
			 [ WWAA :.:WWAA 1];

			 k1 0.0229;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWWAA.Value - k2 * TT.Value * WWAA.Value )";
	}

	Process ExpressionFluxProcess( complex_r7 )
        {
		VariableReferenceList
			 [ TTAA :.:TTAA -1]
			 [ TT :.:TT 1]
			 [ AA :.:AA 1];

			 k1 39.3;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTAA.Value - k2 * TT.Value * AA.Value )";
	}

	Process ExpressionFluxProcess( complex_r8 )
        {
		VariableReferenceList
			 [ TTWAA :.:TTWAA -1]
			 [ TTW :.:TTW 1]
			 [ AA :.:AA 1];

			 k1 727.0;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWAA.Value - k2 * TTW.Value * AA.Value )";
	}

	Process ExpressionFluxProcess( complex_r9 )
        {
		VariableReferenceList
			 [ TTWWAA :.:TTWWAA -1]
			 [ TTWAA :.:TTWAA 1]
			 [ W :.:W 1];

			 k1 7.87E-6;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWWAA.Value - k2 * TTWAA.Value * W.Value )";
	}

	Process ExpressionFluxProcess( complex_r10 )
        {
		VariableReferenceList
			 [ TTWW :.:TTWW -1]
			 [ TTW :.:TTW 1]
			 [ W :.:W 1];

			 k1 0.0511;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWW.Value - k2 * TTW.Value * W.Value )";
	}

	Process ExpressionFluxProcess( complex_r11 )
        {
		VariableReferenceList
			 [ WWAA :.:WWAA -1]
			 [ W :.:W 1]
			 [ WAA :.:WAA 1];

			 k1 0.102;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * WWAA.Value - k2 * W.Value * WAA.Value )";
	}

	Process ExpressionFluxProcess( complex_r12 )
        {
		VariableReferenceList
			 [ TTWAA :.:TTWAA -1]
			 [ TTAA :.:TTAA 1]
			 [ W :.:W 1];

			 k1 0.0676;
			 k2 1000000.0;

		 	 Expression "self.getSuperSystem().Size * ( k1 * TTWAA.Value - k2 * TTWAA.Value * W.Value )";
	}

	Process ExpressionFluxProcess( phosphorylation_r1 )
        {
		VariableReferenceList
			 [ TTWWAA :.:TTWWAA -1]
			 [ TTWWAAp :.:TTWWAAp 1];

			 k1 15.5;

		 	 Expression "self.getSuperSystem().Size * k1 * TTWWAA.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r2 )
        {
		VariableReferenceList
			 [ AA :.:AA -1]
			 [ AAp :.:AAp 1];

			 k1 0.0227;

		 	 Expression "self.getSuperSystem().Size * k1 * AA.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r3 )
        {
		VariableReferenceList
			 [ WAA :.:WAA -1]
			 [ WAAp :.:WAAp 1];

			 k1 0.0227;

		 	 Expression "self.getSuperSystem().Size * k1 * WAA.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r4 )
        {
		VariableReferenceList
			 [ WWAA :.:WWAA -1]
			 [ WWAAp :.:WWAAp 1];

			 k1 0.0227;

		 	 Expression "self.getSuperSystem().Size * k1 * WWAA.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r5 )
        {
		VariableReferenceList
			 [ TTAA :.:TTAA -1]
			 [ TTAAp :.:TTAAp 1];

			 k1 0.0227;

		 	 Expression "self.getSuperSystem().Size * k1 * TTAA.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r6 )
        {
		VariableReferenceList
			 [ TTWAA :.:TTWAA -1]
			 [ TTWAAp :.:TTWAAp 1];

			 k1 0.0227;

		 	 Expression "self.getSuperSystem().Size * k1 * TTWAA.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r7 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ Yp :.:Yp 1];

			 k1 0.00124;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r8 )
        {
		VariableReferenceList
			 [ Yp :.:Yp -1]
			 [ Y :.:Y 1];

			 k1 0.037;

			 Expression "self.getSuperSystem().Size * k1 * Yp.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r9 )
        {
		VariableReferenceList
			 [ Yp :.:Yp -1]
			 [ Z :.:Z -1]
			 [ Y :.:Y 1]
			 [ Z :.:Z 1];

			 k1 500000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * Yp.Value * Z.Value";
	}

	Process ExpressionFluxProcess( phosphorylation_r10 )
        {
		VariableReferenceList
			 [ Bp :.:Bp -1]
			 [ B :.:B 1];

			 k1 0.35;

		 	 Expression "self.getSuperSystem().Size * k1 * Bp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r1 )
        {
		VariableReferenceList
			 [ B :.:B -1]
			 [ AAp :.:AAp -1]
			 [ Bp :.:Bp 1]
			 [ AA :.:AA 1];

			 k1 6000000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * B.Value * AAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r2 )
        {
		VariableReferenceList
			 [ B :.:B -1]
			 [ WAAp :.:WAAp -1]
			 [ Bp :.:Bp 1]
			 [ WAA :.:WAA 1];

			 k1 6000000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * B.Value * WAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r3 )
        {
		VariableReferenceList
			 [ B :.:B -1]
			 [ WWAAp :.:WWAAp -1]
			 [ Bp :.:Bp 1]
			 [ WWAA :.:WWAA 1];

			 k1 6000000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * B.Value * WWAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r4 )
        {
		VariableReferenceList
			 [ B :.:B -1]
			 [ TTAAp :.:TTAAp -1]
			 [ Bp :.:Bp 1]
			 [ TTAA :.:TTAA 1];

			 k1 6000000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * B.Value * TTAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r5 )
        {
		VariableReferenceList
			 [ B :.:B -1]
			 [ TTWAAp :.:TTWAAp -1]
			 [ Bp :.:Bp 1]
			 [ TTWAA :.:TTWAA 1];

			 k1 6000000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * B.Value * TTWAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r6 )
        {
		VariableReferenceList
			 [ B :.:B -1]
			 [ TTWWAAp :.:TTWWAAp -1]
			 [ Bp :.:Bp 1]
			 [ TTWWAA :.:TTWWAA 1];

			 k1 6000000.0;

		 	 Expression "self.getSuperSystem().Size * k1 * B.Value * TTWWAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r7 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ AAp :.:AAp -1]
			 [ Yp :.:Yp 1]
			 [ AA :.:AA 1];

			 k1 3.0E7;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value * AAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r8 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ WAAp :.:WAAp -1]
			 [ Yp :.:Yp 1]
			 [ WAA :.:WAA 1];

			 k1 3.0E7;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value * WAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r9 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ WWAAp :.:WWAAp -1]
			 [ Yp :.:Yp 1]
			 [ WWAA :.:WWAA 1];

			 k1 3.0E7;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value * WWAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r10 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ TTAAp :.:TTAAp -1]
			 [ Yp :.:Yp 1]
			 [ TTAA :.:TTAA 1];

			 k1 3.0E7;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value * TTAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r11 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ TTWAAp :.:TTWAAp -1]
			 [ Yp :.:Yp 1]
			 [ TTWAA :.:TTWAA 1];

			 k1 3.0E7;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value * TTWAAp.Value";
	}

	Process ExpressionFluxProcess( phosphotransfer_r12 )
        {
		VariableReferenceList
			 [ Y :.:Y -1]
			 [ TTWWAAp :.:TTWWAAp -1]
			 [ Yp :.:Yp 1]
			 [ TTWWAA :.:TTWWAA 1];

			 k1 3.0E7;

		 	 Expression "self.getSuperSystem().Size * k1 * Y.Value * TTWWAAp.Value";
	}

	Process ExpressionAssignmentProcess( Assignment_rule )
        {
		VariableReferenceList
			 [ Bias :.:Bias 1]
			 [ Yp   :.:Yp   0]
			 [ setYp  :.:setYp  0];

			 Hill 4.0;
			 Bias 0.0;

		 	 Expression "1.0 - pow( Yp.Value, Hill ) / ( 2.333 * pow( setYp.Value, Hill) + pow( Yp.Value, Hill ) )";
	}
}