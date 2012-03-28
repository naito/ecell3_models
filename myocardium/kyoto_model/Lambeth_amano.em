Stepper FixedODE1Stepper( ODE )
{
	# no property
	StepInterval 1.0E-7;
}

Stepper DiscreteTimeStepper( DT )
{
	# no property
	StepInterval 1.0E-7;
}

Stepper PassiveStepper( PSV )
{
	# no preperty
}

System System( / )
{
	StepperID	ODE;
}


System System( /CELL )
{
	StepperID	ODE;
}


System System( /CELL/GLYCOGENOLYSIS )
{
	StepperID	ODE;

#Aoki_120309
	Variable Variable( GLY )
	{
		Value 112.0;
	}

	Variable Variable( G1P )
	{
		Value 0.0589;
	}

	Variable Variable( Pi )
	{
		Value 4.1;
	}

	Variable Variable( KGLYf_GPa )
	{
		Value 1.7;
	}

	Variable Variable( KGLYb_GPa )
	{
		Value 0.15;
	}

	Variable Variable( KiGLYf_GPa )
	{
		Value 2.0;
	}

	Variable Variable( KiGLYb_GPa )
	{
		Value 0.56;
	}

	Variable Variable( KPi_GPa )
	{
		Value 4.0;
	}

	Variable Variable( KiPi_GPa )
	{
		Value 4.7;
	}

	Variable Variable( KG1P_GPa )
	{
		Value 2.7;
	}

	Variable Variable( KiG1P_GPa )
	{
#		Value 10.1;
		Value 10.0;
	}

	Variable Variable( KeqGP )
	{
		Value 0.42;
	}

	Variable Variable( Vmaxf_GPa )
	{
		Value 20.0;
	}

	Variable Variable( Vmaxr_GPa )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_GPa )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_GPa  :.:Vmaxr_GPa    1 ]			
			[ Vmaxf_GPa  :.:Vmaxf_GPa    0 ]
			[ KGLYb_GPa  :.:KGLYb_GPa    0 ]
			[ KPi_GPa    :.:KPi_GPa      0 ]
			[ KeqGP      :.:KeqGP        0 ]
			[ KiGLYf_GPa :.:KiGLYf_GPa   0 ]
			[ KiG1P_GPa  :.:KiG1P_GPa    0 ];
	
		Expression "( Vmaxf_GPa.Value * KGLYb_GPa.Value * KiG1P_GPa.Value ) / KiGLYf_GPa.Value / KPi_GPa.Value / KeqGP.Value ";
	}

	Variable Variable( V_GPa_a )
	{
		Value 0.0;
	}

        Variable Variable( V_GPa_b )
        {
                Value 0.0;
        }

        Variable Variable( V_GPa )
        {
                Value 0.0;
        }

	Process ExpressionAssignmentProcess ( V_GPa_a_assign )
	{
		StepperID  DT;
		Priority   3;

		VariableReferenceList
			[ V_GPa_a    :.:V_GPa_a      1 ]
			[ Vmaxf_GPa  :.:Vmaxf_GPa    0 ]
			[ Vmaxr_GPa  :.:Vmaxr_GPa    0 ]
			[ GLY        :.:GLY          0 ]
			[ Pi         :.:Pi           0 ]
			[ G1P        :.:G1P          0 ]
			[ KGLYb_GPa  :.:KGLYb_GPa    0 ]
			[ KiGLYf_GPa :.:KiGLYf_GPa   0 ]
			[ KPi_GPa    :.:KPi_GPa      0 ]
			[ KiG1P_GPa  :.:KiG1P_GPa    0 ];
	
		Expression " Vmaxf_GPa.Value * ( GLY.Value * Pi.Value / KiGLYf_GPa.Value / KPi_GPa.Value ) -  Vmaxr_GPa.Value * ( GLY.Value * G1P.Value / KGLYb_GPa.Value / KiG1P_GPa.Value )";		
	}

        Process ExpressionAssignmentProcess ( V_GPa_b_assign )
        {
                StepperID  DT;
                Priority   3;

                VariableReferenceList
                        [ V_GPa_b    :.:V_GPa_b      1 ]
                        [ GLY        :.:GLY          0 ]
                        [ Pi         :.:Pi           0 ]
                        [ G1P        :.:G1P          0 ]
                        [ KGLYf_GPa  :.:KGLYf_GPa    0 ]
                        [ KGLYb_GPa  :.:KGLYb_GPa    0 ]
                        [ KiGLYf_GPa :.:KiGLYf_GPa   0 ]
                        [ KiGLYb_GPa :.:KiGLYb_GPa   0 ]
                        [ KiPi_GPa   :.:KiPi_GPa     0 ]
                        [ KiG1P_GPa  :.:KiG1P_GPa    0 ];

                Expression " 1.0 + GLY.Value / KiGLYf_GPa.Value + Pi.Value / KiPi_GPa.Value + GLY.Value / KiGLYb_GPa.Value + G1P.Value / KiG1P_GPa.Value + GLY.Value * Pi.Value / ( KGLYf_GPa.Value * KiPi_GPa.Value ) + GLY.Value * G1P.Value / ( KGLYb_GPa.Value * KiG1P_GPa.Value )";
        }

        Process ExpressionAssignmentProcess ( V_GPa_assign )
        {
                StepperID  DT;
                Priority   1;

                VariableReferenceList
                        [ V_GPa      :.:V_GPa        1 ]
                        [ V_GPa_b    :.:V_GPa_b      0 ]
                        [ V_GPa_a    :.:V_GPa_a      0 ]
                        [ Vmaxf_GPa  :.:Vmaxf_GPa    0 ]
                        [ Vmaxr_GPa  :.:Vmaxr_GPa    0 ]
                        [ GLY        :.:GLY          0 ]
                        [ Pi         :.:Pi           0 ]
                        [ G1P        :.:G1P          0 ]
                        [ KGLYf_GPa  :.:KGLYf_GPa    0 ]
                        [ KGLYb_GPa  :.:KGLYb_GPa    0 ]
                        [ KiGLYf_GPa :.:KiGLYf_GPa   0 ]
                        [ KiGLYb_GPa :.:KiGLYb_GPa   0 ]
                        [ KPi_GPa    :.:KPi_GPa      0 ]
                        [ KiPi_GPa   :.:KiPi_GPa     0 ]
                        [ KiG1P_GPa  :.:KiG1P_GPa    0 ];
 

                Expression " V_GPa_a.Value / V_GPa_b.Value ";
        }

        Variable Variable( KiGLYf_GPb )
        {
                Value 15.0;
        }

        Variable Variable( KiGLYb_GPb )
        {
                Value 4.4;
        }

	Variable Variable( KPi_GPb )
	{
		Value 0.2;
	}

	Variable Variable( KiPi_GPb )
	{
		Value 4.6;
	}

	Variable Variable( KG1P_GPb )
	{
		Value 1.5;
	}

	Variable Variable( KiG1P_GPb )
	{
		Value 7.4;
	}

	Variable Variable( AMP )
	{
#		Value 0.00002;
		Value 0.00001;
	}

	Variable Variable( K_AMP )
	{
		Value @(1.9 * pow( 10.0, -6.0 ));
	}

	Variable Variable( nH )
	{
		Value 1.75;
	}

	Variable Variable( Vmaxf_GPb )
	{
		Value 30.0;
	}

	Variable Variable( Vmaxr_GPb )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_GPb )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_GPb  :.:Vmaxr_GPb      1 ]			
			[ Vmaxf_GPb  :.:Vmaxf_GPb      0 ]
			[ KiGLYb_GPb :.:KiGLYb_GPb     0 ]
			[ KPi_GPb    :.:KPi_GPb        0 ]
			[ KeqGP      :.:KeqGP          0 ]
			[ KiGLYf_GPb :.:KiGLYf_GPb     0 ]
			[ KG1P_GPb   :.:KG1P_GPb       0 ];
	
		Expression "( Vmaxf_GPb.Value * KiGLYb_GPb.Value * KG1P_GPb.Value ) / ( KiGLYf_GPb.Value * KPi_GPb.Value * KeqGP.Value )";		
	}

        Variable Variable( V_GPb_a )
        {
                Value 0.0;
        }

        Variable Variable( V_GPb_b )
        {
                Value 0.0;
        }

	Variable Variable( V_GPb )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_GPb_a_assign )
	{
		StepperID  DT;
		Priority   3;

		VariableReferenceList
			[ V_GPb_a    :.:V_GPb_a      1 ]
			[ Vmaxf_GPb  :.:Vmaxf_GPb    0 ]
			[ Vmaxr_GPb  :.:Vmaxr_GPb    0 ]
			[ GLY        :.:GLY          0 ]
			[ Pi         :.:Pi           0 ]
			[ G1P        :.:G1P          0 ]
			[ AMP        :.:AMP          0 ]
			[ KiGLYf_GPb :.:KiGLYf_GPb   0 ]
			[ KiGLYb_GPb :.:KiGLYb_GPb   0 ]
			[ KPi_GPb    :.:KPi_GPb      0 ]
			[ KG1P_GPb   :.:KG1P_GPb     0 ]
			[ K_AMP      :.:K_AMP        0 ]
			[ nH         :.:nH           0 ];
	
		Expression "( pow( AMP.Value, nH.Value) / K_AMP.Value ) * ( Vmaxf_GPb.Value * ( GLY.Value * Pi.Value / ( KiGLYf_GPb.Value * KPi_GPb.Value )) - Vmaxr_GPb.Value * ( GLY.Value * G1P.Value / ( KiGLYb_GPb.Value * KG1P_GPb.Value )))";	
        }

        Process ExpressionAssignmentProcess ( V_GPb_b_assign )
        {
                StepperID  DT;
                Priority   3;

                VariableReferenceList
                        [ V_GPb_b    :.:V_GPb_b      1 ]
                        [ Vmaxf_GPb  :.:Vmaxf_GPb    0 ]
                        [ Vmaxr_GPb  :.:Vmaxr_GPb    0 ]
                        [ GLY        :.:GLY          0 ]
                        [ Pi         :.:Pi           0 ]
                        [ G1P        :.:G1P          0 ]
                        [ AMP        :.:AMP          0 ]
                        [ KiGLYf_GPb :.:KiGLYf_GPb   0 ]
                        [ KiGLYb_GPb :.:KiGLYb_GPb   0 ]
                        [ KPi_GPb    :.:KPi_GPb      0 ]
                        [ KiPi_GPb   :.:KiPi_GPb     0 ]
                        [ KG1P_GPb   :.:KG1P_GPb     0 ]
                        [ KiG1P_GPb  :.:KiG1P_GPb    0 ]
                        [ K_AMP      :.:K_AMP        0 ]
                        [ nH         :.:nH           0 ];

                Expression " ( 1 + pow( AMP.Value, nH.Value ) / K_AMP.Value ) * ( 1 + GLY.Value / KiGLYf_GPb.Value + Pi.Value / KiPi_GPb.Value + GLY.Value / KiGLYb_GPb.Value + G1P.Value / KiG1P_GPb.Value + GLY.Value * Pi.Value / ( KiGLYf_GPb.Value * KPi_GPb.Value ) + GLY.Value * G1P.Value / ( KiGLYb_GPb.Value * KG1P_GPb.Value ))";
        }

        Process ExpressionAssignmentProcess ( V_GPb_assign )
        {
                StepperID DT;
                Priority  1;

                VariableReferenceList
                        [ V_GPb      :.:V_GPb        1 ]
                        [ V_GPb_a    :.:V_GPb_a      0 ]
                        [ V_GPb_b    :.:V_GPb_b      0 ]
                        [ Vmaxf_GPb  :.:Vmaxf_GPb    0 ]
                        [ Vmaxr_GPb  :.:Vmaxr_GPb    0 ]
                        [ GLY        :.:GLY          0 ]
                        [ Pi         :.:Pi           0 ]
                        [ G1P        :.:G1P          0 ]
                        [ AMP        :.:AMP          0 ]
                        [ KiGLYf_GPb :.:KiGLYf_GPb   0 ]
                        [ KiGLYb_GPb :.:KiGLYb_GPb   0 ]
                        [ KPi_GPb    :.:KPi_GPb      0 ]
                        [ KiPi_GPb   :.:KiPi_GPb     0 ]
                        [ KG1P_GPb   :.:KG1P_GPb     0 ]
                        [ KiG1P_GPb  :.:KiG1P_GPb    0 ]
                        [ K_AMP      :.:K_AMP        0 ]
			[ nH         :.:nH           0 ];


                Expression " V_GPb_a.Value / V_GPb_b.Value ";
        }

