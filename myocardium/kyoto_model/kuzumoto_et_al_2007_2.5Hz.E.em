%line 1 kuzumoto_et_al_2007_2.5Hz.em


# EMB, LAT, NEO, V, SAN


%line 6 kuzumoto_et_al_2007_2.5Hz.em

%line 7 kuzumoto_et_al_2007_2.5Hz.em







Stepper FixedODE1Stepper( ODE ){ StepInterval   0.01; }
%line 406 kuzumoto_et_al_2007_2.5Hz.em
#Stepper ODEStepper( ODE2 ){}
#Stepper ODE45Stepper( ODE ){}


Stepper PassiveStepper( PSV ){}
#Stepper DiscreteTimeStepper( PSV ){}

#Stepper DiscreteTimeStepper( DSC ){}

#Stepper DAEStepper( DAE ){}

System System( / )
{
	StepperID	ODE;

	
	Variable Variable( SIZE )
	{
		Value 1.28e-8;
		Fixed 1;
	}

	
	Variable Variable( N_A )
	{
		Name "Avogadro number (mol^-1)";
		Value 6.0221367e+23;
	}

	Variable Variable( F )
	{
		Name "Faraday's constant (C/mol)";
		Value 96.4867e+3;
	}

	Variable Variable( R )
	{
		Name "Gas constant (C mV/K/mol)";  # (mJ/K/mol)
		Value 8.3143e+3;
	}

	Variable Variable( zNa )
	{
		Value 1.0;
	}

	Variable Variable( zK )
	{
		Value 1.0;
	}

	Variable Variable( zCa )
	{
		Value 2.0;
	}

	Variable Variable( zCl )
	{
		Value -1.0;
	}

	
	Variable Variable( T )
	{
		Name "absolute temperature (K)";
		Value 310.0;
	}

		Variable Variable( t )
	{
		Value 0.0;
	}

	Process ZeroOrderFluxProcess( elapsedTime ) 
	{
		Priority	15;

		VariableReferenceList
			[ t :.:t  1 ];

		k "1.0";
		
	}

		Variable Variable( forceExt )
	{
		Name "External force";
		Value 0.0;
	}

	
	Variable Variable( Na )
	{
		Name "Extracellular Na+";
		MolarConc 141.0e-3;
		Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Extracellular K+";
		MolarConc 5.4e-3;
		Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Extracellular Ca2+";
		MolarConc 1.8e-3;
		Fixed 1;
	}

	Variable Variable( Cl )
	{
		Name "Extracellular Cl-";
		MolarConc 140.0e-3;
		Fixed 1;
	}

	Variable Variable( LA )
	{
		Name "Extracellular large anionic compound";
		MolarConc 10.0e-3;
		Fixed 1;
	}

	Variable Variable( FCCP )
	{
		Name "Extracellular FCCP";
		MolarConc 0.0;
		Fixed 1;
	}

	Variable Variable( CN )
	{
		Name "Extracellular CN";
		MolarConc 0.0;
		Fixed 1;
	}

	Variable Variable( Oxygen )
	{
		Name "Extracellular Oxygen";
		MolarConc 0.24e-3;
		Fixed 1;
	}

	Variable Variable( isoproterenol )
	{
		Name "Extracellular isoproterenol";
		MolarConc 0.0;
		Fixed 1;
	}

#	Variable Variable( Tonicity )
#	{
#		Name "Extracellular fluid tonicity";
#		Value 1.0;
#	}
#
#	Process PythonProcess( Tonicity ) 
#	{
#		StepperID    PSV;
#		Priority     10;
#
#		Name "Extracellular fluid tonicity";
#
#		VariableReferenceList
#			[ t     :.:Tonicity 0 ]
#			[ Naext :.:Na       0 ]
#			[ Kext  :.:K        0 ]
#			[ Caext :.:Ca       0 ]
#			[ Clext :.:Cl       0 ]
#			[ LAext :.:LA       0 ];
#
#		InitializeMethod '''
#Naext.Value = t.Value * Naext.Value
#Kext.Value  = t.Value * Kext.Value
#Caext.Value = t.Value * Caext.Value
#Clext.Value = t.Value * Clext.Value
#LAext.Value = t.Value * LAext.Value
#'''; 
#	}



# 	Process PythonProcess( pipette )
# 	{
# 		Name "Pipette for CurrentClamp";
# 
# 		interval   400.0;
# 		onset      50.0;
# 		offset     52.0;
# 		amplitude  -8000.0;
# 
# 		InitializeMethod "";
# 		FireMethod "";
# 	}

	Variable Variable( TotalIon )
	{
		Name "Extracellular total ion";
		MolarConc 298.2e-3;
	}

	Process EnvironmentAssignmentProcess( TotalIon ) 
	{
		Name "Extracellular total ion";

		StepperID	PSV;
		Priority	5;

		VariableReferenceList
			[ TotalIon :.:TotalIon 1 ]
			[ Na       :.:Na       0 ]
			[ K        :.:K        0 ]
			[ Cl       :.:Cl       0 ]
			[ Ca       :.:Ca       0 ]
			[ LA       :.:LA       0 ];
	}


#	Process ExpressionFluxProcess( Dummy ) 
#	{
#		StepperID	ODE;
#
#		Name "Dummy Process for ODE";
#
#		VariableReferenceList [ _ :.:Na 1 ];
#
#		Expression "0.0";
#	}

}



System System( /CELL )
{
	StepperID	ODE;
}


System System( /CELL/CYTOPLASM )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
#		Value 15353.339029443347e-15;  # units="L"
#		Value 1.99593407382764e-12;

		Value 1.53533390294e-11;
%line 668 kuzumoto_et_al_2007_2.5Hz.em
	}

	Variable Variable( active_volume )
	{
#		Value 80.0;	# percentage(dimensionless)
		Value 0.8;	# percentage(dimensionless)
%line 674 kuzumoto_et_al_2007_2.5Hz.em
	}


	
	#	Variable Variable( Nav1_5 )
#	{
#		Name   "Relative expression of Nav1.5 for INa";
#		Value  1.0;
%line 684 kuzumoto_et_al_2007_2.5Hz.em
#	}
	
	#	Variable Variable( Cav1_2 )
#	{
#		Name   "Relative expression of Cav1.2 for ICaL";
#		Value  1.0;
%line 691 kuzumoto_et_al_2007_2.5Hz.em
#	}

	#	Variable Variable( Cav3_1 )
#	{
#		Name   "Relative expression of Cav3.1 for ICaT";
#		Value  1.0;
#	}

	#	Variable Variable( ST_gene )
#	{
#		Name   "Relative expression for Ist";
#		Value  0.0;
#	}

	#	Variable Variable( Kir2_1 )
#	{
#		Name   "Relative expression of Kir2.1 for IK1";
#		Value  1.0;
#	}

	#	Variable Variable( erg1 )
#	{
#		Name   "Relative expression of erg1 for IKr";
#		Value  1.0;
#	}

	#	Variable Variable( KCNQ1 )
#	{
#		Name   "Relative expression of KCNQ1 for IKs";
#		Value  1.0;
#	}

	#	Variable Variable( Kv1_4 )
#	{
#		Name   "Relative expression of Kv1.4 for Ito";
#		Value  1.0;
#	}

	#	Variable Variable( Kir3_1 )
#	{
#		Name   "Relative expression for IKACh";
#		Value  0.0;
#	}

	#	Variable Variable( NaK_ATPase )
#	{
#		Name	"Relative expression of Na/K ATPase for Na/K pump";
#		Value	1.0;
#	}

#	#	Variable Variable( NCX1 )
#	{
#		Name	"Relative expression of NCX1 for Na/Ca exchanger";
#		Value	1.0;
#	}

	
#	#	Variable Variable( LCCa_gene )
#	{
#		Name   "Relative expression for ILCCa";
#		Value  1.0;
#	}

	#	Variable Variable( Kir6_2 )
#	{
#		Name   "Relative expression of Kir6.2 for IKATP";
#		Value  1.0;
#	}

	#	Variable Variable( Kpl_gene )
#	{
#		Name   "Relative expression for IKpl";
#		Value  1.0;
#	}

#	#	Variable Variable( bNSC_gene )
#	{
#		Name   "Relative expression for IbNSC";
#		Value  1.0;
#	}

#	#	Variable Variable( Cab_gene )
#	{
#		Name   "Relative expression for ICab";
#		Value  1.0;
#	}

#	#	Variable Variable( Clb_gene )
#	{
#		Name   "Relative expression for IClb";
#		Value  1.0;
#	}

#	#	Variable Variable( NKCC_gene )
#	{
#		Name   "Relative expression for NKCC";
#		Value  1.0;
#	}

	
	
	#	Variable Variable( HCN )
#	{
#		Name	"Relative expression of HCN for Iha";
#		Value	1.0;
#	}

	
	Variable Variable( SR_activity )
	{
		Name	"Relative expression of SR";
		Value	1.0;
	}

#	Variable Variable( RyR1 )
#	{
#		Name	"Relative expression of RyR1 for IRyR";
#		Value	1.0;
#	}

	#	Variable Variable( leak_activity )
#	{
#		Name	"Relative activity of SR leak current";
#		Value	1.0;
#	}

	#	Variable Variable( SERCA )
#	{
#		Name	"Relative expression of SERCA for ISRCA";
#		Value	1.0;
#	}

	
	Variable Variable( Na )
	{
		Name "Intracellular Na+";
		MolarConc 6.346144960767133e-3;
		# Fixed 1;
	}

	Variable Variable( K )
	{
		Name "Intracellular K+";
		MolarConc 139.86283809432015e-3;
		# Fixed 1;
	}

	Variable Variable( Ca )
	{
		Name "Intracellular Ca2+";
		MolarConc 7.485309995633807e-8;
		# Fixed 1;
	}

	Variable Variable( CaTotal )
	{
		Name "Intracellular total Ca2+";
		MolarConc 0.0015994473813345231e-3;
		# Fixed 1;
	}

	Variable Variable( Cl )
	{
		Name "Intracellular Cl-";
		MolarConc 49.77812289122723e-3;
		# Fixed 1;
	}

	Variable Variable( LA )
	{
		Name "Intracellular large anionic compound";
		MolarConc 102.2109911720549e-3;
	}

	
	Variable Variable( Vt )
	{
		Name "Vt";
		Value 1.85533390294e-11;  # (L)
%line 895 kuzumoto_et_al_2007_2.5Hz.em
	}

	Process CytoplasmAssignmentProcess( Cytoplasm ) 
	{
		Name "Total cell volume";

		StepperID	PSV;
#		Priority	200;
		Priority	3;

		VariableReferenceList
#			[ Vi           :.:SIZE                   0 ]
			[ Vi           :.:SIZE                   1 ]
			[ Vt           :.:Vt                     1 ]
			[ active_volume :.:active_volume          0 ]
			[ Volume_ratio :.:Volume_ratio           1 ]
			[ Proton       :.:Proton                 0 ]
			[ pH           :.:pH                     1 ]
			[ Mg           :.:Mg                     0 ]
			[ ATPtotal     :.:ATPtotal               0 ]
			[ ATPfree      :.:ATPfree                1 ]
			[ ATPmg        :.:ATPmg                  1 ]
			[ ADPtotal     :.:ADPtotal               0 ]
			[ ADPfree      :.:ADPfree                1 ]
			[ ADPmg        :.:ADPmg                  1 ]
			[ cAMP         :.:cAMPtot                0 ]
			[ AMP          :.:AMP                    1 ]
			[ PCr          :.:PCr                    0 ]
			[ NAD          :.:NAD                    0 ]
			[ NADH         :.:NADH                   1 ]
			[ Creatine     :.:Creatine               1 ]
			[ Pi           :.:Pi                     1 ]
			[ PiTotal      :.:PiTotal                0 ]
			[ ATPtotal_mt  :./MITOCHONDRIA:ATPtotal  0 ]
			[ ADPtotal_mt  :./MITOCHONDRIA:ADPtotal  0 ]
			[ Pi_mt        :./MITOCHONDRIA:Pi        0 ]
			[ T            :.:T                      1 ]
			[ Tt           :.:Tt                     0 ]
			[ TCa          :.:TCa                    0 ]
			[ TCaCB        :.:TCaCB                  0 ]
			[ TCB          :.:TCB                    0 ]
			[ totalIonin   :.:TotalIon               1 ]
			[ Na           :.:Na                     0 ]
			[ K            :.:K                      0 ]
			[ Cl           :.:Cl                     0 ]
			[ CaTotal      :.:CaTotal                0 ]
			[ Ca           :.:Ca                     1 ]
			[ LA           :.:LA                     0 ]
			[ totalIonex   :/:TotalIon               0 ]
			[ Cm           :../MEMBRANE:Cm           0 ]
			[ WaterFlux    :.:WaterFlux              1 ]
			[ vAK          :.:vAK                    1 ]
			[ vCK          :.:vCK                    1 ]
			[ calmodulin   :.:calmodulin             1 ];


		# Vn              3200.0;          # the osmotically inactive cell volume (um^3)
#		Vn_L              3200.0e-15;      # (L)
#		Vn_L              7.072e-14;      # (L)
		Vn_L              3.2e-12;
%line 955 kuzumoto_et_al_2007_2.5Hz.em
		Vt0i              53898653951.9;
%line 956 kuzumoto_et_al_2007_2.5Hz.em

		ActivityFactor    1.0;
		kD_ATP            0.024e-3;        # units="M"
		kD_ADP            0.347e-3;        # units="M"
		TotalAdenosine    7.0e-3;          # (M)
		TotalCreatine     25.0e-3;         # (M)
		NAD_H_total       0.000594;         # ducky 121026
		f                 1.3743e-17;      # hydraulic conductivity [L/pF/M/ms]
		kfAK              783.0;           #  (1/M/ms)
		kbAK              683.0;           #  (1/M/ms)
		kfCK              16.05e+6;        #  (1/M^2/ms)
		kbCK              9.67e-3;         #  (1/mM/ms)
		Km_calmodulin     2.38e-06;        # units="M"
		calmodulin_total  5e-05;           # units="M"
	}

	
	Variable Variable( Volume_ratio )
	{
		Name "Volume ratio";
		Value 1.1579897648525994;
	}

	
	Variable Variable( Proton )
	{
		Name "Proton";
		MolarConc 1.0e-7;
	}

	Variable Variable( pH )
	{
		Name "pH";
		Value 6.999999999999999;
	}


	Variable Variable( Mg )
	{
		Name "Intracellular Mg2+";
		MolarConc 6.0e-4;
	}

	Variable Variable( ATPtotal )
	{
		Name "Total ATP";
		MolarConc 6.96248492200143e-3;
		# Fixed 1;
	}


	
	Variable Variable( ATPfree )
	{
		Name "Free ATP";
		MolarConc 2.677878816154396e-4;
	}


		
	Variable Variable( ATPmg )
	{
		Name "ATP-Mg";
		MolarConc 6.69469704038599e-3;
	}


	
	Variable Variable( ADPtotal )
	{
		Name "Total ADP";
		MolarConc 3.6781238986170604e-5;
		# Fixed 1;
	}

	Variable Variable( ADPfree )
	{
		Name "Free ADP";
		MolarConc 1.3477391687646462e-5;
	}


	
	Variable Variable( ADPmg )
	{
		Name "ADP-Mg";
		MolarConc 2.3303847298524142e-5;
	}


	
	Variable Variable( AMP )
	{
		Name "AMP";
		MolarConc 5.378613206818983e-8;
	}


	
	Variable Variable( PCr )
	{
		Name "Phospho creatine";
		MolarConc 1.2752455383511842e-2;
	}

	Variable Variable( Creatine )
	{
		Name "Creatine";
		MolarConc 1.2247544616488158e-2;
	}


	
	Variable Variable( Pi )
	{
		Name "Inorganic phosphate";
		MolarConc 2.1272277723005484e-3;
		# Fixed 1;
	}

	Variable Variable( PiTotal )
	{
		MolarConc 46.0e-3;
		# Fixed 1;
	}

