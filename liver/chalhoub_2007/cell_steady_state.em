#
# Chalhoub E, Hanson RW, Belovich JM.
# A computer model of gluconeogenesis and lipid metabolism in the perfused liver.
# Am J Physiol Endocrinol Metab. 2007 Dec;293(6):E1676-86. Epub 2007 Oct 2.
# PubMed PMID: 17911349.
#

@# Entityの名称はできるだけ論文の記載にあわせる（debugのため）
@# Entityの登場順序もできるだけ論文の記載にあわせる（debugのため）

@{
# mol/kgww hep → umol/gww hep
def C( x ):
	return "( %s.MolarConc * 1000.0 )" % x

# umol/gww hep → mol/kgww hep
def umol_gww( umol_gww ):
	return umol_gww / 1000.0


##### Table 1 #####

# Metabolite concentrations, umol/qww hep

Glc_tissue  = 6.3
# Glc_blood   = 5.55
Glc_blood   = 5.2627868852459017
F6P         = 0.039
F16P        = 0.0023
G6P         = 0.087
Glycogen    = 109.0
GAP         = 0.015
GR3P        = 0.25
PEP         = 0.0061
PYR_Blood   = 0.024
PYR_Tissue  = 0.023
LAC_Blood   = 0.59
LAC_Tissue  = 0.46
AcAc_Blood  = 1.47
AcAc_Tissue = 1.61
BHB__Blood  = 2.07
BHB_Tissue  = 5.6
ALA_Blood   = 0.23
ALA_Tissue  = 0.18
AcCoA       = 0.13
ATP         = 3.46
ANP         = 5.07      # ATP + ADP + AMP
NADHm_NADm  = 0.25      # NADH(m)/NAD(m)+
NADH_NAD    = 0.0021    # NADH(c)/NAD(c)+

# Fluxes, umol/gww hep/min

J_GLC_bt_net    =  1.11        # -0.789    △  
J_LAC_bt_net    = -1.38        #  1.30     ○
J_BHB_bt_net    =  1.09        #  1.09     ◎
J_ALA_bt_net    = -0.59        #  0.62     ○
J_PYR_bt_net    = -0.12        #  0.073    ○
J_FFA_bt_net    = -0.87        #  0.87     ◎  calculated
J_GLR_bt_net    = -0.96        #  0.096    ◎  -0.96は-0.096の誤りと判断。calculated
GK              =  0.57        #  0.557    ○
G6Pase          =  1.68        #  1.68     ◎
GI              =  1.07        #  1.10     ○
GAP_F16P        =  2.15 / 2    #  1.08     ○
FBPase          =  1.08        #  6.01     ×  式修正箇所あり, F16BP濃度に非常にsensitiveなので、これでいいのかも→ダメ！！！
PFK             =  0.007       #  0.000188 ×  ほぼゼロってことならいいのかも
PEP_GAP         =  2.08        #  1.90     △
PK              =  0.0003      #  0.000221 △
PYR_PEP         =  2.09        #  2.11     ○
LDH             =  1.38        #  1.42     ○
GLR_GR3P        =  0.099       #  0.100    ○  GLRの初期値を調整
GR3P_GAP        =  0.06        #  0.041    ○
FAT_syn         =  0.71 / 8    #  0.0854   ○
FFA_AcCoA       =  0.86        #  0.786    △
TG_f            =  0.11 / 3    #  0.0327   ○
AcCoA_AcAc      =  4.83 / 2    #  2.37     ○
OxPhos          =  8.20        #  5.04     △
TCA             =  1.37        #  1.37     ◎
J_TG_bt_net     =  0.03
PDC             =  0.0023      #  0.00446  △

# upstream blood concentrations, mM

C_star_Glc  = 4.6
C_star_LAC  = 1.7
C_star_PYR  = 0.12
C_star_FFA  = 1.5
C_star_AcAc = 0.43
C_star_BHB  = 1.2

# physical parameters

F_blood  = 6.57     # ml/min
V_tissue = 5.25     # cm^3
V_blood  = 1.03     # cm^3


##### Table S1 #####

C_AMP       = 0.125      # umol/qww hep
C_cAMP      = 0.0094     # umol/qww hep
C_Pi        = 5.74       # umol/qww hep
C_F26BP     = 0.00013    # umol/qww hep
C_NH4       = 0.7        # umol/qww hep
C_CoA       = 0.25       # umol/qww hep
C_ANP_total = 5.08       # umol/qww hep, (C_ATP + C_ADP + C_AMP)total
C_NADH_NAD  = 1.50       # umol/qww hep, (C_NADH + C_NAD)total
Keq_RS      = 112.0      # dimensionless

PS          = "( ADP.MolarConc / ATP.MolarConc )"
RS          = "( NADH.MolarConc / NAD.MolarConc )"
RSm         = "( %f * %s )" % ( Keq_RS, RS )

PSi         = 0.44       # stady state C_ADP/C_ATP
RSi         = 0.2        # stady state C_NADH/C_NAD   ←Table S1 では C_NADHm/C_NADm としている

# R_GK
Vmax_GK = 2.19   # umol/gww hep/min
Km_GK   = 6.25   # umol/gww hep                   ←← equal to steady state GLC conc. とあるが、齟齬がある。

# R_GAP_F16BP
Vmax_GAP_F16BP = 4.97    # umol/gww hep/min
Km_GAP_F16BP   = 0.0194  # umol/gww hep

# R_GLR_GR3P
Vmax_GLR_GR3P = 0.79       # umol/gww hep/min
Km_GLR_GR3P   = 0.125      # umol/qww hep
GLR = Km_GLR_GR3P / 3.0    # R_GLR_GR3P,ss = 0.099 より

FFA = 0.36     # umol/qww hep, Km,FFA,AcCoAより
TG  = 0.0071   # umol/qww hep, Km,TG,FFAより

O2  = 7.3      # umol/qww hep, Km,OxPhosより

#J_GLC_bt_net
Vmax_GLC_bt = 17.8     # umol/gww hep/min
Km_GLC_bt   = 5.07     # umol/gww hep

#J_LAC_bt_net
Vmax_LAC_bt = 22.5     # umol/gww hep/min
Km_LAC_bt   = 1.2      # umol/gww hep

#J_FFA_bt_net
Vmax_FFA_bt = 4.7      # umol/gww hep/min
Km_FFA_bt   = 0.67     # umol/gww hep

FFA_Blood   = 0.67574412532637074  # umol/gww hep

#J_GLR_bt_net
Vmax_GLR_bt = 2.53     # umol/gww hep/min
Km_GLR_bt   = 0.16     # umol/gww hep

GLR_Blood   = 0.051264037250068478  # umol/gww hep

#J_TG_bt_net
Vmax_TG_bt = 0.044     # umol/gww hep/min
Km_TG_bt   = 0.4       # umol/gww hep

TG_Blood   = 0.0  # umol/gww hep

#J_ALA_bt_net
Vmax_ALA_bt = 12.0     # umol/gww hep/min
Km_ALA_bt   = 0.56     # umol/gww hep

#J_BHB_bt_net
Vmax_BHB_bt = 2.64     # umol/gww hep/min
Km_BHB_bt   = 0.85     # umol/gww hep

#J_pyr_bt_net
Vmax_PYR_bt = 8.0      # umol/gww hep/min
Km_PYR_bt   = 0.062    # umol/gww hep

#J_AcAc_bt_net
Vmax_AcAc_bt = 34.8125 # umol/gww hep/min
Km_AcAc_bt   = 0.7     # umol/gww hep

}


