@{'''
Author Yasuhiro Naito

Version 0.1 2009-06-22 09:43:30 +0900

'''}

@{'''
記録対象VariableのFullIDとSystemID：この２つを書き換えれば別のVariableの記録に使える
'''
#記録対象VariableのFullID
targetFullID = ':/CELL/MEMBRANE:Vm'

#モデル内でのSystemID：/Recorder以下に作成される（行18参照）
SystemID = 'Vm'
}

System System( /Recorder/@SystemID )
{
	StepperID	PSV;

	@{'''時刻の保存'''}

	Variable Variable( t_0 )
	{
		Value 0.0;
	}

	Variable Variable( t_1 )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess( setPastTime1 ) 
	{
		Priority	101;

		VariableReferenceList
			[ t_0 :.:t_0  0 ]
			[ t_1 :.:t_1  1 ];

		Expression "t_0.Value";
		
	}

	Process ExpressionAssignmentProcess( setPastTime0 ) 
	{
		Priority	100;

		VariableReferenceList
			[ t   :/:t    0 ]
			[ t_0 :.:t_0  1 ];

		Expression "t.Value";
		
	}

	@{'''値の保存'''}

	Variable Variable( val_0 )
	{
		Value 0.0;
	}

	Variable Variable( val_1 )
	{
		Value 0.0;
	}

	Variable Variable( val_2 )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess( setPastVal0 ) 
	{
		Priority	100;

		VariableReferenceList
			[ target @targetFullID  0 ] 
			[ val_0  :.:val_0       1 ];

		Expression "target.Value";
		
	}

	Process ExpressionAssignmentProcess( setPastVal1 ) 
	{
		Priority	101;

		VariableReferenceList
			[ val_0  :.:val_0  0 ]
			[ val_1  :.:val_1  1 ];

		Expression "val_0.Value";
		
	}

	Process ExpressionAssignmentProcess( setPastVal2 ) 
	{
		Priority	102;

		VariableReferenceList
			[ val_1  :.:val_1  0 ]
			[ val_2  :.:val_2  1 ];

		Expression "val_1.Value";
		
	}


	@{'''最大値'''}

	Variable Variable( max_val )
	{
		Value 0.0;
	}

	Variable Variable( max_t )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess( max_val ) 
	{
		Priority	1;

		VariableReferenceList
			[ max_val  :.:max_val     1 ]
			[ val_0    :.:val_0       0 ]
			[ val_1    :.:val_1       0 ]
			[ val_2    :.:val_2       0 ];

		Expression "and( lt( val_0.Value, val_1.Value ), geq( val_1.Value, val_2.Value )) * ( val_1.Value - max_val.Value ) + max_val.Value";
		
	}

	Process ExpressionAssignmentProcess( max_t ) 
	{
		Priority	1;

		VariableReferenceList
			[ max_t  :.:max_t  1 ]
			[ val_0  :.:val_0  0 ]
			[ val_1  :.:val_1  0 ]
			[ val_2  :.:val_2  0 ]
			[ t_1    :.:t_1    0 ];

		Expression "and( lt( val_0.Value, val_1.Value ), geq( val_1.Value, val_2.Value )) * ( t_1.Value - max_t.Value ) + max_t.Value";
		
	}

	@{'''最大値'''}

	Variable Variable( min_val )
	{
		Value 0.0;
	}

	Variable Variable( min_t )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess( min_val ) 
	{
		Priority	1;

		VariableReferenceList
			[ min_val  :.:min_val     1 ]
			[ val_0    :.:val_0       0 ]
			[ val_1    :.:val_1       0 ]
			[ val_2    :.:val_2       0 ];

		Expression "and( gt( val_0.Value, val_1.Value ), leq( val_1.Value, val_2.Value )) * ( val_1.Value - min_val.Value ) + min_val.Value";
		
	}

	Process ExpressionAssignmentProcess( min_t ) 
	{
		Priority	1;

		VariableReferenceList
			[ min_t  :.:min_t  1 ]
			[ val_0  :.:val_0  0 ]
			[ val_1  :.:val_1  0 ]
			[ val_2  :.:val_2  0 ]
			[ t_1    :.:t_1    0 ];

		Expression "and( gt( val_0.Value, val_1.Value ), leq( val_1.Value, val_2.Value )) * ( t_1.Value - min_t.Value ) + min_t.Value";
		
	}


	@{'''連続振動チェッカ'''}

	Variable Variable( OscillationCount )
	{
		Value 0.0;
	}

	Variable Variable( lastMaxT )
	{
		Value 0.0;
	}

	Process PythonProcess( OscillationChecker ) 
	{
		Priority	1;

		VariableReferenceList
			[ count    :.:OscillationCount  1 ]
			[ lastMaxT :.:lastMaxT          1 ]
			[ max_t    :.:max_t             0 ]
			[ max_val  :.:max_val           0 ]
			[ min_val  :.:min_val           0 ]
			[ t        :/:t                 0 ];

		minAPD     50.0;
		maxAPD    500.0;
		minVm    -100.0;
		maxVm     150.0;
		
		#lastMaxT    0.0;

		waiting    60.0;  @#シミュレーション開始から計測開始までの待機時間

		FireMethod '''
if t.Value > waiting:
	if max_t.Value > lastMaxT.Value:
		APD = max_t.Value - lastMaxT.Value
		lastMaxT.Value = max_t.Value
		if ( max_val.Value <= maxVm ) and ( min_val.Value >= minVm ) and ( APD <= maxAPD ) and ( APD >= minAPD ):
			count.Value = count.Value + 1.0
		else:
			count.Value = 0.0
''';
		
	}

}