#Aoki_120313

       Variable Variable( frac_a )
       {	
		Value 0.4;
        }

        Variable Variable( frac_b )
	{
                Value 0.6;
        }

        Variable Variable( flux_GP )
	{
                Value 0.0;
        }

#        Process ExpressionAssignmentProcess ( flux_GP )
#        {
#                StepperID DT;
#                Priority  1;
#
#                VariableReferenceList
#                        [ flux_GP    :.:flux_GP      1 ]
#                        [ V_GPa      :.:V_GPa        0 ]
#                        [ V_GPb      :.:V_GPb        0 ]
#                        [ frac_a     :.:frac_a       0 ]
#                        [ frac_b     :.:frac_b       0 ];

#                Expression "frac_a.Value * V_GPa.Value + frac_b.Value * V_GPb.Value";
#        }

	Process ExpressionFluxProcess ( V_GP )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
                        [ V_GPa      :.:V_GPa        0 ]
			[ V_GPb      :.:V_GPb        0 ]
                        [ V_GPb_a    :.:V_GPb_a      0 ]
                        [ V_GPb_b    :.:V_GPb_b      0 ]
                        [ frac_a     :.:frac_a       0 ]
                        [ frac_b     :.:frac_b       0 ]
			[ Vmaxf_GPb  :.:Vmaxf_GPb    0 ]
			[ Vmaxr_GPb  :.:Vmaxr_GPb    0 ]
#			[ GLY        :.:GLY         -1 ]
			[ GLY        :.:GLY          0 ]
#			[ Pi         :.:Pi          -1 ]
			[ Pi         :.:Pi           0 ]
			[ G1P        :.:G1P          1 ]
			[ AMP        :.:AMP          0 ]
			[ KiGLYf_GPb :.:KiGLYf_GPb   0 ]
			[ KiGLYb_GPb :.:KiGLYb_GPb   0 ]
			[ KPi_GPb    :.:KPi_GPb      0 ]
			[ KiPi_GPb   :.:KiPi_GPb     0 ]
			[ KG1P_GPb   :.:KG1P_GPb     0 ]
			[ KiG1P_GPb  :.:KiG1P_GPb    0 ]
			[ K_AMP      :.:K_AMP        0 ]
			[ nH         :.:nH           0 ];

                Expression "frac_a.Value * V_GPa.Value + frac_b.Value * V_GPb.Value";
#		Expression"V_GPb.Value";
	}

#Aoki_120313
	Variable Variable( G6P )
	{
		Value 0.75;
	}

	Variable Variable( KG6P_PGLM )
	{
		Value 0.03;
	}

	Variable Variable( KG1P_PGLM )
	{
		Value 0.063;
	}

	Variable Variable( KeqPGLM )
	{
		Value 16.62;
	}

	Variable Variable( Vmaxf_PGLM )
	{
		Value 480.0;
	}

	Variable Variable( Vmaxr_PGLM )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_PGLM )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_PGLM    :.:Vmaxr_PGLM    1 ]			
			[ Vmaxf_PGLM    :.:Vmaxf_PGLM    0 ]
			[ KG6P_PGLM     :.:KG6P_PGLM     0 ]
			[ KG1P_PGLM     :.:KG1P_PGLM     0 ]
			[ KeqPGLM       :.:KeqPGLM       0 ];
	
		Expression "( Vmaxf_PGLM.Value * KG6P_PGLM.Value ) / ( KG1P_PGLM.Value * KeqPGLM.Value )";		