#	Process ExpressionAssignmentProcess( Pi ) 
#	{
#		Name "Mass conservation of Pi";
#
#		StepperID	PSV;
#		Priority	3;
#
#		VariableReferenceList
#			[ Pi       :.:Pi                    1 ]
#			[ PCr      :.:PCr                   0 ]
#			[ ATPtcell :.:ATPtotal              0 ]
#			[ ADPtcell :.:ADPtotal              0 ]
#			[ AMP      :.:AMP                   0 ]
#			#[ Rcm      :./MITOCHONDRIA:Rcm      0 ]
#			[ ATPtmit  :./MITOCHONDRIA:ATPtotal 0 ]
#			[ ADPtmit  :./MITOCHONDRIA:ADPtotal 0 ]
#			[ Pimit    :./MITOCHONDRIA:Pi       0 ];
#
#		PiTotal 46.0e-3;  # (M)
#
#		Expression "PiTotal * self.getSuperSystem().SizeN_A - PCr.Value - 3.0 * ATPtcell.Value - 2.0 * ADPtcell.Value - AMP.Value - 3.0 * ATPtmit.Value - 2.0 * ADPtmit.Value - Pimit.Value";
#	}
	

	Variable Variable( TotalIon )
	{
		Name "Intracellular total ion";
		MolarConc 298.1981719770164e-3;
	}


	
	Variable Variable( WaterFlux )
	{
		Name "Water Flux";
		Value -5.30589229565e-21;
	}

	Process ZeroVariableAsFluxProcess( WaterFlux ) 
	{
		Name "Intracellular total ion";

		Priority	4;

		VariableReferenceList
			[ WaterFlux :.:WaterFlux      0 ]
			[ volumeint  :.:SIZE          1 ]
			[ volumeext  :/:SIZE         -1 ];
	}

	Variable Variable( halfSarcomereLength )
	{
		Name "Half sarcomere length (um)";
		Value 0.9617633308389127;
	}


	
	Variable Variable( vAK )
	{
		Name "vAK";
		Value -139.834886511;
	}

	Process ZeroVariableAsFluxProcess( vAK ) 
	{
		Name "Adenylate Kinase";

		Priority	15;

		VariableReferenceList
			[ vAK    :.:vAK     0 ]
			[ ADPtotal :.:ADPtotal -2 ]
			#[ ADPfree  :.:ADPfree   0 ]
			#[ ADPmg    :.:ADPmg     0 ]
			[ ATPtotal :.:ATPtotal  1 ];
			#[ ATPmg    :.:ATPmg     0 ]
			#[ AMP      :.:AMP       0 ];
	}


	
	Variable Variable( vCK )
	{
		Name "Creatine Kinase";
		Value -663549.73707;
	}

#amano et al (2009)
#<massconservation name="NAD" initial_value="2.075109324838782" units="mM">
	Variable Variable( NAD )
	{
		MolarConc 0.0004150218649677564;
		#2.075109324838782 / 5.0
	}

#<variable name="NADH" initial_value="0.8948906751612181" units="mM" />
	Variable Variable( NADH )
	{
		MolarConc 0.00017897813503224363;
		#0.8948906751612181 / 5.0
	}

	Process ZeroVariableAsFluxProcess( vCK ) 
	{
		Name "Creatine Kinase";

		Priority	15;

		VariableReferenceList
			[ vCK       :.:vCK  0 ]
			#[ Cr       :.:Creatine  0 ]
			[ PCr      :.:PCr      -1 ]
			[ ADPtotal :.:ADPtotal -1 ]
			[ ATPtotal :.:ATPtotal  1 ];
			#[ Proton   :.:Proton    0 ];
	}


	
	Variable Variable( calmodulin )
	{
		Name "Calmodulin";
		MolarConc 1.524594281378185e-6;
	}

	
	
	Variable Variable( crossBridgeLength )
	{
		Name "Cross Bridge Length";
		Value 0.005009947075106269;
	}


	
	Variable Variable( Tt )
	{
		MolarConc 0.07e-3;
		# Fixed 1;
	}

	Variable Variable( T )
	{
		MolarConc 0.0672942681114029e-3;
	}

	Variable Variable( TCa )
	{
		Name "fraction of contraction unit with troponin C bound to Ca2+";
		MolarConc 2.5982764372710202e-6;
	}

	Variable Variable( TCaCB )
	{
		Name "fraction of contraction unit with troponin C bound to Ca2+ and attached cross bridge (force generator)";
		MolarConc 8.375865245910036e-8;
	}

	Variable Variable( TCB )
	{
		Name "fraction of contraction unit with attached cross bridge and with free troponin C (force generator)";
		MolarConc 2.369679886697068e-8;
	}


	Variable Variable( cAMPtot )
	{
		Name "Total cyclic AMP";
		MolarConc 6.800528803316611e-7;
	}

	Variable Variable( cAMP )
	{
		Name "Cyclic AMP";
		MolarConc 2.939695632625512e-7;
	}

	Variable Variable( PKA )
	{
		Name "protein kinase A";
		MolarConc 1.364353297210205e-7;
	}

	#	Variable Variable( PKA0 )
#	{
#		Name "protein kinase A, initial value?";
#		MolarConc 1.3644055081894695e-7;
#	}

	Variable Variable( AC )
	{
		Name "adenylate cyclase";
		MolarConc 4.969917928875104e-8;
	}

	Variable Variable( Gs_alpha_GTP_AC )
	{
		Name "adenylate cyclase-bound Gs alpha GTP";
		MolarConc 8.207112489611035e-13;
	}

	Variable Variable( Gs_alpha_GTPtot )
	{
		Name "total GTP-bound alpha subunit of Gs";
		MolarConc 5.202597626352922e-9;
	}

# 	<BetaAR_Gs name="BetaAR" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.BetaAR_Gs">
# 		<parameter name="LRG" initial_value="0.0" units="mM" />
# 		<parameter name="RG" initial_value="3.2516235164698E-7" units="mM" />
# 		<parameter name="LR" initial_value="0.0" units="mM" />
# 		<parameter name="L" initial_value="0.0" units="mM" />
# 		<parameter name="beta1_AR" initial_value="3.7991044019474952E-6" units="mM" />
# 		<parameter name="Gstot" initial_value="0.00383" units="mM" />
# 		<parameter name="Gs" initial_value="0.0028244439923392865" units="mM" />
# 		<parameter name="KL" initial_value="0.0010" units="mM" />
# 		<parameter name="KR" initial_value="6.2E-5" units="mM" />
# 		<parameter name="KC" initial_value="0.033" units="mM" />
# 		<parameter name="k_betaARK_plus" initial_value="1.1E-6" units="1/ms" />
# 		<parameter name="k_betaARK_minus" initial_value="2.2E-6" units="1/ms" />
# 		<parameter name="k_PKA_plus" initial_value="0.0036" units="1/(ms*mM)" />
# 		<parameter name="k_PKA_minus" initial_value="2.232E-7" units="1/ms" />
# 		<parameter name="beta1_ARtot" initial_value="1.32E-5" units="mM" />
# 		<parameter name="k_gact" initial_value="0.016" units="1/ms" />
# 		<parameter name="k_hyd" initial_value="0.0010" units="1/ms" />
# 		<parameter name="k_reassoc" initial_value="1200.0" units="1/(ms*mM)" />
# 		<variable name="beta1_ARact" initial_value="4.124266728915964E-6" units="mM" />
# 		<variable name="beta1_AR_S464" initial_value="0.0" units="mM" />
# 		<variable name="beta1_AR_S301" initial_value="9.075733271084037E-6" units="mM" />
# 		<variable name="Gs_beta_gamma" initial_value="0.001005230845247631" units="mM" />
# 		<variable name="Gs_alpha_GDP" initial_value="4.312937712225446E-9" units="mM" />
# 		<link name="Iso" initial_value="../../../isoproterenol" units="mM" />
# 		<link name="PKA" initial_value="../../PKA" units="mM" />
# 		<link name="Gs_alpha_GTPtot" initial_value="../Gs_alpha_GTPtot" units="mM" />
# 	</BetaAR_Gs>

	Variable Variable( LRG )
	{
		Name "beta1-adrenergic receptor bound with ligand and Gs";
		MolarConc 0.0;
	}

	Variable Variable( RG )
	{
		Name "beta1-adrenergic receptor bound with Gs";
		MolarConc 3.2516235164698e-10;
	}

	Variable Variable( LR )
	{
		Name "beta1-adrenergic receptor bound with ligand";
		MolarConc 0.0;
	}

	Variable Variable( L )
	{
		Name "isoproterenol (ligand)";
		MolarConc 0.0;
	}

	Variable Variable( beta1_AR )
	{
		Name "beta1-adrenergic receptor";
		MolarConc 3.7991044019474952e-9;
	}

	Variable Variable( Gstot )
	{
		Name "total Gs";
		MolarConc 3.83e-6;
	}

	Variable Variable( Gs )
	{
		Name "aipha, beta and gamma subunit of Gs";
		MolarConc 2.8244439923392865e-6;
	}

	Variable Variable( beta1_ARact )
	{
		Name "? activated beta1-adrenergic receptor";
		MolarConc 4.124266728915964e-9;
	}

	Variable Variable( beta1_AR_S464 )
	{
		Name "? beta1-adrenergic receptor S464";
		MolarConc 0.0;
	}

	Variable Variable( beta1_AR_S301 )
	{
		Name "? beta1-adrenergic receptor S301";
		MolarConc 9.075733271084037e-9;
	}

	Variable Variable( Gs_beta_gamma )
	{
		Name "beta and gamma subunit of Gs";
		MolarConc 1.005230845247631e-6;
	}

	Variable Variable( Gs_alpha_GDP )
	{
		Name "GDP-bound alpha subunit of Gs";
		MolarConc 4.312937712225446e-12;
	}

	Variable Variable( PDE )
	{
		Name "phosphodiesterase";
		MolarConc 3.9e-8;
	}

# 	<CAMP name="CAMP" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.CAMP">
# 		<parameter name="ACtot" initial_value="4.97E-5" units="mM" />
# 		<parameter name="K_Gs_alpha" initial_value="0.315" units="mM" />
# 		<parameter name="Gs_alpha_GTP" initial_value="5.201776915103961E-6" units="mM" />
# 		<link name="Gs_alpha_GTP_AC" initial_value="../Gs_alpha_GTP_AC" units="mM" />
# 		<link name="AC" initial_value="../AC" units="mM" />
# 		<link name="Gs_alpha_GTPtot" initial_value="../Gs_alpha_GTPtot" units="mM" />
# 		<parameter name="PDEtot" initial_value="3.9E-5" units="mM" />
# 		<link name="PDE" initial_value="../PDE" units="mM" />
# 		<link name="cAMPtot" initial_value="../../cAMPtot" units="mM" />
# 		<link name="cAMP" initial_value="../../cAMP" units="mM" />
# 		<link name="ATP" initial_value="../../ATPtotal" units="mM" />
# 		<parameter name="k_AC_basal" initial_value="0.0035" units="1/ms" />
# 		<parameter name="k_PDE" initial_value="0.031" units="1/ms" />
# 		<parameter name="k_AC_Gs_alpha" initial_value="91.0" units="1/ms" />
# 		<parameter name="Km_basal" initial_value="1.03" units="mM" />
# 		<parameter name="Km_PDE" initial_value="0.0013" units="mM" />
# 		<parameter name="Km_Gs_alpha_GTP" initial_value="0.315" units="mM" />
# 	</CAMP>

	Variable Variable( ACtot )
	{
		Name "total adenylate cyclase";
		MolarConc 4.97e-8;
	}

	Variable Variable( Gs_alpha_GTP )
	{
		Name "alpha GTP-bound alpha subunit of Gs";
		MolarConc 5.201776915103961e-9;
	}

	Variable Variable( PDEtot )
	{
		Name "total phosphodiesterase";
		MolarConc 3.9e-8;
	}

# 	<PKA_NR name="PKA" className="org.simBio.bio.kuzumoto_et_al_2007.molecule.PKA">
# 		<parameter name="KA" initial_value="0.0080" units="mM" />
# 		<parameter name="KB" initial_value="0.0080" units="mM" />
# 		<parameter name="KD" initial_value="0.0090" units="mM" />
# 		<parameter name="PKItot" initial_value="1.8E-4" units="mM" />
# 		<parameter name="KPKI" initial_value="0.0010" units="mM" />
# 		<link name="PKA" initial_value="../../PKA" units="mM" />
# 		<link name="cAMP" initial_value="../../cAMP" units="mM" />
# 		<parameter name="ARCI" initial_value="6.520090177298568E-5" units="mM" />
# 		<parameter name="A2RCI" initial_value="2.3958850773161374E-6" units="mM" />
# 		<parameter name="A2RI" initial_value="1.5804532257104254E-4" units="mM" />
# 		<parameter name="RCI" initial_value="0.0017743578906433443" units="mM" />
# 		<parameter name="PKACI_PKI" initial_value="2.1609992850022038E-5" units="mM" />
# 		<parameter name="PKI" initial_value="1.5623401026755668E-4" units="mM" />
# 		<link name="cAMPtot" initial_value="../../cAMPtot" units="mM" />
# 		<parameter name="PKAtot" initial_value="0.0010" units="mM" />
# 	</PKA_NR>

	Variable Variable( PKItot )
	{
		Name "total protein kinase inhibitor";
		MolarConc 1.8e-7;
	}

	Variable Variable( ARCI )
	{
		Name "complex of cAMP, PKA and regulatory subunit";
		MolarConc 6.520090177298568e-8;
	}

	Variable Variable( A2RCI )
	{
		Name "complex of 2 cAMP, PKA and regulatory subunit";
		MolarConc 2.3958850773161374e-9;
	}

	Variable Variable( A2RI )
	{
		Name "complex of 2 cAMP and regulatory subunit";
		MolarConc 1.5804532257104254e-7;
	}

	Variable Variable( RCI )
	{
		Name "regulatory subunit-bound PKA";
		MolarConc 1.7743578906433443e-6;
	}

	Variable Variable( PKACI_PKI )
	{
		Name "PKA inhibited by PKI";
		MolarConc 2.1609992850022038e-8;
	}

	Variable Variable( PKI )
	{
		Name "protein kinase inhibitor";
		MolarConc 1.5623401026755668e-7;
	}

	Variable Variable( PKAtot )
	{
		Name "total protein kinase A (dimer)";
		MolarConc 1.0e-6;
	}

	Variable Variable( Spermine )
	{
		Name "Spermine";
		MolarConc 5.0e-6;
	}

	Variable Variable( ACh )
	{
		Name "Acetylcholine";
		MolarConc 0.0;
	}
}