Stepper FixedODE1Stepper( ODE )
{
	StepInterval @( 0.001 / 60.0 );
}

Stepper PassiveStepper( PSV ){}

System System( / )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		# no property
	}

}

System System( /TISSUE )
{
	StepperID	ODE;

	###### Variable #####

	Variable Variable( SIZE )
	{
		Value	@( V_tissue/1000.0 );  @# cm^3 → L
	}

	Variable Variable( GLC )
	{
		MolarConc  @umol_gww( Glc_tissue );
		# MolarConc  @umol_gww( Km_GK );
	}

	Variable Variable( F6P )
	{
		MolarConc  @umol_gww( F6P );
	}

	Variable Variable( F16BP )
	{
		MolarConc  @umol_gww( F16P );
	}

	Variable Variable( G6P )
	{
		MolarConc  @umol_gww( G6P );
	}

	Variable Variable( Glyc )
	{
		MolarConc  @umol_gww( Glycogen );
		Fixed  1;  @# Table S1
	}

	Variable Variable( GAP )
	{
		MolarConc  @umol_gww( GAP );
	}

	Variable Variable( GR3P )
	{
		MolarConc  @umol_gww( GR3P );
	}

	Variable Variable( PEP )
	{
		MolarConc  @umol_gww( PEP );
	}

	Variable Variable( PYR )
	{
		MolarConc  @umol_gww( PYR_Tissue );
	}

	Variable Variable( LAC )
	{
		MolarConc  @umol_gww( LAC_Tissue );
	}

	Variable Variable( AcAc )
	{
		MolarConc  @umol_gww( AcAc_Tissue );
	}

	Variable Variable( BHB )
	{
		MolarConc  @umol_gww( BHB_Tissue );
	}

	Variable Variable( ALA )
	{
		MolarConc  @umol_gww( ALA_Tissue );
	}

	Variable Variable( AcCoA )
	{
		MolarConc  @umol_gww( AcCoA );
	}

	Variable Variable( ATP )
	{
		MolarConc  @umol_gww( ATP );   @# Table 1の初期値
		# MolarConc  @umol_gww( ( ANP - C_AMP ) * 1.0 / ( 1.0 + PSi ) );   @# PSiから計算
		Fixed  1;  @# 定常探索のため仮固定
	}

	Variable Variable( ANP )
	{
		MolarConc  @umol_gww( ANP );
		Fixed  1;  @# Table S1
	}

	Variable Variable( ADP )
	{
		MolarConc  @umol_gww( ANP - ATP - C_AMP );   @# Table 1の初期値
		# MolarConc  @umol_gww( ANP - ( ANP - C_AMP ) * 1.0 / ( 1.0 + PSi ) - C_AMP );   @# PSiから計算
		Fixed  1;  @# 定常探索のため仮固定
	}

	Variable Variable( AMP )
	{
		MolarConc  @umol_gww( C_AMP );
		Fixed  1;  @# Table S1
	}

	Variable Variable( cAMP )
	{
		MolarConc  @umol_gww( C_cAMP );
		Fixed  1;  @# Table S1
	}

	Variable Variable( Pi )
	{
		MolarConc  @umol_gww( C_Pi );
		Fixed  1;  @# Table S1
	}

	Variable Variable( F26BP )
	{
		MolarConc  @umol_gww( C_F26BP );
		Fixed  1;  @# Table S1
	}

	Variable Variable( NH4 )
	{
		MolarConc  @umol_gww( C_NH4 );
		Fixed  1;  @# Table S1
	}

	Variable Variable( CoA )
	{
		MolarConc  @umol_gww( C_CoA );
		Fixed  1;  @# Table S1
	}

	Variable Variable( NADH_NAD )
	{
		MolarConc  @umol_gww( C_NADH_NAD );
		Fixed  1;  @# Table S1
	}

	Variable Variable( NAD )
	{
		MolarConc  @umol_gww( C_NADH_NAD / ( 1.0 + NADH_NAD ) );
		Fixed  1;  @# 定常探索のため仮固定
	}

	Variable Variable( NADH )
	{
		MolarConc  @umol_gww( C_NADH_NAD * NADH_NAD / ( 1.0 + NADH_NAD ) );
		Fixed  1;  @# 定常探索のため仮固定
	}

	Variable Variable( FFA )
	{
		MolarConc  @umol_gww( FFA );
	}

	Variable Variable( TG )
	{
		MolarConc  @umol_gww( TG );
	}

	Variable Variable( GLR )
	{
		MolarConc  @umol_gww( GLR );
	}

	Variable Variable( O2 )
	{
		MolarConc  @umol_gww( O2 );
		Fixed  1;  @# Table S1
	}


	###### Process #####

	Process ExpressionFluxProcess( R_GK ) @# Table S1
	{
		VariableReferenceList
			[ GLC :.:GLC -1 ]
			[ ATP :.:ATP -1 ]
			[ G6P :.:G6P  1 ]
 			[ ADP :.:ADP  1 ];

		Expression  "Vmax * GLC.Value / ( Km + @C( 'GLC' ) ) * ( 1.0/@PS / ( 1.0/@PSi + 1.0/@PS ))";

		Vmax  @Vmax_GK;
		Km    @Km_GK;   @# umol/gww hep         
	}

	Process ExpressionFluxProcess( R_G6Pase ) @# Table S1, MolarActivity OK (20110420)
	{
		VariableReferenceList
			[ G6P :.:G6P -1 ]
			[ GLC :.:GLC  1 ];

		Expression  "Vmax * G6P.Value / ( Km + @C( 'G6P' ) )";

		Vmax  3.65;   @# umol/gww hep/min
		Km    0.102;  @# umol/gww hep
	}

	Process ExpressionFluxProcess( R_GI ) @# Table S1
	{
		VariableReferenceList
			[ G6P :.:G6P  1 ]
			[ F6P :.:F6P -1 ];

		Expression  "Vmax_G6P / Km_F6P * ( F6P.Value - G6P.Value / Keq) / ( 1.0 + @C( 'F6P' ) / Km_F6P + @C( 'G6P' ) / Km_G6P )";

		Vmax_G6P  32.8;   @# umol/gww hep/min
		Km_F6P    0.046; @# umol/gww hep
		Km_G6P    0.10;   @# umol/gww hep
		Keq       2.5;    @# dimensionless
	}

	Process ExpressionFluxProcess( R_FBPase ) @# Table S1
	{
		VariableReferenceList
			[ F16BP :.:F16BP -1 ]
			[ F6P   :.:F6P    1 ]
			[ F26BP :.:F26BP  0 ]
			[ cAMP  :.:cAMP   0 ]
			[ AMP   :.:AMP    0 ];

@{
mu_FBPase    = "( %s / K_F16BP )"  % C( 'F16BP' )  # μ
beta_FBPase  = "( %s / Ki_F26BP )" % C( 'F26BP' )  # β
gamma_FBPase = "( %s / Ki_cAMP )"  % C( 'cAMP' )   # γ
delta_FBPase = "( %s / Ki_AMP )"   % C( 'AMP' )    # δ
}

		Expression  "Vmax * F16BP.Value / K_F16BP * pow( 1.0 + @mu_FBPase, n ) / pow( 1.0 + @beta_FBPase, n ) / pow( 1.0 + @delta_FBPase, n ) * pow( 1.0 + @beta_FBPase * @gamma_FBPase + @delta_FBPase * @gamma_FBPase, n ) / ( L * pow( 1.0 + @beta_FBPase, n ) / pow( 1.0 + C_FBP * @gamma_FBPase, n ) + pow( 1.0 + @mu_FBPase, n ))";

		@# σは、δのtypoと判断
		@# n_fgbp, n_fbpは、n_FBPのtypoと判断
		@# 要チェック: (1 + β^n) or (1 + β)^n

		Vmax       20.0;      @# umol/gww hep/min
		K_F16BP    4.84e-4;   @# umol/gww hep
		Ki_cAMP    9.23e-3;   @# umol/gww hep
		Ki_F26BP   1.56e-2;   @# umol/gww hep
		Ki_AMP     0.106;     @# umol/gww hep
		n          5.52;      @# dimensionless
		L          2.76e+6;   @# dimensionless
		C_FBP      0.56;      @# dimensionless
	}

	Process ExpressionFluxProcess( R_PFK ) @# Table S1
	{
		VariableReferenceList
			[ F6P   :.:F6P   -1 ]
			[ ATP   :.:ATP   -1 ]
			[ F16BP :.:F16BP  1 ]
			[ ADP   :.:ADP    1 ]
			[ F26BP :.:F26BP  0 ]
			[ AMP   :.:AMP    0 ];

@{
T1_PFK = "( alpha * ( Ki_F26BP + %s ) / ( Ki_F26BP + Q1 * %s ))" % ( C( 'F26BP' ), C( 'F26BP' ) )
T2_PFK = "( sigma * ( Ki_AMP + %s ) / ( Ki_AMP + Q2 * %s ))" % ( C( 'AMP' ), C( 'AMP' ) )
K_PFK  = "( Kapp_F6P * pow(( %s + K_ATP + pow( %s, n1 ) * pow( %s, 2.0 ) / Ki_ATP ), 2.0 ) * ( 1.0 + pow( %s, n2 ) + pow( %s, n1 )))" % ( C( 'ATP' ), T1_PFK, C( 'ATP' ), T2_PFK, T1_PFK )
}
		Expression  "Vmax * ATP.Value * @C( 'F6P' ) * @C( 'F6P' ) / ( @K_PFK + @C( 'ATP' ) * @C( 'F6P' ) * @C( 'F6P' ) )";

		Vmax      3.75;    @# umol/gww hep/min
		K_ATP     3.91e-2; @# umol/gww hep
		Ki_ATP    0.058;   @# umol/gww hep
		Ki_AMP    1.16;    @# umol/gww hep
		Kapp_F6P  4.0e-4;  @# umol/gww hep
		Ki_F26BP  1.7e-2;  @# umol/gww hep
		alpha     2.0;     @# dimensionless
		sigma     3.5;     @# dimensionless
		n1        3.0;     @# dimensionless
		n2        3.0;     @# dimensionless
		Q1        100.0;   @# dimensionless
		Q2        50.0;    @# dimensionless
	}

	Process ExpressionFluxProcess( R_PK ) @# Table S1
	{
		VariableReferenceList
			[ PEP   :.:PEP   -1 ]
			[ ADP   :.:ADP   -1 ]
			[ PYR   :.:PYR    1 ]
			[ ATP   :.:ATP    1 ]
			[ ALA   :.:ALA    0 ]
			[ F16BP :.:F16BP  0 ];

@{
pi_PK    = "( %s / K_PEP )" % C( 'PEP' )      # π
gamma_PK = "( %s / K_ATP )" % C( 'ATP' )      # γ
beta_PK  = "( %s / Ki_ALA )" % C( 'ALA' )     # β
phi_PK   = "( %s / K_FBP )" % C( 'F16BP' )    # φ
}

		Expression  "Vmax * PEP.Value / K_PEP * pow( 1.0 + @pi_PK + @gamma_PK, ( n - 1.0 )) / ( Lp * pow( 1.0 + @beta_PK, n ) * pow( 1.0 + kappa_ATP * @gamma_PK, n ) / pow( 1.0 + kappa_ALA * @beta_PK, n ) / pow( 1.0 + @phi_PK, n ) + pow( 1.0 + @pi_PK + @gamma_PK, n ))";

		Vmax       62.5;     @# umol/gww hep/min
		K_PEP      3.2e-2;   @# umol/gww hep
		K_ATP      0.435;    @# umol/gww hep
		Ki_ALA     1.16e-1;  @# umol/gww hep
		K_FBP      5.80e-4;  @# umol/gww hep
		Lp         1.60e+4;  @# dimensionless
		n          3.10;     @# dimensionless
		kappa_ATP  2.0;      @# dimensionless
		kappa_ALA  0.2;      @# dimensionless
	}

	Process ExpressionFluxProcess( R_LDH ) @# Table S1
	{
		VariableReferenceList
			[ LAC  :.:LAC   -1 ]
			[ NAD  :.:NAD   -1 ]
			[ PYR  :.:PYR    1 ]
			[ NADH :.:NADH   1 ];

		Expression  "Vmax / Km_LAC * ( LAC.Value * @C( 'NAD' ) - PYR.Value * @C( 'NADH' ) / Keq ) / ( 1.0 + @C( 'LAC' ) * @C( 'NAD' ) / Km_LAC + @C( 'PYR' ) * @C( 'NADH' ) / Km_PYR )";

		Vmax    195.0;    @# umol/gww hep/min
		Km_LAC  1.43;     @# umol/gww hep       ←単位があやしい
		Km_PYR  4.77e-5;  @# umol/gww hep       ←単位があやしい
		Keq     1.1e-4;   @# dimensionless

	}

	Process ExpressionFluxProcess( R_ALA_PYR ) @# Table S1
	{
		VariableReferenceList
			[ ALA  :.:ALA   -1 ]
			[ NAD  :.:NAD   -1 ]
			[ PYR  :.:PYR    1 ]
			[ NADH :.:NADH   1 ];

		Expression  "Vmax / Km_ALA * ( ALA.Value * @C( 'NAD' ) - @C( 'PYR' ) * @C( 'NADH' ) / Keq ) / ( 1.0 + @C( 'ALA' ) * @C( 'NAD' ) / Km_ALA + @C( 'PYR' ) * @C( 'NADH' ) / Km_PYR )";

		Vmax    300.0;    @# umol/gww hep/min
		Km_ALA  0.71;     @# umol/gww hep       ←単位があやしい
		Km_PYR  2.4e-7;  @# umol/gww hep       ←単位があやしい
		Keq     2.5e-3;   @# dimensionless
	}

	Process ExpressionFluxProcess( R_PYR_PEP ) @# Table S1    ←←NaN発生源！！！
	{
		VariableReferenceList
			[ PYR   :.:PYR   -1 ]
			[ ATP   :.:ATP   -1 ]
		@#	[ GTP   :.:GTP   -1 ]
			[ PEP   :.:PEP    1 ]
			[ ADP   :.:ADP    1 ]
		@#	[ GDP   :.:GDP    1 ]
			[ Pi    :.:Pi     1 ]
		@#	[ CO2   :.:CO2    1 ]
			[ AcCoA :.:AcCoA  0 ];

@{
omega_PC = "( 1.0 / ( 1.0 + pow( %s, n3 ) / Ka_AcCoA ) + K_ATP / Ki_ADP_ATP * %s / pow( %s, n1 ) )" % ( C( 'AcCoA' ), C( 'ADP' ), C( 'ATP' ) )
}

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A / ( 1.0 + @C( 'ADP' ) / Ki_ADP_PYR ) / ( 1.0 + K_ATP / pow( @C( 'ATP' ), n1 ) + K_PYR / ( pow( @C( 'PYR' ), n2 ) * ( 1.0 + @C( 'ADP' ) / Ki_ADP_PYR )) * @omega_PC )";

		Vmax        12.4;     @# umol/gww hep/min
		K_ATP       0.034;    @# (umol/gww hep)^1.03
		K_PYR       7.1;      @# (umol/gww hep)^0.8
		Ki_ADP_PYR  1.74;     @# umol/gww hep
		Ki_ADP_ATP  0.521;    @# umol/gww hep
		Ka_AcCoA    2.28e-5;  @# (umol/gww hep)^1.65
		n1          1.03;     @# dimensionless
		n2          0.80;     @# dimensionless
		n3          1.65;     @# dimensionless
	}

	Process ExpressionFluxProcess( R_PEP_GAP ) @# Table S1
	{
		VariableReferenceList
			[ PEP  :.:PEP   -1 ]
			[ ATP  :.:ATP   -1 ]
			[ NADH :.:NADH  -1 ]
			[ GAP  :.:GAP    1 ]
			[ ADP  :.:ADP    1 ]
			[ NAD  :.:NAD    1 ]
			[ Pi   :.:Pi     1 ];

		Expression  "Vmax / Km_PEP * ( PEP.Value * @C( 'NADH' ) * @C( 'ATP' ) - GAP.Value * @C( 'Pi' ) * @C( 'NAD' ) * @C( 'ADP' ) / Keq ) / ( 1.0 + @C( 'PEP' ) * @C( 'NADH' ) * @C( 'ATP' ) / Km_PEP + @C( 'GAP' ) * @C( 'Pi' ) * @C( 'NAD' ) * @C( 'ADP' ) / Km_GAP )";

		Vmax    94.0;     @# umol/gww hep/min
		Km_PEP  4.3e-5;   @# umol/gww hep
		Km_GAP  9.13e-3;  @# umol/gww hep
		Keq     4166.0;   @# dimensionless
	}

	Process ExpressionFluxProcess( R_GAP_F16BP ) @# Table S1
	{
		VariableReferenceList
			[ GAP   :.:GAP   -2 ]             # ←←論文では -1 だが、-2 が正解と思われる
			[ F16BP :.:F16BP  1 ];

		Expression  "Vmax * GAP.Value / ( Km + @C( 'GAP' ) )";

		Vmax  @( Vmax_GAP_F16BP / 2.0 );
		Km    @Km_GAP_F16BP;
	}

	Process ExpressionFluxProcess( R_PDC ) @# Table S1
	{
		VariableReferenceList
			[ PYR   :.:PYR   -1 ]
			[ NAD   :.:NAD   -1 ]
			[ AcCoA :.:AcCoA  1 ]
			[ NADH  :.:NADH   1 ]
			[ ATP   :.:ATP    0 ]
			[ ADP   :.:ADP    0 ]
			[ CoA   :.:CoA    0 ];

		Expression  "Vmax * PYR.Value / ( 1.0 + alpha / @PS ) / ( 1.0 + beta * @C( 'AcCoA' ) / @C( 'CoA' ) + delta * pow( @RSm, 2.0 )) / ( K + @C( 'PYR' ) )";

		Vmax   1.88;  @# umol/gww hep/min
		K      0.20;  @# umol/gww hep
		alpha  0.9;   @# dimensionless
		beta   25.0;  @# dimensionless
		delta  0.50;  @# dimensionless
	}

	Process ExpressionFluxProcess( R_FFA_AcCoA ) @# Table S1
	{
		VariableReferenceList
			[ FFA   :.:FFA   -1 ]
			[ ATP   :.:ATP   -2 ]
			[ NAD   :.:NAD   -7 ]
		@#	[ FAD   :.:FAD   -7 ]
			[ AcCoA :.:AcCoA  8 ]
			[ NADH  :.:NADH   7 ]
		@#	[ FADH  :.:FADH   7 ]
			[ ADP   :.:ADP    2 ];

		Expression  "Vmax * FFA.Value / ( Km + @C( 'FFA' ) ) * ( 1.0 / @RSm / ( 1.0 / @RSi + 1.0 / @RSm )) * ( 1.0 / @PS / ( 1.0 / @PSi + 1.0 / @PS ))";

		Vmax   6.76;  @# umol/gww hep/min
		Km     @FFA;  @# umol/gww hep
	}

	Process ExpressionFluxProcess( R_TG_FFA ) @# Table S1
	{
		VariableReferenceList
			[ TG  :.:TG  -1 ]
			[ FFA :.:FFA  1 ];

		Expression  "Vmax * TG.Value / ( Km + @C( 'TG' ) )";

		Vmax  3.67;  @# umol/gww hep/min
		Km    @TG;   @# umol/gww hep
	}

	Process ExpressionFluxProcess( R_GLR_GR3P ) @# Table S1
	{
		VariableReferenceList
			[ GLR  :.:GLR  -1 ]
			[ ATP  :.:ATP  -1 ]
			[ GR3P :.:GR3P  1 ]
			[ ADP  :.:ADP   1 ];

		Expression  "Vmax * GLR.Value / ( Km + @C( 'GLR' ) ) * ( 1.0 / @PS / ( 1.0 / @PSi + 1.0 / @PS ))";

		Vmax   @Vmax_GLR_GR3P;
		Km     @Km_GLR_GR3P;
	}

	Process ExpressionFluxProcess( R_GR3P_GAP ) @# Table S1
	{
		VariableReferenceList
			[ GR3P :.:GR3P -1 ]
			[ NAD  :.:NAD  -1 ]
			[ GAP  :.:GAP   1 ]
			[ NADH :.:NADH  1 ];

		Expression  "Vmax / Km_GR3P * ( GR3P.Value * @C( 'NAD' ) - GAP.Value * @C( 'NADH' ) / Keq ) / ( 1.0 + @C( 'GR3P' ) * @C( 'NAD' ) / Km_GR3P + @C( 'GAP' ) * @C( 'NADH' ) / Km_GAP )";

		Vmax     115.0;    @# umol/gww hep/min
		Km_GR3P  0.47;     @# umol/gww hep
		Km_GAP   7.06e-7;  @# umol/gww hep
		Keq      1.3e-4;   @# dimensionless
	}

	Process ExpressionFluxProcess( R_FA_syn ) @# Table S1
	{
		VariableReferenceList
			[ AcCoA :.:AcCoA -8 ]
			[ ATP   :.:ATP   -7 ]
			[ FFA   :.:FFA    1 ]
			[ ADP   :.:ADP    7 ];

		Expression  "Vmax * AcCoA.Value / ( Km + @C( 'AcCoA' ) ) * ( 1.0 / @PS / ( 1.0 / @PSi + 1.0 / @PS ))";

		Vmax   @( 2.7 / 8.0 );   @# umol/gww hep/min
		Km     0.13;  @# umol/gww hep
	}

	Process ExpressionFluxProcess( R_TG_f ) @# Table S1
	{
		VariableReferenceList
			[ FFA  :.:FFA  -3 ]
			[ ATP  :.:ATP  -2 ]
			[ GR3P :.:GR3P -1 ]
			[ TG   :.:TG    1 ]
			[ ADP  :.:ADP   2 ];

		Expression  "Vmax * GR3P.Value * @C( 'FFA' ) / ( Km + @C( 'GR3P' ) * @C( 'FFA' ) ) * ( 1.0 / @PS / ( 1.0 / @PSi + 1.0 / @PS ))";

		Vmax   @( 0.43 / 3.0 );   @# umol/gww hep/min
		Km     0.11;  @# umol/gww hep         ←← product of steady state FFA and GR3P conc. とあるが、齟齬がある。
	}

	Process ExpressionFluxProcess( R_TCA ) @# Table S1
	{
		VariableReferenceList
			[ AcCoA :.:AcCoA -8 ]
			[ ADP   :.:ADP   -1 ]
			[ NAD   :.:NAD   -3 ]
		@#	[ FAD   :.:FAD   -1 ]
		@#	[ CO2   :.:CO2   16 ]
			[ ATP   :.:ATP    1 ]
			[ NADH  :.:NADH   3 ];
		@#	[ FADH  :.:FADH   1 ]

		Expression  "Vmax * AcCoA.Value * ( epsilon * 1.0 / @RSm / ( 1.0 / @RSi + 1.0 / @RSm ) + ( 1.0 - epsilon ) * 1.0 / @PS / ( 1.0 / @PSi + 1.0 / @PS ))";

		Vmax     @( 22.33 / 8.0 );  @# umol/gww hep/min
		epsilon  0.75;              @# dimensionless
	}

	Process ExpressionFluxProcess( R_AcCoA_AcAc ) @# Table S1
	{
		VariableReferenceList
			[ AcCoA :.:AcCoA -2 ]
			[ AcAc  :.:AcAc   1 ]
			[ CoA   :.:CoA    2 ];

		Expression  "Vmax * AcCoA.Value / ( Km + @C( 'AcCoA' ) )";

		Vmax   @( 9.28 / 2.0 );   @# umol/gww hep/min
		Km     0.124;  @# umol/gww hep         ←← equal to steady state AcCoA conc. とあるが、齟齬がある。
	}

	Process ExpressionFluxProcess( R_BHBdh ) @# Table S1
	{
		VariableReferenceList
			[ AcAc :.:AcAc -1 ]
			[ NADH :.:NADH -1 ]
			[ BHB  :.:BHB   1 ]
			[ NAD  :.:NAD   1 ];

		Expression  "Vmax / Km_AcAc * ( AcAc.Value * @C( 'NADH' ) - BHB.Value * @C( 'NAD' ) / Keq ) / ( 1.0 + @C( 'AcAc' ) * @C( 'NADH' ) / Km_AcAc + @C( 'BHB' ) * @C( 'NAD' ) / Km_BHB )";

		Vmax     60.0;    @# umol/gww hep/min
		Km_AcAc  0.0071;  @# umol/gww hep
		Km_BHB   0.0059;  @# umol/gww hep
		Keq      20.0;    @# dimensionless
	}

	Process ExpressionFluxProcess( R_OxPhos ) @# Table S1
	{
		VariableReferenceList
			[ O2   :.:O2   -1 ]
			[ ADP  :.:ADP  -5 ]
			[ NADH :.:NADH -2 ]
		@#	[ H20  :.:H20   2 ]
			[ ATP  :.:ATP   5 ]
			[ NAD  :.:NAD   2 ];

		Expression  "Vmax * O2.Value / ( Km + @C( 'O2' ) ) * ( @PS / ( @PS + @PSi )) * ( @RSm / ( @RSi + @RSm ))";

		Vmax   37.8;  @# umol/gww hep/min
		Km     @O2;   @# umol/gww hep
	}

	Process ExpressionFluxProcess( R_urea ) @# Table S1
	{
		VariableReferenceList
			[ NH4  :.:NH4  -2 ]
		@#	[ HCO3 :.:HCO3 -1 ]
			[ ATP  :.:ATP  -3 ]
		@#	[ urea :.:urea  1 ]
			[ ADP  :.:ADP   2 ]
			[ Pi   :.:Pi    2 ]
			[ AMP  :.:AMP   1 ];
		@#	[ PPi  :.:PPi   1 ]

		Expression  "Vmax * NH4.Value / ( Km + @C( 'NH4' ) ) * ( 1.0 / @PS / ( 1.0 / @PSi + 1.0 / @PS ))";

		Vmax   2.57;  @# umol/gww hep/min
		Km     0.70;  @# umol/gww hep
	}

	Process ExpressionFluxProcess( R_Glyc_G6P ) @# Table S1
	{
		VariableReferenceList
			[ Glyc :.:Glyc -1 ]
			[ G6P  :.:G6P   1 ];

		Expression  "0.0358 * 1.0e-3 * self.getSuperSystem().SizeN_A";  @# umol/gww hep/min
	}


	##### Blood <--> Tissue Transport Rate #####

	Process ExpressionFluxProcess( J_GLC_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:GLC  -1 ]
			[ t :/TISSUE:GLC  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_GLC_bt;
		Km    @Km_GLC_bt;
	}

	Process ExpressionFluxProcess( J_LAC_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:LAC  -1 ]
			[ t :/TISSUE:LAC  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_LAC_bt;
		Km    @Km_LAC_bt;
	}

	Process ExpressionFluxProcess( J_FFA_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:FFA  -1 ]
			[ t :/TISSUE:FFA  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_FFA_bt;
		Km    @Km_FFA_bt;
	}

	Process ExpressionFluxProcess( J_GLR_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:GLR  -1 ]
			[ t :/TISSUE:GLR  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_GLR_bt;
		Km    @Km_GLR_bt;
	}

	Process ExpressionFluxProcess( J_TG_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:TG  -1 ]
			[ t :/TISSUE:TG  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_TG_bt;
		Km    @Km_TG_bt;
	}

	Process ExpressionFluxProcess( J_ALA_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:ALA  -1 ]
			[ t :/TISSUE:ALA  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_ALA_bt;
		Km    @Km_ALA_bt;
	}

	Process ExpressionFluxProcess( J_BHB_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:BHB  -1 ]
			[ t :/TISSUE:BHB  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_BHB_bt;
		Km    @Km_BHB_bt;
	}

	Process ExpressionFluxProcess( J_pyr_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:PYR  -1 ]
			[ t :/TISSUE:PYR  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_PYR_bt;
		Km    @Km_PYR_bt;
	}

	Process ExpressionFluxProcess( J_AcAc_bt_net ) @# Table S1
	{
		VariableReferenceList
			[ b :/BLOOD:AcAc  -1 ]
			[ t :/TISSUE:AcAc  1 ];

		Expression  "Vmax * 1.0e-3 * self.getSuperSystem().SizeN_A * ( @C( 'b' ) - @C( 't' )) / ( Km + @C( 'b' ) + @C( 't' ))";

		Vmax  @Vmax_AcAc_bt;
		Km    @Km_AcAc_bt;
	}

}