#		Expression "( Vmaxf_PGLM.Value * KG6P_PGLM.Value ) / ( KG1P_PGLM.Value / KeqPGLM.Value )";		

	}

	Variable Variable( V_PGLM )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_PGLM_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_PGLM       :.:V_PGLM         1 ]
			[ G1P          :.:G1P            0 ]
			[ G6P          :.:G6P            0 ]			
			[ Vmaxf_PGLM   :.:Vmaxf_PGLM     0 ]
			[ Vmaxr_PGLM   :.:Vmaxr_PGLM     0 ]
			[ KG1P_PGLM    :.:KG1P_PGLM      0 ]
			[ KG6P_PGLM    :.:KG6P_PGLM      0 ];
	
		Expression "( Vmaxf_PGLM.Value * ( G1P.Value / KG1P_PGLM.Value ) - Vmaxr_PGLM.Value * ( G6P.Value / KG6P_PGLM.Value)) / ( 1.0 +  G1P.Value / KG1P_PGLM.Value + G6P.Value / KG6P_PGLM.Value )";		
	}

	Process ExpressionFluxProcess ( V_PGLM )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_PGLM       :.:V_PGLM         0 ]
			[ G1P          :.:G1P           -1 ]
			[ G6P          :.:G6P            1 ]			
			[ Vmaxf_PGLM   :.:Vmaxf_PGLM     0 ]
			[ Vmaxr_PGLM   :.:Vmaxr_PGLM     0 ]
			[ KG1P_PGLM    :.:KG1P_PGLM      0 ]
			[ KG6P_PGLM    :.:KG6P_PGLM      0 ];
	
		Expression "V_PGLM.Value";
	}

	Variable Variable( F6P )
	{
		Value 0.228;
	}

	Variable Variable( KF6P_PGI )
	{
		Value 0.119;
	}

	Variable Variable( KG6P_PGI )
	{
		Value 0.48;
	}

	Variable Variable( KeqPGI )
	{
		Value 0.45;
	}

	Variable Variable( Vmaxr_PGI )
	{
#		Value 0.88;
		Value 880.0;
#duck		Value 880.0;
	}

	Variable Variable( Vmaxf_PGI )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxf_PGI )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxf_PGI    :.:Vmaxf_PGI    1 ]			
			[ Vmaxr_PGI    :.:Vmaxr_PGI    0 ]
			[ KG6P_PGI     :.:KG6P_PGI     0 ]
			[ KF6P_PGI     :.:KF6P_PGI     0 ]
			[ KeqPGI       :.:KeqPGI       0 ];
	
		Expression "( Vmaxr_PGI.Value * KG6P_PGI.Value  * KeqPGI.Value) / KF6P_PGI.Value";		
	}

	Variable Variable( V_PGI )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_PGI_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_PGI        :.:V_PGI        1 ]
			[ G6P          :.:G6P          0 ]
			[ F6P          :.:F6P          0 ]			
			[ Vmaxf_PGI    :.:Vmaxf_PGI    0 ]
			[ Vmaxr_PGI    :.:Vmaxr_PGI    0 ]
			[ KG6P_PGI     :.:KG6P_PGI     0 ]
			[ KF6P_PGI     :.:KF6P_PGI     0 ];
	
		Expression "( Vmaxf_PGI.Value * ( G6P.Value / KG6P_PGI.Value ) - Vmaxr_PGI.Value * ( F6P.Value / KF6P_PGI.Value)) / ( 1.0 +  G6P.Value / KG6P_PGI.Value + F6P.Value / KF6P_PGI.Value )";		
	}
	Process ExpressionFluxProcess ( V_PGI )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_PGI        :.:V_PGI        0 ]
			[ G6P          :.:G6P         -1 ]
			[ F6P          :.:F6P          1 ]			
			[ Vmaxf_PGI    :.:Vmaxf_PGI    0 ]
			[ Vmaxr_PGI    :.:Vmaxr_PGI    0 ]
			[ KG6P_PGI     :.:KG6P_PGI     0 ]
			[ KF6P_PGI     :.:KF6P_PGI     0 ];
	
		Expression "V_PGI.Value";
	}
#Aoki_120313
	Variable Variable( FBP )
	{
		Value 0.0723;
	}

	Variable Variable( ATP )
	{
		Value 8.2;
	}

	Variable Variable( ADP )
	{
		Value 0.013;
	}

	Variable Variable( KATP_PFK )
	{
		Value 0.08;
	}

	Variable Variable( KADP_PFK )
	{
		Value 2.7;
	}

	Variable Variable( KF6P_PFK )
	{
		Value 0.18;
	}

	Variable Variable( KFBP_PFK )
	{
		Value 4.02;
	}

	Variable Variable( delta )
	{
		Value 1.0;
	}

	Process ExpressionAssignmentProcess ( delta )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ delta       :.:delta         1 ]			
			[ F6P         :.:F6P           0 ]
			[ ATP         :.:ATP           0 ]
			[ ADP         :.:ADP           0 ]
			[ FBP         :.:FBP           0 ]
			[ KF6P_PFK    :.:KF6P_PFK      0 ]
			[ KATP_PFK    :.:KATP_PFK      0 ]
			[ KADP_PFK    :.:KADP_PFK      0 ]
			[ KFBP_PFK    :.:KFBP_PFK      0 ];
	
		Expression "( 1.0 + F6P.Value / KF6P_PFK.Value ) * ( 1.0 + ATP.Value / KATP_PFK.Value ) + ADP.Value / KADP_PFK.Value + FBP.Value / KFBP_PFK.Value * ( 1.0 + ADP.Value / KADP_PFK.Value )";		
	}

	Variable Variable( K_FBP )
	{
		Value 4.02;
	}

	Variable Variable( K_ATP )
	{
		Value 0.25;
	}

	Variable Variable( K_ADP )
	{
		Value 2.7;
	}

	Variable Variable( K_F6P )
	{
		Value 20.0;
	}

	Variable Variable( delta_ )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( delta_ )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ delta_   :.:delta_     1 ]			
			[ F6P      :.:F6P        0 ]
			[ ATP      :.:ATP        0 ]
			[ ADP      :.:ADP        0 ]
			[ FBP      :.:FBP        0 ]
			[ K_F6P    :.:K_F6P      0 ]
			[ K_ATP    :.:K_ATP      0 ]
			[ K_ADP    :.:K_ADP      0 ]
			[ K_FBP    :.:K_FBP      0 ];
	
		Expression "( 1.0 + F6P.Value / K_F6P.Value ) * ( 1.0 + ATP.Value / K_ATP.Value ) + ADP.Value / K_ADP.Value + FBP.Value / K_FBP.Value * ( 1.0 + ADP.Value / K_ADP.Value )";		
	}

	Variable Variable( alpha )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( alpha )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ alpha       :.:alpha         1 ]			
			[ K_F6P       :.:K_F6P         0 ]
			[ K_ATP       :.:K_ATP         0 ]
			[ KF6P_PFK    :.:KF6P_PFK      0 ]
			[ KATP_PFK    :.:KATP_PFK      0 ];

		Expression "KF6P_PFK.Value * KATP_PFK.Value / ( K_F6P.Value * K_ATP.Value )";
#	     Expression "KF6P_PFK.Value * KATP_PFK.Value / ( K_F6P.Value / K_ATP.Value )";
	}

	Variable Variable( KiATP_PFK )
	{
		Value 0.87;
	}

	Variable Variable( KaAMP )
	{
		Value 0.06;
	}

	Variable Variable( L0 )
	{
		Value 13.0;
	}

	Variable Variable( d )
	{
		Value 0.01;
	}

	Variable Variable( e )
	{
		Value 0.01;
	}

	Variable Variable( L )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( L )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ L          :.:L          1 ]
			[ L0         :.:L0         0 ]
			[ d          :.:d          0 ]			
			[ e          :.:e          0 ]			
			[ ATP        :.:ATP        0 ]
			[ AMP        :.:AMP        0 ]
			[ KiATP_PFK  :.:KiATP_PFK  0 ]
			[ KaAMP      :.:KaAMP      0 ];
	
		Expression "L0.Value * pow(( 1.0 + ATP.Value / KiATP_PFK.Value ) / ( 1.0 + d.Value * ATP.Value / KiATP_PFK.Value ) * ( 1.0 + e.Value * AMP.Value / KaAMP.Value ) / ( 1.0 + AMP.Value / KaAMP.Value ), 4.0 ) ";		
	}

	Variable Variable( Vmaxf_PFK )
	{
#		Value 0.056;
		Value 56.0;
#duck		Value 56.0;
	}

        Variable Variable( Keq_PFK ) #Aoki_add120313
        {
                Value 242.0;
        }

        Variable Variable( Vmaxr_PFK )
        {
                Value 0.0;
        }

	Process ExpressionAssignmentProcess ( Vmaxr_PFK )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_PFK    :.:Vmaxr_PFK    1 ]			
			[ Vmaxf_PFK    :.:Vmaxf_PFK    0 ]
			[ KADP_PFK    :.:KADP_PFK      0 ]
			[ KF6P_PFK    :.:KF6P_PFK      0 ]
			[ KATP_PFK    :.:KATP_PFK      0 ]
			[ KFBP_PFK    :.:KFBP_PFK      0 ]
                        [ Keq_PFK     :.:Keq_PFK       0 ];
	