System System( /CELL/MEMBRANE )
{
	StepperID	ODE;

		Variable Variable( Vm )
	{
		Name "membrane potential (mV)";
		Value -86.72869394206137;
		# Fixed 1;
	}

	


	Variable Variable( Cm )
	{
		Name "membrane capacitance (pF)";
		Value 211.2;
%line 1562 kuzumoto_et_al_2007_2.5Hz.em
	}

	Variable Variable( EK )
	{
		Name "equilibrium potential for K+ (mV)";
		Value -86.93058752466963;
	}

	
	Process MembraneAssignmentProcess( Membrane ) 
	{
		Name "K reversal potential";

		StepperID	PSV;
		Priority	29;

		VariableReferenceList
			[ Vm        :.:Vm             0 ]
			[ T         :/:T              0 ]
			[ R         :/:R              0 ]
			[ F         :/:F              0 ]
			[ zK        :/:zK             0 ]
			[ zNa       :/:zNa            0 ]
			[ zCa       :/:zCa            0 ]
			[ zCl       :/:zCl            0 ]
			[ EK        :.:EK             1 ]
			[ Ke        :/:K              0 ]
			[ Ki        :../CYTOPLASM:K   0 ]
			[ CFNa      :.:CFNa           1 ]
			[ Nae       :/:Na             0 ]
			[ Nai       :../CYTOPLASM:Na  0 ]
			[ CFK       :.:CFK            1 ]
			[ CFCa      :.:CFCa           1 ]
			[ Cae       :/:Ca             0 ]
			[ Cai       :../CYTOPLASM:Ca  0 ]
			[ CFCl      :.:CFCl           1 ]
			[ Cle       :/:Cl             0 ]
			[ Cli       :../CYTOPLASM:Cl  0 ]
			[ vrtf      :.:_vrtf          1 ]
			[ current   :.:current        1 ]
			[ currentNa :.:currentNa      1 ]
			[ currentK  :.:currentK       1 ]
			[ currentCa :.:currentCa      1 ]
			[ currentCl :.:currentCl      1 ];
	}

	Variable Variable( CFNa )
	{
		Name "dependency of Na+ flux on Vm (constant field equation)";
		Value -475.48115680026734;
	}


	Variable Variable( CFK )
	{
		Name "dependency of K+ flux on Vm (constant field equation)";
		Value 0.1383929081707904;
	}


	Variable Variable( CFCa )
	{
		Name "dependency of Ca2+ flux on Vm (constant field equation)";
		Value -11.705853861559248;
	}


	Variable Variable( CFCl )
	{
		Name "dependency of Cl- flux on Vm (constant field equation)";
		Value 149.75827659080292;
	}


		Variable Variable( CaDiadic )
	{
		Name  "CICRfactor (mM)";
		Value -1.5309723748693796E-7;
		Fixed 0;
	}

	Variable Variable( _vrtf )
	{
		Name "Vm / ( R * T / F )";
		Value -3.24670533581;
	}


	Variable Variable( current )
	{
		Name "total current of ion channels and ion exchangers (pA)";
		#Value 0.047652741143697386;
		Value 0.0;
	}

	Variable Variable( currentNa )
	{
		Name "sum of current components carried by Na+ (pA)";
		#Value 94.88482988241198;
		Value 0.0;
	}

	Variable Variable( currentK )
	{
		Name "sum of current components carried by K+ (pA)";
		#Value -118.10325682749983;
		Value 0.0;
	}

	Variable Variable( currentCa )
	{
		Name "sum of current components carried by Ca2+ (pA)";
		#Value 26.782021853292502;
		Value 0.0;
	}

	Variable Variable( currentCl )
	{
		Name "sum of current components carried by Cl- (pA)";
		#Value -3.5159421670609547;
		Value 0.0;
	}

}

System System( /CELL/CYTOPLASM/SRREL )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
#		Value 307.06678058886695e-15;  #  units="L"
#                Value 1.19756044429658e-14;  #  units="L"
		Value 3.07066780589e-13;
%line 1707 kuzumoto_et_al_2007_2.5Hz.em
	}

	Process SRrelAssignmentProcess( volume ) 
	{
		Name "SRrel volume";

		StepperID	PSV;
		Priority	4;

		VariableReferenceList
			[ volume        :.:SIZE                1 ]
			[ total         :/CELL/CYTOPLASM:SIZE  0 ]
			[ CaTotal       :.:CaTotal             1 ]
			[ Ca            :.:Ca                  1 ]
			[ calsequestrin :.:calsequestrin       1 ];

#		ratio                 0.02;
		ratio                 0.02; 
%line 1725 kuzumoto_et_al_2007_2.5Hz.em

		Km_calsequestrin    0.0008;	# units="M"
		calsequestrin_total   0.01;	# units="M"
	}

	Variable Variable( Ca )
	{
		Name "SRrel Ca2+";
		MolarConc 1.706059829830171e-3;
		# Fixed 1;
	}

	Variable Variable( CaTotal )
	{
		Name "SRrel total Ca2+";
		MolarConc 8.513797656048734e-3;
	}

	Variable Variable( calsequestrin )
	{
		Name "Calsequestrin";
		MolarConc 6.807737826218563e-3;
	}

}


System System( /CELL/CYTOPLASM/SRUP )
{
	StepperID	ODE;

	Variable Variable( SIZE )
	{
#		Value 767.6669514721674e-15;
#                Value 2.99390111074145e-14;
		Value 7.67666951472e-13;
%line 1761 kuzumoto_et_al_2007_2.5Hz.em
	}

	Process SRupAssignmentProcess( volume ) 
	{
		Name "SRup volume";

		StepperID	PSV;
		Priority	8;

		VariableReferenceList
			[ volume :.:SIZE   1 ]
			[ total  :..:SIZE  0 ];

#		ratio 0.05;
		ratio 0.05;
%line 1776 kuzumoto_et_al_2007_2.5Hz.em
	}

	Variable Variable( Ca )
	{
		Name "SRup Ca2+";
		MolarConc 1.7464597368253787e-3;
		# Fixed 1;
	}

	Variable Variable( PLBphos )
	{
		Name "phosphorylated phospholamban";
		MolarConc 0.07920338500674862e-3;
	}

	



	Variable Variable( Inhib1ptot )
	{
		Name "total phosphorylated inhibitor-1 of PP1";
		MolarConc 1.05319402505e-07;
%line 26 PLB.em
	}

	Variable Variable( PLBp )
	{
		Name "phosphorylated phospholamban";
		MolarConc 8.39555881072e-06;
%line 32 PLB.em
	}

	Variable Variable( PLB )
	{
		Name "phospholamban";
		MolarConc 9.76044411893e-05;
%line 38 PLB.em
	}

	Variable Variable( PP1 )
	{
		MolarConc 7.84814623255e-07;
%line 43 PLB.em
	}

	Variable Variable( Inhib1 )
	{
		MolarConc 1.94680597495e-07;
%line 48 PLB.em
	}

	Variable Variable( Inhib1p )
	{
		MolarConc 1.34025760514e-10;
%line 53 PLB.em
	}

	Variable Variable( PP1_Inhib1p )
	{
		MolarConc 1.05185376745e-07;
%line 58 PLB.em
	}

	Variable Variable( dATP_PLB )
	{
		Value 1.2363598668;
	}

	Variable Variable( dATP_Inhib1 )
	{
		Value 0.463547103573;
	}

	Process PLBAssignmentProcess( PLB ) 
	{
		StepperID	PSV;
		Priority	6;

		VariableReferenceList
			[ plb  :.:PLB   1 ]
			[ plbp :.:PLBp  0 ]
			[ phos :.:PLBphos  1 ]
			[ pp1     :.:PP1          1 ]
			[ pp1_i1p :.:PP1_Inhib1p  0 ]
			[ i1   :.:Inhib1      1 ]
			[ i1pt :.:Inhib1ptot  0 ]
			[ i1p     :.:Inhib1p      1 ]
			[ pka  :..:PKA       0 ]
			[ dATP_PLB  :.:dATP_PLB       0 ]
			[ dATP_Inhib1   :.:dATP_Inhib1       0 ];

		PLBItot    0.000106;   # PLB total concentration (M)
%line 89 PLB.em
		PP1tot     8.9e-07;     # total protein phosphatase 1 (M)
%line 90 PLB.em
		Inhib1tot    3e-07;   # inhibitor-1 concentration (M)
%line 91 PLB.em
		b_i1pt     8.91e-07;  #  b - i1pt (M) = PP1tot + KInhib1(=1.0E-9)
%line 92 PLB.em

		KmPKA_PLB  0.021e-3;   # (M)
		kPKA_PLB   0.0324e+3;
		KmPP1_PLB  0.0070e-3;  # (M)
		kPP1_PLB   0.0085e+3;

		KmPKA_Inhib1  0.0010e-3;   # (M)
		kPKA_Inhib1   0.06e+3;
		VmaxPP2A_Inhib1  1.4E-5;     # total protein phosphatase 1 (M)
		KmPP2A_Inhib1    0.0010e-3;   # (M)
	}

		Process ZeroVariableAsFluxProcess( dATP_PLB ) 
	{
		Priority	5;

		VariableReferenceList
			[ dATP_PLB  :.:dATP_PLB       0 ]
			[ ATP  :..:ATPtotal -1 ]
			[ ADP  :..:ADPtotal  1 ]
			[ plbp :.:PLBp          1 ];
	}


	Process ZeroVariableAsFluxProcess( dATP_Inhib1 ) 
	{
		Priority	5;

		VariableReferenceList
			[ dATP_Inhib1   :.:dATP_Inhib1       0 ]
			[ i1pt :.:Inhib1ptot   1 ]
			[ ATP  :..:ATPtotal   -1 ]
			[ ADP  :..:ADPtotal    1 ];
	}




%line 1791 kuzumoto_et_al_2007_2.5Hz.em

%line 1792 kuzumoto_et_al_2007_2.5Hz.em

}


System System( /CELL/CYTOPLASM/SEPARATOR )
{
	StepperID	ODE;

#	Variable Variable( SIZE )
#	{
#		Value 4.266230178693931e-14;
#	}

	Variable Variable( transfer )
	{
		Value 42.66230178693931;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 1835 kuzumoto_et_al_2007_2.5Hz.em
	}

	Process SRDiffusionAssignmentProcess( transfer ) 
	{
		Name "transfer Ca2+ current";

		StepperID	PSV;
		Priority	11;

		VariableReferenceList
			[ I   :.:transfer         1 ]
			[ SR_f    :..:SR_activity 0 ]
			[ GX  :.:GX               0 ]
			[ Cai :../SRREL:Ca        0 ]
			[ Cao :../SRUP:Ca         0 ]
			[ Cm  :../../MEMBRANE:Cm  0 ];

                permeabilityCa  5000.0;  #  pA/M
%line 1853 kuzumoto_et_al_2007_2.5Hz.em
#		permeabilityCa	5.0e+3;  #  pA/M
#               permeabilityCa  248.579545454545;  #  pA/M
#                permeabilityCa  1508.57142857143;  #  pA/M
#                permeabilityCa  200;  #  pA/M
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ in  :../SRUP:Ca       -1 ]  # Cao = in
			[ out :../SRREL:CaTotal  1 ]
			[ i   :.:transfer        0 ]
			[ N_A :/:N_A             0 ]
			[ F   :/:F               0 ]
			[ z   :/:zCa             0 ];
	}
}



