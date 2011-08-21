@{
def VRefNameToExpression( VRefName ):  # VariabeReference Name -> expression

    if   ( VRefName[ 2 ] == 'C' ):
        return '%s.MolarConc' % VRefName[ :2 ]
    elif ( VRefName[ 2 ] == 'V' ):
        return '%s.Value' % VRefName[ :2 ]
    else:
        return VRefName

def termDicWithVRefName( VRefNameList ):

    theDic = {}

    for VRefName in VRefNameList:
        theDic[ VRefName ] = VRefNameToExpression( VRefName )
    
    return theDic

MetaNet_term = termDicWithVRefName([ 'S0C', 'S1C', 'P0C', 'P1C', 'P2C' ])

MetaNet_term[ 'KS1iP0'   ] = '( KS1 * ( 1.0 + %(P0C)s / KiP0S1 ))' % MetaNet_term

MetaNet_term[ 'Keq_1x1'      ] = '( kcatf / kcatr / KS0 * KP0 )' % MetaNet_term
MetaNet_term[ 'Keq_2x2'      ] = '( kcatf / kcatr / KS0 / KS1 * KP1 * KP0 )' % MetaNet_term
MetaNet_term[ 'Keq_2x3'      ] = '( kcatf / kcatr / KS0 / KS1 * KP1 * KP0* KP2 )' % MetaNet_term
MetaNet_term[ 'Keq_2x2iP0S1' ] = '( kcatf / kcatr / KS0 / %(KS1iP0)s * KP1 * KP0 )' % MetaNet_term

MetaNet_term[ 'Q_1x1' ] = '( %(P0C)s / %(S0C)s )' % MetaNet_term
MetaNet_term[ 'Q_2x2' ] = '( %(P0C)s * %(P1C)s / %(S0C)s / %(S1C)s )' % MetaNet_term
MetaNet_term[ 'Q_2x3' ] = '( %(P0C)s * %(P1C)s * %(P2C)s / %(S0C)s / %(S1C)s )' % MetaNet_term

MetaNet_term[ 'S_1x1'      ] = '( 1.0 - %(Q_1x1)s / %(Keq_1x1)s )' % MetaNet_term
MetaNet_term[ 'S_2x2'      ] = '( 1.0 - %(Q_2x2)s / %(Keq_2x2)s )' % MetaNet_term
MetaNet_term[ 'S_2x3'      ] = '( 1.0 - %(Q_2x3)s / %(Keq_2x3)s )' % MetaNet_term
MetaNet_term[ 'S_2x2iP0S1' ] = '( 1.0 - %(Q_2x2)s / %(Keq_2x2iP0S1)s )' % MetaNet_term

MetaNet_term[ 'TermS_1'      ] = '( KS0 / %(S0C)s )' % MetaNet_term
MetaNet_term[ 'TermS_2'      ] = '( KS0 / %(S0C)s + KS1 / %(S1C)s )' % MetaNet_term
MetaNet_term[ 'TermS_2iP0S1' ] = '( KS0 / %(S0C)s + %(KS1iP0)s / %(S1C)s )' % MetaNet_term

MetaNet_term[ 'TermP_1' ] = '( %(P0C)s / KP0 )' % MetaNet_term
MetaNet_term[ 'TermP_2' ] = '( %(P0C)s / KP0 + %(P1C)s / KP1 )' % MetaNet_term
MetaNet_term[ 'TermP_3' ] = '( %(P0C)s / KP0 + %(P1C)s / KP1 + %(P2C)s / KP2 )' % MetaNet_term

MetaNet_Yd_1x1      = '( %(S_1x1)s / ( 1.0 + %(TermS_1)s * ( 1.0 + %(TermP_1)s )))' % MetaNet_term
MetaNet_Yd_2x2      = '( %(S_2x2)s / ( 1.0 + %(TermS_2)s * ( 1.0 + %(TermP_2)s )))' % MetaNet_term
MetaNet_Yd_2x3      = '( %(S_2x3)s / ( 1.0 + %(TermS_2)s * ( 1.0 + %(TermP_3)s )))' % MetaNet_term
MetaNet_Yd_2x2iP0S1 = '( %(S_2x2iP0S1)s / ( 1.0 + %(TermS_2iP0S1)s * ( 1.0 + %(TermP_2)s )))' % MetaNet_term
}

Stepper FixedODE1Stepper( ODE ){}
#Stepper ODEStepper( ODE ){}

# /SIN⇒/CELL/CYT⇒/CELL/MIT
#
###############################################
System System( / ){
    StepperID    ODE;
}

System System( /CELL ){
    StepperID    ODE;
}

###############################################
#--/SIN   物質・7 反応・0        
###############################################
System System( /SIN ){

    StepperID    ODE;

    Variable Variable( SIZE ) { Value     9.408e-10;          }
    Variable Variable( Gln )  { MolarConc 0.5e-3;    Fixed 1; }
    Variable Variable( Glu )  { MolarConc 0.16e-3;   Fixed 1; }
    Variable Variable( His )  { MolarConc 0.125e-3;           }
    Variable Variable( NH4 )  { MolarConc 0.2e-3;    Fixed 1; }
    Variable Variable( Na )   { MolarConc 143.5e-3;  Fixed 1; }
    Variable Variable( Trp )  { MolarConc 0.25e-3;            }
    Variable Variable( Urea ) { MolarConc 6e-3;               }

}