#		Expression "Vmaxf_PFK.Value * KADP_PFK.Value * KFBP_PFK.Value / ( KATP_PFK.Value * KF6P_PFK.Value)";		
		Expression "Vmaxf_PFK.Value * KADP_PFK.Value * KFBP_PFK.Value / KATP_PFK.Value / KF6P_PFK.Value / Keq_PFK.Value ";		
	}

	Variable Variable( V_PFK )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_PFK_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_PFK         :.:V_PFK       1 ]
			[ Vmaxf_PFK     :.:Vmaxf_PFK   0 ]
			[ Vmaxr_PFK     :.:Vmaxr_PFK   0 ]
			[ F6P           :.:F6P         0 ]			
			[ ATP           :.:ATP         0 ]
			[ ADP           :.:ADP         0 ]			
			[ FBP           :.:FBP         0 ]
        						
			[ KF6P_PFK      :.:KF6P_PFK    0 ]
			[ KATP_PFK      :.:KATP_PFK    0 ]
			[ KADP_PFK      :.:KADP_PFK    0 ]
			[ KFBP_PFK      :.:KFBP_PFK    0 ]
			[ alpha         :.:alpha       0 ]
			[ delta         :.:delta       0 ]
			[ delta_        :.:delta_      0 ]
			[ L             :.:L           0 ];
	
#		Expression "( Vmaxf_PFK.Value * ATP.Value * F6P.Value / ( KATP_PFK.Value * KF6P_PFK.Value ) -  Vmaxr_PFK.Value *  ADP.Value * FBP.Value / ( KADP_PFK.Value * KFBP_PFK.Value )) / delta.Value * ( 1.0 + alpha.Value * L.Value * pow( delta_.Value / delta.Value, 3 )) / ( 1.0 + L.Value * pow (( delta_.Value / delta.Value ), 4))";		
		Expression "( 1.0 + alpha.Value * L.Value * pow(delta_.Value / delta.Value, 3 )) * (Vmaxf_PFK.Value * ATP.Value * F6P.Value / ( KATP_PFK.Value * KF6P_PFK.Value ) -  Vmaxr_PFK.Value *  ADP.Value * FBP.Value / ( KADP_PFK.Value * KFBP_PFK.Value )) / (delta.Value * ( 1.0 + L.Value * pow( delta_.Value / delta.Value, 4 )))";		
	}

	Process ExpressionFluxProcess ( V_PFK )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_PFK         :.:V_PFK       0 ]
			[ Vmaxf_PFK     :.:Vmaxf_PFK   0 ]
			[ Vmaxr_PFK     :.:Vmaxr_PFK   0 ]
			[ F6P           :.:F6P        -1 ]
			[ ATP           :.:ATP         0 ]
			[ ADP           :.:ADP         0 ]						
#			[ ATP           :.:ATP        -1 ]
#			[ ADP           :.:ADP         1 ]			
			[ FBP           :.:FBP         1 ]						
			[ KF6P_PFK      :.:KF6P_PFK    0 ]
			[ KATP_PFK      :.:KATP_PFK    0 ]
			[ KADP_PFK      :.:KADP_PFK    0 ]
			[ KFBP_PFK      :.:KFBP_PFK    0 ]
			[ alpha         :.:alpha       0 ]
			[ delta         :.:delta       0 ]
			[ delta_        :.:delta_      0 ]
			[ L             :.:L           0 ];
	
		Expression "V_PFK.Value";
	}
#Aoki_120313
	Variable Variable( DHAP )
	{
		Value 0.0764;
	}

	Variable Variable( GAP )
	{
		Value 0.0355;
	}

	Variable Variable( KDHAP_ALD )
	{
		Value 2.0;
	}

	Variable Variable( KGAP_ALD )
	{
		Value 1.0;
	}

	Variable Variable( KFBP_ALD )
	{
#		Value 0.05;
		Value 0.5;
	}

	Variable Variable( KeqALD )
	{
#		Value @(9.5 * pow( 10.0, -2 ));
		Value @(1.0 / ( 9.5 * pow( 10.0, -8 )));
#		Value 0.095;
	}

	Variable Variable( Vmaxf_ALD )
	{
		Value 104.0;
	}

	Variable Variable( Vmaxr_ALD )
	{
		Value 0.0;
	}

	Variable Variable( V_ALD )
	{
		Value 0.0;
#		Value @( 1.45229 * pow( 10.0, -18.0));
	}

	Process ExpressionAssignmentProcess ( Vmaxr_ALD )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_ALD    :.:Vmaxr_ALD    1 ]			
			[ Vmaxf_ALD    :.:Vmaxf_ALD    0 ]
			[ KDHAP_ALD    :.:KDHAP_ALD    0 ]
			[ KGAP_ALD    :.:KGAP_ALD      0 ]
			[ KFBP_ALD    :.:KFBP_ALD      0 ]
			[ KeqALD    :.:KeqALD          0 ];
	
		Expression "Vmaxf_ALD.Value * KDHAP_ALD.Value * KGAP_ALD.Value / ( KFBP_ALD.Value * KeqALD.Value)";		
#		Expression "Vmaxf_ALD.Value * KDHAP_ALD.Value * KGAP_ALD.Value / ( KFBP_ALD.Value / KeqALD.Value)";		
	}

	Process ExpressionAssignmentProcess ( V_ALD_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_ALD        :.:V_ALD         1 ]
			[ Vmaxf_ALD    :.:Vmaxf_ALD     0 ]
			[ Vmaxr_ALD    :.:Vmaxr_ALD     0 ]
			[ DHAP         :.:DHAP          0 ]
			[ GAP          :.:GAP           0 ]			
			[ FBP          :.:FBP           0 ]						
			[ KDHAP_ALD    :.:KDHAP_ALD     0 ]
			[ KGAP_ALD     :.:KGAP_ALD      0 ]
			[ KFBP_ALD     :.:KFBP_ALD      0 ];
	
#		Expression "(( Vmaxf_ALD.Value * FBP.Value / KFBP_ALD.Value ) - ( Vmaxr_ALD.Value * DHAP.Value * GAP.Value / ( KDHAP_ALD.Value * KGAP_ALD.Value ))) / ( 1.0 + FBP.Value / KFBP_ALD.Value + DHAP.Value / KDHAP_ALD.Value + GAP.Value / KGAP_ALD.Value )";
		Expression "( Vmaxf_ALD.Value * FBP.Value / KFBP_ALD.Value - Vmaxr_ALD.Value * DHAP.Value * GAP.Value / ( KDHAP_ALD.Value * KGAP_ALD.Value )) / ( 1.0 + FBP.Value / KFBP_ALD.Value + DHAP.Value / KDHAP_ALD.Value + GAP.Value / KGAP_ALD.Value )";
	}

	Process ExpressionFluxProcess ( V_ALD )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_ALD        :.:V_ALD         0 ]
			[ Vmaxf_ALD    :.:Vmaxf_ALD     0 ]
			[ Vmaxr_ALD    :.:Vmaxr_ALD     0 ]
			[ FBP          :.:FBP          -1 ]
			[ DHAP         :.:DHAP          1 ]
			[ GAP          :.:GAP           1 ]
			[ KDHAP_ALD    :.:KDHAP_ALD     0 ]
			[ KGAP_ALD     :.:KGAP_ALD      0 ]
			[ KFBP_ALD     :.:KFBP_ALD      0 ];

		Expression "V_ALD.Value";
	}

#Aoki120313
	Variable Variable( KGAP_TPI )
	{
		Value 0.32;
	}

	Variable Variable( KDHAP_TPI )
	{
		Value 0.61;
	}

	Variable Variable( KeqTPI )
	{
		Value 0.052;
	}

	Variable Variable( Vmaxf_TPI )
	{
		Value 12000.0;
	}

	Variable Variable( Vmaxr_TPI )
	{
		Value 0.0;
	}
	Process ExpressionAssignmentProcess ( Vmaxr_TPI )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_TPI    :.:Vmaxr_TPI    1 ]			
			[ Vmaxf_TPI    :.:Vmaxf_TPI    0 ]
			[ KDHAP_TPI    :.:KDHAP_TPI    0 ]
			[ KGAP_TPI     :.:KGAP_TPI     0 ]
			[ KeqTPI       :.:KeqTPI       0 ];
	