System System( /CELL/CYTOPLASM/MITOCHONDRIA )
{
	StepperID	ODE;

	

	Variable Variable( SIZE )
	{
		Value 3.53126797677e-12;
%line 71 Mitochondria.em
	}

	Process MitochondriaAssignmentProcess( _assignment ) 
	{
		Name "mitochondria assingnment";

		StepperID	PSV;
		Priority	18;

		VariableReferenceList
			[ volume     :.:SIZE               1 ]
			[ total      :/CELL/CYTOPLASM:SIZE 0 ]
			[ ratio      :.:volumeRatio        0 ]
			[ Rcm        :.:Rcm                1 ]
			[ Pi         :..:Pi                1 ]
			[ PiTotal    :..:PiTotal           0 ]
			[ PCr        :..:PCr               0 ]
			[ ATPtcell   :..:ATPtotal          0 ]
			[ ADPtcell   :..:ADPtotal          0 ]
			[ AMP        :..:AMP               0 ]
			[ ATPtmit    :.:ATPtotal           0 ]
			[ ADPtmit    :.:ADPtotal           1 ]
			[ ATPfcell   :..:ATPfree           0 ]
			[ ADPfcell   :..:ADPfree           0 ]
			[ ATPfmit    :.:ATPfree            1 ]
			[ ADPfmit    :.:ADPfree            1 ]
			[ Pimit      :.:Pi                 0 ]
			[ Mg         :.:Mg                 0 ]
			[ ATPMg      :.:ATPmg              1 ]
			[ ADPMg      :.:ADPmg              1 ]
			#[ z         :.:Zvalue             0 ]
			[ T          :/:T                  0 ]
			[ R          :/:R                  0 ]
			[ F          :/:F                  0 ]
			[ Proton     :.:Proton             0 ]
			[ Hcell      :..:Proton            0 ]
			[ pH         :.:pH                 1 ]
			[ pHcell     :..:pH                0 ]
			[ rbuffer    :.:rbuffer            1 ]
			[ NADH       :.:NADH               0 ]
			[ NAD        :.:NAD                1 ]
			[ UQH2       :.:UQH2               0 ]
			[ UQ         :.:UQ                 1 ]
			[ Cytc2      :.:Cytc2              0 ]
			[ Cytc3      :.:Cytc3              1 ]
			[ EmN        :.:EmN                1 ]
			[ EmU        :.:EmU                1 ]
			[ Emc        :.:Emc                1 ]
			[ Ema        :.:Ema                1 ]
			#[ Cyta_total :.:Cyta_total         0 ]
			[ Cyta2      :.:Cyta2              1 ]
			[ Cyta3      :.:Cyta3              1 ]
			[ vC1        :.:vC1                1 ]
			[ vC3        :.:vC3                1 ]
			[ vC4        :.:vC4                1 ]
			[ jC1        :.:jC1                1 ]
			[ jC3        :.:jC3                1 ]
			[ jC4        :.:jC4                1 ]
			[ O2         :/:Oxygen             0 ]
			[ CN         :/:CN                 0 ]
			[ jO2        :.:jO2                1 ]
			[ vSN        :.:vSN                1 ]
			[ vANT       :.:vANT               1 ]
			[ vPI        :.:vPI                1 ]
			[ vLK        :.:vLK                1 ]
			[ jSN        :.:jSN                1 ]
			[ jANT       :.:jANT               1 ]
			[ jPI        :.:jPI                1 ]
			[ jLK        :.:jLK                1 ]
			[ FCCP       :/:FCCP               0 ]
			[ vDH        :.:vDH                1 ]
			[ jDH        :.:jDH                1 ];

		#PiTotal 46.0e-3;  # (M)
		ActivityFactor  1.0;
		cbuffer         0.022;  # (mM Proton / pH)
		dpH             0.001;  # HBuffering.javaの内部パラメータ、gradientpH dpHとは別物
		dP_myu          0.861;
		dPsi_ratio      0.65;
		ANP_total       0.01626;
%line 151 Mitochondria.em
		kD_ATP          0.017e-3;
		kD_ADP          0.282e-3;
		NAD_H_total     0.00297;
%line 154 Mitochondria.em
		UQ_H2_total     0.00135;
%line 155 Mitochondria.em
		Cytc_23_total   0.00027;
%line 156 Mitochondria.em
		Cyta_total      0.000135;
%line 157 Mitochondria.em
		ZscaleN         1.0;
		ZscaleU         1.0;
		Zscalec         2.0;
		EmN0           -320.0;  # mV
		EmU0            85.0;  # mV
		Emc0            250.0;  # mV
		Ema0            540.0;  # mV
		Amp             5.0;
%line 165 Mitochondria.em
		kC1             3.9825E-6;  # mM/mV/ms
		kC3             2.2735e-6;  # mM/mV/ms
		KmOC4           0.0008e-3;   #  (M)
		kC4_0           0.06;     #  1/mM/ms, CN/initial
		KmC4            0.12e-3;  #  (M)
		nC4             5.0;
		dGp0            31.9;  # J/mmol = C V /mmol
		kSN             5.7193e-4;  # mM/ms
		nASN            2.5;  # nA of vSN
		kEX             9.0953e-4;  #  mM/ms
		KmADP           0.0035e-3;  #  (M)
		kPI             1.157016667;  # 1/mM/ms
		pKa             6.8;  # dimensionless
		kLK1            4.16667e-8;  # mM/ms
		kLK1_0          4.16667e-8;  # mM/ms
		kLK2            0.038;  # 1/mV
		kDH             4.679e-4;  # mM/ms
		KmN             100.0;  # dimensionless
		PD              0.8;  # dimensionless
		Km_NAD          0.000207510932484;  # M
%line 185 Mitochondria.em
		Km_UQ           2.97754570899e-05;  # M
%line 186 Mitochondria.em
		Km_Cytc3        2.19871129676e-05;  # M
%line 187 Mitochondria.em
		Km_Pi           0.000524746929998;  # M
%line 188 Mitochondria.em
		Km_Proton       3.80521173094e-09;  # M
%line 189 Mitochondria.em
		Km_ATPcell      0.0006962484922;  # M
%line 190 Mitochondria.em
		Km_ADPcell      3.67812389862e-06;  # M
%line 191 Mitochondria.em
		Km_ATPmit       0.000640303765779;  # M
%line 192 Mitochondria.em
		Km_ADPmit       0.000985696234221;  # M
%line 193 Mitochondria.em
		StopgapStepInterval 0.05;
	}

	

	Variable Variable( volumeRatio )
	{
		Value 0.23;
%line 206 Mitochondria.em
	}

	Variable Variable( Rcm )
	{
		Name "Volume ratio between cell and mitochondria";
		Value 4.34782608696;
%line 212 Mitochondria.em
	}

	
	
	


		Variable Variable( Mg )
	{
		Name "Mg";
		MolarConc 0.00038;
%line 233 Mitochondria.em
	}

		Variable Variable( Proton )
	{
		Name "Proton";
		MolarConc 3.80521173094e-08;
%line 240 Mitochondria.em
	}

	
	Variable Variable( pH )
	{
		Name "pH";
		Value 7.41962117305;
%line 251 Mitochondria.em
	}


	
	Variable Variable( rbuffer )
	{
		Name "rbuffer (mM Proton / pH)";
		Value 251378.46458;
%line 265 Mitochondria.em
	}


	

	

	

	

		Variable Variable( ATPtotal )
	{
		Name "Total ATP";
		MolarConc 0.00640303765779;
%line 310 Mitochondria.em
	}

	
	Variable Variable( ATPfree )
	{
		Name "Free ATP";
		MolarConc 0.000274185491643;
%line 323 Mitochondria.em
	}

	
	Variable Variable( ATPmg )
	{
		Name "ATP-Mg";
		MolarConc 0.00612885216614;
%line 335 Mitochondria.em
	}

	
	
	Variable Variable( ADPtotal )
	{
		Name "Total ADP";
		MolarConc 0.00985696234221;
%line 349 Mitochondria.em
	}

	
	Variable Variable( ADPfree )
	{
		Name "Free ADP";
		MolarConc 0.00419888728173;
%line 362 Mitochondria.em
	}

	
	Variable Variable( ADPmg )
	{
		Name "ADP-Mg";
		MolarConc 0.00565807506048;
%line 374 Mitochondria.em
	}

		Variable Variable( Pi )
	{
		Name "Pi";
		MolarConc 0.00524746929998;
%line 381 Mitochondria.em
	}

		Variable Variable( NADH )
	{
		Name "NADH";
		MolarConc 0.000894890675161;
%line 388 Mitochondria.em
	}

	
	Variable Variable( NAD )
	{
		Name "NAD";
		MolarConc 0.00207510932484;
%line 400 Mitochondria.em
	}

		Variable Variable( UQH2 )
	{
		Name "UQH2";
		MolarConc 0.0010522454291;
%line 407 Mitochondria.em
	}

	
	Variable Variable( UQ )
	{
		Name "UQ";
		MolarConc 0.000297754570899;
%line 419 Mitochondria.em
	}

		Variable Variable( Cytc2 )
	{
		Name "cytochrome c2";
		MolarConc 5.01288703245e-05;
%line 426 Mitochondria.em
	}

	
	Variable Variable( Cytc3 )
	{
		Name "cytochrome c3";
		MolarConc 0.000219871129676;
%line 438 Mitochondria.em
	}

	
	Variable Variable( EmN )
	{
		Name "NAD redox potential (mV)";
		Value -308.764327634;
%line 453 Mitochondria.em
	}

	
	Variable Variable( EmU )
	{
		Name "ubiquinone redox potential (mV)";
		Value 68.1356605532;
%line 467 Mitochondria.em
	}

	
	Variable Variable( Emc )
	{
		Name "cytochrome c redox potential (mV)";
		Value 289.50055595;
%line 482 Mitochondria.em
	}

	
	Variable Variable( Ema )
	{
		Name "cytochrome a3 redox potential (mV)";
		Value 635.12371543;
%line 496 Mitochondria.em
	}

	
	Variable Variable( Cyta2 )
	{
		Name "cytochrome a2";
		MolarConc 3.73186833112e-06;
%line 511 Mitochondria.em
	}

	
	Variable Variable( Cyta3 )
	{
		Name "cytochrome a3";
		MolarConc 0.000131268131669;
%line 523 Mitochondria.em
	}

	

		Variable Variable( vC1 )
	{
		Name "rate of Complex I (mM/ms)";
		Value 0.000108759689553;
%line 541 Mitochondria.em
	}

	Variable Variable( jC1 )  # jC1 は、量論係数の都合上 vC1 の 1/5 になっている
	{
		Name "jC1";
		Value 201118.214403;
	}

	Process ZeroVariableAsFluxProcess( NADH_UQOxidoreductase ) 
	{
		Name "NADH UQ Oxidoreductase (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j     :.:jC1     0 ]
			[ NADH  :.:NADH   -1 ]   # ≡ - vC1 / 5
			[ UQH2  :.:UQH2    5 ];  # ≡ vC1
	}

	

		Variable Variable( vC3 )
	{
		Name "rate of Complex III (mM/ms)";
		Value 0.000111752675042;
%line 578 Mitochondria.em
	}

	Variable Variable( jC3 )
	{
		Name "jC3";
		Value 1033264.18784;
	}

	Process ZeroVariableAsFluxProcess( Cytochrome_bc1 ) 
	{
		Name "Cytochrome bc1 (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j     :.:jC3    0 ]
			[ UQH2  :.:UQH2  -1 ]
			[ Cytc2 :.:Cytc2  2 ];
	}

	

		Variable Variable( vC4 )
	{
		Name "rate of Complex IV (mM/ms)";
		Value 5.59358502575e-05;
%line 619 Mitochondria.em
	}

	Variable Variable( jC4 )
	{
		Name "jC4";
		Value 517182.348127;
	}

	Process ZeroVariableAsFluxProcess( CytochromecOxidase ) 
	{
		Name "Cytochrome c oxidase (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j     :.:jC4     0 ]
			[ Cytc2 :.:Cytc2  -4 ];
	}

	

	Variable Variable( jO2 )
	{
		Name "jO2";
		Value -9.22582150713;
	}

	Process ZeroVariableAsFluxProcess( vO2 ) 
	{
		Name "Delta H (1/ms)";

		Priority	12;

		VariableReferenceList
			[ Hmito       :.:Proton  1 ]
			[ j           :.:jO2     0 ];
	}

	

		Variable Variable( vSN )
	{
		Name "rate of ATP synthase (mM/ms)";
		Value 0.000263638826181;
%line 723 Mitochondria.em
	}

	Variable Variable( jSN )
	{
		Name "jSN";
		Value 2437602.12017;
	}

	Process ZeroVariableAsFluxProcess( ATPsynthase ) 
	{
		Name "ATP synthase (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j        :.:jSN       0 ]
			[ ATPtmito :.:ATPtotal  1 ]
			#[ ADPtmito :.:ADPtotal -1 ]    
			[ Pitmito  :.:Pi       -1 ];
	}

	
	Variable Variable( vANT )
	{
		Name "rate of ATP/ADP exchanger (mM/ms)";
		Value 0.000186970250079;
%line 771 Mitochondria.em
	}

	Variable Variable( jANT )
	{
		Name "jANT";
		Value 1728725.18287;
	}

	Process ZeroVariableAsFluxProcess( ATPADPExchanger ) 
	{
		Name "ATP/ADP exchanger, Adenine Nucleotide Transporter (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j        :.:jANT       0 ]
			[ ATPtcell :..:ATPtotal  1 ]
			[ ADPtcell :..:ADPtotal -1 ]
			[ ATPtmito :.:ATPtotal  -1 ];
	}

	

		Variable Variable( vPI )
	{
		Name "rate of phosphate carrier (mM/ms)";
		Value 0.000252434188981;
%line 828 Mitochondria.em
	}

	Variable Variable( jPI )
	{
		Name "jPI";
		Value 2334064.60115;
	}

	Process ZeroVariableAsFluxProcess( PhosphateCarrier ) 
	{
		Name "phosphate carrier (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j       :.:jPI 0 ]
			[ Pitmito :.:Pi  1 ];
	}

	

		Variable Variable( vLK )
	{
		Name "rate of proton leak (mM/ms)";
		Value 0.000241736305079;
%line 870 Mitochondria.em
	}

	Variable Variable( jLK )
	{
		Name "jLK";
		Value 8.89134086618;
	}

	Process ZeroVariableAsFluxProcess( ProtonLeak ) 
	{
		Name "proton leak (1/ms)";

		Priority	12;

		VariableReferenceList
			[ Hmito       :.:Proton   1 ]
			[ j           :.:jLK      0 ];
	}

	

		Variable Variable( vDH )
	{
		Name "rate of substrate dehydrogenation in mitochondria (mM/ms)";
		Value 0.000113077281422;
%line 907 Mitochondria.em
	}

	Variable Variable( jDH )
	{
		Name "jDH";
		Value 209102.297208;
	}

	Process ZeroVariableAsFluxProcess( SubstrateDehydrogenation ) 
	{
		Name "substrate dehydrogenation in mitochondria (1/ms)";

		Priority	12;

		VariableReferenceList
			[ j    :.:jDH  0 ]
			[ NADH :.:NADH 1 ];
	}

	
}
%line 1874 kuzumoto_et_al_2007_2.5Hz.em

%line 1875 kuzumoto_et_al_2007_2.5Hz.em


System System( /CELL/CYTOPLASM/Contraction )
{
	StepperID	ODE;

	Variable Variable( X )
	{
		Name "half length of thick filament + thin filament length over the non-overlap zone";

				Value 0.956753383764;    # units="um"
%line 12 IsotonicContraction.em
		# Value 0.9568;    # units="um"
	}

	Variable Variable( dXdt )
	{
		Name "derivative value of inextensibleLength";
		Value 1.19364901275e-05;    # units="um/ms" ?
%line 19 IsotonicContraction.em
	}


	Variable Variable( vL  )
	{
		Name "Valocity of hSML";
		Value 1.36e-5;
	}

	Variable Variable( aL )
	{
		Name "Acceleration of hSML";
		Value 4.18e-6;
	}

	Variable Variable( qb )
	{
		Name  "Q1"
		Value 11682.9802486;
	}

	Variable Variable( qa1 )
	{
		Name  "1st term of Q2"
		Value 27934.9978915;
	}

	Variable Variable( ATPfactor )
	{
		Value 0.99999703717561594;
	}

	Variable Variable( qa2 )
	{
		Name  "2nd term of Q2"
		Value 3020.27474759;
	}

	Variable Variable( qr )
	{
		Name  "Q3"
		Value 25998.2753404;
	}

	Variable Variable( qd )
	{
		Name  "1st term of Q4"
		Value 26291.9677744;
	}

	Variable Variable( cbFactor )
	{
		Value 2.8495959312890017e-12;
	}

	Variable Variable( qd1 )
	{
		Name  "2nd term of Q4"
		Value 0.00499476562636;
	}

	Variable Variable( qd2 )
	{
		Name  "Q5"
		Value 0.0176544874505;
	}

	Process IsotonicContractionAssignmentProcess( IsotonicContractionAssignment ) 
	{
		Name "Isotonic Contraction Assignment";

		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ L         :..:halfSarcomereLength  1 ]
			[ X         :.:X                     0 ]
			[ CBL       :..:crossBridgeLength    0 ]
			# [ h        :..:crossBridgeLength    0 ]
			[ dXdt      :.:dXdt                  1 ]
			[ forceExt  :/:forceExt              0 ]
			# [ ForceEcomp :.:ForceEcomp           1 ]
			# [ ForceCB   :.:ForceCB               1 ]
			[ aL        :.:aL                    1 ]
			# [ dF        :.:dF                    1 ]
			[ TCaCB     :..:TCaCB                0 ]
			[ TCB       :..:TCB                  0 ]
			[ qb        :.:qb                    1 ]    # Q1
			[ T         :..:T                    1 ]
			[ Tt        :..:Tt                   0 ]
			[ TCa       :..:TCa                  0 ]
			[ Ca        :..:Ca                   0 ]
			[ CaTotal   :..:CaTotal              0 ]
			[ qa1       :.:qa1                   1 ]
			[ Pi        :..:Pi                   0 ]
			[ ATPfactor :.:ATPfactor             0 ]
			[ ATP       :..:ATPtotal             0 ]
			[ qa2       :.:qa2                   1 ]
			[ ADP       :..:ADPtotal             0 ]
			[ qr        :.:qr                    1 ]
			[ qd        :.:qd                    1 ]
			[ cbFactor  :.:cbFactor              0 ]
			[ qd1       :.:qd1                   1 ]
			[ qd2       :.:qd2                   1 ];

		B          1.2;                    # turn over rate of cross bridge sliding 1200/s=1200/1000ms=1.2/ms
		hc         0.005;                  # lower limit of cross bridge lendgth 0.005 um

		A          3.06e+6;                # force of cross bridge and parallel elastic comp.
		L0         0.97;
		K          140000;
		Kl         200;

		Y1         31200.0;
%line 151 IsotonicContraction.em
		Z1         0.06;
%line 152 IsotonicContraction.em

		Y2         0.0039;
%line 154 IsotonicContraction.em
		La         1.17;
		KmPi       1.83e-3;                #  (M)

		KmATP      0.1e-3;                 #  (M)

		Z2         0.0039;
%line 160 IsotonicContraction.em

		Y3         0.06;
%line 162 IsotonicContraction.em
		Z3         1248000.0;
%line 163 IsotonicContraction.em

		Y4         0.12;
%line 165 IsotonicContraction.em

		dXdtFactor 50.0;

		Yd         8000.0;
	}

	Process ZeroVariableAsFluxProcess( d2Ldt2 ) 
	{
		Name "hSML Velocity Change";

		Priority	17;

		VariableReferenceList
			[ aL :.:aL 0 ]
			[ vL :.:vL 1 ];
	}

	Process ZeroVariableAsFluxProcess( dLdt ) 
	{
		Name " hSML Change";

		Priority	15;

		VariableReferenceList
			[ vL :.:vL                    0 ]
			[ L  :..:halfSarcomereLength  1 ];
	}

	Process ZeroVariableAsFluxProcess( crossBridgeLength_X ) 
	{
		Name "Cross Bridge Length";

		Priority	15;

		VariableReferenceList
			[ dXdt :.:dXdt  0 ]
			[ X    :.:X     1 ];
	}


	Process ZeroVariableAsFluxProcess( qb ) 
	{
		Priority	15;

		VariableReferenceList
			[ qb       :.:qb        0 ]
			[ TCa     :..:TCa       1 ]
			# [ Ca      :..:Ca       -1 ]    
			[ CaTotal :..:CaTotal  -1 ];
	}

	Process ZeroVariableAsFluxProcess( qa1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qa1   :.:qa1     0 ]
			[ TCa   :..:TCa   -1 ]
			[ TCaCB :..:TCaCB  1 ];
	}

	Process ZeroVariableAsFluxProcess( qa2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qa2   :.:qa2         0 ]
			[ TCa   :..:TCa        1 ]
			[ TCaCB :..:TCaCB     -1 ]
			[ ATP   :..:ATPtotal -14 ]
			[ ADP   :..:ADPtotal  14 ];
			#[ Pi   :..:Pi        14 ];
	}

	Process ZeroVariableAsFluxProcess( qr ) 
	{
		Priority	15;

		VariableReferenceList
			[ qr      :.:qr        0 ]
			[ TCaCB   :..:TCaCB   -1 ]
			[ TCB     :..:TCB      1 ]
			#[ Ca      :..:Ca       1 ]    
			[ CaTotal :..:CaTotal  1 ];
	}

	Process ZeroVariableAsFluxProcess( qd ) 
	{
		Priority	15;

		VariableReferenceList
			[ qd  :.:qd          0 ]
			[ TCB :..:TCB       -1 ]
			[ ATP :..:ATPtotal -14 ]
			[ ADP :..:ADPtotal  14 ];
			#[ Pi :..:Pi        14 ];
	}

	Process ZeroVariableAsFluxProcess( qd1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qd1 :.:qd1         0 ]
			[ TCB :..:TCB       -1 ]
			[ ATP :..:ATPtotal -14 ]
			[ ADP :..:ADPtotal  14 ];
			#[ Pi :..:Pi        14 ];
	}

	Process ZeroVariableAsFluxProcess( qd2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ qd2     :.:qd2         0 ]
			[ TCaCB   :..:TCaCB     -1 ]
			#[ Ca      :..:Ca         1 ]    
			[ CaTotal :..:CaTotal    1 ]
			[ ATP     :..:ATPtotal -14 ]
			[ ADP     :..:ADPtotal  14 ];
			#[ Pi     :..:Pi        14 ];
	}

}