###############################################
#--/CELL/CYT   物質・29 うち酵素・7 反応・12        
###############################################
System System( /CELL/CYT ){
    StepperID    ODE;    
    Variable Variable( SIZE )    { Value     9.408e-10;          }
    Variable Variable( AMP )     { MolarConc 0.218e-3;  Fixed 1; }
    Variable Variable( AdoMet )  { MolarConc 0.046e-3;  Fixed 1; }
    Variable Variable( aKG )     { MolarConc 2e-3;      Fixed 1; }
    Variable Variable( Arg )     { MolarConc 0.05e-3;            }
    Variable Variable( AS )      { MolarConc 0.034e-3;           }
    Variable Variable( Asp )     { MolarConc 1.2e-3;             }
    Variable Variable( Cit )     { MolarConc 0.085e-3;           }
    Variable Variable( Cr )      { MolarConc 1e-3;               }
    Variable Variable( Fum )     { MolarConc 1e-3;      Fixed 1; }
    Variable Variable( Gln )     { MolarConc 2.96e-3;            }
    Variable Variable( Glu )     { MolarConc 1.06e-2;            }
    Variable Variable( Gly )     { MolarConc 6e-3;      Fixed 1; }
    Variable Variable( GuaAc )   { MolarConc 0.014e-3;           }
    Variable Variable( His )     { MolarConc 0.41e-3;            }
    Variable Variable( MgATP )   { MolarConc 4.54e-3;   Fixed 1; }
    Variable Variable( Na )      { MolarConc 34.2e-3;   Fixed 1; }
    Variable Variable( NH4 )     { MolarConc 8.9e-5;             }
    Variable Variable( OAA )     { MolarConc 0.015e-3;  Fixed 1; }
    Variable Variable( Orn )     { MolarConc 0.51e-3;   Fixed 1; }
    Variable Variable( PI )      { MolarConc 7.4e-3;    Fixed 1; }
    Variable Variable( Trp )     { MolarConc 0.2e-3;             }
    Variable Variable( Urea )    { MolarConc 6e-3;               }

    Variable Variable( ASL )     { MolarConc 2.2e-6;             }
    Variable Variable( ASS )     { MolarConc 4.7513549899483933e-4; }
    Variable Variable( Aase )    { MolarConc 1.7367e-7;          }
#    Variable Variable( Aase )     { MolarConc 6.7727979e-6; }
#大野モデルは6.77〜。Aaseの式が微妙に違う
    Variable Variable( GAMT )    { MolarConc 7.361085021997732e-7;  }
    Variable Variable( GAT )     { MolarConc 2.3113795671881858e-4; }
    Variable Variable( GOT )     { MolarConc 1e-6; }
    Variable Variable( GS )      { MolarConc 1e-5; }

##  尿素回路 ASS・ASL・Aase
##--------------------------
    Process ExpressionFluxProcess( ASS ){

        VariableReferenceList
            [ C0 :.:ASS    0 ]
            [ S0 :.:Cit   -1 ]
            [ S1 :.:Asp   -1 ]
            [ S2 :.:MgATP -1 ]
            [ P0 :.:AS     1 ]
            [ P1 :.:AMP    1 ]
            [ P2 :.:PI     1 ];##??

@{
ASS_term= termDicWithVRefName([ 'S0C', 'S1C', 'S2C', 'P0C', 'P1C', 'P2C' ])

ASS_term.update({
    'D01' : '( k11 * k2 * k4 * (k6 + k7) * k9 )',
    'D02' : '( k11 * k2 * k5 * k7 * k9 )',
    'D03' : '( k12 * k2 * k4 * (k6 * k7) * k9 )',
    'D04' : '( k10 * k12 * k2 * k4 * (k6 + k7) )',
    'D05' : '( k12 * k2 * k5 * k7 * k9 )',
    'D06' : '( k10 * k12 * k2 * k5 * k7 )',
    'D07' : '( k11 * k3 * k5 * k7 * k9 )',
    'D08' : '( k12 * k3 * k5 * k7 * k9 )',
    'D09' : '( k10 * k12 * k3 * k5 * k7 )',
    'D10' : '( k11 * k1 * k4 * (k6 + k7) * k9 )',
    'D11' : '( k11 * k1 * k5 * k7 * k9 )',
    'D12' : '( k11 * k1 * k3 * (k6 + k7) * k9 )',
    'D13' : '( k1 * k3 * k5 * (k11 * k7 + k11 * k9 + k7 * k9) )',
    'D14' : '( k10 * k1 * k3 * k5 * k7 )',
    'D15' : '( k11 * k2 *k4 * k6 *k8 )',
    'D16' : '( k10 * k2 * k4 * k6 * k8 )',
    'D17' : '( k12 * k2 * k4 * k6 * k8 )',
    'D18' : '( k10 * k12 * (k2 * k4 + k2 * k6 + k4 * k6) * k8 )', 
    'D19' : '( k10 * k12 * k2 * k5 * k8 )',
    'D20' : '( k10 * k12 * k3 * k6 * k8 )',
    'D21' : '( k10 * k12 * k3 * k5 * k8 )',
    'D22' : '( k11 * k1 * k4 * k6 * k8 )',
    'D23' : '( k10 * k1 * k4 * k6 * k8 )',
    'D24' : '( k11 * k1 * k3 * k6 * k8 )',
    'D25' : '( k10 * k1 * k3 * k6 * k8 )',
    'D26' : '( k11 * k1 * k3 * k5 * k8 )',
    'D27' : '( k10 * k1 * k3 * k5 * k8 )'
})

ASS_FOR = '( k1 * k3 * k5 * k7 * k9 * k11 * %(S0C)s * %(S1C)s * %(S2C)s )' % ASS_term
ASS_REV = '( k2 * k4 * k6 * k8 * k10 * k12 * %(P0C)s * %(P1C)s * %(P2C)s )' % ASS_term

ASS_denom = '( \
      %(D01)s \
    + %(D02)s * %(S1C)s \
    + %(D03)s * %(P0C)s \
    + %(D04)s * %(P1C)s * %(P0C)s \
    + %(D05)s * %(S1C)s * %(P0C)s \
    + %(D06)s * %(P1C)s * %(S1C)s * %(P0C)s \
    + %(D07)s * %(S1C)s * %(S2C)s \
    + %(D08)s * %(S1C)s * %(P0C)s * %(S2C)s \
    + %(D09)s * %(P1C)s * %(S1C)s * %(P0C)s * %(S2C)s \
    + %(D10)s * %(S0C)s \
    + %(D11)s * %(S1C)s * %(S0C)s \
    + %(D12)s *  %(S2C)s * %(S0C)s \
    + %(D13)s * %(S1C)s * %(S2C)s * %(S0C)s \
    + %(D14)s * %(P1C)s * %(S1C)s * %(S2C)s * %(S0C)s \
    + %(D15)s * %(P2C)s \
    + %(D16)s * %(P2C)s * %(P1C)s \
    + %(D17)s * %(P0C)s * %(P2C)s \
    + %(D18)s * %(P1C)s * %(P0C)s* %(P2C)s \
    + %(D19)s * %(P1C)s * %(S1C)s * %(P0C)s* %(P2C)s \
    + %(D20)s * %(P1C)s * %(P0C)s* %(S2C)s * %(P2C)s \
    + %(D21)s * %(P1C)s * %(S1C)s * %(P0C)s* %(S2C)s * %(P2C)s \
    + %(D22)s * %(S0C)s * %(P2C)s \
    + %(D23)s * %(P1C)s * %(S0C)s * %(P2C)s \
    + %(D24)s * %(S2C)s * %(S0C)s* %(P2C)s \
    + %(D25)s * %(P1C)s * %(S2C)s * %(S0C)s * %(P2C)s \
    + %(D26)s * %(S1C)s * %(S2C)s * %(S0C)s* %(P2C)s \
    + %(D27)s * %(P1C)s * %(S1C)s * %(S2C)s * %(S0C)s * %(P2C)s \
    )' % ASS_term
}

        Expression  "C0.Value * ( @ASS_FOR - @ASS_REV ) / @ASS_denom";

        k1  2.4e+5;    k2  2.3;
        k3  3.5e+4;    k4  10.0;
        k5  4.8e+5;    k6  10.0;
        k7  2.0e+1;    k8  8.9e+5;
        k9  5.0e+1;    k10 6.4e+5;
        k11 5.0e+1;    k12 1.7e+5;
    }

    Process ExpressionFluxProcess( ASL ){

        VariableReferenceList
            [ S0 :.:AS  -1 ]
            [ P0 :.:Fum  1 ]
            [ P1 :.:Arg  1 ]
            [ C0 :.:ASL  0 ];

        Expression  "((( k1 * k3 * k5 * S0.Value ) - ( k2 * k4 * k6 * P0.Value * P1.MolarConc )) * C0.MolarConc ) /( k5 * ( k2 + k3 ) + k1 * ( k3 + k5 ) * S0.MolarConc + k2 * k4 * P0.MolarConc + k6 * ( k2 + k3 ) * P1.MolarConc + k4 * k6 * P1.MolarConc * P0.MolarConc + k1 * k4 * S0.MolarConc * P0.MolarConc )";

        k1  2.7e+6;    k2 7.0e+1;
        k3  7.5e+1;     k4 1.5e+6;
        k5  1.1e+3;    k6 7.0e+5;
    }

    Process ExpressionFluxProcess( Aase ){

        VariableReferenceList
            [ S0 :.:Arg -1]
            [ P0 :.:Urea 1]
            [ P1 :.:Orn 1]
            [ C0 :.:Aase 0];

        Expression "k1 * k3 * k4 * C0.Value * S0.MolarConc /( k4 * ( k2 + k3 ) + k5 * ( k2 + k3 ) * P1.MolarConc + k1 * ( k3 + k4 ) * S0.MolarConc )";
    
        k1 1.0e+7;    k2 5.4e+4;
        k3 5.3e+3;    k4 3.0e+4;
        k5 1.0e+7;
    }

##  クレアチンルート GAT・GAMT
##----------------------------
    Process ExpressionFluxProcess( GAT ){    @# MetaNet3Process

        VariableReferenceList
        [ S0 :.:Gly   -1 ]
        [ S1 :.:Arg   -1 ]
        [ P0 :.:Orn    1 ]
        [ P1 :.:GuaAc  1 ]
        [ C0 :.:GAT    0 ];

        Expression  "C0.Value * @MetaNet_Yd_2x2iP0S1 * ( geq( @MetaNet_Yd_2x2iP0S1, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x2iP0S1, 0.0 ) * kcatr )";

        kcatf  @( 2076.0 / 60.0 );
        kcatr  @( 44.2 / 60.0);
        KS0     1.8e-3;
        KS1     1.3e-3;
        KP0     0.253e-3;
        KP1     0.05e-3;
        KiP0S1     0.116e-3;
    }

    Process ExpressionFluxProcess( GAMT ){    @# MetaNet5Process

        VariableReferenceList
            [ S0 :.:AdoMet -1 ]
            [ S1 :.:GuaAc  -1 ]
            [ P0 :.:Cr      1 ]
            [ C0 :.:GAMT    0 ];

        Expression  "C0.Value / ( 1.0 + KS0 / S0.MolarConc + KS1 / S1.MolarConc ) * kcatf";

        kcatf @( 2120.0 / 60.0 );
        KS0 0.09e-3;
        KS1 0.0014e-3;
    }

##  その他の反応 GOTc・GS
##------------------------
    Process ExpressionFluxProcess( GOTc ){    @# MetaNet1Process

        VariableReferenceList
            [ S0 :.:Asp -1 ]
            [ S1 :.:aKG -1 ]
            [ P0 :.:Glu  1 ]
            [ P1 :.:OAA  1 ]
            [ C0 :.:GOT  0 ];

        Expression  "C0.Value * @MetaNet_Yd_2x2 * ( geq( @MetaNet_Yd_2x2, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x2, 0.0 ) * kcatr )";

        kcatf @( 16400.0 / 60.0 );
        kcatr @( 32180.0 / 60.0 );
        KS0 3.12e-3;
        KS1 0.31e-3;
        KP0 6.5e-3;
        KP1 0.048e-3;
    }

    Process ExpressionFluxProcess( GS ){

        VariableReferenceList
            [ S0 :.:Glu         -1 ]
            [ S1 :.:MgATP       -1 ]
            [ S2 :/CELL/MIT:NH4 -1 ]
            [ P0 :.:AMP          1 ]
            [ P1 :.:PI           1 ]
            [ P2 :.:Gln          1 ]
            [ C0 :.:GS           0 ];

        Expression  "kcat * C0.Value * S0.MolarConc * S1.MolarConc * S2.MolarConc / ( (KmG + S0.MolarConc) * (KmA + S1.MolarConc) * (KmN + S2.MolarConc) )";

        KmG   3e-3;
        KmN   2e-4;
        KmA   8e-4;
        kcat  4.587699044135982;
    }


##  CYT-SIN輸送 
##    -SysN/L・Glu/Urea/NH4
##-------------------------
    Process ExpressionFluxProcess( sysN ){

        VariableReferenceList
            [ S0 :/SIN:Gln -1 ]
            [ S1 :/SIN:Na  -1 ]
            [ S2 :/SIN:His  0 ]
            [ P0 :.:Gln     1 ]
            [ P1 :.:Na      1 ]
            [ P2 :.:His     0 ];

        Expression  "Vmax * ((S1.Value / (S1.MolarConc + Kmn))*(S0.MolarConc /(S0.MolarConc + Kmg * (1.0 + S2.MolarConc / Kih))) - (P1.Value / (P1.MolarConc + Kmn))*(P0.MolarConc /(P0.MolarConc + Kmg * (1.0 + P2.MolarConc / Kih))))";

        Kmg   1.1e-3;
        Kmn   17.0e-3;
        Kih   0.21e-3;
        Vmax  2.2443329939865615e-5;
    }

    Process ExpressionFluxProcess( sysL ){

        VariableReferenceList
            [ S0 :/SIN:Gln -1 ]
            [ C0 :/SIN:Trp  0 ]
            [ P0 :.:Gln     1 ]
            [ C1 :.:Trp     0 ];

        Expression  "Vmax * ( S0.Value / ( S0.MolarConc + Kmg * ( C0.MolarConc / Kit + 1.0 )) - P0.Value / ( P0.MolarConc + Kmg * ( C1.MolarConc / Kit + 1.0 )))";

        Kmg   4.0e-3;
        Kit   1.65e-3;
        Vmax  7.3391591648329236e-6;
    }

    Process ExpressionFluxProcess( Glutrans ){

        VariableReferenceList
            [ S0 :/SIN:Glu -1 ]
            [ P0 :.:Glu     1 ];

        Expression  "VmF * S0.Value /(S0.MolarConc + Kmg) - VmR * P0.Value /(P0.MolarConc + Kmg)";

        Kmg  0.53e-3;
        VmF  6.146743017801964e-4;
        VmR  1.2293486035603929e-4;
    }

    Process ExpressionFluxProcess( Ureatrans ){

        VariableReferenceList
            [ U0 :.:Urea    -1 ]
            [ U1 :/SIN:Urea  1 ];

        Expression  "k * U0.Value";

        k  1.1e-3;
    }

    Process ExpressionFluxProcess( Ammtrans ){

        VariableReferenceList
            [ Am :/SIN:NH4 -1 ]
            [ Ao :/CELL/MIT:NH4 1 ];
             ###修正の可能性あり

        Expression  "(k * (Am.MolarConc - Ao.MolarConc)) * self.getSuperSystem().SizeN_A"; @# AoのSystemが異なるのでValueにできない

        k  0.11261261261261261;
    }

}  # End of System( /CELL/CYT )