#		Expression "Vmaxf_TPI.Value * KDHAP_TPI.Value / ( KGAP_TPI.Value * KeqTPI.Value)";		
		Expression "Vmaxf_TPI.Value * KDHAP_TPI.Value / KGAP_TPI.Value / KeqTPI.Value ";		
	}

	Variable Variable( V_TPI )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_TPI_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_TPI       :.:V_TPI         1 ]
			[ Vmaxf_TPI   :.:Vmaxf_TPI     0 ]
			[ Vmaxr_TPI   :.:Vmaxr_TPI     0 ]
			[ DHAP        :.:DHAP          0 ]
			[ GAP         :.:GAP           0 ]			
			[ KDHAP_TPI   :.:KDHAP_TPI     0 ]
			[ KGAP_TPI    :.:KGAP_TPI      0 ];
	
		Expression "(( Vmaxf_TPI.Value * GAP.Value / KGAP_TPI.Value ) - ( Vmaxr_TPI.Value * DHAP.Value / KDHAP_TPI.Value )) / ( 1.0 + GAP.Value / KGAP_TPI.Value + DHAP.Value / KDHAP_TPI.Value )";		
	}

	Process ExpressionFluxProcess ( V_TPI )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_TPI       :.:V_TPI         0 ]
			[ Vmaxf_TPI   :.:Vmaxf_TPI     0 ]
			[ Vmaxr_TPI   :.:Vmaxr_TPI     0 ]
			[ DHAP        :.:DHAP          1 ]
			[ GAP         :.:GAP          -1 ]
			[ KDHAP_TPI   :.:KDHAP_TPI     0 ]
			[ KGAP_TPI    :.:KGAP_TPI      0 ];
	
		Expression "V_TPI.Value";
	}

#Aoki120313
	Variable Variable( _13BPG )
	{
		Value 0.065;
	}

	Variable Variable( KGAP_GAPDH )
	{
		Value 0.0025;
	}

	Variable Variable( KNAD_GAPDH )
	{
		Value 0.09;
	}

	Variable Variable( KPi_GAPDH )
	{
		Value 0.29;
	}

	Variable Variable( K13BPG_GAPDH )
	{
		Value 0.0008;
	}

	Variable Variable( KNADH_GAPDH )
	{
		Value 0.0033;
	}

	Variable Variable( KeqGAPDH )
	{
		Value 0.089;
	}

	Variable Variable( NAD )
	{
		Value 0.5;
	}

	Variable Variable( NADH )
	{
#		Value 0.001;
		Value 0.0005;
	}

	Variable Variable( D_GAPDH )
	{
		Value 1.0;
	}

	Process ExpressionAssignmentProcess ( D_GAPDH )
	{
		StepperID  DT;
		Priority   5;
		VariableReferenceList
			[ D_GAPDH       :.:D_GAPDH        1 ]			
			[ GAP           :.:GAP            0 ]		
			[ NAD           :.:NAD            0 ]
			[ Pi            :.:Pi             0 ]
			[ x13BPG        :.:_13BPG         0 ]
			[ NADH          :.:NADH           0 ]
			[ KGAP_GAPDH    :.:KGAP_GAPDH     0 ]
			[ KNAD_GAPDH    :.:KNAD_GAPDH     0 ]
			[ KPi_GAPDH     :.:KPi_GAPDH      0 ]
			[ K13BPG_GAPDH  :.:K13BPG_GAPDH   0 ]
			[ KNADH_GAPDH   :.:KNADH_GAPDH    0 ];
	
		Expression "1.0 + GAP.Value / KGAP_GAPDH.Value + NAD.Value / KNAD_GAPDH.Value + Pi.Value / KPi_GAPDH.Value + GAP.Value * NAD.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value ) + GAP.Value * NAD.Value * Pi.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value * KPi_GAPDH.Value ) + x13BPG.Value / K13BPG_GAPDH.Value + NADH.Value / KNADH_GAPDH.Value + x13BPG.Value * NADH.Value / ( K13BPG_GAPDH.Value * KNADH_GAPDH.Value )";		
	}

	Variable Variable( Vmaxf_GAPDH )
	{
		Value 1265.0;
	}

	Variable Variable( Vmaxr_GAPDH )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_GAPDH )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_GAPDH    :.:Vmaxr_GAPDH      1 ]			
			[ Vmaxf_GAPDH    :.:Vmaxf_GAPDH      0 ]
			[ K13BPG_GAPDH    :.:K13BPG_GAPDH    0 ]
			[ KNAD_GAPDH    :.:KNAD_GAPDH        0 ]
			[ KNADH_GAPDH    :.:KNADH_GAPDH      0 ]
			[ KGAP_GAPDH    :.:KGAP_GAPDH        0 ]
			[ KPi_GAPDH    :.:KPi_GAPDH          0 ]
			[ KeqGAPDH    :.:KeqGAPDH            0 ];
	
#		Expression "Vmaxf_GAPDH.Value * K13BPG_GAPDH.Value * KNADH_GAPDH.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value * KPi_GAPDH.Value * KeqGAPDH.Value )";		
		Expression "Vmaxf_GAPDH.Value * K13BPG_GAPDH.Value * KNADH_GAPDH.Value / KGAP_GAPDH.Value / KNAD_GAPDH.Value / KPi_GAPDH.Value / KeqGAPDH.Value";		
	}

	Variable Variable( V_GAPDH )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_GAPDH_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_GAPDH        :.:V_GAPDH         1 ]
			[ Vmaxf_GAPDH    :.:Vmaxf_GAPDH     0 ]
			[ Vmaxr_GAPDH    :.:Vmaxr_GAPDH     0 ]
			[ GAP            :.:GAP             0 ]			
			[ NAD            :.:NAD             0 ]
			[ Pi             :.:Pi              0 ]
			[ x13BPG         :.:_13BPG          0 ]
			[ NADH           :.:NADH            0 ]
			[ KGAP_GAPDH     :.:KGAP_GAPDH      0 ]
			[ KNAD_GAPDH     :.:KNAD_GAPDH      0 ]
			[ K13BPG_GAPDH   :.:K13BPG_GAPDH    0 ]
			[ KPi_GAPDH      :.:KPi_GAPDH       0 ]
			[ KNADH_GAPDH    :.:KNADH_GAPDH     0 ]
			[ D_GAPDH        :.:D_GAPDH         0 ];
	
		Expression "( Vmaxf_GAPDH.Value * GAP.Value * NAD.Value * Pi.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value * KPi_GAPDH.Value ) -  Vmaxr_GAPDH.Value * x13BPG.Value * NADH.Value / ( K13BPG_GAPDH.Value * KNADH_GAPDH.Value )) / D_GAPDH.Value";		
	}

	Process ExpressionFluxProcess ( V_GAPDH )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_GAPDH        :.:V_GAPDH         0 ]
			[ Vmaxf_GAPDH    :.:Vmaxf_GAPDH     0 ]
			[ Vmaxr_GAPDH    :.:Vmaxr_GAPDH     0 ]
			[ GAP            :.:GAP            -1 ]			
#duck			[ NAD            :.:NAD            -1 ]
#			[ NAD            :.:NAD            -1 ]
#duck			[ Pi             :.:Pi             -1 ]
#			[ Pi             :.:Pi             -1 ]
			[ x13BPG         :.:_13BPG          1 ]
			[ NADH           :.:NADH            1 ]
			[ KGAP_GAPDH     :.:KGAP_GAPDH      0 ]
			[ KNAD_GAPDH     :.:KNAD_GAPDH      0 ]
			[ K13BPG_GAPDH   :.:K13BPG_GAPDH    0 ]
			[ KPi_GAPDH      :.:KPi_GAPDH       0 ]
			[ KNADH_GAPDH    :.:KNADH_GAPDH     0 ]
			[ D_GAPDH        :.:D_GAPDH         0 ];

		Expression "V_GAPDH.Value";
	}

#Aoki120313
	Variable Variable( _3PG )
	{
		Value 0.052;
	}

	Variable Variable( K13BPG_PGK )
	{
		Value 0.002;
	}

	Variable Variable( KADP_PGK )
	{
		Value 0.008;
	}

	Variable Variable( K3PG_PGK )
	{
		Value 1.2;
	}

	Variable Variable( KATP_PGK )
	{
		Value 0.35;
	}

	Variable Variable( KeqPGK )
	{
		Value 57109.0;
	}

	Variable Variable( Vmaxr_PGK )
	{
#		Value 112.0;
		Value 1120.0;
	}

	Variable Variable( Vmaxf_PGK )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxf_PGK )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxf_PGK     :.:Vmaxf_PGK     1 ]			
			[ Vmaxr_PGK     :.:Vmaxr_PGK     0 ]
			[ K13BPG_PGK    :.:K13BPG_PGK    0 ]
			[ KADP_PGK      :.:KADP_PGK      0 ]
			[ K3PG_PGK      :.:K3PG_PGK      0 ]
			[ KATP_PGK      :.:KATP_PGK      0 ]
			[ KeqPGK        :.:KeqPGK        0 ];
	