%line 1877 kuzumoto_et_al_2007_2.5Hz.em

%line 1878 kuzumoto_et_al_2007_2.5Hz.em



System System(/CELL/MEMBRANE/INa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -22.3734006843;
%line 30 INa.em
	}

	Variable Variable( POpen )
	{
		Value 1.028312972845809e-05;
	}

	Variable Variable( pRP )
	{
		Value 0.391716095199;
%line 40 INa.em
	}

	Variable Variable( pAP )
	{
		Value 1.59717600392e-05;
%line 45 INa.em
	}

	Variable Variable( pAI )
	{
		Value 0.368385053951;
%line 50 INa.em
	}

	Variable Variable( pRI )
	{
		Value 0.23988287909;
%line 55 INa.em
	}

	Variable Variable( vRPAP )
	{
		Value -1.59939860247e-05;
	}

	Variable Variable( vAPAI )
	{
		Value -1.61606418138e-05;
	}

	Variable Variable( vAIRI )
	{
		Value 0.00067476444273;
	}

	Variable Variable( vRPRI )
	{
		Value -0.00109716431175;
	}

	Variable Variable( vgate )
	{
		Value 9.69484197675e-05;
	}

	Variable Variable( gate )
	{
		Value 0.643831969877;
%line 85 INa.em
	}

	Variable Variable( i )
	{
		Value 0.00217179699865;
	}

	Variable Variable( cNa )
	{
		Value -22.3740519006;
	}

	Variable Variable( cK )
	{
		Value 0.000651216154604;
	}

	Variable Variable( GX ){
#		Value 1.0;
%line 104 INa.em
		Value 1.0;
%line 105 INa.em
	}

#	Process GXAssignmentProcess ( GX )
#	{
#		StepperID  PSV;
#		Priority   25;#

#		VariableReferenceList
#			[ GX       :.:GX                    1 ]			
#			[ rel_Act  :../../CYTOPLASM:Nav1_5  0 ]
#			[ Cm       :..:Cm                   0 ];

#		Cm_V 	211.2;		
%line 118 INa.em
#	}

	Process INaAssignmentProcess( pOpen ) 
	{
		StepperID  PSV;
		Priority   20;

		VariableReferenceList
			[ pAP      :.:pAP                   0 ]
			[ pRP      :.:pRP                   0 ]
			[ pAI      :.:pAI                   0 ]
			[ pRI      :.:pRI                   1 ]
			[ vRPAP    :.:vRPAP                 1 ]
			[ vAPAI    :.:vAPAI                 1 ]
			[ vAIRI    :.:vAIRI                 1 ]
			[ vRPRI    :.:vRPRI                 1 ]
			[ v        :..:Vm                   0 ]
			[ dy       :.:vgate                 1 ]
			[ y        :.:gate                  0 ]
			[ pOpen    :.:POpen                 1 ]
			[ i        :.:i                     1 ]
			[ GX       :.:GX                    0 ]
#			[ GX       :../../CYTOPLASM:Nav1_5  0 ]
			[ Cm       :..:Cm                   0 ]
			[ cNa      :.:cNa                   1 ]
			[ CFNa     :..:CFNa                 0 ]
			[ cK       :.:cK                    1 ]
			[ CFK      :..:CFK                  0 ]
			[ I        :.:I                     1 ];

		kAIAP           0.0000875;

                permeabilityNa  21.7;
%line 151 INa.em
                permeabilityK   2.17;
%line 152 INa.em
				
	}

	Process ZeroVariableAsFluxProcess( vRPAP ) 
	{
		Priority  15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			[ pAP   :.:pAP    1 ]
			[ vRPAP :.:vRPAP  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAPAI ) 
	{
		Priority  15;

		VariableReferenceList
			[ pAP   :.:pAP   -1 ]
			[ pAI   :.:pAI    1 ]
			[ vAPAI :.:vAPAI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAIRI ) 
	{
		Priority  15;

		VariableReferenceList
			[ pAI   :.:pAI   -1 ]
			#[ pRI  :.:pRI    0 ]
			[ vAIRI :.:vAIRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vRPRI ) 
	{
		Priority  15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			#[ pRI  :.:pRI    0 ]
			[ vRPRI :.:vRPRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( gate ) 
	{
		Priority  15;

		VariableReferenceList
			[ dy :.:vgate 0 ]
			[ y  :.:gate  1 ];
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 205 INa.em

}



%line 1880 kuzumoto_et_al_2007_2.5Hz.em
     %line 1881 kuzumoto_et_al_2007_2.5Hz.em



System System(/CELL/MEMBRANE/ICaL)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.0215402848793;
%line 37 ICaL_V.em
	}

		Variable Variable( pRP )
	{
		Value 0.998655955409;
%line 43 ICaL_V.em
	}

	Variable Variable( pAP )
	{
		Value 1.06891561403e-06;
%line 48 ICaL_V.em
	}

	Variable Variable( pAI )
	{
		Value 0.000309743546175;
%line 53 ICaL_V.em
	}

	Variable Variable( pRI )
	{
		Value 0.00103323212951;
%line 58 ICaL_V.em
	}

	Variable Variable( vRPAP )
	{
		Value -3.11032857788e-07;
	}

	Variable Variable( vAPAI )
	{
		Value -3.05467883719e-07;
	}

	Variable Variable( vAIRI )
	{
		Value 9.19580075465e-06;
	}

	Variable Variable( vRPRI )
	{
		Value -3.98996407608e-05;
	}

		Variable Variable( pU )
	{
		Value 0.182480963265;
%line 84 ICaL_V.em
	}

	Variable Variable( pUCa )
	{
		Value 8.75164495267e-05;
%line 89 ICaL_V.em
	}

	Variable Variable( pC )
	{
		Value 0.44939265822;
%line 94 ICaL_V.em
	}

	Variable Variable( pCCa )
	{
		Value 0.368038862066;
%line 99 ICaL_V.em
	}

	Variable Variable( vCU )
	{
		Value 0.00039481298286;
	}

	Variable Variable( vUCaU )
	{
		Value 7.98993896509e-05;
	}

	Variable Variable( vCCaUCa )
	{
		Value 7.97809012855e-05;
	}

	Variable Variable( vCCaC )
	{
		Value 0.00154496996709;
	}

		Variable Variable( vgate )
	{
		Value 1.57021018524e-05;
	}

	Variable Variable( gate )
	{
		Value 0.999468049883;
%line 130 ICaL_V.em
	}

	Variable Variable( POpen )
	{
		Value 1.9347175017002756e-7;
	}

	Variable Variable( i )
	{
		Value 4.08612336359e-05;
	}

	Variable Variable( cNa )
	{
		Value -1.61744315758e-05;
	}

	Variable Variable( cK )
	{
		Value 9.28818137278e-08;
	}

	Variable Variable( cCa )
	{
		Value -0.0215242033295;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 159 ICaL_V.em
	}

	Process ICaLAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ vAPAI    :.:vAPAI                  1 ]
			[ vRPAP    :.:vRPAP                  1 ]
			[ vAIRI    :.:vAIRI                  1 ]
			[ vRPRI    :.:vRPRI                  1 ]
			[ v        :..:Vm                    0 ]
			[ pRI      :.:pRI                    1 ]
			[ pRP      :.:pRP                    0 ]
			[ pAP      :.:pAP                    0 ]
			[ pAI      :.:pAI                    0 ]

			[ Cai      :../../CYTOPLASM:Ca       0 ]
			[ vCU      :.:vCU                    1 ]
			[ vUCaU    :.:vUCaU                  1 ]
			[ vCCaUCa  :.:vCCaUCa                1 ]
			[ vCCaC    :.:vCCaC                  1 ]

			[ pCCa     :.:pCCa                   1 ]
			[ pU       :.:pU                     0 ]
			[ pUCa     :.:pUCa                   0 ]
			[ pC       :.:pC                     0 ]

			[ dy       :.:vgate                  1 ]
			[ y        :.:gate                   0 ]

			[ PKA      :../../CYTOPLASM:PKA      0 ]
			[ ATP      :../../CYTOPLASM:ATPtotal 0 ]
			[ pOpen    :.:POpen                  1 ]
			[ CaDiadic :..:CaDiadic              1 ]
			[ i        :.:i                      1 ]
			[ GX       :.:GX                     0 ]

			[ Cm       :..:Cm                    0 ]
			[ cNa      :.:cNa                    1 ]
			[ CFNa     :..:CFNa                  0 ]
			[ cK       :.:cK                     1 ]
			[ CFK      :..:CFK                   0 ]
			[ cCa      :.:cCa                    1 ]
			[ CFCa     :..:CFCa                  0 ]
			[ I        :.:I                      1 ];


		kAPAI             0.004;
		kAIAP             0.001;

		kUUCa             6.954;
		kCCCa             6.954;

		kCU               0.143;
		kUC               0.35;
		kUCaU             2.0020000000000002;
		kCCaUCa           0.0003;
		kUCaCCa           0.35;
		kCCaC             0.0042;

		PKA0              1.36440550819e-07;   #  (M)
%line 222 ICaL_V.em
		KmPKA             6.5e-07;  #  (M)
%line 223 ICaL_V.em
		hill_n            2.0;
%line 224 ICaL_V.em
		MAX               3.0;
%line 225 ICaL_V.em
		#PKA_factor0       0.873393690783;
%line 226 ICaL_V.em

                permeabilityNa    0.0008325;
%line 228 ICaL_V.em
		permeabilityK     0.016425;
%line 229 ICaL_V.em
	        permeabilityCa    45.0;
%line 230 ICaL_V.em
		
		kSingleCurrentAmp 0.3;
%line 232 ICaL_V.em
		amplitudePKAf     0.0;
%line 233 ICaL_V.em

	}

	Process ZeroVariableAsFluxProcess( vRPAP ) 
	{
		Priority	15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			[ pAP   :.:pAP    1 ]
			[ vRPAP :.:vRPAP  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAPAI ) 
	{
		Priority	15;

		VariableReferenceList
			[ pAP :.:pAP   -1 ]
			[ pAI :.:pAI    1 ]
			[ vAPAI   :.:vAPAI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vAIRI ) 
	{
		Priority	15;

		VariableReferenceList
			[ pAI   :.:pAI   -1 ]
			#[ pRI   :.:pRI    0 ]
			[ vAIRI :.:vAIRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vRPRI ) 
	{
		Priority	15;

		VariableReferenceList
			[ pRP   :.:pRP   -1 ]
			#[ pRI   :.:pRI    0 ]
			[ vRPRI :.:vRPRI  0 ];
	}

	Process ZeroVariableAsFluxProcess( vCU ) 
	{
		Priority	15;

		VariableReferenceList
			[ pC   :.:pC   -1 ]
			[ pU   :.:pU    1 ]
			[ vCU :.:vCU   0 ];
	}

	Process ZeroVariableAsFluxProcess( vUCaU ) 
	{
		Priority	15;

		VariableReferenceList
			[ pUCa   :.:pUCa    -1 ]
			[ pU   :.:pU       1 ]
			[ vUCaU :.:vUCaU    0 ];
	}

	Process ZeroVariableAsFluxProcess( vCCaUCa ) 
	{
		Priority	15;

		VariableReferenceList
			#[ pCCa   :.:pCCa     0 ]
			[ pUCa   :.:pUCa     1 ]
			[ vCCaUCa :.:vCCaUCa  0 ];
	}

	Process ZeroVariableAsFluxProcess( vCCaC ) 
	{
		Priority	15;

		VariableReferenceList
			#[ pCCa   :.:pCCa     0 ]
			[ pC   :.:pC       1 ]
			[ vCCaC :.:vCCaC    0 ];
	}

	Process ZeroVariableAsFluxProcess( gate ) 
	{
		Priority	15;

		VariableReferenceList
			[ dy :.:vgate  0 ]
			[ y  :.:gate   1 ];
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process IonFluxProcess( jCa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cae  :/:Ca                1 ]
			[ Cai  :../../CYTOPLASM:CaTotal -1 ]
			[ i   :.:cCa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zCa                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentCa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCa  1 ]
			[ c     :.:cCa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 326 ICaL_V.em

}


%line 1881 kuzumoto_et_al_2007_2.5Hz.em
    %line 1882 kuzumoto_et_al_2007_2.5Hz.em


System System(/CELL/MEMBRANE/ICaT)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.147360119624;
%line 24 ICaT.em
	}

	Variable Variable( POpen )
	{
		Value 1.285699651743902E-5;
	}

	Variable Variable( activation )
	{
		Value 1.47076654231e-05;
%line 34 ICaT.em
	}

	Variable Variable( inactivation )
	{
		Value 0.874169771175;
%line 39 ICaT.em
	}

	Variable Variable( v_activation )
	{
		Value -1.42658286626e-10;
	}

	Variable Variable( v_inactivation )
	{
		Value 7.31376837008e-05;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 53 ICaT.em
	}

	Process ICaTAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ dy1   :.:v_activation          0 ]
			[ dy2   :.:v_inactivation        0 ]
			[ v     :..:Vm                   0 ]
			[ y1    :.:activation            0 ]
			[ y2    :.:inactivation          0 ]
			[ pOpen :.:POpen                 1 ]
			[ GX       :.:GX                 0 ]
#			[ GX    :../../CYTOPLASM:Cav3_1  0 ]
			[ Cm    :..:Cm                   0 ]
			[ CFCa  :..:CFCa                 0 ]
			[ I     :.:I                     1 ];

		permeabilityCa  4.636;  # pA/mM
%line 74 ICaT.em
	}

	Process ZeroVariableAsFluxProcess( activation ) 
	{
		Priority	15;

		VariableReferenceList
			[ y :.:activation    1 ]
			[ v :.:v_activation  0 ];
	}

	Process ZeroVariableAsFluxProcess( inactivation ) 
	{
		Priority	15;

		VariableReferenceList
			[ y :.:inactivation    1 ]
			[ v :.:v_inactivation  0 ];
	}

	
	Process IonFluxProcess( jCa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cae  :/:Ca                1 ]
			[ Cai  :../../CYTOPLASM:CaTotal -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zCa                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentCa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCa  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 95 ICaT.em

}


%line 1882 kuzumoto_et_al_2007_2.5Hz.em
    %line 1883 kuzumoto_et_al_2007_2.5Hz.em


System System(/CELL/MEMBRANE/Ist)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -11.854337592615822;
	}

	Variable Variable( dactivation )
	{
		Value 0.0;
	}

	Variable Variable( dinactivation )
	{
		Value 0.0;
	}

	Variable Variable( dslowInactivation )
	{
		Value 0.0;
	}

	Variable Variable( activation )
	{
		Name	"the open probability of activation gate";
		Value 0.3141402829962753;
	}

	Variable Variable( inactivation )
	{
		Name	"the open probability of inactivation gate";
		Value 0.7679681596792866;
	}

	Variable Variable( slowInactivation )
	{
		Name	"the C2 state probability of slow inactivation gate";
		Value 0.8299423547898264;
	}

	Variable Variable( GX ){
		Value 0;
%line 73 Ist.em
	}

	Process IstAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	19;

		VariableReferenceList
			[ Vm     :..:Vm     0 ]
			[ Cm     :..:Cm                  0 ]
			[ CFNa   :..:CFNa                0 ]
			[ CFK    :..:CFK                 0 ]
			[ Cai :../../CYTOPLASM:Ca  0 ]
			[ PKA    :../../CYTOPLASM:PKA     0 ]
			[ activation     :.:activation                0 ]
			[ inactivation     :.:inactivation                0 ]
			[ slowInactivation    :.:slowInactivation               0 ]
			[ dactivation     :.:dactivation                0 ]
			[ dinactivation     :.:dinactivation                0 ]
			[ dslowInactivation    :.:dslowInactivation               0 ]
			[ pOpen  :.:POpen                1 ]
			[ i      :.:i                    1 ]
			[ GX       :.:GX                     0 ]
#			[ GX     :../../CYTOPLASM:ST_gene  0 ]
			[ cK     :.:cK                   1 ]
			[ cNa    :.:cNa                  1 ]
			[ I      :.:I                    1 ];

		PKA0            1.36440550819e-07;   #  (M)
%line 102 Ist.em
		max             1.0;

                permeabilityNa  0.007375;  # pA//pF/mM
%line 105 Ist.em
                permeabilityK   0.0043125; # pA/pF/mM
%line 106 Ist.em
	}

	Process ZeroVariableAsFluxProcess( activation ) 
	{
		Priority	16;

		VariableReferenceList
			[ y     :.:activation   1 ]
			[ dy     :.:dactivation   0 ];
	}

	Process ZeroVariableAsFluxProcess( inactivation ) 
	{
		Priority	16;

		VariableReferenceList
			[ y     :.:inactivation   1 ]
			[ dy     :.:dinactivation   0 ];
	}

	Process ZeroVariableAsFluxProcess( slowInactivation ) 
	{
		Priority	16;

		VariableReferenceList
			[ y     :.:slowInactivation   1 ]
			[ dy     :.:dslowInactivation   0 ];
	}


	Variable Variable( POpen )
	{
		Value 0.0;
	}

	Variable Variable( i )
	{
		Value 0.0;
	}

	Variable Variable( cK )
	{
		Value 0.0;
	}

	Variable Variable( cNa )
	{
		Value 0.0;
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 157 Ist.em

}


%line 1883 kuzumoto_et_al_2007_2.5Hz.em
     %line 1884 kuzumoto_et_al_2007_2.5Hz.em


System System(/CELL/MEMBRANE/IK1)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 24.2928839816;
%line 23 IK1.em
	}

	Variable Variable( POpen )
	{
		Value 4.26E-01;
	}

	Variable Variable( vPspm )
	{
		Value -3.73433916526e-07;
	}

	Variable Variable( Pspm )
	{
		Value 0.637340766173;
%line 38 IK1.em
	}

	Variable Variable( fracO )
	{
		Value 0.414217508395;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 47 IK1.em
	}

	Process IK1AssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ Vm    :..:Vm                     0 ]
			[ EK    :..:EK                     0 ]
			[ Mg    :../../CYTOPLASM:Mg        0 ]
			[ SPM   :../../CYTOPLASM:Spermine  0 ]
			[ vPspm :.:vPspm                   1 ]
			[ Pspm  :.:Pspm                    0 ]
			[ fracO :.:fracO                   1 ]
			[ pOpen :.:POpen                   1 ]
			[ GX    :.:GX                      0 ]			
