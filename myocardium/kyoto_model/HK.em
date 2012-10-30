
#	Variable Variable( Glc )
#	{
#		Value 1.8;#min
#		Value 2.5;#max
#		MolarConc 1.8;#min
#		MolarConc 2.5;#max
#		MolarConc 0.0018;#min
#		MolarConc 0.0025;#max
#	}

	Variable Variable( Vf )
	{
		Value 1.0;
	}

       Variable Variable( VHK_GX )
       {
		Value @( Lambeth[Glycolysis]);
#               Value 1.0;
        }

        Process HK_Process( V_HK )
        {
                StepperID  ODE;
                Priority   0;

                VariableReferenceList
                        [ Vf           :.:Vf           0 ]
                        [ ATP          :.:ATPtotal    -1 ]
#                       [ ATP          :.:ATP         -1 ]
                        [ Glc          :.:Glc         -1 ]
                        [ ADP          :.:ADPtotal     1 ]
#                       [ ADP          :.:ADP          1 ]
                        [ G6P          :.:G6P          1 ]
                        [ GX           :.:VHK_GX       0 ];

                        Kapp 1700.0;
                        KATP 0.17;
                        KGlc 0.11;
                        KADP 1.2;
                        KG6P 0.0014;
                        KiATP 0.17;
                        KiGlc 0.11;
                        KiADP 1.2;
                        KiG6P 0.0014;

	}