#		Expression "Vmaxr_PGK.Value * K13BPG_PGK.Value * KADP_PGK.Value * KeqPGK.Value / ( K3PG_PGK.Value * KATP_PGK.Value)";		
		Expression "Vmaxr_PGK.Value * K13BPG_PGK.Value * KADP_PGK.Value * KeqPGK.Value / K3PG_PGK.Value / KATP_PGK.Value ";		
	}

	Variable Variable( V_PGK )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_PGK_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_PGK        :.:V_PGK        1 ]
			[ Vmaxf_PGK    :.:Vmaxf_PGK    0 ]
			[ Vmaxr_PGK    :.:Vmaxr_PGK    0 ]
			[ x13BPG       :.:_13BPG       0 ]
			[ ADP          :.:ADP          0 ]
			[ x3PG         :.:_3PG         0 ]
			[ ATP          :.:ATP          0 ]
			[ K13BPG_PGK   :.:K13BPG_PGK   0 ]
			[ KADP_PGK     :.:KADP_PGK     0 ]
			[ K3PG_PGK     :.:K3PG_PGK     0 ]
			[ KATP_PGK     :.:KATP_PGK     0 ];
	
		Expression "( Vmaxf_PGK.Value * x13BPG.Value * ADP.Value / ( K13BPG_PGK.Value * KADP_PGK.Value ) -  Vmaxr_PGK.Value * x3PG.Value * ATP.Value / ( K3PG_PGK.Value * KATP_PGK.Value )) / ( 1.0 + x13BPG.Value / K13BPG_PGK.Value + ADP.Value / KADP_PGK.Value + x13BPG.Value * ADP.Value / ( K13BPG_PGK.Value * KADP_PGK.Value ) + x3PG.Value / K3PG_PGK.Value + ATP.Value / KATP_PGK.Value + x3PG.Value * ATP.Value / ( K3PG_PGK.Value * KATP_PGK.Value ))";		
	}

	Process ExpressionFluxProcess ( V_PGK )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_PGK        :.:V_PGK        0 ]
			[ Vmaxf_PGK    :.:Vmaxf_PGK    0 ]
			[ Vmaxr_PGK    :.:Vmaxr_PGK    0 ]
			[ x13BPG       :.:_13BPG      -1 ]
			[ x3PG         :.:_3PG         1 ]
			[ ADP          :.:ADP          0 ]
			[ ATP          :.:ATP          0 ]
#			[ ADP          :.:ADP         -1 ]
#			[ ATP          :.:ATP          1 ]
			[ K13BPG_PGK   :.:K13BPG_PGK   0 ]
			[ KADP_PGK     :.:KADP_PGK     0 ]
			[ K3PG_PGK     :.:K3PG_PGK     0 ]
			[ KATP_PGK     :.:KATP_PGK     0 ];
	
		Expression "V_PGK.Value";
	}

#Toki_120313
	Variable Variable( _2PG )
	{
		Value 0.005;
	}

	Variable Variable( PEP )
	{
		Value 0.0194;
	}

	Variable Variable( K3PG_PGM )
	{
		Value 0.2;
	}

	Variable Variable( K2PG_PGM )
	{
		Value 0.014;
	}

	Variable Variable( Vmaxf_PGM )
	{
		Value 1120.0;
	}

	Variable Variable( KeqPGM )
	{
		Value 0.18;
	}

	Variable Variable( Vmaxr_PGM )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_PGM )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_PGM    :.:Vmaxr_PGM    1 ]			
			[ Vmaxf_PGM    :.:Vmaxf_PGM    0 ]
			[ K3PG_PGM     :.:K3PG_PGM     0 ]
			[ K2PG_PGM     :.:K2PG_PGM     0 ]
			[ KeqPGM       :.:KeqPGM       0 ];
	
		Expression "Vmaxf_PGM.Value * K2PG_PGM.Value / ( K3PG_PGM.Value * KeqPGM.Value)";		
	}

	Variable Variable( V_PGM )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_PGM_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_PGM        :.:V_PGM         1 ]
			[ Vmaxr_PGM    :.:Vmaxr_PGM     0 ]
			[ Vmaxf_PGM    :.:Vmaxf_PGM     0 ]
			[ x3PG         :.:_3PG          0 ]
			[ x2PG         :.:_2PG          0 ]
			[ K3PG_PGM     :.:K3PG_PGM      0 ]
			[ K2PG_PGM     :.:K2PG_PGM      0 ];
	
		Expression "( Vmaxf_PGM.Value * x3PG.Value / K3PG_PGM.Value -  Vmaxr_PGM.Value * x2PG.Value / K2PG_PGM.Value ) / ( 1.0 + x3PG.Value / K3PG_PGM.Value + x2PG.Value / K2PG_PGM.Value )";		
	}

	Process ExpressionFluxProcess ( V_PGM )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_PGM        :.:V_PGM         0 ]
			[ Vmaxr_PGM    :.:Vmaxr_PGM     0 ]
			[ Vmaxf_PGM    :.:Vmaxf_PGM     0 ]
			[ x3PG         :.:_3PG         -1 ]
			[ x2PG         :.:_2PG          1 ]
			[ K3PG_PGM     :.:K3PG_PGM      0 ]
			[ K2PG_PGM     :.:K2PG_PGM      0 ];
	
		Expression "V_PGM.Value";
	}