#			[ GX    :../../CYTOPLASM:Kir2_1    0 ]
			[ Ko    :/:K                       0 ]
			[ Cm    :..:Cm                     0 ]
			[ I     :.:I                       1 ];

		Phi        0.9;

		amplitude  2.6;
%line 72 IK1.em

		constant   5.4;
		power      0.6;
		A         -0.6;
		B          3.1;
	}


	

	Process ZeroVariableAsFluxProcess( Pspm ) 
	{
		Priority	15;

		VariableReferenceList
			[ Pspm   :.:Pspm   1 ]
			[ vPspm  :.:vPspm  0 ];
	}

	
	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 95 IK1.em

}


%line 1884 kuzumoto_et_al_2007_2.5Hz.em
     %line 1885 kuzumoto_et_al_2007_2.5Hz.em


System System(/CELL/MEMBRANE/IKr)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0.0948689472945;
%line 25 IKr.em
	}

	Variable Variable( POpen )
	{
		Value 0.0635681552845;
%line 30 IKr.em
	}

	Variable Variable( gate1 )
	{
		Value 0.00118011832989;
%line 35 IKr.em
	}

	Variable Variable( gate2 )
	{
		Value 0.162180965269;
%line 40 IKr.em
	}

	Variable Variable( gate3 )
	{
		Value 0.969315526153;
%line 45 IKr.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 49 IKr.em
	}

	Process IKrAssignmentProcess( I )
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ y1    :.:gate1               0 ]
			[ y2    :.:gate2               0 ]
			[ y3    :.:gate3               0 ]
			[ pOpen :.:POpen               1 ]
			[ I     :.:I                   1 ]
			[ GX    :.:GX                  0 ]
			[ Ko    :/:K                   0 ]
			[ EK    :..:EK                 0 ]
			[ Vm    :..:Vm                 0 ]
			[ Cm    :..:Cm                 0 ];

                amplitude  0.035;
%line 69 IKr.em

		constant 5.4;
		power    0.2;
		
		dy1      -1.57812176308e-05;
		dy2      -0.00131940244958;
		dy3      1.0760828538e-07;
	}

	Process SpyFluxProcess( gate1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate1  1 ];

		target  "Process:/CELL/MEMBRANE/IKr:I:dy1";
	}

	Process SpyFluxProcess( gate2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate2  1 ];

		target  "Process:/CELL/MEMBRANE/IKr:I:dy2";
	}

	Process SpyFluxProcess( gate3 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate3  1 ];

		target  "Process:/CELL/MEMBRANE/IKr:I:dy3";
	}

	
	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 109 IKr.em

}

# Author Yasuhiro NAITO
# Version 0.1 2008-08-20 06:55:43 +0900

#simBio 1.0 className	"org.simBio.bio.terashima_et_al_2006.current.potassium.IKr"
%line 1885 kuzumoto_et_al_2007_2.5Hz.em
     %line 1886 kuzumoto_et_al_2007_2.5Hz.em


System System(/CELL/MEMBRANE/IKs)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -1.21154215503;
%line 44 IKs.em
	}

	Variable Variable( vgate1 )
	{
		Name	"the open probability of voltage-dependent gate";
		Value -0.000704918007056;
	}

	Variable Variable( vgate2 )
	{
		Name	"the open probability of [Ca2+]i-dependent gate";
		Value -4.44991510009e-05;
	}

	Variable Variable( vgateC2 )
	{
		Name	"the C2 state probability of [Ca2+]i-dependent gate";
		Value -3.78567359532e-05;
	}

	Variable Variable( gate1 )
	{
		Name	"the open probability of voltage-dependent gate";
		Value 0.153860656384;
%line 68 IKs.em
	}

	Variable Variable( gate2 )
	{
		Name	"the open probability of [Ca2+]i-dependent gate";
		Value 0.459164084551;
%line 74 IKs.em
	}

	Variable Variable( gateC2 )
	{
		Name	"the C2 state probability of [Ca2+]i-dependent gate";
		Value 0.0783438946628;
%line 80 IKs.em
	}

	Variable Variable( KCNQ1 )
	{
		MolarConc 2.11326506635e-08;
%line 85 IKs.em
	}

	Variable Variable( KCNQ1free )
	{
		MolarConc 1.45505137689e-09;
%line 90 IKs.em
	}

	Variable Variable( vKCNQ1p )
	{
		MolarConc 0.0;
	}

	Variable Variable( KCNQ1p )
	{
		MolarConc 2.37320352913e-09;
%line 100 IKs.em
	}

	Variable Variable( KCNQ1p_ratio )
	{
		Value 0.0949281411652;
%line 105 IKs.em
	}

	Variable Variable( POpen )
	{
		Value 0.0121501643734;
%line 110 IKs.em
	}

	Variable Variable( i )
	{
		Value 2.5661147156641411;
	}

	Variable Variable( cK )
	{
		Value 0.00888036354663;
	}

	Variable Variable( cNa )
	{
		Value -1.2204225186;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 129 IKs.em
	}

	Process IKsAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ pka     :../../CYTOPLASM:PKA     0 ]
			[ PKAtot  :../../CYTOPLASM:PKAtot  0 ]
			[ vkcnq1p :.:vKCNQ1p               0 ]
			[ Vm      :..:Vm                   0 ]
			[ Ca      :../../CYTOPLASM:Ca      0 ]
			[ dy1     :.:vgate1                1 ]
			[ dy2     :.:vgate2                1 ]
			[ dyC2    :.:vgateC2               1 ]
			[ y1      :.:gate1                 0 ]
			[ y2      :.:gate2                 0 ]
			[ yC2     :.:gateC2                0 ]
			[ pOpen   :.:POpen                 0 ]
			[ i       :.:i                     1 ]
			[ GX      :.:GX                    0 ]
			[ Cm      :..:Cm                   0 ]
			[ kcnq1p  :.:KCNQ1p                0 ]
			[ kcnq1   :.:KCNQ1                 0 ]
			[ cK      :.:cK                    1 ]
			[ CFK     :..:CFK                  0 ]
			[ cNa     :.:cNa                   1 ]
			[ CFNa    :..:CFNa                 0 ]
			[ I       :.:I                     1 ];

		eps             10.0;
		kPKA_KCNQ1      0.0004104;
%line 162 IKs.em
		KmPKA_KCNQ1     0.003528;
%line 163 IKs.em
		kPP1_KCNQ1      1.704e-05;
%line 164 IKs.em
		KmPP1_KCNQ1     5.6e-08;  #  ( M )
%line 165 IKs.em
		PKAtot_Yot      0.04e-3;
		PP1tot_Yot      0.025e-3;

		F_KCNQ1p0       0.0947077;

		b2              0.000148;
		a3              0.005;
		b3              0.03;

		Yottot          0.025e-3;
		Kyotiao         1.0e-7;

		KCNQ1tot        0.025e-6;  #  ( M )
		permeabilityK0  0.025;
%line 179 IKs.em

		relativePNa     0.04;

		amplitudePKAf   0.0;
%line 183 IKs.em

		ka11            85.0;
%line 185 IKs.em
		ka12            -10.5;
%line 186 IKs.em
		ka13            370.0;
%line 187 IKs.em
		ka14            -62.0;
%line 188 IKs.em
		kb11            1450.0;
%line 189 IKs.em
		kb12            20.0;
%line 190 IKs.em
		kb13            300.0;
%line 191 IKs.em
		kb14            210.0;
%line 192 IKs.em

	}

	Process ZeroVariableAsFluxProcess( KCNQ1p ) 
	{
		Priority	15;

		VariableReferenceList
			  # himeno modelでは[ KCNQ1 -1 ]が追加される
%line 201 IKs.em
			[ vkcnq1p :.:vKCNQ1p  0 ]
			[ kcnq1p  :.:KCNQ1p   1 ];
	}

	Process ZeroVariableAsFluxProcess( gate1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ y1  :.:gate1   1 ]
			[ dy1 :.:vgate1  0 ];
	}

	Process ZeroVariableAsFluxProcess( gate2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ dy2 :.:vgate2  0 ]
			[ yC2 :.:gateC2 -1 ]
			[ y2  :.:gate2   1 ];
	}

	Process ZeroVariableAsFluxProcess( gateC2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ dyC2 :.:vgateC2  0 ]
			[ yC2  :.:gateC2   1 ];
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 234 IKs.em

}

     


System System(/CELL/MEMBRANE/Ito)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value -1.0239203896445138E-9;
	}

	Variable Variable( vgate1 )
	{
		Value 1.86016106945e-08;
	}

	Variable Variable( vgate2 )
	{
		Value 9.26233516051e-09;
	}

	Variable Variable( gate1 )
	{
		Value 7.689524645841579E-4;
	}

	Variable Variable( gate2 )
	{
		Value 0.9999188299582759;
	}

	Variable Variable( POpen )
	{
		Value 4.54635376672e-10;
%line 48 Ito.em
	}

	Process ZeroVariableAsFluxProcess( gate1 )
	{
		Priority	18;

		VariableReferenceList
			[ y  :.:gate1 1 ]
			[ dy  :.:vgate1 0 ];
	}

	Process ZeroVariableAsFluxProcess( gate2 )
	{
		Priority	18;

		VariableReferenceList
			[ y  :.:gate2 1 ]
			[ dy  :.:vgate2 0 ];
	}

	Variable Variable( GX ){
		Value 1.0;
%line 70 Ito.em
	}

	Process ItoAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	19;

		VariableReferenceList
			[ Vm :..:Vm   0 ]
			[ dy1    :.:vgate1                0 ]
			[ dy2    :.:vgate2                0 ]
			[ y1    :.:gate1                0 ]
			[ y2    :.:gate2                0 ]
			[ pOpen :.:POpen                1 ]
			[ i     :.:i                    1 ]
			[ GX    :.:GX                   0 ]
			[ Cm    :..:Cm                  0 ]
			[ cK    :.:cK                   1 ]
			[ CFK   :..:CFK                 0 ]
			[ cNa   :.:cNa                  1 ]
			[ CFNa  :..:CFNa                0 ]
			[ I     :.:I                    1 ];

                permeabilityK  0.00025;	
%line 94 Ito.em
                permeabilityNa   2.25e-05;
%line 95 Ito.em
	}

	Variable Variable( i )
	{
		Value 2.5661147156641411;
	}

	Variable Variable( cK )
	{
		Value 3.32208686491e-12;
	}

	Variable Variable( cNa )
	{
		Value -1.02724247652e-09;
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 113 Ito.em

}


%line 269 IKs.em
     %line 270 IKs.em
# Author Yasuhiro NAITO
# Version 0.1 2009-07-10 14:47:15 +0900

#simBio 1.0 className	"org.simBio.bio.himeno_et_al_2008.IKACh"



System System(/CELL/MEMBRANE/IKACh)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0.0;
%line 30 IKACh.em
	}

	Variable Variable( dgate )
	{
		Value 0.0;
	}

	Variable Variable( gate )
	{
		Value 0.027497803646;
%line 40 IKACh.em
	}

	Variable Variable( pOpen )
	{
		Value 0.0;
	}

	Variable Variable( GX ){
		Value 0;
%line 49 IKACh.em
	}

	Process IKAChAssignmentProcess( I )
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ I     :.:I                        1 ]
			[ Vm    :..:Vm                      0 ]
			[ EK    :..:EK                      0 ]
			[ ACh   :../../CYTOPLASM:ACh        0 ]
			[ dgate :.:dgate                    1 ]
			[ gate  :.:gate                     0 ]
			[ pOpen :.:pOpen                    1 ]
			[ GX    :.:GX                       0 ]
			[ Cm    :..:Cm                      0 ];

		Km             0.0042e-3;  # M
		permeabilityK  0.135;  # pA/mV
%line 69 IKACh.em
#		permeabilityK  0.135;  # pA/mV
#                permeabilityK  0.0;  # pA/mV
	}

	Process ZeroVariableAsFluxProcess( gate ) 
	{
		Priority	15;

		VariableReferenceList
			[ y   :.:gate  1 ]
			[ dy  :.:dgate 0 ];
	}

	
	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 83 IKACh.em

}

%line 270 IKs.em
   %line 271 IKs.em


System System(/CELL/MEMBRANE/INaK)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value 71.0920500406;
%line 24 INaK.em
	}

	Variable Variable( vgate )
	{
		Value 1.76804588672e-06;
	}

	Variable Variable( gate )
	{
		Value 0.535593815822;
%line 34 INaK.em
	}

	Variable Variable( Couabain )
	{
		MolarConc 0.0;
	}

	Variable Variable( E1A )
	{
		Value 0.209952775275;
	}

	Variable Variable( E2A )
	{
		Value 0.532101004335;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 53 INaK.em
	}

	Process INaKAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	20;

		VariableReferenceList
			[ Nai      :../../CYTOPLASM:Na          0 ]
			[ Ki       :../../CYTOPLASM:K           0 ]
			[ PKA      :../../CYTOPLASM:PKA         0 ]
			[ Vm       :..:Vm                       0 ]
			[ vrtf     :..:_vrtf                    0 ]
			[ T        :/:T                         0 ]
			[ Nao      :/:Na                        0 ]
			[ Ko       :/:K                         0 ]
			[ R        :/:R                         0 ]
			[ F        :/:F                         0 ]
			[ ATP      :../../CYTOPLASM:ATPtotal    0 ]
			[ GX       :.:GX                        0 ]
			[ Couabain :.:Couabain                  0 ]
			[ dy       :.:vgate                     1 ]
			[ y        :.:gate                      0 ]
			[ E1A      :.:E1A                       1 ]
			[ E2A      :.:E2A                       1 ]
			[ I        :.:I                         1 ]
			[ Cm       :..:Cm                       0 ];

		KmNai         4.05e-3;   #  control dissociation constant for intracellular Sodium (M)
		KmKi          32.88e-3;  #  dissociation constant for intracellular Potassium (M)

		nHNa          1.06;      #  Hill coefficient of Sodium
		nHK           1.12;      #  Hill coefficient of Potassium

		amplitudePKAf 1.0;       #  to modulate PKA effect

		# PKA phosphorylation parameter
		ratio         0.35;
		KmPKA         0.0005e-3; #  (M)
		hill          5.0;

		KmNao         69.8e-3;   #  dissociation constant for extracellular Sodium (M)
		KmKo          0.258e-3;  #  dissociation constant for extracellular Potassium (M)

		ramda        -0.82;      #  relative depth of access channel

		k2            0.04;      #  rate constant for the reaction E2Na->E1Na
		k3            0.01;      #  rate constant for the reaction E1K->E2K
		k4            0.165;     #  rate constant for the reaction E2K->E1K

		KmATP         0.094e-3;  #  hydrolysis coefficient of ATP (M)
		amplitude0    10.8;      #  (pA/pF)
