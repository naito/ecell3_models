
# created by eml2em program
# from file: Lambeth_amano.nearlySteady120328.eml, date: Wed Mar 28 14:34:00 2012
#

Stepper DiscreteTimeStepper( DT )
{
	MaxStepInterval	inf;
	MinStepInterval	1e-100;
	NextTime	3.00000000369;
	Priority	0;
	StepInterval	1.0000000028e-07;
}

Stepper FixedODE1Stepper( ODE )
{
	MaxStepInterval	inf;
	MinStepInterval	1e-100;
	NextTime	3.0000001;
	Priority	0;
	StepInterval	9.99999998363e-08;
}

Stepper PassiveStepper( PSV )
{
	MaxStepInterval	inf;
	MinStepInterval	1e-100;
	NextTime	inf;
	Priority	0;
	StepInterval	inf;
}

System System( / )
{
	Name	"The Root System";
	StepperID	ODE;

	Variable Variable( SIZE )
	{
		DiffusionCoeff	6.93768071338e-310;
		Fixed	0;
		Value	1.0;
	}
	
	
}

System System( /CELL )
{
	StepperID	ODE;
}

System System( /CELL/GLYCOGENOLYSIS )
{
	StepperID	ODE;

	Variable Variable( ADP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.013;
	}
	
	Variable Variable( AMP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1e-05;
	}
	
	Variable Variable( ATP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	8.2;
	}
	
	Variable Variable( Cr )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	39.9862584551;
	}
	
	Variable Variable( DHAP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.28955634555e-06;
	}
	
	Variable Variable( D_GAPDH )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	142.31742832;
	}
	
	Variable Variable( F6P )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.247410951384;
	}
	
	Variable Variable( FBP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.00695113348482;
	}
	
	Variable Variable( G1P )
	{
		DiffusionCoeff	2.18436024291e-314;
		Fixed	0;
		Value	0.0369279341364;
	}
	
	Variable Variable( G6P )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.551614004414;
	}
	
	Variable Variable( GAP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	6.00238333705e-06;
	}
	
	Variable Variable( GLY )
	{
		DiffusionCoeff	2.1843597607e-314;
		Fixed	0;
		Value	112.0;
	}
	
	Variable Variable( K13BPG_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0008;
	}
	
	Variable Variable( K13BPG_PGK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.002;
	}
	
	Variable Variable( K2PG_EN )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.1;
	}
	
	Variable Variable( K2PG_PGM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.014;
	}
	
	Variable Variable( K3PG_PGK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.2;
	}
	
	Variable Variable( K3PG_PGM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.2;
	}
	
	Variable Variable( KADP_ADK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.35;
	}
	
	Variable Variable( KADP_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.7;
	}
	
	Variable Variable( KADP_PGK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.008;
	}
	
	Variable Variable( KADP_PK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.3;
	}
	
	Variable Variable( KAMP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.32;
	}
	
	Variable Variable( KATP_ADK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.27;
	}
	
	Variable Variable( KATP_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.08;
	}
	
	Variable Variable( KATP_PGK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.35;
	}
	
	Variable Variable( KATP_PK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.13;
	}
	
	Variable Variable( KCr )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	3.8;
	}
	
	Variable Variable( KDHAP_ALD )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	2.0;
	}
	
	Variable Variable( KDHAP_TPI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.61;
	}
	
	Variable Variable( KF6P_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.18;
	}
	
	Variable Variable( KF6P_PGI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.119;
	}
	
	Variable Variable( KFBP_ALD )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.5;
	}
	
	Variable Variable( KFBP_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	4.02;
	}
	
	Variable Variable( KG1P_GPa )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	2.7;
	}
	
	Variable Variable( KG1P_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.5;
	}
	
	Variable Variable( KG1P_PGLM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.063;
	}
	
	Variable Variable( KG6P_PGI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.48;
	}
	
	Variable Variable( KG6P_PGLM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.03;
	}
	
	Variable Variable( KGAP_ALD )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.0;
	}
	
	Variable Variable( KGAP_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0025;
	}
	
	Variable Variable( KGAP_TPI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.32;
	}
	
	Variable Variable( KGLYb_GPa )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.15;
	}
	
	Variable Variable( KGLYf_GPa )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.7;
	}
	
	Variable Variable( KLAC )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	17.0;
	}
	
	Variable Variable( KNADH_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0033;
	}
	
	Variable Variable( KNADH_LDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.002;
	}
	
	Variable Variable( KNAD_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.09;
	}
	
	Variable Variable( KNAD_LDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.849;
	}
	
	Variable Variable( KPCr )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.11;
	}
	
	Variable Variable( KPEP_EN )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.37;
	}
	
	Variable Variable( KPEP_PK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.08;
	}
	
	Variable Variable( KPYR_LDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.335;
	}
	
	Variable Variable( KPYR_PK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	7.05;
	}
	
	Variable Variable( KPi_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.29;
	}
	
	Variable Variable( KPi_GPa )
	{
		DiffusionCoeff	2.31584178475e+77;
		Fixed	0;
		Value	4.0;
	}
	
	Variable Variable( KPi_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.2;
	}
	
	Variable Variable( K_ADP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.7;
	}
	
	Variable Variable( K_AMP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.9e-06;
	}
	
	Variable Variable( K_ATP )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.25;
	}
	
	Variable Variable( K_F6P )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	20.0;
	}
	
	Variable Variable( K_FBP )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	4.02;
	}
	
	Variable Variable( KaAMP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.06;
	}
	
	Variable Variable( KeqADK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.21;
	}
	
	Variable Variable( KeqALD )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	10526315.7895;
	}
	
	Variable Variable( KeqCK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	233.0;
	}
	
	Variable Variable( KeqEN )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.49;
	}
	
	Variable Variable( KeqGAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.089;
	}
	
	Variable Variable( KeqGP )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.42;
	}
	
	Variable Variable( KeqLDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	16198.0;
	}
	
	Variable Variable( KeqPGI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.45;
	}
	
	Variable Variable( KeqPGK )
	{
		DiffusionCoeff	2.31584178475e+77;
		Fixed	0;
		Value	57109.0;
	}
	
	Variable Variable( KeqPGLM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	16.62;
	}
	
	Variable Variable( KeqPGM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.18;
	}
	
	Variable Variable( KeqPK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	10304.0;
	}
	
	Variable Variable( KeqTPI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.052;
	}
	
	Variable Variable( Keq_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	242.0;
	}
	
	Variable Variable( KiADP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.135;
	}
	
	Variable Variable( KiATP_CK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	3.5;
	}
	
	Variable Variable( KiATP_PFK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.87;
	}
	
	Variable Variable( KiG1P_GPa )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	10.0;
	}
	
	Variable Variable( KiG1P_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	7.4;
	}
	
	Variable Variable( KiGLYb_GPa )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.56;
	}
	
	Variable Variable( KiGLYb_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	4.4;
	}
	
	Variable Variable( KiGLYf_GPa )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.0;
	}
	
	Variable Variable( KiGLYf_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	15.0;
	}
	
	Variable Variable( KiPCr )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	3.9;
	}
	
	Variable Variable( KiPi_GPa )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	4.7;
	}
	
	Variable Variable( KiPi_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	4.6;
	}
	
	Variable Variable( L )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	107038.027369;
	}
	
	Variable Variable( L0 )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	13.0;
	}
	
	Variable Variable( LAC )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	7.49222780905;
	}
	
	Variable Variable( NAD )
	{
		DiffusionCoeff	2.31584178475e+77;
		Fixed	0;
		Value	9.66973412648;
	}
	
	Variable Variable( NADH )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.0248954451663;
	}
	
	Variable Variable( PCr )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0137415448749;
	}
	
	Variable Variable( PEP )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.00494815008052;
	}
	
	Variable Variable( PYR )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.181153417814;
	}
	
	Variable Variable( Pi )
	{
		DiffusionCoeff	2.18436097808e-314;
		Fixed	0;
		Value	4.1;
	}
	
	Variable Variable( V_ADK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0;
	}
	
	Variable Variable( V_ALD )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.4260009274;
	}
	
	Variable Variable( V_CK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	-8.66440904006e-12;
	}
	
	Variable Variable( V_EN )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.85109557542;
	}
	
	Variable Variable( V_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.8520010749;
	}
	
	Variable Variable( V_GPa )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	3.53147802316;
	}
	
	Variable Variable( V_GPa_a )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1123.38137724;
	}
	
	Variable Variable( V_GPa_b )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	318.105158768;
	}
	
	Variable Variable( V_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0222890226042;
	}
	
	Variable Variable( V_GPb_a )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	4.20565467952;
	}
	
	Variable Variable( V_GPb_b )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	188.687263421;
	}
	
	Variable Variable( V_LDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.84154529887;
	}
	
	Variable Variable( V_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.4260003645;
	}
	
	Variable Variable( V_PGI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.42598981245;
	}
	
	Variable Variable( V_PGK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	2.85199263191;
	}
	
	Variable Variable( V_PGLM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.42596620376;
	}
	
	Variable Variable( V_PGM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2.85123138231;
	}
	
	Variable Variable( V_PK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	2.85103006245;
	}
	
	Variable Variable( V_TPI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	-1.426000889;
	}
	
	Variable Variable( Vmaxf_ADK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	880.0;
	}
	
	Variable Variable( Vmaxf_ALD )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	104.0;
	}
	
	Variable Variable( Vmaxf_CK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	10340006.6733;
	}
	
	Variable Variable( Vmaxf_EN )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	192.0;
	}
	
	Variable Variable( Vmaxf_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1265.0;
	}
	
	Variable Variable( Vmaxf_GPa )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	20.0;
	}
	
	Variable Variable( Vmaxf_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	30.0;
	}
	
	Variable Variable( Vmaxf_LDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1920.0;
	}
	
	Variable Variable( Vmaxf_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	56.0;
	}
	
	Variable Variable( Vmaxf_PGI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1597.31092437;
	}
	
	Variable Variable( Vmaxf_PGK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	2436.65066667;
	}
	
	Variable Variable( Vmaxf_PGLM )
	{
		DiffusionCoeff	6.95335580784e-309;
		Fixed	0;
		Value	480.0;
	}
	
	Variable Variable( Vmaxf_PGM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1120.0;
	}
	
	Variable Variable( Vmaxf_PK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	1440.0;
	}
	
	Variable Variable( Vmaxf_TPI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	12000.0;
	}
	
	Variable Variable( Vmaxr_ADK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0;
	}
	
	Variable Variable( Vmaxr_ALD )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	3.95199999999e-05;
	}
	
	Variable Variable( Vmaxr_CK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	500.0;
	}
	
	Variable Variable( Vmaxr_EN )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1449.79591837;
	}
	
	Variable Variable( Vmaxr_GAPDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	575.074260622;
	}
	
	Variable Variable( Vmaxr_GPa )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	8.92857142857;
	}
	
	Variable Variable( Vmaxr_GPb )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	157.142857143;
	}
	
	Variable Variable( Vmaxr_LDH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	2553.41639745;
	}
	
	Variable Variable( Vmaxr_PFK )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	174.421487603;
	}
	
	Variable Variable( Vmaxr_PGI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	880.0;
	}
	
	Variable Variable( Vmaxr_PGK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	1120.0;
	}
	
	Variable Variable( Vmaxr_PGLM )
	{
		DiffusionCoeff	6.95335580784e-309;
		Fixed	0;
		Value	13.7527935362;
	}
	
	Variable Variable( Vmaxr_PGM )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	435.555555556;
	}
	
	Variable Variable( Vmaxr_PK )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	46.3887810559;
	}
	
	Variable Variable( Vmaxr_TPI )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	439903.846154;
	}
	
	Variable Variable( _13BPG )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.000775885062475;
	}
	
	Variable Variable( _2PG )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.011777966215;
	}
	
	Variable Variable( _3PG )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.0665400259572;
	}
	
	Variable Variable( alpha )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.00288;
	}
	
	Variable Variable( d )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.01;
	}
	
	Variable Variable( delta )
	{
		DiffusionCoeff	2.31584178475e+77;
		Fixed	0;
		Value	245.767849324;
	}
	
	Variable Variable( delta_ )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	34.2246767858;
	}
	
	Variable Variable( e )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.01;
	}
	
	Variable Variable( flux_GP )
	{
		DiffusionCoeff	4.94065645841e-324;
		Fixed	0;
		Value	0.0;
	}
	
	Variable Variable( frac_a )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	0.4;
	}
	
	Variable Variable( frac_b )
	{
		DiffusionCoeff	2.31584178475e+77;
		Fixed	0;
		Value	0.6;
	}
	
	Variable Variable( k )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	7.5;
	}
	
	Variable Variable( nH )
	{
		DiffusionCoeff	0.0;
		Fixed	0;
		Value	1.75;
	}
	
	Process ExpressionAssignmentProcess( D_GAPDH )
	{
		Expression	"1.0 + GAP.Value / KGAP_GAPDH.Value + NAD.Value / KNAD_GAPDH.Value + Pi.Value / KPi_GAPDH.Value + GAP.Value * NAD.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value ) + GAP.Value * NAD.Value * Pi.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value * KPi_GAPDH.Value ) + x13BPG.Value / K13BPG_GAPDH.Value + NADH.Value / KNADH_GAPDH.Value + x13BPG.Value * NADH.Value / ( K13BPG_GAPDH.Value * KNADH_GAPDH.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ GAP :/CELL/GLYCOGENOLYSIS:GAP ] [ K13BPG_GAPDH :/CELL/GLYCOGENOLYSIS:K13BPG_GAPDH ] [ KGAP_GAPDH :/CELL/GLYCOGENOLYSIS:KGAP_GAPDH ] [ KNADH_GAPDH :/CELL/GLYCOGENOLYSIS:KNADH_GAPDH ] [ KNAD_GAPDH :/CELL/GLYCOGENOLYSIS:KNAD_GAPDH ] [ KPi_GAPDH :/CELL/GLYCOGENOLYSIS:KPi_GAPDH ] [ NAD :/CELL/GLYCOGENOLYSIS:NAD ] [ NADH :/CELL/GLYCOGENOLYSIS:NADH ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ x13BPG :/CELL/GLYCOGENOLYSIS:_13BPG ] [ D_GAPDH :/CELL/GLYCOGENOLYSIS:D_GAPDH 1 ];
	}
	
	Process ExpressionAssignmentProcess( L )
	{
		Expression	"L0.Value * pow(( 1.0 + ATP.Value / KiATP_PFK.Value ) / ( 1.0 + d.Value * ATP.Value / KiATP_PFK.Value ) * ( 1.0 + e.Value * AMP.Value / KaAMP.Value ) / ( 1.0 + AMP.Value / KaAMP.Value ), 4.0 )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ AMP :/CELL/GLYCOGENOLYSIS:AMP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ KaAMP :/CELL/GLYCOGENOLYSIS:KaAMP ] [ KiATP_PFK :/CELL/GLYCOGENOLYSIS:KiATP_PFK ] [ L0 :/CELL/GLYCOGENOLYSIS:L0 ] [ d :/CELL/GLYCOGENOLYSIS:d ] [ e :/CELL/GLYCOGENOLYSIS:e ] [ L :/CELL/GLYCOGENOLYSIS:L 1 ];
	}
	
	Process ExpressionFluxProcess( V_ALD )
	{
		Expression	V_ALD.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ FBP :/CELL/GLYCOGENOLYSIS:FBP -1 ] [ KDHAP_ALD :/CELL/GLYCOGENOLYSIS:KDHAP_ALD ] [ KFBP_ALD :/CELL/GLYCOGENOLYSIS:KFBP_ALD ] [ KGAP_ALD :/CELL/GLYCOGENOLYSIS:KGAP_ALD ] [ V_ALD :/CELL/GLYCOGENOLYSIS:V_ALD ] [ Vmaxf_ALD :/CELL/GLYCOGENOLYSIS:Vmaxf_ALD ] [ Vmaxr_ALD :/CELL/GLYCOGENOLYSIS:Vmaxr_ALD ] [ DHAP :/CELL/GLYCOGENOLYSIS:DHAP 1 ] [ GAP :/CELL/GLYCOGENOLYSIS:GAP 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_ALD_assign )
	{
		Expression	"( Vmaxf_ALD.Value * FBP.Value / KFBP_ALD.Value - Vmaxr_ALD.Value * DHAP.Value * GAP.Value / ( KDHAP_ALD.Value * KGAP_ALD.Value )) / ( 1.0 + FBP.Value / KFBP_ALD.Value + DHAP.Value / KDHAP_ALD.Value + GAP.Value / KGAP_ALD.Value )";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ DHAP :/CELL/GLYCOGENOLYSIS:DHAP ] [ FBP :/CELL/GLYCOGENOLYSIS:FBP ] [ GAP :/CELL/GLYCOGENOLYSIS:GAP ] [ KDHAP_ALD :/CELL/GLYCOGENOLYSIS:KDHAP_ALD ] [ KFBP_ALD :/CELL/GLYCOGENOLYSIS:KFBP_ALD ] [ KGAP_ALD :/CELL/GLYCOGENOLYSIS:KGAP_ALD ] [ Vmaxf_ALD :/CELL/GLYCOGENOLYSIS:Vmaxf_ALD ] [ Vmaxr_ALD :/CELL/GLYCOGENOLYSIS:Vmaxr_ALD ] [ V_ALD :/CELL/GLYCOGENOLYSIS:V_ALD 1 ];
	}
	
	Process ExpressionFluxProcess( V_CK )
	{
		Expression	V_CK.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ Cr :/CELL/GLYCOGENOLYSIS:Cr -1 ] [ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ KCr :/CELL/GLYCOGENOLYSIS:KCr ] [ KPCr :/CELL/GLYCOGENOLYSIS:KPCr ] [ KiPCr :/CELL/GLYCOGENOLYSIS:KPCr ] [ KiADP :/CELL/GLYCOGENOLYSIS:KiADP ] [ KiATP_CK :/CELL/GLYCOGENOLYSIS:KiATP_CK ] [ V_CK :/CELL/GLYCOGENOLYSIS:V_CK ] [ Vmaxf_CK :/CELL/GLYCOGENOLYSIS:Vmaxf_CK ] [ Vmaxr_CK :/CELL/GLYCOGENOLYSIS:Vmaxr_CK ] [ PCr :/CELL/GLYCOGENOLYSIS:PCr 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_CK_assign )
	{
		Expression	"( Vmaxr_CK.Value * ATP.Value * Cr.Value / ( KiATP_CK.Value * KCr.Value ) -  Vmaxf_CK.Value * ADP.Value * PCr.Value / ( KiADP.Value * KPCr.Value )) / ( 1.0 + ADP.Value / KiADP.Value + PCr.Value / KiPCr.Value + ADP.Value * PCr.Value / ( KiADP.Value * KPCr.Value ) + ATP.Value / KiATP_CK.Value + Cr.Value / KCr.Value + ATP.Value * Cr.Value / ( KiATP_CK.Value * KCr.Value ))";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ Cr :/CELL/GLYCOGENOLYSIS:Cr ] [ KCr :/CELL/GLYCOGENOLYSIS:KCr ] [ KPCr :/CELL/GLYCOGENOLYSIS:KPCr ] [ KiPCr :/CELL/GLYCOGENOLYSIS:KPCr ] [ KiADP :/CELL/GLYCOGENOLYSIS:KiADP ] [ KiATP_CK :/CELL/GLYCOGENOLYSIS:KiATP_CK ] [ PCr :/CELL/GLYCOGENOLYSIS:PCr ] [ Vmaxf_CK :/CELL/GLYCOGENOLYSIS:Vmaxf_CK ] [ Vmaxr_CK :/CELL/GLYCOGENOLYSIS:Vmaxr_CK ] [ V_CK :/CELL/GLYCOGENOLYSIS:V_CK 1 ];
	}
	
	Process ExpressionFluxProcess( V_EN )
	{
		Expression	V_EN.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ x2PG :/CELL/GLYCOGENOLYSIS:_2PG -1 ] [ K2PG_EN :/CELL/GLYCOGENOLYSIS:K2PG_EN ] [ KPEP_EN :/CELL/GLYCOGENOLYSIS:KPEP_EN ] [ V_EN :/CELL/GLYCOGENOLYSIS:V_EN ] [ Vmaxf_EN :/CELL/GLYCOGENOLYSIS:Vmaxf_EN ] [ Vmaxr_EN :/CELL/GLYCOGENOLYSIS:Vmaxr_EN ] [ PEP :/CELL/GLYCOGENOLYSIS:PEP 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_EN_assign )
	{
		Expression	"( Vmaxf_EN.Value * x2PG.Value / K2PG_EN.Value - Vmaxr_EN.Value * PEP.Value / KPEP_EN.Value ) / ( 1.0 + x2PG.Value / K2PG_EN.Value + PEP.Value / KPEP_EN.Value )";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ K2PG_EN :/CELL/GLYCOGENOLYSIS:K2PG_EN ] [ KPEP_EN :/CELL/GLYCOGENOLYSIS:KPEP_EN ] [ PEP :/CELL/GLYCOGENOLYSIS:PEP ] [ Vmaxf_EN :/CELL/GLYCOGENOLYSIS:Vmaxf_EN ] [ Vmaxr_EN :/CELL/GLYCOGENOLYSIS:Vmaxr_EN ] [ x2PG :/CELL/GLYCOGENOLYSIS:_2PG ] [ V_EN :/CELL/GLYCOGENOLYSIS:V_EN 1 ];
	}
	
	Process ExpressionFluxProcess( V_GAPDH )
	{
		Expression	V_GAPDH.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ GAP :/CELL/GLYCOGENOLYSIS:GAP -1 ] [ D_GAPDH :/CELL/GLYCOGENOLYSIS:D_GAPDH ] [ K13BPG_GAPDH :/CELL/GLYCOGENOLYSIS:K13BPG_GAPDH ] [ KGAP_GAPDH :/CELL/GLYCOGENOLYSIS:KGAP_GAPDH ] [ KNADH_GAPDH :/CELL/GLYCOGENOLYSIS:KNADH_GAPDH ] [ KNAD_GAPDH :/CELL/GLYCOGENOLYSIS:KNAD_GAPDH ] [ KPi_GAPDH :/CELL/GLYCOGENOLYSIS:KPi_GAPDH ] [ V_GAPDH :/CELL/GLYCOGENOLYSIS:V_GAPDH ] [ Vmaxf_GAPDH :/CELL/GLYCOGENOLYSIS:Vmaxf_GAPDH ] [ Vmaxr_GAPDH :/CELL/GLYCOGENOLYSIS:Vmaxr_GAPDH ] [ NADH :/CELL/GLYCOGENOLYSIS:NADH 1 ] [ x13BPG :/CELL/GLYCOGENOLYSIS:_13BPG 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GAPDH_assign )
	{
		Expression	"( Vmaxf_GAPDH.Value * GAP.Value * NAD.Value * Pi.Value / ( KGAP_GAPDH.Value * KNAD_GAPDH.Value * KPi_GAPDH.Value ) -  Vmaxr_GAPDH.Value * x13BPG.Value * NADH.Value / ( K13BPG_GAPDH.Value * KNADH_GAPDH.Value )) / D_GAPDH.Value";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ D_GAPDH :/CELL/GLYCOGENOLYSIS:D_GAPDH ] [ GAP :/CELL/GLYCOGENOLYSIS:GAP ] [ K13BPG_GAPDH :/CELL/GLYCOGENOLYSIS:K13BPG_GAPDH ] [ KGAP_GAPDH :/CELL/GLYCOGENOLYSIS:KGAP_GAPDH ] [ KNADH_GAPDH :/CELL/GLYCOGENOLYSIS:KNADH_GAPDH ] [ KNAD_GAPDH :/CELL/GLYCOGENOLYSIS:KNAD_GAPDH ] [ KPi_GAPDH :/CELL/GLYCOGENOLYSIS:KPi_GAPDH ] [ NAD :/CELL/GLYCOGENOLYSIS:NAD ] [ NADH :/CELL/GLYCOGENOLYSIS:NADH ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ Vmaxf_GAPDH :/CELL/GLYCOGENOLYSIS:Vmaxf_GAPDH ] [ Vmaxr_GAPDH :/CELL/GLYCOGENOLYSIS:Vmaxr_GAPDH ] [ x13BPG :/CELL/GLYCOGENOLYSIS:_13BPG ] [ V_GAPDH :/CELL/GLYCOGENOLYSIS:V_GAPDH 1 ];
	}
	
	Process ExpressionFluxProcess( V_GP )
	{
		Expression	"frac_a.Value * V_GPa.Value + frac_b.Value * V_GPb.Value";
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ AMP :/CELL/GLYCOGENOLYSIS:AMP ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KG1P_GPb :/CELL/GLYCOGENOLYSIS:KG1P_GPb ] [ KPi_GPb :/CELL/GLYCOGENOLYSIS:KPi_GPb ] [ K_AMP :/CELL/GLYCOGENOLYSIS:K_AMP ] [ KiG1P_GPb :/CELL/GLYCOGENOLYSIS:KiG1P_GPb ] [ KiGLYb_GPb :/CELL/GLYCOGENOLYSIS:KiGLYb_GPb ] [ KiGLYf_GPb :/CELL/GLYCOGENOLYSIS:KiGLYf_GPb ] [ KiPi_GPb :/CELL/GLYCOGENOLYSIS:KiPi_GPb ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ V_GPa :/CELL/GLYCOGENOLYSIS:V_GPa ] [ V_GPb :/CELL/GLYCOGENOLYSIS:V_GPb ] [ V_GPb_a :/CELL/GLYCOGENOLYSIS:V_GPb_a ] [ V_GPb_b :/CELL/GLYCOGENOLYSIS:V_GPb_b ] [ Vmaxf_GPb :/CELL/GLYCOGENOLYSIS:Vmaxf_GPb ] [ Vmaxr_GPb :/CELL/GLYCOGENOLYSIS:Vmaxr_GPb ] [ frac_a :/CELL/GLYCOGENOLYSIS:frac_a ] [ frac_b :/CELL/GLYCOGENOLYSIS:frac_b ] [ nH :/CELL/GLYCOGENOLYSIS:nH ] [ G1P :/CELL/GLYCOGENOLYSIS:G1P 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GPa_a_assign )
	{
		Expression	"Vmaxf_GPa.Value * ( GLY.Value * Pi.Value / KiGLYf_GPa.Value / KPi_GPa.Value ) -  Vmaxr_GPa.Value * ( GLY.Value * G1P.Value / KGLYb_GPa.Value / KiG1P_GPa.Value )";
		Priority	3;
		StepperID	DT;
		VariableReferenceList	[ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KGLYb_GPa :/CELL/GLYCOGENOLYSIS:KGLYb_GPa ] [ KPi_GPa :/CELL/GLYCOGENOLYSIS:KPi_GPa ] [ KiG1P_GPa :/CELL/GLYCOGENOLYSIS:KiG1P_GPa ] [ KiGLYf_GPa :/CELL/GLYCOGENOLYSIS:KiGLYf_GPa ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ Vmaxf_GPa :/CELL/GLYCOGENOLYSIS:Vmaxf_GPa ] [ Vmaxr_GPa :/CELL/GLYCOGENOLYSIS:Vmaxr_GPa ] [ V_GPa_a :/CELL/GLYCOGENOLYSIS:V_GPa_a 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GPa_assign )
	{
		Expression	"V_GPa_a.Value / V_GPa_b.Value";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KGLYb_GPa :/CELL/GLYCOGENOLYSIS:KGLYb_GPa ] [ KGLYf_GPa :/CELL/GLYCOGENOLYSIS:KGLYf_GPa ] [ KPi_GPa :/CELL/GLYCOGENOLYSIS:KPi_GPa ] [ KiG1P_GPa :/CELL/GLYCOGENOLYSIS:KiG1P_GPa ] [ KiGLYb_GPa :/CELL/GLYCOGENOLYSIS:KiGLYb_GPa ] [ KiGLYf_GPa :/CELL/GLYCOGENOLYSIS:KiGLYf_GPa ] [ KiPi_GPa :/CELL/GLYCOGENOLYSIS:KiPi_GPa ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ V_GPa_a :/CELL/GLYCOGENOLYSIS:V_GPa_a ] [ V_GPa_b :/CELL/GLYCOGENOLYSIS:V_GPa_b ] [ Vmaxf_GPa :/CELL/GLYCOGENOLYSIS:Vmaxf_GPa ] [ Vmaxr_GPa :/CELL/GLYCOGENOLYSIS:Vmaxr_GPa ] [ V_GPa :/CELL/GLYCOGENOLYSIS:V_GPa 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GPa_b_assign )
	{
		Expression	"1.0 + GLY.Value / KiGLYf_GPa.Value + Pi.Value / KiPi_GPa.Value + GLY.Value / KiGLYb_GPa.Value + G1P.Value / KiG1P_GPa.Value + GLY.Value * Pi.Value / ( KGLYf_GPa.Value * KiPi_GPa.Value ) + GLY.Value * G1P.Value / ( KGLYb_GPa.Value * KiG1P_GPa.Value )";
		Priority	3;
		StepperID	DT;
		VariableReferenceList	[ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KGLYb_GPa :/CELL/GLYCOGENOLYSIS:KGLYb_GPa ] [ KGLYf_GPa :/CELL/GLYCOGENOLYSIS:KGLYf_GPa ] [ KiG1P_GPa :/CELL/GLYCOGENOLYSIS:KiG1P_GPa ] [ KiGLYb_GPa :/CELL/GLYCOGENOLYSIS:KiGLYb_GPa ] [ KiGLYf_GPa :/CELL/GLYCOGENOLYSIS:KiGLYf_GPa ] [ KiPi_GPa :/CELL/GLYCOGENOLYSIS:KiPi_GPa ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ V_GPa_b :/CELL/GLYCOGENOLYSIS:V_GPa_b 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GPb_a_assign )
	{
		Expression	"( pow( AMP.Value, nH.Value) / K_AMP.Value ) * ( Vmaxf_GPb.Value * ( GLY.Value * Pi.Value / ( KiGLYf_GPb.Value * KPi_GPb.Value )) - Vmaxr_GPb.Value * ( GLY.Value * G1P.Value / ( KiGLYb_GPb.Value * KG1P_GPb.Value )))";
		Priority	3;
		StepperID	DT;
		VariableReferenceList	[ AMP :/CELL/GLYCOGENOLYSIS:AMP ] [ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KG1P_GPb :/CELL/GLYCOGENOLYSIS:KG1P_GPb ] [ KPi_GPb :/CELL/GLYCOGENOLYSIS:KPi_GPb ] [ K_AMP :/CELL/GLYCOGENOLYSIS:K_AMP ] [ KiGLYb_GPb :/CELL/GLYCOGENOLYSIS:KiGLYb_GPb ] [ KiGLYf_GPb :/CELL/GLYCOGENOLYSIS:KiGLYf_GPb ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ Vmaxf_GPb :/CELL/GLYCOGENOLYSIS:Vmaxf_GPb ] [ Vmaxr_GPb :/CELL/GLYCOGENOLYSIS:Vmaxr_GPb ] [ nH :/CELL/GLYCOGENOLYSIS:nH ] [ V_GPb_a :/CELL/GLYCOGENOLYSIS:V_GPb_a 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GPb_assign )
	{
		Expression	"V_GPb_a.Value / V_GPb_b.Value";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ AMP :/CELL/GLYCOGENOLYSIS:AMP ] [ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KG1P_GPb :/CELL/GLYCOGENOLYSIS:KG1P_GPb ] [ KPi_GPb :/CELL/GLYCOGENOLYSIS:KPi_GPb ] [ K_AMP :/CELL/GLYCOGENOLYSIS:K_AMP ] [ KiG1P_GPb :/CELL/GLYCOGENOLYSIS:KiG1P_GPb ] [ KiGLYb_GPb :/CELL/GLYCOGENOLYSIS:KiGLYb_GPb ] [ KiGLYf_GPb :/CELL/GLYCOGENOLYSIS:KiGLYf_GPb ] [ KiPi_GPb :/CELL/GLYCOGENOLYSIS:KiPi_GPb ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ V_GPb_a :/CELL/GLYCOGENOLYSIS:V_GPb_a ] [ V_GPb_b :/CELL/GLYCOGENOLYSIS:V_GPb_b ] [ Vmaxf_GPb :/CELL/GLYCOGENOLYSIS:Vmaxf_GPb ] [ Vmaxr_GPb :/CELL/GLYCOGENOLYSIS:Vmaxr_GPb ] [ nH :/CELL/GLYCOGENOLYSIS:nH ] [ V_GPb :/CELL/GLYCOGENOLYSIS:V_GPb 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_GPb_b_assign )
	{
		Expression	"( 1 + pow( AMP.Value, nH.Value ) / K_AMP.Value ) * ( 1 + GLY.Value / KiGLYf_GPb.Value + Pi.Value / KiPi_GPb.Value + GLY.Value / KiGLYb_GPb.Value + G1P.Value / KiG1P_GPb.Value + GLY.Value * Pi.Value / ( KiGLYf_GPb.Value * KPi_GPb.Value ) + GLY.Value * G1P.Value / ( KiGLYb_GPb.Value * KG1P_GPb.Value ))";
		Priority	3;
		StepperID	DT;
		VariableReferenceList	[ AMP :/CELL/GLYCOGENOLYSIS:AMP ] [ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ GLY :/CELL/GLYCOGENOLYSIS:GLY ] [ KG1P_GPb :/CELL/GLYCOGENOLYSIS:KG1P_GPb ] [ KPi_GPb :/CELL/GLYCOGENOLYSIS:KPi_GPb ] [ K_AMP :/CELL/GLYCOGENOLYSIS:K_AMP ] [ KiG1P_GPb :/CELL/GLYCOGENOLYSIS:KiG1P_GPb ] [ KiGLYb_GPb :/CELL/GLYCOGENOLYSIS:KiGLYb_GPb ] [ KiGLYf_GPb :/CELL/GLYCOGENOLYSIS:KiGLYf_GPb ] [ KiPi_GPb :/CELL/GLYCOGENOLYSIS:KiPi_GPb ] [ Pi :/CELL/GLYCOGENOLYSIS:Pi ] [ Vmaxf_GPb :/CELL/GLYCOGENOLYSIS:Vmaxf_GPb ] [ Vmaxr_GPb :/CELL/GLYCOGENOLYSIS:Vmaxr_GPb ] [ nH :/CELL/GLYCOGENOLYSIS:nH ] [ V_GPb_b :/CELL/GLYCOGENOLYSIS:V_GPb_b 1 ];
	}
	
	Process ExpressionFluxProcess( V_LDH )
	{
		Expression	V_LDH.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ NADH :/CELL/GLYCOGENOLYSIS:NADH -1 ] [ PYR :/CELL/GLYCOGENOLYSIS:PYR -1 ] [ KLAC :/CELL/GLYCOGENOLYSIS:KLAC ] [ KNADH_LDH :/CELL/GLYCOGENOLYSIS:KNADH_LDH ] [ KNAD_LDH :/CELL/GLYCOGENOLYSIS:KNAD_LDH ] [ KPYR_LDH :/CELL/GLYCOGENOLYSIS:KPYR_LDH ] [ V_LDH :/CELL/GLYCOGENOLYSIS:V_LDH ] [ Vmaxf_LDH :/CELL/GLYCOGENOLYSIS:Vmaxf_LDH ] [ Vmaxr_LDH :/CELL/GLYCOGENOLYSIS:Vmaxr_LDH ] [ LAC :/CELL/GLYCOGENOLYSIS:LAC 1 ] [ NAD :/CELL/GLYCOGENOLYSIS:NAD 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_LDH_assign )
	{
		Expression	"( Vmaxf_LDH.Value * PYR.Value * NADH.Value / ( KPYR_LDH.Value * KNADH_LDH.Value ) -  Vmaxr_LDH.Value * LAC.Value * NAD.Value / ( KLAC.Value * KNAD_LDH.Value )) / ( 1.0 + PYR.Value / KPYR_LDH.Value + NADH.Value / KNADH_LDH.Value + PYR.Value * NADH.Value / ( KPYR_LDH.Value * KNADH_LDH.Value ) + LAC.Value / KLAC.Value + NAD.Value / KNAD_LDH.Value + LAC.Value * NAD.Value / ( KLAC.Value * KNAD_LDH.Value ))";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ KLAC :/CELL/GLYCOGENOLYSIS:KLAC ] [ KNADH_LDH :/CELL/GLYCOGENOLYSIS:KNADH_LDH ] [ KNAD_LDH :/CELL/GLYCOGENOLYSIS:KNAD_LDH ] [ KPYR_LDH :/CELL/GLYCOGENOLYSIS:KPYR_LDH ] [ LAC :/CELL/GLYCOGENOLYSIS:LAC ] [ NAD :/CELL/GLYCOGENOLYSIS:NAD ] [ NADH :/CELL/GLYCOGENOLYSIS:NADH ] [ PYR :/CELL/GLYCOGENOLYSIS:PYR ] [ Vmaxf_LDH :/CELL/GLYCOGENOLYSIS:Vmaxf_LDH ] [ Vmaxr_LDH :/CELL/GLYCOGENOLYSIS:Vmaxr_LDH ] [ V_LDH :/CELL/GLYCOGENOLYSIS:V_LDH 1 ];
	}
	
	Process ExpressionFluxProcess( V_OUTPUT )
	{
		Expression	"( 0.2 * LAC.Value )";
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ LAC :/CELL/GLYCOGENOLYSIS:LAC -1 ];
	}
	
	Process ExpressionFluxProcess( V_PFK )
	{
		Expression	V_PFK.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ F6P :/CELL/GLYCOGENOLYSIS:F6P -1 ] [ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ KADP_PFK :/CELL/GLYCOGENOLYSIS:KADP_PFK ] [ KATP_PFK :/CELL/GLYCOGENOLYSIS:KATP_PFK ] [ KF6P_PFK :/CELL/GLYCOGENOLYSIS:KF6P_PFK ] [ KFBP_PFK :/CELL/GLYCOGENOLYSIS:KFBP_PFK ] [ L :/CELL/GLYCOGENOLYSIS:L ] [ V_PFK :/CELL/GLYCOGENOLYSIS:V_PFK ] [ Vmaxf_PFK :/CELL/GLYCOGENOLYSIS:Vmaxf_PFK ] [ Vmaxr_PFK :/CELL/GLYCOGENOLYSIS:Vmaxr_PFK ] [ alpha :/CELL/GLYCOGENOLYSIS:alpha ] [ delta :/CELL/GLYCOGENOLYSIS:delta ] [ delta_ :/CELL/GLYCOGENOLYSIS:delta_ ] [ FBP :/CELL/GLYCOGENOLYSIS:FBP 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_PFK_assign )
	{
		Expression	"( 1.0 + alpha.Value * L.Value * pow(delta_.Value / delta.Value, 3 )) * (Vmaxf_PFK.Value * ATP.Value * F6P.Value / ( KATP_PFK.Value * KF6P_PFK.Value ) -  Vmaxr_PFK.Value *  ADP.Value * FBP.Value / ( KADP_PFK.Value * KFBP_PFK.Value )) / (delta.Value * ( 1.0 + L.Value * pow( delta_.Value / delta.Value, 4 )))";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ F6P :/CELL/GLYCOGENOLYSIS:F6P ] [ FBP :/CELL/GLYCOGENOLYSIS:FBP ] [ KADP_PFK :/CELL/GLYCOGENOLYSIS:KADP_PFK ] [ KATP_PFK :/CELL/GLYCOGENOLYSIS:KATP_PFK ] [ KF6P_PFK :/CELL/GLYCOGENOLYSIS:KF6P_PFK ] [ KFBP_PFK :/CELL/GLYCOGENOLYSIS:KFBP_PFK ] [ L :/CELL/GLYCOGENOLYSIS:L ] [ Vmaxf_PFK :/CELL/GLYCOGENOLYSIS:Vmaxf_PFK ] [ Vmaxr_PFK :/CELL/GLYCOGENOLYSIS:Vmaxr_PFK ] [ alpha :/CELL/GLYCOGENOLYSIS:alpha ] [ delta :/CELL/GLYCOGENOLYSIS:delta ] [ delta_ :/CELL/GLYCOGENOLYSIS:delta_ ] [ V_PFK :/CELL/GLYCOGENOLYSIS:V_PFK 1 ];
	}
	
	Process ExpressionFluxProcess( V_PGI )
	{
		Expression	V_PGI.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ G6P :/CELL/GLYCOGENOLYSIS:G6P -1 ] [ KF6P_PGI :/CELL/GLYCOGENOLYSIS:KF6P_PGI ] [ KG6P_PGI :/CELL/GLYCOGENOLYSIS:KG6P_PGI ] [ V_PGI :/CELL/GLYCOGENOLYSIS:V_PGI ] [ Vmaxf_PGI :/CELL/GLYCOGENOLYSIS:Vmaxf_PGI ] [ Vmaxr_PGI :/CELL/GLYCOGENOLYSIS:Vmaxr_PGI ] [ F6P :/CELL/GLYCOGENOLYSIS:F6P 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_PGI_assign )
	{
		Expression	"( Vmaxf_PGI.Value * ( G6P.Value / KG6P_PGI.Value ) - Vmaxr_PGI.Value * ( F6P.Value / KF6P_PGI.Value)) / ( 1.0 +  G6P.Value / KG6P_PGI.Value + F6P.Value / KF6P_PGI.Value )";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ F6P :/CELL/GLYCOGENOLYSIS:F6P ] [ G6P :/CELL/GLYCOGENOLYSIS:G6P ] [ KF6P_PGI :/CELL/GLYCOGENOLYSIS:KF6P_PGI ] [ KG6P_PGI :/CELL/GLYCOGENOLYSIS:KG6P_PGI ] [ Vmaxf_PGI :/CELL/GLYCOGENOLYSIS:Vmaxf_PGI ] [ Vmaxr_PGI :/CELL/GLYCOGENOLYSIS:Vmaxr_PGI ] [ V_PGI :/CELL/GLYCOGENOLYSIS:V_PGI 1 ];
	}
	
	Process ExpressionFluxProcess( V_PGK )
	{
		Expression	V_PGK.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ x13BPG :/CELL/GLYCOGENOLYSIS:_13BPG -1 ] [ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ K13BPG_PGK :/CELL/GLYCOGENOLYSIS:K13BPG_PGK ] [ K3PG_PGK :/CELL/GLYCOGENOLYSIS:K3PG_PGK ] [ KADP_PGK :/CELL/GLYCOGENOLYSIS:KADP_PGK ] [ KATP_PGK :/CELL/GLYCOGENOLYSIS:KATP_PGK ] [ V_PGK :/CELL/GLYCOGENOLYSIS:V_PGK ] [ Vmaxf_PGK :/CELL/GLYCOGENOLYSIS:Vmaxf_PGK ] [ Vmaxr_PGK :/CELL/GLYCOGENOLYSIS:Vmaxr_PGK ] [ x3PG :/CELL/GLYCOGENOLYSIS:_3PG 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_PGK_assign )
	{
		Expression	"( Vmaxf_PGK.Value * x13BPG.Value * ADP.Value / ( K13BPG_PGK.Value * KADP_PGK.Value ) -  Vmaxr_PGK.Value * x3PG.Value * ATP.Value / ( K3PG_PGK.Value * KATP_PGK.Value )) / ( 1.0 + x13BPG.Value / K13BPG_PGK.Value + ADP.Value / KADP_PGK.Value + x13BPG.Value * ADP.Value / ( K13BPG_PGK.Value * KADP_PGK.Value ) + x3PG.Value / K3PG_PGK.Value + ATP.Value / KATP_PGK.Value + x3PG.Value * ATP.Value / ( K3PG_PGK.Value * KATP_PGK.Value ))";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ K13BPG_PGK :/CELL/GLYCOGENOLYSIS:K13BPG_PGK ] [ K3PG_PGK :/CELL/GLYCOGENOLYSIS:K3PG_PGK ] [ KADP_PGK :/CELL/GLYCOGENOLYSIS:KADP_PGK ] [ KATP_PGK :/CELL/GLYCOGENOLYSIS:KATP_PGK ] [ Vmaxf_PGK :/CELL/GLYCOGENOLYSIS:Vmaxf_PGK ] [ Vmaxr_PGK :/CELL/GLYCOGENOLYSIS:Vmaxr_PGK ] [ x13BPG :/CELL/GLYCOGENOLYSIS:_13BPG ] [ x3PG :/CELL/GLYCOGENOLYSIS:_3PG ] [ V_PGK :/CELL/GLYCOGENOLYSIS:V_PGK 1 ];
	}
	
	Process ExpressionFluxProcess( V_PGLM )
	{
		Expression	V_PGLM.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ G1P :/CELL/GLYCOGENOLYSIS:G1P -1 ] [ KG1P_PGLM :/CELL/GLYCOGENOLYSIS:KG1P_PGLM ] [ KG6P_PGLM :/CELL/GLYCOGENOLYSIS:KG6P_PGLM ] [ V_PGLM :/CELL/GLYCOGENOLYSIS:V_PGLM ] [ Vmaxf_PGLM :/CELL/GLYCOGENOLYSIS:Vmaxf_PGLM ] [ Vmaxr_PGLM :/CELL/GLYCOGENOLYSIS:Vmaxr_PGLM ] [ G6P :/CELL/GLYCOGENOLYSIS:G6P 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_PGLM_assign )
	{
		Expression	"( Vmaxf_PGLM.Value * ( G1P.Value / KG1P_PGLM.Value ) - Vmaxr_PGLM.Value * ( G6P.Value / KG6P_PGLM.Value)) / ( 1.0 +  G1P.Value / KG1P_PGLM.Value + G6P.Value / KG6P_PGLM.Value )";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ G1P :/CELL/GLYCOGENOLYSIS:G1P ] [ G6P :/CELL/GLYCOGENOLYSIS:G6P ] [ KG1P_PGLM :/CELL/GLYCOGENOLYSIS:KG1P_PGLM ] [ KG6P_PGLM :/CELL/GLYCOGENOLYSIS:KG6P_PGLM ] [ Vmaxf_PGLM :/CELL/GLYCOGENOLYSIS:Vmaxf_PGLM ] [ Vmaxr_PGLM :/CELL/GLYCOGENOLYSIS:Vmaxr_PGLM ] [ V_PGLM :/CELL/GLYCOGENOLYSIS:V_PGLM 1 ];
	}
	
	Process ExpressionFluxProcess( V_PGM )
	{
		Expression	V_PGM.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ x3PG :/CELL/GLYCOGENOLYSIS:_3PG -1 ] [ K2PG_PGM :/CELL/GLYCOGENOLYSIS:K2PG_PGM ] [ K3PG_PGM :/CELL/GLYCOGENOLYSIS:K3PG_PGM ] [ V_PGM :/CELL/GLYCOGENOLYSIS:V_PGM ] [ Vmaxf_PGM :/CELL/GLYCOGENOLYSIS:Vmaxf_PGM ] [ Vmaxr_PGM :/CELL/GLYCOGENOLYSIS:Vmaxr_PGM ] [ x2PG :/CELL/GLYCOGENOLYSIS:_2PG 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_PGM_assign )
	{
		Expression	"( Vmaxf_PGM.Value * x3PG.Value / K3PG_PGM.Value -  Vmaxr_PGM.Value * x2PG.Value / K2PG_PGM.Value ) / ( 1.0 + x3PG.Value / K3PG_PGM.Value + x2PG.Value / K2PG_PGM.Value )";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ K2PG_PGM :/CELL/GLYCOGENOLYSIS:K2PG_PGM ] [ K3PG_PGM :/CELL/GLYCOGENOLYSIS:K3PG_PGM ] [ Vmaxf_PGM :/CELL/GLYCOGENOLYSIS:Vmaxf_PGM ] [ Vmaxr_PGM :/CELL/GLYCOGENOLYSIS:Vmaxr_PGM ] [ x2PG :/CELL/GLYCOGENOLYSIS:_2PG ] [ x3PG :/CELL/GLYCOGENOLYSIS:_3PG ] [ V_PGM :/CELL/GLYCOGENOLYSIS:V_PGM 1 ];
	}
	
	Process ExpressionFluxProcess( V_PK )
	{
		Expression	V_PK.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ PEP :/CELL/GLYCOGENOLYSIS:PEP -1 ] [ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ KADP_PK :/CELL/GLYCOGENOLYSIS:KADP_PK ] [ KATP_PK :/CELL/GLYCOGENOLYSIS:KATP_PK ] [ KPEP_PK :/CELL/GLYCOGENOLYSIS:KPEP_PK ] [ KPYR_PK :/CELL/GLYCOGENOLYSIS:KPYR_PK ] [ V_PK :/CELL/GLYCOGENOLYSIS:V_PK ] [ Vmaxf_PK :/CELL/GLYCOGENOLYSIS:Vmaxf_PK ] [ Vmaxr_PK :/CELL/GLYCOGENOLYSIS:Vmaxr_PK ] [ PYR :/CELL/GLYCOGENOLYSIS:PYR 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_PK_assign )
	{
		Expression	"(( Vmaxf_PK.Value * PEP.Value * ADP.Value ) / ( KPEP_PK.Value * KADP_PK.Value )) -  (( Vmaxr_PK.Value * PYR.Value * ATP.Value ) / ( KPYR_PK.Value * KATP_PK.Value )) / ( 1.0 + ( PEP.Value / KPEP_PK.Value ) + ( ADP.Value / KADP_PK.Value ) + (( PEP.Value * ADP.Value ) / ( KPEP_PK.Value * KADP_PK.Value )) + ( PYR.Value / KPYR_PK.Value ) + ( ATP.Value / KATP_PK.Value ) + (( PYR.Value * ATP.Value ) / ( KPYR_PK.Value * KATP_PK.Value )))";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ KADP_PK :/CELL/GLYCOGENOLYSIS:KADP_PK ] [ KATP_PK :/CELL/GLYCOGENOLYSIS:KATP_PK ] [ KPEP_PK :/CELL/GLYCOGENOLYSIS:KPEP_PK ] [ KPYR_PK :/CELL/GLYCOGENOLYSIS:KPYR_PK ] [ PEP :/CELL/GLYCOGENOLYSIS:PEP ] [ PYR :/CELL/GLYCOGENOLYSIS:PYR ] [ Vmaxf_PK :/CELL/GLYCOGENOLYSIS:Vmaxf_PK ] [ Vmaxr_PK :/CELL/GLYCOGENOLYSIS:Vmaxr_PK ] [ V_PK :/CELL/GLYCOGENOLYSIS:V_PK 1 ];
	}
	
	Process ExpressionFluxProcess( V_TPI )
	{
		Expression	V_TPI.Value;
		Priority	0;
		StepperID	ODE;
		VariableReferenceList	[ GAP :/CELL/GLYCOGENOLYSIS:GAP -1 ] [ KDHAP_TPI :/CELL/GLYCOGENOLYSIS:KDHAP_TPI ] [ KGAP_TPI :/CELL/GLYCOGENOLYSIS:KGAP_TPI ] [ V_TPI :/CELL/GLYCOGENOLYSIS:V_TPI ] [ Vmaxf_TPI :/CELL/GLYCOGENOLYSIS:Vmaxf_TPI ] [ Vmaxr_TPI :/CELL/GLYCOGENOLYSIS:Vmaxr_TPI ] [ DHAP :/CELL/GLYCOGENOLYSIS:DHAP 1 ];
	}
	
	Process ExpressionAssignmentProcess( V_TPI_assign )
	{
		Expression	"(( Vmaxf_TPI.Value * GAP.Value / KGAP_TPI.Value ) - ( Vmaxr_TPI.Value * DHAP.Value / KDHAP_TPI.Value )) / ( 1.0 + GAP.Value / KGAP_TPI.Value + DHAP.Value / KDHAP_TPI.Value )";
		Priority	1;
		StepperID	DT;
		VariableReferenceList	[ DHAP :/CELL/GLYCOGENOLYSIS:DHAP ] [ GAP :/CELL/GLYCOGENOLYSIS:GAP ] [ KDHAP_TPI :/CELL/GLYCOGENOLYSIS:KDHAP_TPI ] [ KGAP_TPI :/CELL/GLYCOGENOLYSIS:KGAP_TPI ] [ Vmaxf_TPI :/CELL/GLYCOGENOLYSIS:Vmaxf_TPI ] [ Vmaxr_TPI :/CELL/GLYCOGENOLYSIS:Vmaxr_TPI ] [ V_TPI :/CELL/GLYCOGENOLYSIS:V_TPI 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxf_CK )
	{
		Expression	"Vmaxr_CK.Value * KiATP_CK.Value * KCr.Value * KeqCK.Value / ( KiADP.Value * KPCr.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KCr :/CELL/GLYCOGENOLYSIS:KCr ] [ KPCr :/CELL/GLYCOGENOLYSIS:KPCr ] [ KeqCK :/CELL/GLYCOGENOLYSIS:KeqCK ] [ KiADP :/CELL/GLYCOGENOLYSIS:KiADP ] [ KiATP_CK :/CELL/GLYCOGENOLYSIS:KiATP_CK ] [ KiPCr :/CELL/GLYCOGENOLYSIS:KiPCr ] [ Vmaxr_CK :/CELL/GLYCOGENOLYSIS:Vmaxr_CK ] [ Vmaxf_CK :/CELL/GLYCOGENOLYSIS:Vmaxf_CK 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxf_PGI )
	{
		Expression	"( Vmaxr_PGI.Value * KG6P_PGI.Value  * KeqPGI.Value) / KF6P_PGI.Value";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KF6P_PGI :/CELL/GLYCOGENOLYSIS:KF6P_PGI ] [ KG6P_PGI :/CELL/GLYCOGENOLYSIS:KG6P_PGI ] [ KeqPGI :/CELL/GLYCOGENOLYSIS:KeqPGI ] [ Vmaxr_PGI :/CELL/GLYCOGENOLYSIS:Vmaxr_PGI ] [ Vmaxf_PGI :/CELL/GLYCOGENOLYSIS:Vmaxf_PGI 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxf_PGK )
	{
		Expression	"Vmaxr_PGK.Value * K13BPG_PGK.Value * KADP_PGK.Value * KeqPGK.Value / K3PG_PGK.Value / KATP_PGK.Value";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ K13BPG_PGK :/CELL/GLYCOGENOLYSIS:K13BPG_PGK ] [ K3PG_PGK :/CELL/GLYCOGENOLYSIS:K3PG_PGK ] [ KADP_PGK :/CELL/GLYCOGENOLYSIS:KADP_PGK ] [ KATP_PGK :/CELL/GLYCOGENOLYSIS:KATP_PGK ] [ KeqPGK :/CELL/GLYCOGENOLYSIS:KeqPGK ] [ Vmaxr_PGK :/CELL/GLYCOGENOLYSIS:Vmaxr_PGK ] [ Vmaxf_PGK :/CELL/GLYCOGENOLYSIS:Vmaxf_PGK 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_ALD )
	{
		Expression	"Vmaxf_ALD.Value * KDHAP_ALD.Value * KGAP_ALD.Value / ( KFBP_ALD.Value * KeqALD.Value)";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KDHAP_ALD :/CELL/GLYCOGENOLYSIS:KDHAP_ALD ] [ KFBP_ALD :/CELL/GLYCOGENOLYSIS:KFBP_ALD ] [ KGAP_ALD :/CELL/GLYCOGENOLYSIS:KGAP_ALD ] [ KeqALD :/CELL/GLYCOGENOLYSIS:KeqALD ] [ Vmaxf_ALD :/CELL/GLYCOGENOLYSIS:Vmaxf_ALD ] [ Vmaxr_ALD :/CELL/GLYCOGENOLYSIS:Vmaxr_ALD 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_EN )
	{
		Expression	"Vmaxf_EN.Value * KPEP_EN.Value / ( K2PG_EN.Value * KeqEN.Value)";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ K2PG_EN :/CELL/GLYCOGENOLYSIS:K2PG_EN ] [ KPEP_EN :/CELL/GLYCOGENOLYSIS:KPEP_EN ] [ KeqEN :/CELL/GLYCOGENOLYSIS:KeqEN ] [ Vmaxf_EN :/CELL/GLYCOGENOLYSIS:Vmaxf_EN ] [ Vmaxr_EN :/CELL/GLYCOGENOLYSIS:Vmaxr_EN 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_GAPDH )
	{
		Expression	"Vmaxf_GAPDH.Value * K13BPG_GAPDH.Value * KNADH_GAPDH.Value / KGAP_GAPDH.Value / KNAD_GAPDH.Value / KPi_GAPDH.Value / KeqGAPDH.Value";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ K13BPG_GAPDH :/CELL/GLYCOGENOLYSIS:K13BPG_GAPDH ] [ KGAP_GAPDH :/CELL/GLYCOGENOLYSIS:KGAP_GAPDH ] [ KNADH_GAPDH :/CELL/GLYCOGENOLYSIS:KNADH_GAPDH ] [ KNAD_GAPDH :/CELL/GLYCOGENOLYSIS:KNAD_GAPDH ] [ KPi_GAPDH :/CELL/GLYCOGENOLYSIS:KPi_GAPDH ] [ KeqGAPDH :/CELL/GLYCOGENOLYSIS:KeqGAPDH ] [ Vmaxf_GAPDH :/CELL/GLYCOGENOLYSIS:Vmaxf_GAPDH ] [ Vmaxr_GAPDH :/CELL/GLYCOGENOLYSIS:Vmaxr_GAPDH 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_GPa )
	{
		Expression	"( Vmaxf_GPa.Value * KGLYb_GPa.Value * KiG1P_GPa.Value ) / KiGLYf_GPa.Value / KPi_GPa.Value / KeqGP.Value";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KGLYb_GPa :/CELL/GLYCOGENOLYSIS:KGLYb_GPa ] [ KPi_GPa :/CELL/GLYCOGENOLYSIS:KPi_GPa ] [ KeqGP :/CELL/GLYCOGENOLYSIS:KeqGP ] [ KiG1P_GPa :/CELL/GLYCOGENOLYSIS:KiG1P_GPa ] [ KiGLYf_GPa :/CELL/GLYCOGENOLYSIS:KiGLYf_GPa ] [ Vmaxf_GPa :/CELL/GLYCOGENOLYSIS:Vmaxf_GPa ] [ Vmaxr_GPa :/CELL/GLYCOGENOLYSIS:Vmaxr_GPa 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_GPb )
	{
		Expression	"( Vmaxf_GPb.Value * KiGLYb_GPb.Value * KG1P_GPb.Value ) / ( KiGLYf_GPb.Value * KPi_GPb.Value * KeqGP.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KG1P_GPb :/CELL/GLYCOGENOLYSIS:KG1P_GPb ] [ KPi_GPb :/CELL/GLYCOGENOLYSIS:KPi_GPb ] [ KeqGP :/CELL/GLYCOGENOLYSIS:KeqGP ] [ KiGLYb_GPb :/CELL/GLYCOGENOLYSIS:KiGLYb_GPb ] [ KiGLYf_GPb :/CELL/GLYCOGENOLYSIS:KiGLYf_GPb ] [ Vmaxf_GPb :/CELL/GLYCOGENOLYSIS:Vmaxf_GPb ] [ Vmaxr_GPb :/CELL/GLYCOGENOLYSIS:Vmaxr_GPb 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_LDH )
	{
		Expression	"Vmaxf_LDH.Value * KLAC.Value * KNAD_LDH.Value / ( KPYR_LDH.Value * KNADH_LDH.Value * KeqLDH.Value)";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KLAC :/CELL/GLYCOGENOLYSIS:KLAC ] [ KNADH_LDH :/CELL/GLYCOGENOLYSIS:KNADH_LDH ] [ KNAD_LDH :/CELL/GLYCOGENOLYSIS:KNAD_LDH ] [ KPYR_LDH :/CELL/GLYCOGENOLYSIS:KPYR_LDH ] [ KeqLDH :/CELL/GLYCOGENOLYSIS:KeqLDH ] [ Vmaxf_LDH :/CELL/GLYCOGENOLYSIS:Vmaxf_LDH ] [ Vmaxr_LDH :/CELL/GLYCOGENOLYSIS:Vmaxr_LDH 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_PFK )
	{
		Expression	"Vmaxf_PFK.Value * KADP_PFK.Value * KFBP_PFK.Value / KATP_PFK.Value / KF6P_PFK.Value / Keq_PFK.Value";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KADP_PFK :/CELL/GLYCOGENOLYSIS:KADP_PFK ] [ KATP_PFK :/CELL/GLYCOGENOLYSIS:KATP_PFK ] [ KF6P_PFK :/CELL/GLYCOGENOLYSIS:KF6P_PFK ] [ KFBP_PFK :/CELL/GLYCOGENOLYSIS:KFBP_PFK ] [ Keq_PFK :/CELL/GLYCOGENOLYSIS:Keq_PFK ] [ Vmaxf_PFK :/CELL/GLYCOGENOLYSIS:Vmaxf_PFK ] [ Vmaxr_PFK :/CELL/GLYCOGENOLYSIS:Vmaxr_PFK 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_PGLM )
	{
		Expression	"( Vmaxf_PGLM.Value * KG6P_PGLM.Value ) / ( KG1P_PGLM.Value * KeqPGLM.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KG1P_PGLM :/CELL/GLYCOGENOLYSIS:KG1P_PGLM ] [ KG6P_PGLM :/CELL/GLYCOGENOLYSIS:KG6P_PGLM ] [ KeqPGLM :/CELL/GLYCOGENOLYSIS:KeqPGLM ] [ Vmaxf_PGLM :/CELL/GLYCOGENOLYSIS:Vmaxf_PGLM ] [ Vmaxr_PGLM :/CELL/GLYCOGENOLYSIS:Vmaxr_PGLM 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_PGM )
	{
		Expression	"Vmaxf_PGM.Value * K2PG_PGM.Value / ( K3PG_PGM.Value * KeqPGM.Value)";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ K2PG_PGM :/CELL/GLYCOGENOLYSIS:K2PG_PGM ] [ K3PG_PGM :/CELL/GLYCOGENOLYSIS:K3PG_PGM ] [ KeqPGM :/CELL/GLYCOGENOLYSIS:KeqPGM ] [ Vmaxf_PGM :/CELL/GLYCOGENOLYSIS:Vmaxf_PGM ] [ Vmaxr_PGM :/CELL/GLYCOGENOLYSIS:Vmaxr_PGM 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_PK )
	{
		Expression	"( Vmaxf_PK.Value * KATP_PK.Value * KPYR_PK.Value ) / ( KPEP_PK.Value * KADP_PK.Value * KeqPK.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KADP_PK :/CELL/GLYCOGENOLYSIS:KADP_PK ] [ KATP_PK :/CELL/GLYCOGENOLYSIS:KATP_PK ] [ KPEP_PK :/CELL/GLYCOGENOLYSIS:KPEP_PK ] [ KPYR_PK :/CELL/GLYCOGENOLYSIS:KPYR_PK ] [ KeqPK :/CELL/GLYCOGENOLYSIS:KeqPK ] [ Vmaxf_PK :/CELL/GLYCOGENOLYSIS:Vmaxf_PK ] [ Vmaxr_PK :/CELL/GLYCOGENOLYSIS:Vmaxr_PK 1 ];
	}
	
	Process ExpressionAssignmentProcess( Vmaxr_TPI )
	{
		Expression	"Vmaxf_TPI.Value * KDHAP_TPI.Value / KGAP_TPI.Value / KeqTPI.Value";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KDHAP_TPI :/CELL/GLYCOGENOLYSIS:KDHAP_TPI ] [ KGAP_TPI :/CELL/GLYCOGENOLYSIS:KGAP_TPI ] [ KeqTPI :/CELL/GLYCOGENOLYSIS:KeqTPI ] [ Vmaxf_TPI :/CELL/GLYCOGENOLYSIS:Vmaxf_TPI ] [ Vmaxr_TPI :/CELL/GLYCOGENOLYSIS:Vmaxr_TPI 1 ];
	}
	
	Process ExpressionAssignmentProcess( alpha )
	{
		Expression	"KF6P_PFK.Value * KATP_PFK.Value / ( K_F6P.Value * K_ATP.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ KATP_PFK :/CELL/GLYCOGENOLYSIS:KATP_PFK ] [ KF6P_PFK :/CELL/GLYCOGENOLYSIS:KF6P_PFK ] [ K_ATP :/CELL/GLYCOGENOLYSIS:K_ATP ] [ K_F6P :/CELL/GLYCOGENOLYSIS:K_F6P ] [ alpha :/CELL/GLYCOGENOLYSIS:alpha 1 ];
	}
	
	Process ExpressionAssignmentProcess( delta )
	{
		Expression	"( 1.0 + F6P.Value / KF6P_PFK.Value ) * ( 1.0 + ATP.Value / KATP_PFK.Value ) + ADP.Value / KADP_PFK.Value + FBP.Value / KFBP_PFK.Value * ( 1.0 + ADP.Value / KADP_PFK.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ F6P :/CELL/GLYCOGENOLYSIS:F6P ] [ FBP :/CELL/GLYCOGENOLYSIS:FBP ] [ KADP_PFK :/CELL/GLYCOGENOLYSIS:KADP_PFK ] [ KATP_PFK :/CELL/GLYCOGENOLYSIS:KATP_PFK ] [ KF6P_PFK :/CELL/GLYCOGENOLYSIS:KF6P_PFK ] [ KFBP_PFK :/CELL/GLYCOGENOLYSIS:KFBP_PFK ] [ delta :/CELL/GLYCOGENOLYSIS:delta 1 ];
	}
	
	Process ExpressionAssignmentProcess( delta_ )
	{
		Expression	"( 1.0 + F6P.Value / K_F6P.Value ) * ( 1.0 + ATP.Value / K_ATP.Value ) + ADP.Value / K_ADP.Value + FBP.Value / K_FBP.Value * ( 1.0 + ADP.Value / K_ADP.Value )";
		Priority	5;
		StepperID	DT;
		VariableReferenceList	[ ADP :/CELL/GLYCOGENOLYSIS:ADP ] [ ATP :/CELL/GLYCOGENOLYSIS:ATP ] [ F6P :/CELL/GLYCOGENOLYSIS:F6P ] [ FBP :/CELL/GLYCOGENOLYSIS:FBP ] [ K_ADP :/CELL/GLYCOGENOLYSIS:K_ADP ] [ K_ATP :/CELL/GLYCOGENOLYSIS:K_ATP ] [ K_F6P :/CELL/GLYCOGENOLYSIS:K_F6P ] [ K_FBP :/CELL/GLYCOGENOLYSIS:K_FBP ] [ delta_ :/CELL/GLYCOGENOLYSIS:delta_ 1 ];
	}
	
	
}