#Toki_120313
	Variable Variable( K2PG_EN )
	{
		Value 0.1;
	}

	Variable Variable( KPEP_EN )
	{
		Value 0.37;
	}

	Variable Variable( KeqEN )
	{
		Value 0.49;
	}

	Variable Variable( Vmaxf_EN )
	{
		Value 192.0;
	}

	Variable Variable( Vmaxr_EN )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_EN )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_EN    :.:Vmaxr_EN    1 ]			
			[ Vmaxf_EN    :.:Vmaxf_EN    0 ]
			[ KPEP_EN    :.:KPEP_EN    0 ]
			[ K2PG_EN    :.:K2PG_EN    0 ]
			[ KeqEN    :.:KeqEN    0 ];
	
		Expression "Vmaxf_EN.Value * KPEP_EN.Value / ( K2PG_EN.Value * KeqEN.Value)";		
	}

	Variable Variable( V_EN )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_EN_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_EN       :.:V_EN         1 ]
			[ Vmaxf_EN   :.:Vmaxf_EN     0 ]
			[ Vmaxr_EN   :.:Vmaxr_EN     0 ]
			[ x2PG       :.:_2PG         0 ]
			[ PEP        :.:PEP          0 ]
			[ K2PG_EN    :.:K2PG_EN      0 ]
			[ KPEP_EN    :.:KPEP_EN      0 ];
	
		Expression "( Vmaxf_EN.Value * x2PG.Value / K2PG_EN.Value - Vmaxr_EN.Value * PEP.Value / KPEP_EN.Value ) / ( 1.0 + x2PG.Value / K2PG_EN.Value + PEP.Value / KPEP_EN.Value )";		
	}

	Process ExpressionFluxProcess ( V_EN )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_EN       :.:V_EN         0 ]
			[ Vmaxf_EN   :.:Vmaxf_EN     0 ]
			[ Vmaxr_EN   :.:Vmaxr_EN     0 ]
			[ x2PG       :.:_2PG        -1 ]
			[ PEP        :.:PEP          1 ]
			[ K2PG_EN    :.:K2PG_EN      0 ]
			[ KPEP_EN    :.:KPEP_EN      0 ];
	
		Expression "V_EN.Value";
	}

	Variable Variable( PYR )
	{
		Value 0.0994;
	}

	Variable Variable( KPEP_PK )
	{
		Value 0.08;
	}

	Variable Variable( KADP_PK )
	{
		Value 0.3;
	}

	Variable Variable( KPYR_PK )
	{
		Value 7.05;
	}

	Variable Variable( KATP_PK )
	{
		Value 1.13;
	}

	Variable Variable( KeqPK )
	{
		Value 10304.0;
	}

	Variable Variable( Vmaxf_PK )
	{
		Value 1440.0;
	}

	Variable Variable( Vmaxr_PK )
	{
		Value 0.0;
	}

        Process ExpressionAssignmentProcess ( Vmaxr_PK )
        {
               StepperID  DT;
	       Priority   5;

               VariableReferenceList
                      [ Vmaxr_PK    :.:Vmaxr_PK   1 ]
                      [ Vmaxf_PK    :.:Vmaxf_PK   0 ]
	              [ KPEP_PK     :.:KPEP_PK    0 ]
		      [ KADP_PK     :.:KADP_PK    0 ]
                      [ KPYR_PK     :.:KPYR_PK    0 ]
                      [ KATP_PK     :.:KATP_PK    0 ]
         	      [ KeqPK       :.:KeqPK      0 ];

                Expression "( Vmaxf_PK.Value * KATP_PK.Value * KPYR_PK.Value ) / ( KPEP_PK.Value * KADP_PK.Value * KeqPK.Value )";
        }

        Variable Variable( V_PK )
        {
               Value 0.0;
        }

        Process ExpressionAssignmentProcess ( V_PK_assign )
        {
               StepperID  DT;
               Priority   1;

	       VariableReferenceList
                      [ V_PK        :.:V_PK         1 ]
                      [ Vmaxf_PK    :.:Vmaxf_PK     0 ]
                      [ Vmaxr_PK    :.:Vmaxr_PK     0 ]
                      [ PEP         :.:PEP          0 ]
                      [ ADP         :.:ADP          0 ]
                      [ PYR         :.:PYR          0 ]
                      [ ATP         :.:ATP          0 ]
                      [ KPEP_PK     :.:KPEP_PK      0 ]
                      [ KADP_PK     :.:KADP_PK      0 ]
                      [ KPYR_PK     :.:KPYR_PK      0 ]
                      [ KATP_PK     :.:KATP_PK      0 ];

                Expression "(( Vmaxf_PK.Value * PEP.Value * ADP.Value ) / ( KPEP_PK.Value * KADP_PK.Value )) -  (( Vmaxr_PK.Value * PYR.Value * ATP.Value ) / ( KPYR_PK.Value * KATP_PK.Value )) / ( 1.0 + ( PEP.Value / KPEP_PK.Value ) + ( ADP.Value / KADP_PK.Value ) + (( PEP.Value * ADP.Value ) / ( KPEP_PK.Value * KADP_PK.Value )) + ( PYR.Value / KPYR_PK.Value ) + ( ATP.Value / KATP_PK.Value ) + (( PYR.Value * ATP.Value ) / ( KPYR_PK.Value * KATP_PK.Value )))";
        }

        Process ExpressionFluxProcess ( V_PK )
        {
               StepperID  ODE;
               Priority   0;

               VariableReferenceList
                      [ V_PK        :.:V_PK         0 ]
                      [ Vmaxf_PK    :.:Vmaxf_PK     0 ]
                      [ Vmaxr_PK    :.:Vmaxr_PK     0 ]
                      [ PEP         :.:PEP         -1 ]
                      [ PYR         :.:PYR          1 ]
                      [ ADP         :.:ADP          0 ]
                      [ ATP         :.:ATP          0 ]
#                     [ ADP         :.:ADP         -1 ]
#                     [ ATP         :.:ATP          1 ]
                      [ KPEP_PK     :.:KPEP_PK      0 ]
                      [ KADP_PK     :.:KADP_PK      0 ]
                      [ KPYR_PK     :.:KPYR_PK      0 ]
                      [ KATP_PK     :.:KATP_PK      0 ];

                Expression "V_PK.Value";
        }

#Toki_120313
	Variable Variable( LAC )
	{
		Value 1.3;
	}

	Variable Variable( KPYR_LDH )
	{
		Value 0.335;
	}

	Variable Variable( KNADH_LDH )
	{
		Value 0.002;
	}

	Variable Variable( KNAD_LDH )
	{
		Value 0.849;
	}

	Variable Variable( KLAC )
	{
		Value 17.0;
	}

	Variable Variable( KeqLDH )
	{
		Value 16198.0;
	}

	Variable Variable( Vmaxf_LDH )
	{
		Value 1920.0;
	}

	Variable Variable( Vmaxr_LDH )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxr_LDH )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxr_LDH    :.:Vmaxr_LDH   1 ]			
			[ Vmaxf_LDH    :.:Vmaxf_LDH   0 ]
			[ KPYR_LDH     :.:KPYR_LDH    0 ]
			[ KNADH_LDH    :.:KNADH_LDH   0 ]
			[ KNAD_LDH     :.:KNAD_LDH    0 ]
			[ KLAC         :.:KLAC        0 ]
			[ KeqLDH       :.:KeqLDH      0 ];
	
		Expression "Vmaxf_LDH.Value * KLAC.Value * KNAD_LDH.Value / ( KPYR_LDH.Value * KNADH_LDH.Value * KeqLDH.Value)";		
	}

	Variable Variable( V_LDH )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_LDH_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_LDH        :.:V_LDH         1 ]
			[ Vmaxf_LDH    :.:Vmaxf_LDH     0 ]
			[ Vmaxr_LDH    :.:Vmaxr_LDH     0 ]
			[ PYR          :.:PYR           0 ]
			[ NADH         :.:NADH          0 ]
			[ NAD          :.:NAD           0 ]
			[ LAC          :.:LAC           0 ]
			[ KPYR_LDH     :.:KPYR_LDH      0 ]
			[ KNADH_LDH    :.:KNADH_LDH     0 ]
			[ KNAD_LDH     :.:KNAD_LDH      0 ]
			[ KLAC         :.:KLAC          0 ];
	
		Expression "( Vmaxf_LDH.Value * PYR.Value * NADH.Value / ( KPYR_LDH.Value * KNADH_LDH.Value ) -  Vmaxr_LDH.Value * LAC.Value * NAD.Value / ( KLAC.Value * KNAD_LDH.Value )) / ( 1.0 + PYR.Value / KPYR_LDH.Value + NADH.Value / KNADH_LDH.Value + PYR.Value * NADH.Value / ( KPYR_LDH.Value * KNADH_LDH.Value ) + LAC.Value / KLAC.Value + NAD.Value / KNAD_LDH.Value + LAC.Value * NAD.Value / ( KLAC.Value * KNAD_LDH.Value ))";		
	}

	Process ExpressionFluxProcess ( V_LDH )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_LDH        :.:V_LDH         0 ]
			[ Vmaxf_LDH    :.:Vmaxf_LDH     0 ]
			[ Vmaxr_LDH    :.:Vmaxr_LDH     0 ]
			[ PYR          :.:PYR          -1 ]
			[ NADH         :.:NADH         -1 ]
			[ NAD          :.:NAD           1 ]
			[ LAC          :.:LAC           1 ]
			[ KPYR_LDH     :.:KPYR_LDH      0 ]
			[ KNADH_LDH    :.:KNADH_LDH     0 ]
			[ KNAD_LDH     :.:KNAD_LDH      0 ]
			[ KLAC         :.:KLAC          0 ];
	
		Expression "V_LDH.Value";
	}

#	Variable Variable( V_OUTPUT )
#	{
#		Value 0.0;
#	}

	Process ExpressionFluxProcess ( V_OUTPUT )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
#			[ V_OUTPUT     :.:V_OUTPUT      1 ]
			[ LAC          :.:LAC           -1 ];
	
		Expression "( 0.2 * LAC.Value )";		
	}