%line 105 INaK.em
#		amplitude0    10.8;      #  (pA/pF)
#                amplitude0    1.43;      #  (pA/pF)
	}

	Process ZeroVariableAsFluxProcess( gate )
	{
		Priority	15;

		VariableReferenceList
			[ y  :.:gate   1 ]
			[ dy :.:vgate  0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                      -2 ]
			[ Ki  :../../CYTOPLASM:K         2 ]
			[ Nae :/:Na                      3 ]
			[ Nai :../../CYTOPLASM:Na       -3 ]
			[ ATP :../../CYTOPLASM:ATPtotal -1 ]
			[ ADP :../../CYTOPLASM:ADPtotal  1 ]
			#[ Pi :../../CYTOPLASM:Pi        1 ]
			[ i   :.:I                       0 ]
			[ N_A :/:N_A                     0 ]
			[ F   :/:F                       0 ]
			[ z   :/:zNa                     0 ];
	}


	
	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

%line 138 INaK.em

	
	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:I               0 ];

		n 3;
		
	}

%line 140 INaK.em

	
	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n -2;
		
	}

%line 142 INaK.em

	
	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 144 INaK.em

}


%line 271 IKs.em
    %line 272 IKs.em


System System(/CELL/MEMBRANE/INaCa)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value -12.3822080255;
%line 27 INaCa.em
	}

	Variable Variable( pE1total )
	{
		Value 0.152769658963;
%line 32 INaCa.em
	}

	Variable Variable( pE2total )
	{
		Value 0.000346222378344;
%line 37 INaCa.em
	}

	Variable Variable( vInActivation1 )
	{
		Value 2.4577513386e-06;
	}

	Variable Variable( vInActivation2 )
	{
		Value 0.000321955009939;
	}

	Variable Variable( inActivation1 )
	{
		Value 0.174422487248;
%line 52 INaCa.em
	}

	Variable Variable( inActivation2 )
	{
		Value 0.67246163141;
%line 57 INaCa.em
	}

	Variable Variable( E1A )
	{
		Value 0.0277077332606;
	}

	Variable Variable( E2A )
	{
		Value 0.644870175642;
	}

	Variable Variable( dE )
	{
		Value 7.6263502799998276e-07;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 76 INaCa.em
	}

	Process INaCaAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority        20;

		VariableReferenceList
			[ Nai     :../../CYTOPLASM:Na    0 ]
			[ Cai     :../../CYTOPLASM:Ca    0 ]
			[ E1A     :.:E1A                 1 ]
			[ Nao     :/:Na                  0 ]
			[ Cao     :/:Ca                  0 ]
			[ E2A     :.:E2A                 1 ]
			[ vrtf    :..:_vrtf              0 ]
			[ dinact1 :.:vInActivation1      1 ]
			[ dinact2 :.:vInActivation2      1 ]
			[ inact1  :.:inActivation1       0 ]
			[ inact2  :.:inActivation2       0 ]
			[ pE1tot  :.:pE1total            0 ]
			[ pE2tot  :.:pE2total            1 ]
			[ dE      :.:dE                  1 ]
			[ GX      :.:GX                  0 ]
			[ I       :.:I                   1 ]
			[ Cm      :..:Cm                 0 ];

		KmNai      20.74854e-3;  #  Dissociation constant for intracellular Na+ [M]
		nHNa       3.0;          #  experimental index for Hill constant about Na+
		KmCai      0.0184e-3;    #  Dissociation constant for intracellular Ca2+ [M]

		KmNao      87.5e-3;      #  Dissociation constant for extracellular Na+ [M]
		KmCao      1.38e-3;      #  Dissociation constant for extracellular Ca<sup>2+</sup> [M]

		KmCaact    0.004e-3;     #  Dissociation constant for regulatory Ca2+ at the inner side [M]

		partition  0.32;         #  distribution constant

                amplitude  110.0;        #  amplitude factor [pA/pF]
%line 114 INaCa.em

		#  rate constants in the presence of regulatory Ca2+ [msec-1]
		a1Caon     0.002;
		b1Caon     0.0012;
		#  rate constants in the absence of regulatory Ca2+ [msec-1]
		a1Caoff    0.0015;
		b1Caoff    5.0E-7;

		# rate constants [msec-1]
		a2Caoff    0.01;
		b2Caoff    1.0E-4;
		a2Caon     3.0E-5;
		b2Caon     0.09;
	}

	Process ZeroVariableAsFluxProcess( E )
	{
		Priority	15;

		VariableReferenceList
			[ dy     :.:dE        0 ]
			[ pE1tot :.:pE1total  1 ];
	}

	Process ZeroVariableAsFluxProcess( E1_inAntivation1 )
	{
		Priority	15;

		VariableReferenceList
			[ inact1   :.:inActivation1    1 ]
			[ pE1tot   :.:pE1total        -1 ]
			[ dinact1  :.:vInActivation1   0 ];
	}

	Process ZeroVariableAsFluxProcess( E1_inAntivation2 )
	{
		Priority	15;

		VariableReferenceList
			[ inact2   :.:inActivation2   1 ]
			[ pE1tot   :.:pE1total       -1 ]
			[ dinact2  :.:vInActivation2  0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae :/:Na                       3 ]
			[ Nai :../../CYTOPLASM:Na        -3 ]
			[ Cae :/:Ca                      -1 ]
			[ Cai :../../CYTOPLASM:CaTotal    1 ]
			[ i   :.:I                        0 ]
			[ N_A :/:N_A                      0 ]
			[ F   :/:F                        0 ]
			[ z   :/:zNa                      0 ];
	}


	
	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

%line 175 INaCa.em

	
	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:I               0 ];

		n 3;
		
	}

%line 177 INaCa.em

	
	Process CurrentIncrementProcess( currentCa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCa  1 ]
			[ c     :.:I               0 ];

		n -2;
		
	}

%line 179 INaCa.em

	
	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 181 INaCa.em

}


%line 272 IKs.em
   %line 273 IKs.em


System System(/CELL/MEMBRANE/IPMCA)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value 2.93558985495;
%line 16 IPMCA.em
	}

	Variable Variable( gate )
	{
		Value 0.472318266381;
%line 21 IPMCA.em
	}

	Variable Variable( E1A )
	{
		Value 0.656321655384;
	}

	Variable Variable( E2A )
	{
		Value 0.421631000578;
	}

	Variable Variable( dE )
	{
		Value 0.00019295063214;
	}


	Process IPMCAAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority        20;

		VariableReferenceList
			[ Cai   :../../CYTOPLASM:Ca          0 ]
			[ CaCaM :../../CYTOPLASM:calmodulin  0 ]
			[ E1A   :.:E1A                       1 ]
			[ Cao   :/:Ca                        0 ]
			[ E2A   :.:E2A                       1 ]
			[ ATP   :../../CYTOPLASM:ATPtotal    0 ]
			[ y     :.:gate                      0 ]
			[ dE    :.:dE                        1 ]
			[ PKA   :../../CYTOPLASM:PKA         0 ]
			[ I     :.:I                         1 ]
			[ Cm    :..:Cm                       0 ];
		
		KmCaCp0        0.0019e-3;   #  Dissociation constant for Ca binding within cytoplasm (M)
		KmCaCaM        0.00005e-3;  #  (M)
		hill           1.0;

		KmCao          2.0e-3;  #  Dissociation constant for Ca binding outside (M)
		
		k2             0.01;
		k3             0.01;
		k4             1.0;
		KmATP          0.1e-3;  #  Model adjusted. (M)

		amplitude      0.045815939110831344;  #  amplitude factor [pA/pF]
		amplitude0     0.0055;
		amplitudePKAf  1.0;
	}

	Process ZeroVariableAsFluxProcess( E )
	{
		Priority	15;

		VariableReferenceList
			[ dy  :.:dE   0 ]
			[ y   :.:gate  1 ];
	}

	Process IonFluxProcess( jCa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cae :/:Ca                      1 ]
			[ Cai :../../CYTOPLASM:CaTotal  -1 ]
			[ ATP :../../CYTOPLASM:ATPtotal -1 ]
			[ ADP :../../CYTOPLASM:ADPtotal  1 ]
			#[ Pi  :../../CYTOPLASM:Pi        1 ]
			[ i   :.:I                       0 ]
			[ N_A :/:N_A                     0 ]
			[ F   :/:F                       0 ]
			[ z   :/:zCa                     0 ];
	}

	
	
	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

%line 101 IPMCA.em

	
	Process CurrentIncrementProcess( currentCa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCa  1 ]
			[ c     :.:I               0 ];

		n 1;
		
	}

%line 103 IPMCA.em

	
	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 105 IPMCA.em

}

%line 273 IKs.em
   %line 274 IKs.em



System System(/CELL/MEMBRANE/ILCCa)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.182701580547;
%line 23 ILCCa.em
	}

	Variable Variable( i )
	{
		Value 0.0512476734476;
	}

	Variable Variable( cNa )
	{
		Value -0.182754772907;
	}

	Variable Variable( cK )
	{
		Value 5.31923591564e-05;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 42 ILCCa.em
	}

	Process ILCCaAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ Cai  :../../CYTOPLASM:Ca         0 ]
			[ GX   :.:GX                       0 ]
			[ i    :.:i                        1 ]
			[ Cm   :..:Cm                      0 ]
			[ cNa  :.:cNa                      1 ]
			[ CFNa :..:CFNa                    0 ]
			[ cK   :.:cK                       1 ]
			[ CFK  :..:CFK                     0 ]
			[ I    :.:I                        1 ];

                permeabilityNa  0.0075;
%line 61 ILCCa.em
                permeabilityK   0.0075;
%line 62 ILCCa.em
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 65 ILCCa.em

}


%line 274 IKs.em
   %line 275 IKs.em


System System(/CELL/MEMBRANE/IKATP)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0.00439861157876;
%line 25 IKATP.em
	}

	Variable Variable( POpen )
	{
		Value 0.000164995;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 34 IKATP.em
	}

	Process IKATPAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	13;

		VariableReferenceList
			[ ATPi  :../../CYTOPLASM:ATPtotal  0 ]
			[ pOpen :.:POpen                   1 ]
			[ I     :.:I                       1 ]
			[ GX    :.:GX                      0 ]
			[ Ko    :/:K                       0 ]
			[ EK    :..:EK                     0 ]
			[ Vm    :..:Vm                     0 ]
			[ Cm    :..:Cm                     0 ];

#		amplitude  0.0236;
#                amplitude  0.00312878787878788;
#                amplitude  0.0236;
                amplitude  0.0236;
%line 55 IKATP.em
		number     2333.0;
%line 56 IKATP.em
		constant   1.0e-3;
		power      0.24;
		Cm0        132.0;
%line 59 IKATP.em
	}

	
	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 62 IKATP.em

}

%line 275 IKs.em
   %line 276 IKs.em


System System(/CELL/MEMBRANE/IKpl)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 3.25859167917e-06;
%line 21 IKpl.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 25 IKpl.em
	}

	Process IKplAssignmentProcess( I ) 
	{
		StepperID       PSV;
		Priority	20;

		VariableReferenceList
			[ I   :.:I                       1 ]
			[ GX  :.:GX                      0 ]
			[ Cm  :..:Cm                     0 ]
			[ Vm  :..:Vm                     0 ]
			[ Ko  :/:K                       0 ]
			[ CFK :..:CFK                    0 ];

		amplitude  8.333e-07;
%line 41 IKpl.em
#		amplitude  8.333E-7;
#        	amplitude  0.0000001104753787879;
		constant   5.4;
		power      0.16;
		pOpen      1.0;
	}

	
	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 49 IKpl.em

}

%line 276 IKs.em
    %line 277 IKs.em


System System(/CELL/MEMBRANE/IbNSC)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -57.1332495346;
%line 33 IbNSC.em
	}

	Variable Variable( i )
	{
		Value 211.2;
	}

	Variable Variable( cNa )
	{
		Value -57.1399019601;
	}

	Variable Variable( cK )
	{
		Value 0.00665242529949;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 52 IbNSC.em
	}

	Process IbNSCAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ i    :.:i                        1 ]
			[ GX   :.:GX                       0 ]
			[ Cm   :..:Cm                      0 ]
			[ cNa  :.:cNa                      1 ]
			[ CFNa :..:CFNa                    0 ]
			[ cK   :.:cK                       1 ]
			[ CFK  :..:CFK                     0 ]
			[ I    :.:I                        1 ];

		permeabilityNa  0.000569;
%line 70 IbNSC.em
		permeabilityK   0.0002276;
%line 71 IbNSC.em

		pOpen           1.0;
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 76 IbNSC.em

}



%line 277 IKs.em
   %line 278 IKs.em


System System(/CELL/MEMBRANE/ICab)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.749099729675;
%line 22 ICab.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 26 ICab.em
	}

	Process ICabAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ I    :.:I                       1 ]
			[ GX   :.:GX                      0 ]
			[ CFCa :..:CFCa                   0 ]
			[ Cm   :..:Cm                     0 ];

		permeabilityCa   0.000303;
%line 40 ICab.em
#                permeabilityCa   0.0000401704545454545;
		pOpen            1.0;
	}

	
	Process IonFluxProcess( jCa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cae  :/:Ca                1 ]
			[ Cai  :../../CYTOPLASM:CaTotal -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zCa                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentCa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCa  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 45 ICab.em

}


%line 278 IKs.em
    %line 279 IKs.em


System System(/CELL/MEMBRANE/IClb)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.575646853891;
%line 12 IClb.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 16 IClb.em
	}

	Process IClbAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ I     :.:I                       1 ]
			[ GX    :.:GX                      0 ]
			[ CFCl  :..:CFCl                   0 ]
			[ Cm    :..:Cm                     0 ];

		permeabilityCl  -1.82E-5;
		pOpen            1.0;
	}

	
	Process IonFluxProcess( jCl ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cle  :/:Cl                1 ]
			[ Cli  :../../CYTOPLASM:Cl -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zCl                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentCl ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCl  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 34 IClb.em

}


%line 279 IKs.em
    %line 280 IKs.em


System System(/CELL/MEMBRANE/NKCC)
{
	StepperID       ODE;

	Variable Variable( ClFlux )  # = cCl
	{
		Value 0.655097671199;  # units="pA"      
%line 21 NKCC.em
	}

	Variable Variable( _I )  # = cNa = cK
	{
		Value -0.327548835599;  # units="pA"      
%line 26 NKCC.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 30 NKCC.em
	}

	Process NKCCAssignmentProcess( ClFlux ) 
	{
		StepperID	PSV;
		Priority	16;

		VariableReferenceList
			[ Clo    :/:Cl                0 ]
			[ Ko     :/:K                 0 ]
			[ Nao    :/:Na                0 ]
			[ Cli    :../../CYTOPLASM:Cl  0 ]
			[ Ki     :../../CYTOPLASM:K   0 ]
			[ Nai    :../../CYTOPLASM:Na  0 ]
			[ ClFlux :.:ClFlux            1 ]
			[ I     :.:_I                 1 ]
			[ GX    :.:GX  0 ]
			[ F     :/:F                  0 ];

		KK      1.16;  #  binding constant for K+ [M^-1]
%line 50 NKCC.em
		KCl     57.35;  #  binding constant for Cl- [M^-1]
%line 51 NKCC.em
		KNa     84.45;  #  binding constant for Na+ [M^-1]
%line 52 NKCC.em

		kbEmpty 79.522;  
		kfEmpty 37.767; 
		kbFull  1.456;   
		kfFull  3.065; 
		P       0.0359; # amol
%line 58 NKCC.em
#		P       0.0359; # amol
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Clo :/:Cl                2 ]
			[ Ko  :/:K                 1 ]
			[ Nao :/:Na                1 ]
			[ Cli :../../CYTOPLASM:Cl -2 ]
			[ Nai :../../CYTOPLASM:Na -1 ]
			[ Ki  :../../CYTOPLASM:K  -1 ]
			[ i   :.:_I                0 ]
			[ N_A :/:N_A               0 ]
			[ F   :/:F                 0 ]
			[ z   :/:zNa               0 ];
	}


	
	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:ClFlux               0 ];

		n -0.5;
		
	}