System System( /BLOOD )
{
	StepperID	ODE;


	Variable Variable( SIZE )
	{
		Value	@( V_blood/1000.0 );  @# cm^3 → L
	}

	Variable Variable( GLC )
	{
		MolarConc  @umol_gww( Glc_blood );
		Fixed  1;
	}

	Variable Variable( PYR )
	{
		MolarConc  @umol_gww( PYR_Blood );
		Fixed  1;
	}

	Variable Variable( LAC )
	{
		MolarConc  @umol_gww( LAC_Blood );
		Fixed  1;
	}

	Variable Variable( AcAc )
	{
		MolarConc  @umol_gww( AcAc_Blood );
		Fixed  1;
	}

	Variable Variable( BHB )
	{
		MolarConc  @umol_gww( BHB__Blood );
		Fixed  1;
	}

	Variable Variable( ALA )
	{
		MolarConc  @umol_gww( ALA_Blood );
		Fixed  1;
	}

	Variable Variable( FFA )
	{
		MolarConc  @umol_gww( FFA_Blood );
		Fixed  1;
	}

	Variable Variable( GLR )
	{
		MolarConc  @umol_gww( GLR_Blood );
		Fixed  1;
	}

	Variable Variable( TG )
	{
		MolarConc  @umol_gww( TG_Blood );
		Fixed  1;
	}
}

System System( /PERFUSATE )
{
	StepperID	ODE;


	Variable Variable( SIZE )
	{
		Value	1.0; @# とりあえずの値 論文の値に修正すること
	}
}