#Toki_120313
	Variable Variable( PCr )
	{
		Value 34.67;
	}

	Variable Variable( Cr )
	{
#		Value 35.0;
		Value 5.33;
	}	

	Variable Variable( KPCr )
	{
		Value 1.11;
	}

	Variable Variable( KiPCr )
	{
		Value 3.9;
	}

	Variable Variable( KCr )
	{
		Value 3.8;
	}

	Variable Variable( KiADP )
	{
		Value 0.135;
	}

	Variable Variable( KiATP_CK )
	{
		Value 3.5;
	}

	Variable Variable( KeqCK )
	{
		Value 233.0;
	}

	Variable Variable( Vmaxr_CK )
	{
		Value 500.0;
	}

	Variable Variable( Vmaxf_CK )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( Vmaxf_CK )
	{
		StepperID  DT;
		Priority   5;

		VariableReferenceList
			[ Vmaxf_CK   :.:Vmaxf_CK    1 ]			
			[ Vmaxr_CK   :.:Vmaxr_CK    0 ]
			[ KiATP_CK   :.:KiATP_CK    0 ]
			[ KPCr       :.:KPCr        0 ]
			[ KiPCr      :.:KiPCr       0 ]
			[ KCr        :.:KCr         0 ]
			[ KiADP      :.:KiADP       0 ]
			[ KeqCK      :.:KeqCK       0 ];
	
		Expression "Vmaxr_CK.Value * KiATP_CK.Value * KCr.Value * KeqCK.Value / ( KiADP.Value * KPCr.Value )";		
	}

	Variable Variable( V_CK )
	{
		Value 0.0;
	}

	Process ExpressionAssignmentProcess ( V_CK_assign )
	{
		StepperID  DT;
		Priority   1;

		VariableReferenceList
			[ V_CK       :.:V_CK        1 ]
			[ Vmaxf_CK   :.:Vmaxf_CK    0 ]
			[ Vmaxr_CK   :.:Vmaxr_CK    0 ]
			[ ADP        :.:ADP         0 ]
			[ PCr        :.:PCr         0 ]
			[ ATP        :.:ATP         0 ]
			[ Cr         :.:Cr          0 ]
			[ KiATP_CK   :.:KiATP_CK    0 ]
			[ KiADP      :.:KiADP       0 ]
			[ KPCr       :.:KPCr        0 ]
			[ KiPCr      :.:KPCr        0 ]
			[ KCr        :.:KCr         0 ];
	
#		Expression "( Vmaxr_CK.Value * ATP.Value * Cr.Value / ( KiATP_CK.Value * KCr.Value ) -  Vmaxf_CK.Value * ADP.Value * PCr.Value / ( KiADP.Value * KPCr.Value )) / ( 1.0 + ADP.Value / KiADP.Value + PCr.Value / KiPCr.Value + ADP.Value * PCr.Value / ( KiADP.Value * KPCr.Value ) + ATP.Value / KiATP_CK.Valu + ATP.Value * Cr.Value / ( KiATP_CK.Value * KCr.Value ))";		
		Expression "( Vmaxr_CK.Value * ATP.Value * Cr.Value / ( KiATP_CK.Value * KCr.Value ) -  Vmaxf_CK.Value * ADP.Value * PCr.Value / ( KiADP.Value * KPCr.Value )) / ( 1.0 + ADP.Value / KiADP.Value + PCr.Value / KiPCr.Value + ADP.Value * PCr.Value / ( KiADP.Value * KPCr.Value ) + ATP.Value / KiATP_CK.Value + Cr.Value / KCr.Value + ATP.Value * Cr.Value / ( KiATP_CK.Value * KCr.Value ))";		
	}

	Process ExpressionFluxProcess ( V_CK )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ V_CK       :.:V_CK        0 ]
			[ Vmaxf_CK   :.:Vmaxf_CK    0 ]
			[ Vmaxr_CK   :.:Vmaxr_CK    0 ]
#			[ ADP        :.:ADP         1 ]
#			[ ATP        :.:ATP        -1 ]
			[ Cr         :.:Cr         -1 ]
			[ PCr        :.:PCr         1 ]
			[ ADP        :.:ADP         0 ]
			[ ATP        :.:ATP         0 ]
			[ KiATP_CK   :.:KiATP_CK    0 ]
			[ KiADP      :.:KiADP       0 ]
			[ KPCr       :.:KPCr        0 ]
			[ KiPCr      :.:KPCr        0 ]
			[ KCr        :.:KCr         0 ];
	
		Expression"V_CK.Value";
	}

#Toki_120313
      Variable Variable( KAMP )
        {
                Value 0.32;
        }

        Variable Variable( KATP_ADK )
        {
                Value 0.27;
        }

        Variable Variable( KADP_ADK )
        {
                Value 0.35;
        }

        Variable Variable( KeqADK )
        {
                Value 2.21;
        }

        Variable Variable( Vmaxf_ADK )
        {
                Value 880.0;
	}

        Variable Variable( Vmaxr_ADK )
        {
	        Value 0.0;
	}

#        Process ExpressionAssignmentProcess ( Vmaxr_ADK )
#        {
#	        StepperID  DT;
#                Priority   5;

#                VariableReferenceList
#                        [ Vmaxr_ADK   :.:Vmaxr_ADK   1 ]
#			[ Vmaxf_ADK   :.:Vmaxf_ADK   0 ]
#	                [ KATP_ADK    :.:KATP_ADK    0 ]
#                        [ KADP_ADK    :.:KADP_ADK    0 ]
#                        [ KAMP        :.:KAMP        0 ]
#                        [ KeqADK      :.:KeqADK      0 ];

#	 Expression "Vmaxf_ADK.Value * pow( KADP_ADK.Value, 2.0 ) / ( KATP_ADK.Value * KAMP.Value * KeqADK.Value )";
#        }

	Variable Variable( V_ADK )
	{
                Value 0.0;
        }

#       Process ExpressionAssignmentProcess ( V_ADK_assign )
#       {
#               StepperID  DT;
#               Priority   1;

#                VariableReferenceList
#                        [ V_ADK         :.:V_ADK         1 ]
#                        [ Vmaxf_ADK     :.:Vmaxf_ADK     0 ]
#                        [ Vmaxr_ADK     :.:Vmaxr_ADK     0 ]
#                        [ ATP           :.:ATP           0 ]
#                        [ ADP           :.:ADP           0 ]
#                        [ AMP           :.:AMP           0 ]
#                        [ KATP_ADK      :.:KATP_ADK      0 ]
#                        [ KADP_ADK      :.:KADP_ADK      0 ]
#                        [ KAMP          :.:KAMP          0 ];

#               Expression "((( Vmaxf_ADK.Value * ATP.Value * AMP.Value ) / ( KATP_ADK.Value * KAMP.Value )) - ( Vmaxr_ADK.Value * pow( ADP.Value, 2.0 )) / ( pow( KADP_ADK.Value, 2.0 ))) / ( 1.0 + ( ATP.Value / KATP_ADK.Value ) + ( AMP.Value / KAMP.Value ) + (( ATP.Value * AMP.Value ) / ( KATP_ADK.Value * KAMP.Value )) + ( 2.0 * ADP.Value / KADP_ADK.Value ) + ( pow( ADP.Value, 2.0 )) / ( pow( KADP_ADK.Value, 2.0 )))";
#       }

#        Process ExpressionFluxProcess ( V_ADK )
#        {
#                StepperID  ODE;
#                Priority   0;

#                VariableReferenceList
#                        [ V_ADK         :.:V_ADK         0 ]
#                        [ Vmaxf_ADK     :.:Vmaxf_ADK     0 ]
#                        [ Vmaxr_ADK     :.:Vmaxr_ADK     0 ]
#                        [ ATP           :.:ATP           0 ]
#                        [ ADP           :.:ADP           0 ]
#                       [ ATP           :.:ATP          -1 ]
#                       [ ADP           :.:ADP           2 ]
#                        [ AMP           :.:AMP          -1 ]
#                        [ KATP_ADK      :.:KATP_ADK      0 ]
#                        [ KADP_ADK      :.:KADP_ADK      0 ]
#                        [ KAMP          :.:KAMP          0 ];

#                Expression "V_ADK.Value";
#        }

#Toki_120313
#	Variable Variable( ATPase )
#	{
#		Value 0.75;
#	}

#	Variable Variable( V_ATPase )
#	{
#		Value 600.0;
#	}

	Variable Variable( k )
	{
		Value 7.5;
#		Value 0.75;
#		Value 0.075;
	}

#	Process ExpressionAssignmentProcess ( V_ATPase_assign )
#	{
#		StepperID  DT;
#		Priority   1;

#		VariableReferenceList
#			[ V_ATPase      :.:V_ATPase     1 ]
#			[ ATP           :.:ATP          0 ]
#			[ ADP           :.:ADP          0 ]
#			[ k           :.:k          0 ]
#			[ Pi            :.:Pi           0 ];

#		Expression "k.Value * ATP.Value";		
#	}

#	Process ExpressionFluxProcess ( V_ATPase )
#	{
#		StepperID  ODE;
#		Priority   0;

#		VariableReferenceList
#			[ V_ATPase      :.:V_ATPase     0 ]
#			[ ATP           :.:ATP         -1 ]	
#			[ ADP           :.:ADP          1 ]
#			[ ATP           :.:ATP          0 ]	
#			[ ADP           :.:ADP          0 ]
#			[ Pi            :.:Pi           1 ];
	
#		Expression "V_ATPase.Value";		
#	}

}