%line 80 NKCC.em

	
	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:ClFlux               0 ];

		n -0.5;
		
	}

%line 82 NKCC.em

	
	Process CurrentIncrementProcess( currentCl ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCl  1 ]
			[ c     :.:ClFlux               0 ];

		n 1.0;
		
	}

%line 84 NKCC.em

}

%line 280 IKs.em
    %line 281 IKs.em


System System(/CELL/MEMBRANE/IVRCC)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -3.3097598013710625;
	}

	Process IVRCCAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ I     :.:I                 1 ]
			[ CFCl  :..:CFCl             0 ]
			[ Cm    :..:Cm               0 ]
			[ Vt    :../../CYTOPLASM:Vt  0 ]
			[ Vm    :..:Vm               0 ];

		maxFactor  200.0;
		compliance  0.001;
		halfMaxVt  21700.0;
		slope  50.0;
		halfMaxVm  -100.0;
		permeabilityNa   0.0;
		permeabilityK    0.0;
		permeabilityCa   0.0;
		permeabilityCl   -2.0E-5;
	}

	
	Process IonFluxProcess( jCl ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cle  :/:Cl                1 ]
			[ Cli  :../../CYTOPLASM:Cl -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zCl                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentCl ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCl  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 60 IVRCC.em

}


%line 281 IKs.em
   %line 282 IKs.em


System System(/CELL/MEMBRANE/ICFTR)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -0.28563318299805246;
	}

	Variable Variable( _CPKA )
	{
		Value -0.28563318299805246;
	}

	Process ICFTRAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ PKA   :../../CYTOPLASM:PKA       0 ]
			[ I     :.:I                       1 ]
			[ CFCl  :..:CFCl                   0 ]
			[ ATP   :../../CYTOPLASM:ATPtotal  0 ]
			[ CPKA  :.:_CPKA                   0 ]
			[ Cm    :..:Cm                     0 ]
			[ Vm    :..:Vm                     0 ];

		permeabilityCl   -0.0040;
		
		alpha1  0.0756e+3;    #  rate constant for free ADP-bound closed state->ADP,ATP-bound closed state [/M/msec]
		alpha2  0.000109e+3;  #  rate constant for 2ADP-bound open state->ADP,ATP-bound open state [/M/msec]
		beta1   0.0065;       #  rate constant for ADP,ATP-bound closed state->ADP-bound closed state [/msec]
		beta2   0.00003;      #  rate constant for ADP,ATP-bound open state->2ADP-bound open state [/msec]
		k2      0.00385;      #  rate constant for channel closure (Pi and ADP release) [/msec]
	}

	
	Process IonFluxProcess( jCl ) 
	{
		Priority	11;

		VariableReferenceList
			[ Cle  :/:Cl                1 ]
			[ Cli  :../../CYTOPLASM:Cl -1 ]
			[ i   :.:I                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zCl                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentCl ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentCl  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 57 ICFTR.em

}


%line 282 IKs.em
   %line 283 IKs.em




System System(/CELL/MEMBRANE/Iha)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 0.0;
%line 35 Iha.em
	}

	Variable Variable( closedState1 )
	{
		Value 0.996023662973;
%line 40 Iha.em
	}

	Variable Variable( closedState2 )
	{
		Value 0.0024941594071;
%line 45 Iha.em
	}

	Variable Variable( openState1 )
	{
		Value 0.00105297062259;
%line 50 Iha.em
	}

	Variable Variable( openState2 )
	{
		Value 0.000329452497062;
%line 55 Iha.em
	}

	Variable Variable( vC1_C2 )
	{
		Value -0.00143342514945;
	}

	Variable Variable( vC2_O1 )
	{
		Value -0.000170414753418;
	}

	Variable Variable( vO1_O2 )
	{
		Value -7.19808602705e-05;
	}

	Variable Variable( vO2_O3 )
	{
		Value -2.25223489708e-05;
	}

	Variable Variable( POpen )
	{
		Value 0.00148217761976;
	}

	Variable Variable( i )
	{
		Value 0.0;
	}


	Variable Variable( cK )
	{
		Value 0.0;
	}

	Variable Variable( cNa )
	{
		Value 0.0;
	}

	Variable Variable( GX ){
		Value 0;
%line 100 Iha.em
	}

	Process IhaAssignmentProcess( assignment ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ cAMP   :../../CYTOPLASM:cAMP  0 ]
			[ Vm     :..:Vm                 0 ]
			[ vC1_C2 :.:vC1_C2              1 ]
			[ vC2_O1 :.:vC2_O1              1 ]
			[ vO1_O2 :.:vO1_O2              1 ]
			[ vO2_O3 :.:vO2_O3              1 ]
			[ pC1    :.:closedState1        0 ]
			[ pC2    :.:closedState2        0 ]
			[ pO1    :.:openState1          0 ]
			[ pO2    :.:openState2          0 ]
			[ pOpen  :.:POpen               1 ]
			[ i      :.:i                   1 ]
			[ GX     :.:GX                  0 ]
			[ Cm     :..:Cm                 0 ]
			[ cK     :.:cK                  1 ]
			[ CFK    :..:CFK                0 ]
			[ cNa    :.:cNa                 1 ]
			[ CFNa   :..:CFNa               0 ]
			[ I      :.:I                   1 ];

		cAMP0           2.93969563263e-07 ;  # M
%line 129 Iha.em
		hill_n          1.0;

		Vshift          0.0;
		amplitudecAMPf  1.0;
		KmcAMP_hill_n   0.0002;
%line 134 Iha.em

                permeabilityK   0.05635;
%line 136 Iha.em
                permeabilityNa  0.01379;
%line 137 Iha.em
	}

	Process ZeroVariableAsFluxProcess( vC1_C2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vC1_C2 :.:vC1_C2        0 ]
			[ pC1    :.:closedState1  1 ]
			[ pC2    :.:closedState2 -1 ];
	}

	Process ZeroVariableAsFluxProcess( vC2_O1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vC2_O1 :.:vC2_O1        0 ]
			[ pC2    :.:closedState2  1 ]
			[ pO1    :.:openState1   -1 ];
	}

	Process ZeroVariableAsFluxProcess( vO1_O2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vO1_O2 :.:vO1_O2      0 ]
			[ pO1    :.:openState1  1 ]
			[ pO2    :.:openState2 -1 ];
	}

	Process ZeroVariableAsFluxProcess( vO2_O3 ) 
	{
		Priority	15;

		VariableReferenceList
			[ vO2_O3 :.:vO2_O3        0 ]
			#[ pC1   :.:closedState1  0 ]
			#[ pC2   :.:closedState2  0 ]
			#[ pO1   :.:openState1    0 ]
			[ pO2    :.:openState2    1 ];
	}

	
	Process IonFluxProcess( jNa ) 
	{
		Priority	11;

		VariableReferenceList
			[ Nae  :/:Na                1 ]
			[ Nai  :../../CYTOPLASM:Na -1 ]
			[ i   :.:cNa                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zNa                0 ];
	}

	Process IonFluxProcess( jK ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ke  :/:K                1 ]
			[ Ki  :../../CYTOPLASM:K -1 ]
			[ i   :.:cK                 0 ]
			[ N_A :/:N_A                0 ]
			[ F   :/:F                  0 ]
			[ z   :/:zK                0 ];
	}

	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

	Process CurrentIncrementProcess( currentNa ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentNa  1 ]
			[ c     :.:cNa               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:cK               0 ];

		n 1.0;
		
	}

	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 182 Iha.em

}


%line 284 IKs.em
     %line 285 IKs.em



System System(/CELL/CYTOPLASM/SRREL/IRyR)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 8.51320462927;
%line 25 IRyR.em
	}

	Variable Variable( open )
	{
		Value 0.00011813918232;
%line 30 IRyR.em
	}

	Variable Variable( close )
	{
		Value 0.189620582569;
%line 35 IRyR.em
	}

	Variable Variable( k1 )
	{
		Value 8.08377469561e-06;
	}

	Variable Variable( k2 )
	{
		Value 7.80432436175e-06;
	}

	Variable Variable( k3_k4 )
	{
		Value 0.000728121009439;
	}

	Variable Variable( GX ){
		Value 1.0;
%line 54 IRyR.em
	}

	Process IRyRAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ pOpen    :.:open                      0 ]
			[ pClose   :.:close                     0 ]
			[ CaDiadic :../../../MEMBRANE:CaDiadic  0 ]
			[ Cai      :../..:Ca                    0 ]
			[ Cao      :..:Ca                       0 ]
			[ k1       :.:k1                        1 ]
			[ k2       :.:k2                        1 ]
			[ k3_k4    :.:k3_k4                     1 ]
			[ I        :.:I                         1 ]
			[ GX       :.:GX                        0 ]
			[ SR_f     :../..:SR_activity		0 ]
			[ Cm       :../../../MEMBRANE:Cm        0 ];

		diadicFactor  -150.0;
%line 76 IRyR.em
		k3_1      3.77e-4;
		k3_hill   2.0;
		k4        8.49e-4;
	
		permeabilityCa 200000.0;  # 200 pA/pF/mM -> pA/pF/M
%line 81 IRyR.em

	}

	Process ZeroVariableAsFluxProcess( k1 ) 
	{
		Priority	15;

		VariableReferenceList
			[ pOpen  :.:open   1 ]
			[ pClose :.:close -1 ]
			[ dy     :.:k1     0 ];
	}

	Process ZeroVariableAsFluxProcess( k2 ) 
	{
		Priority	15;

		VariableReferenceList
			[ pOpen :.:open  -1 ]
			[ dy    :.:k2     0 ];
	}

	Process ZeroVariableAsFluxProcess( k3_k4 ) 
	{
		Priority	15;

		VariableReferenceList
			[ pClose :.:close  1 ]
			[ dy     :.:k3_k4  0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ out :../..:CaTotal  1 ]
			[ in  :..:CaTotal    -1 ]
			[ i   :.:I            0 ]
			[ N_A :/:N_A          0 ]
			[ F   :/:F            0 ]
			[ z   :/:zCa          0 ];
	}


}


%line 287 IKs.em

%line 288 IKs.em


System System(/CELL/CYTOPLASM/SRUP/leak)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value 110.650946233;
%line 22 leak.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 26 leak.em
	}

	Process SRleakDiffusionAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	12;

		VariableReferenceList
			[ I   :.:I                   1 ]
			[ SR_f:../..:SR_activity     0 ]
			[ act :.:GX                  0 ]
			[ Cai :../..:Ca              0 ]
			[ Cao :..:Ca                 0 ]  # Cao = in
			[ Cm  :../../../MEMBRANE:Cm  0 ];

		permeabilityCa	300.0;  #  pA/M
%line 42 leak.em
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ in  :..:Ca         -1 ]  # Cao = in
			[ out :../..:CaTotal  1 ]
			[ i   :.:I            0 ]
			[ N_A :/:N_A          0 ]
			[ F   :/:F            0 ]
			[ z   :/:zCa          0 ];
	}

}


%line 288 IKs.em

%line 289 IKs.em


System System(/CELL/CYTOPLASM/SRUP/ISRCA)
{
	StepperID	ODE;

	Variable Variable( I )
	{
		Value -49.3736588814;
%line 23 ISRCA.em
	}

	Variable Variable( gate )
	{
		Value 0.0293230153817;
%line 28 ISRCA.em
	}

	Variable Variable( GX ){
		Value 1.0;
%line 32 ISRCA.em
	}

	Process ISRCAAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	16;

		VariableReferenceList
			[ Cao     :..:Ca                ]  #  Ca2+ concentration in SR (uptake site compartment)
			[ Cai     :../..:Ca             ]  #  Ca2+ concentration in cytoplasm
			[ PLBphos :..:PLBphos           ]
			[ dE      :.:dE                 ]
			[ y       :.:gate               ]
			[ ATP     :../..:ATPtotal       ]
			[ I       :.:I                 1]
			[ SR_f     :../..:SR_activity    0 ]
			[ GX      :.:GX          ]
			[ Cm      :../../../MEMBRANE:Cm ];

		KmCaSR  3.0e-3;          #  (M)
		hill  2.0;
		amplitudePKAf   1.0;       #  to modulate PKA effect
		a               -3.93e-4;  #  (mM) dimensionless?
		b               6.85e-7;   #  (M)
		kmcacp_minimum 1e-8;  #  (M)
		KmATP   0.1e-3;          #  (M)
		k1    0.01;			
		k3   1.0;
		k4   0.01;

		amplitude 19.0;
%line 63 ISRCA.em

#		amplitude  19.0;
#               amplitude  0.0755681818181818;
#               amplitude  4.29942857142857;
#                amplitude  0.57;
	}
	
#	Variable Variable( dEA )
#	{
#		Value 0.0123040417866;
#	}

	Variable Variable( dE )
	{
		Value -1.55351689138e-05;
	}
	
	Process ZeroVariableAsFluxProcess( E ) 
	{
		Priority	12;

		VariableReferenceList
			[ y   :.:gate  1 ]
			[ dy :.:dE     0 ];
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ out :../..:CaTotal   2 ]  #  Ca2+ concentration in cytoplasm
			[ in  :..:Ca          -2 ]  #  Ca2+ concentration in SR (uptake site compartment)
			[ ATP :../..:ATPtotal  1 ]
			[ ADP :../..:ADPtotal -1 ]
			#[ Pi :../..:Pi       -1 ]
			[ i   :.:I             0 ]
			[ N_A :/:N_A           0 ]
			[ F   :/:F             0 ]
			[ z   :/:zCa           0 ];
				}

}


%line 289 IKs.em

%line 290 IKs.em




System System(/Pipette)
{
	StepperID	ODE;


	Variable Variable( I )
	{
		Value 0.0;
	}

	
	Process CurrentClampAssignmentProcess( I ) 
	{
		StepperID	PSV;
		Priority	20;

		VariableReferenceList
			[ I :.:I  1 ]
			[ t :/:t  0 ];

		amplitude  -8000.0;  #  (pA)
%line 41 CurrentClamp.em
		onset      50.0;  #  (pA)
%line 42 CurrentClamp.em
		offset     52.0;  #  (pA)
%line 43 CurrentClamp.em
		interval   400.0;  #  (pA)
%line 44 CurrentClamp.em
	}

	Process IonFluxProcess( j ) 
	{
		Priority	11;

		VariableReferenceList
			[ Ki  :/CELL/CYTOPLASM:K -1 ]
			[ i   :.:I                0 ]
			[ N_A :/:N_A              0 ]
			[ F   :/:F                0 ]
			[ z   :/:zK               0 ];
	}

	
	Process ApplyCurrentProcess( Vm ) 
	{
		Priority	10;

		VariableReferenceList
			[ Vm :/CELL/MEMBRANE:Vm  1 ]
			[ Cm :/CELL/MEMBRANE:Cm   0 ]
			[ I  :.:I    0 ];
	}

%line 59 CurrentClamp.em

	
	Process CurrentIncrementProcess( currentK ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:currentK  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 61 CurrentClamp.em

	
	Process CurrentIncrementProcess( current ) 
	{
		StepperID	PSV;
		Priority	10;

		VariableReferenceList
			[ total :/CELL/MEMBRANE:current  1 ]
			[ c     :.:I               0 ];

		n 1.0;
		
	}

%line 63 CurrentClamp.em

}

%line 293 IKs.em

%line 294 IKs.em

System System( /Recorder )
{
	StepperID	PSV;
}