###############################################
#--/CELL/MIT   物質・31 うち酵素・10 反応・16        
###############################################  
System System( /CELL/MIT ){

    StepperID    ODE;

    Variable Variable( SIZE )    { Value      2.352e-10; }
    Variable Variable( AMP )     { MolarConc  2.6e-3;   Fixed 1; }
    Variable Variable( AcCoA )   { MolarConc  0.24e-3;  Fixed 1; }
    Variable Variable( Arg )     { MolarConc  5e-5; }
    Variable Variable( AcGlu )   { MolarConc  0.68e-3; }
    Variable Variable( aKG )     { MolarConc  0.31e-3; }
    Variable Variable( Asp )     { MolarConc  0.4e-3; }
    Variable Variable( CP )      { MolarConc  0.085e-3; }
    Variable Variable( Cit )     { MolarConc  0.15e-3; }
    Variable Variable( CoA )     { MolarConc  0.38e-3; }
    Variable Variable( Gln )     { MolarConc  2.0e-2; }
    Variable Variable( Glu )     { MolarConc  2.57e-3; }
    Variable Variable( HCO3 )    { MolarConc  7e-3;     Fixed 1; }
    Variable Variable( Mg2 )     { MolarConc  0.83e-3;  Fixed 1; }
    Variable Variable( MgATP )   { MolarConc  1.8e-3;   Fixed 1; }
    Variable Variable( NAD )     { MolarConc  1.58e-3;  Fixed 1; }
    Variable Variable( NADH )    { MolarConc  0.36e-3;  Fixed 1; }
    Variable Variable( NH4 )     { MolarConc  0.089e-3; }
    Variable Variable( OAA )     { MolarConc  0.07e-3;  Fixed 1; }
    Variable Variable( Orn )     { MolarConc  0.42e-3; }
    Variable Variable( P5C )     { MolarConc  0.02e-3;  Fixed 1;  }
    Variable Variable( PI )      { MolarConc  4.1e-3; }

    Variable Variable( AGS )     { MolarConc  2e-5; }
    Variable Variable( CPS )     { MolarConc  6.578991464657054e-5; }
    Variable Variable( GDH )     { MolarConc  3.114508378224604e-7; }
    Variable Variable( GOT )     { MolarConc  1.8432511026871124e-6; }
    Variable Variable( Glnase )  { MolarConc  1e-4; }
    Variable Variable( OAT )     { MolarConc  1.217198451092118e-5; }
    Variable Variable( GTL )     { MolarConc  1e-7; }
    Variable Variable( OTL )     { MolarConc  8.198494252683558e-5; }
    Variable Variable( GATL )    { MolarConc  7.470657553077835e-6; }
    Variable Variable( OCT )     { MolarConc  2.1727639560684564e-7; }

##  尿素回路+α CPS・OCT・OTL・AGS
##--------------------------------
    Process ExpressionFluxProcess( CPS ){

        VariableReferenceList
            [ S0 :.:MgATP -2 ]
            [ S1 :.:HCO3  -1 ]
            [ S2 :.:NH4   -1 ]
            [ P0 :.:Mg2    2 ]
            [ P1 :.:PI     2 ]
            [ P2 :.:AMP    2 ]
            [ P3 :.:CP     1 ]
            [ C0 :.:AcGlu  0 ]
            [ C1 :.:CPS    0 ];

@{
CPS_term= termDicWithVRefName([ 'S0C', 'S1C', 'S2C', 'P0C', 'C0C' ])

CPS_term.update({
    'D01' : '( Ksa1 * Km_b + Ksb * (Kma2 + Km_a2) )',
    'D02' : '( Ksg * Kma1 )',
    'D03' : '( Ksm * Kma1 )',
    'D04' : '( Ksa2 *Kmn )',
    'D05' : '( Ksg * Km_b )',
    'D06' : '( Ksg * Ksm * Kma1 )',
    'D07' : '( Ksa1 * Ksg * Km_b + Ksg * Ksb * Km_a2 )',
    'D08' : '( Ksa1 * Ksm* Kmb )',
    'D09' : '( Ksa2 * Ksb * (Kmn + Km_n) )',
    'D10' : '( Ksa1 * Ksm * Ksg * Km_b )',
    'D11' : '( Ksa2 * Ksg * Ksb * Km_n )',
    'D12' : '( Ksa1 * Ksb * Km_a2 )',
    'D13' : '( Ksa1 * Ksg * Ksb * Km_a2 )',
    'D14' : '( Ksa1 * Ksm * Ksb * Km_a2 )',
    'D15' : '( Ksa1 * Ksa2 * Ksb * Km_n )',
    'D16' : '( Ksa1 * Ksm * Ksg * Ksb * Km_a2 )',
    'D17' : '( Ksa1 * Ksa2 * Ksm * Ksb * Km_n )',
    'D18' : '( Ksa1 * Ksa2 * Ksg * Ksb* Km_n )',
    'D19' : '( Ksa1 * Ksa2 * Ksm * Ksg * Ksb * Km_n )'
})

CPS_denom = '( 1.0 + (Kma1 + Kma2) / %(S0C)s + Kmb / %(S1C)s + Kmn / %(S2C)s + Kmg / %(C0C)s \
    + %(D01)s / (%(S0C)s * %(S1C)s) \
    + %(D02)s / (%(S0C)s * %(C0C)s) \
    + %(D03)s / (%(S0C)s * %(P0C)s) \
    + %(D04)s / (%(S0C)s * %(S2C)s) \
    + %(D05)s / (%(C0C)s * %(S1C)s) \
    + %(D06)s / (%(S0C)s * %(P0C)s * %(C0C)s) \
    + %(D07)s / (%(S0C)s * %(C0C)s * %(S1C)s) \
    + %(D08)s / (%(S0C)s * %(P0C)s * %(S1C)s) \
    + %(D09)s / (%(S0C)s * %(S1C)s * %(S2C)s) \
    + %(D10)s / (%(S0C)s * %(P0C)s * %(C0C)s * %(S1C)s) \
    + %(D11)s / (%(S0C)s * %(C0C)s * %(S1C)s * %(S2C)s) \
    + %(D12)s / (%(S0C)s * %(S0C)s * %(S1C)s) \
    + %(D13)s / (%(S0C)s * %(S0C)s * %(C0C)s * %(S1C)s) \
    + %(D14)s / (%(S0C)s * %(S0C)s * %(P0C)s * %(S1C)s) \
    + %(D15)s / (%(S0C)s * %(S0C)s * %(S1C)s * %(S2C)s) \
    + %(D16)s / (%(S0C)s * %(S0C)s * %(P0C)s * %(C0C)s * %(S1C)s) \
    + %(D17)s / (%(S0C)s * %(S0C)s * %(P0C)s * %(S1C)s * %(S2C)s) \
    + %(D18)s / (%(S0C)s * %(S0C)s * %(C0C)s * %(S1C)s * %(S2C)s) \
    + %(D19)s / (%(S0C)s * %(S0C)s * %(P0C)s * %(C0C)s * %(S1C)s * %(S2C)s) \
    )' % CPS_term
}

        Expression  "kcat * C1.Value / @CPS_denom";

        Kma1   0.05e-3;
        Kma2   1e-3;
        Kmb    5e-3;
        Kmn    2e-3;
        Kmg    0.1e-3;
        Ksa1   0.01e-3;
        Ksa2   0.2e-3;
        Ksb    0.8e-3;
        Ksg    0.65e-6;
        Ksm    0.17e-3;
        Km_a2  1e-3;
        Km_b   0.8e-3;
        Km_n   2e-3;
        kcat   @( 1550.0 / 60.0 );
    }

    Process ExpressionFluxProcess( OTC ){

        VariableReferenceList
            [ S0 :.:Orn -1 ]
            [ S1 :.:CP  -1 ]
            [ P0 :.:Cit  1 ]
            [ P1 :.:PI   1 ]
            [ C0 :.:OCT  0 ];

@{
OTC_term= termDicWithVRefName([ 'S0C', 'S1C', 'P0C', 'P1C', 'C0V' ])

OTC_term.update({
    'D01'  : '( k2 * (k4 + k5) * k7 )',
    'D02'  : '( k2 * k4 * k6 )',
    'D03'  : '( k1 * (k4 + k5) * k7 )',
    'D04'  : '( k1 * k4 * k6 )',
    'D05'  : '( k3 * k5 * k7 )',
    'D06'  : '( k1 * k3 * (k5 + k7) )',
    'D07'  : '( k1 * k3 * k6 )',
    'D08'  : '( k2 * (k4 + k5) * k8 )',
    'D09'  : '( (k2 + k4) * k6 * k8 )',
    'D10'  : '( k3 * k5 * k8 )',
    'D11'  : '( k3 * k6 * k8 )'
})

OTC_FOR = '%(C0V)s * k1 * k3 * k5 * k7 * %(S0C)s * %(S1C)s' % OTC_term
OTC_REV = '%(C0V)s * k2 * k4 * k6 * k8 * %(P0C)s * %(P1C)s' % OTC_term

OTC_denom = '( \
      %(D01)s \
    + %(D02)s * %(P0C)s \
    + %(D03)s * %(S1C)s \
    + %(D04)s * %(S1C)s * %(P0C)s \
    + %(D05)s * %(S0C)s \
    + %(D06)s * %(S1C)s * %(S0C)s \
    + %(D07)s * %(S1C)s * %(S0C)s * %(P0C)s \
    + %(D08)s * %(P1C)s \
    + %(D09)s * %(P0C)s * %(P1C)s \
    + %(D10)s * %(S0C)s * %(P1C)s \
    + %(D11)s * %(P0C)s * %(P1C)s * %(S0C)s \
    )' % OTC_term
}

        Expression  "( @OTC_FOR - @OTC_REV ) / @OTC_denom";

        k1 1.7e+7;    k2 6.3e+1;
        k3 2.1e+6;    k4 1.0e+3;    
        k5 3.0e+3;     k6 9.0e+4;
        k7 2.6e+3;    k8 5.0e+5;
    }

    Process ExpressionFluxProcess( OTL ){    @# MetaNet1Process

        VariableReferenceList
            [ S0 :.:Cit         -1 ]
            [ S1 :/CELL/CYT:Orn -1 ]
            [ P0 :.:Orn          1 ]
            [ P1 :/CELL/CYT:Cit  1 ]
            [ C0 :.:OTL          0 ];

        Expression  "C0.Value * @MetaNet_Yd_2x2 * ( geq( @MetaNet_Yd_2x2, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x2, 0.0 ) * kcatr )";

        kcatf  @( 7440.0 / 60.0 );
        kcatr  @( 7440.0 / 60.0 );
        KS0     3.6e-3;
        KS1     0.16e-3;
        KP0     0.16e-3;
        KP1     3.6e-3;
    }

    Process ExpressionFluxProcess( AGS ){

        VariableReferenceList
            [ S0 :.:AcCoA -1 ]
            [ S1 :.:Glu   -1 ]
            [ P0 :.:CoA    1 ]
            [ P1 :.:AcGlu  1 ]
            [ C0 :.:Arg    0 ]
            [ C1 :.:AGS    0 ];

        Expression  "kcat * C1.Value * S0.MolarConc * S1.MolarConc / (1.0 + KaM / C0.MolarConc) / ( KiA * (1.0 + P0.MolarConc / KiP) * KmB * (1.0 + P1.MolarConc / KiQ) + KmB * (1.0 + P1.MolarConc / KiQ) * S0.MolarConc + KmA * (1.0 + P0.MolarConc / KiP) * S1.MolarConc + S0.MolarConc * S1.MolarConc )";

        KmA   4.4e-3;
        KiA   4.7e-3;
        KmB   8.1e-3;
        KaM   3e-5;
        KiP   5.6e-3;
        KiQ   0.28e-3;
        kcat  37.16666666666666666666667;
    }

##  NH4+生成路  Glnase・GDH
##--------------------------
    Process ExpressionFluxProcess( Glnase ){

        VariableReferenceList
            [ S :.:Gln -1 ]
            [ A :.:PI 0 ]
            [ P :.:NH4 1 ]
            [ P1 :.:Glu 1 ]
            [ Glnase :.:Glnase 0 ];

        Expression  "(( kcat * Glnase.Value * pow( S.MolarConc, ns ))/( 1.0 + Ka / P.MolarConc )) / (( S_ + pow( S.MolarConc, ns )) * ( 1.0 + A_ / pow( A.MolarConc, na )))"; 

        S_    0.0005211518;
        A_    1.248109e-5;
        Ka    450e-6;
        ns    1.8;
        na    2.6;
        kcat  36.397766116;
}

    Process ExpressionFluxProcess( GDH ){    @# MetaNet2Process

        VariableReferenceList
            [ S0 :.:Glu  -1 ]
            [ S1 :.:NAD  -1 ]
            [ P0 :.:aKG   1 ]
            [ P1 :.:NH4   1 ]
            [ P2 :.:NADH  1 ]
            [ C0 :.:GDH   0 ];

        Expression  "C0.Value * @MetaNet_Yd_2x3 * ( geq( @MetaNet_Yd_2x3, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x3, 0.0 ) * kcatr )";

        kcatf @( 64850.0 / 60.0 );
        kcatr @( 11240.0 / 60.0 );
        KS0     1.8e-3;
        KS1     0.071e-3;
        KP0     0.7e-3;
        KP1     0.5e-3;
        KP2     0.03e-3;
    }

##  その他の反応  OAT・GOTm
##--------------------------
    Process ExpressionFluxProcess( OAT ){    @# MetaNet1Process

        VariableReferenceList
            [ S0 :.:Orn  0 ]
            [ S1 :.:aKG -1 ]
            [ P0 :.:P5C  1 ]
            [ P1 :.:Glu  1 ]
            [ C0 :.:OAT  0 ];   #Ornは使わないものとして考慮。

        Expression  "C0.Value * @MetaNet_Yd_2x2 * ( geq( @MetaNet_Yd_2x2, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x2, 0.0 ) * kcatr )";

        kcatf @( 8450.0 / 60.0 );
        kcatr @( 74.0 / 60.0 );
        KS0     1.1e-3;
        KS1     1.1e-3;
        KP0     0.1e-3;
        KP1     7.5e-3;
    }

    Process ExpressionFluxProcess( GOTm ){    @# MetaNet1Process
        
        VariableReferenceList
            [ S0 :.:Glu -1 ]
            [ S1 :.:OAA -1 ]
            [ P0 :.:Asp 1 ]
            [ P1 :.:aKG 1 ]
            [ C0 :.:GOT 0 ];

        Expression  "C0.Value * @MetaNet_Yd_2x2 * ( geq( @MetaNet_Yd_2x2, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x2, 0.0 ) * kcatr )";

    
        kcatf @( 32180 / 60.0 );
        kcatr @( 16400 / 60.0 );
        KS0 7.5e-3;
        KS1 0.0242e-3;
        KP0 1.12e-3;
        KP1 0.7e-3;
    }

##  CYT-MIT輸送 
##    -GATL・GTL・Glntr
##------------------------
    Process ExpressionFluxProcess( GATL ){    @# MetaNet1Process

        VariableReferenceList
            [ S0 :/CELL/CYT:Glu -1 ]
            [ S1 :.:Asp         -1 ]
            [ P0 :.:Glu          1 ]
            [ P1 :/CELL/CYT:Asp  1 ]
            [ C0 :.:GATL         0 ];

        Expression  "C0.Value * @MetaNet_Yd_2x2 * ( geq( @MetaNet_Yd_2x2, 0.0 ) * kcatf + lt( @MetaNet_Yd_2x2, 0.0 ) * kcatr )";

        kcatf @( 29000.0 / 60.0 );
        kcatr @( 29000.0 / 60.0 );
        KS0     1.6e-3;
        KS1     0.4e-3;
        KP0     1.6e-3;
        KP1     0.4e-3;
    }

    Process ExpressionFluxProcess( GTL ){    @# MetaNet4Process

        VariableReferenceList
            [ S0 :/CELL/CYT:Glu -1 ]
            [ P0 :.:Glu          1 ]
            [ C0 :.:GTL          0 ];

        Expression  "C0.Value * @MetaNet_Yd_1x1 * ( geq( @MetaNet_Yd_1x1, 0.0 ) * kcatf + lt( @MetaNet_Yd_1x1, 0.0 ) * kcatr )";

        kcatf @( 10200.0 / 60.0 );
        kcatr @( 10200.0 / 60.0 );
        KS0     4e-3;
        KP0     1.75e-3;
    }

    Process ExpressionFluxProcess( Glntr ){

        VariableReferenceList
            [ Gc :/CELL/CYT:Gln -1 ]
            [ Gm :.:Gln          1 ];

        Expression  "(( Keq * Gc.MolarConc - Gm.MolarConc )/( Keq + 1.0 )) * self.getSuperSystem().SizeN_A";

        Keq  6.75675675675675675675675676;
    }

#１：１の濃度対応
#    Process ExpressionFluxProcess( NH4tp ){
#
#        Expression  "((Keq * Gc.MolarConc - Gm.MolarConc)/(Keq + 1)) * self.getSuperSystem().SizeN_A";
# 
#    Keq 1;
#
#        VariableReferenceList
#            [Gc :/CELL/CYT:NH4 -1 ]
#            [Gm :.:NH4          1 ];
#    }

    Process ExpressionFluxProcess( Argtp ){

        VariableReferenceList
            [ Gc :/CELL/CYT:Arg -1 ]
            [ Gm :.:Arg          1 ];

        Expression  "(( Keq * Gc.MolarConc - Gm.MolarConc )/( Keq + 1.0 )) * self.getSuperSystem().SizeN_A";

        Keq  1.0;
    }

##  流入＆流出 Gluin・NAG/Pi/CoA
##------------------------------
    Process ExpressionFluxProcess( Gluin ){

        VariableReferenceList
            [ G :.:Glu -1 ];

        Expression  "( k * G.MolarConc -Rate ) * self.getSuperSystem().SizeN_A";

        Rate  6e-5;
        k     8.25186e-2;
    }

    Process ExpressionFluxProcess( NAGsink ){

        VariableReferenceList
            [ S :.:AcGlu -1 ];

        Expression  "k * S.Value";

        k  2.6546817361902436e-3;
    }

    Process ExpressionFluxProcess( Pisink ){

        VariableReferenceList
            [ S :.:PI -1 ];

        Expression  "k * S.Value";

        k  4.44222635095070566e-2;
    }

    Process ExpressionFluxProcess( CoAGsink ){

        VariableReferenceList
            [ S :.:CoA -1 ];

        Expression  "k * S.Value";

        k  4.750483106866752e-3;
    }

}  # End of System( /CELL/MIT )
