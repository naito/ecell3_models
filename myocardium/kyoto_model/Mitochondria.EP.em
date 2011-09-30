System System( /CELL/CYTOPLASM/MITOCHONDRIA )
{
	StepperID	ODE;

	@{'''
	<volume name="volume" initial_value="3531.2679767719696" units="um^3">
		<link name="total" initial_value="../../volume" units="um^3" />
		<parameter name="ratio" initial_value="0.23" units="/cell volume" />
	</volume>
	'''}
	Variable Variable( SIZE )
	{
		Value 3531.2679767719696e-15;
	}

	Process ExpressionAssignmentProcess( volume ) 
	{
		Name "SRup volume";

		StepperID	PSV;
		Priority	18;

		VariableReferenceList
			[ volume :.:SIZE               1 ]
			[ total  :/CELL/CYTOPLASM:SIZE 0 ]
			[ ratio  :.:volumeRatio        0 ];

		Expression "total.Value * ratio.Value";
	}

	@{'''
	<volumeratio name="Rcm" initial_value="4.3478260869565215" units="dimensionless"
		className="org.simBio.bio.matsuoka_et_al_2004.function.VolumeRatio">
		<link name="ratio" initial_value="../volume/ratio" units="/cell volume" />
	</volumeratio>
	'''}
	Variable Variable( volumeRatio )
	{
		Value 0.23;
	}

	Variable Variable( Rcm )
	{
		Name "Volume ratio between cell and mitochondria";
		Value 4.3478260869565215;
	}

	Process ExpressionAssignmentProcess( Rcm ) 
	{
		Name "Calulate volume ratio between cell and mitochondria";
		# Korzeniewski B & Zoladz JA, Biophys. Chem., 92, 17-34, 2001

		StepperID	PSV;
		Priority	18;

		VariableReferenceList
			[ Rcm   :.:Rcm         1 ]
			[ ratio :.:volumeRatio 0 ];

		Expression "1.0 / ratio.Value";
	}

	@# 細胞質 Pi の計算だが、ミトコンドリア内のリン酸関連物質量も計算に用いるため、Processをここに置く。Cytoplasmに置くと、Mitochondria.emを外したときにミトコンドリア内のVariableを参照できずエラーとなってしまう。
	Process ExpressionAssignmentProcess( Pi ) 
	{
		Name "Mass conservation of Pi";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ Pi       :..:Pi        1 ]
			[ PiTotal  :..:PiTotal   0 ]
			[ PCr      :..:PCr       0 ]
			[ ATPtcell :..:ATPtotal  0 ]
			[ ADPtcell :..:ADPtotal  0 ]
			[ AMP      :..:AMP       0 ]
			[ ATPtmit  :.:ATPtotal   0 ]
			[ ADPtmit  :.:ADPtotal   0 ]
			[ Pimit    :.:Pi         0 ];

		PiTotal 46.0e-3;  # (M)

		Expression "PiTotal.Value - PCr.Value - 3.0 * ATPtcell.Value - 2.0 * ADPtcell.Value - AMP.Value - 3.0 * ATPtmit.Value - 2.0 * ADPtmit.Value - Pimit.Value";
	}
	@# 体積の変動を表現しているのに、総イオン濃度が変化しないと仮定しているのは厳密には不適切。無視して差し支えない程度かもしれないが。

	@{'''
	<Zvalue name="Zvalue" initial_value="61.51965192093832" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.Zvalue">
		<link name="T" initial_value="/absolute temperature" units="K" />
		<link name="R" initial_value="/Gas constant" units="mVC/K/mmol" />
		<link name="F" initial_value="/Faraday constant" units="C/mmol" />
	</Zvalue>
	'''}
	Variable Variable( Zvalue )
	{
		Name "Z value (mV)";
		Value 61.51965192093832;
	}

	Process ExpressionAssignmentProcess( Zvalue ) 
	{
		Name "Z value (mV)";
		# Korzeniewski B & Zoladz JA, Biophys. Chem., 92, 17-34, 2001

		StepperID	PSV;
		Priority	18;

		VariableReferenceList
			[ z :.:Zvalue 1 ]
			[ T :/:T      0 ];


		Expression "2.303 * @R_F * T.Value";
	}

	@# <parameter name="Mg" initial_value="0.38" units="mM" />
	Variable Variable( Mg )
	{
		Name "Mg";
		MolarConc 0.38e-3;
	}

	@# <variable name="Proton" initial_value="3.8052117309416624E-5" units="mM" />
	Variable Variable( Proton )
	{
		Name "Proton";
		MolarConc 3.8052117309416624e-8;
	}

	@{'''
	<Acidity name="pH" initial_value="7.419621173053379" units="dimensionless">
		<link name="Proton" initial_value="../Proton" units="mM" />
	</Acidity>
	'''}
	Variable Variable( pH )
	{
		Name "pH";
		Value 7.419621173053379;
	}

	Process ExpressionAssignmentProcess( Acidity ) 
	{
		Name "Acidity";

		StepperID	PSV;
		Priority	18;

		VariableReferenceList
			[ Proton :.:Proton 0 ]
			[ pH     :.:pH     1 ];

		ActivityFactor 1.0;

		Expression "-log10( ActivityFactor * Proton.MolarConc )";
	}

	@{'''
	<ProtonBuffering name="rbuffer" initial_value="251378.46458038045" units="mM Proton / pH"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.buffer.HBuffering">
		<link name="pH" initial_value="../pH" units="dimensionless" />
		<parameter name="cbuffer" initial_value="0.022" units="mM Proton / pH" />
	</ProtonBuffering>
	'''}
	Variable Variable( rbuffer )
	{
		Name "rbuffer (mM Proton / pH)";
		Value 251378.46458038045;
	}

	Process ExpressionAssignmentProcess( ProtonBuffering ) 
	{
		Name "ProtonBuffering";

		StepperID	PSV;
		Priority	17;

		VariableReferenceList
			[ rbuffer :.:rbuffer 1 ]
			[ pH      :.:pH      0 ];

		cbuffer 0.022;  # (mM Proton / pH)
		dpH 0.001;

		Expression "cbuffer / ( (pow(10.0, - pH.Value) - pow(10.0, (- pH.Value - dpH))) / dpH )";
	}

	@{'''
	<gradientpH name="dpH" initial_value="25.814948504899753" units="dimensionless"
		className="org.simBio.bio.matsuoka_et_al_2004.function.GradientpH">
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="pHcell" initial_value="../../pH" units="dimensionless" />
		<link name="pHmit" initial_value="../pH" units="dimensionless" />
	</gradientpH>
	'''}
	Variable Variable( dpH )
	{
		Name "Delta pH";
		Value 25.814948504899753;
	}

	Process ExpressionAssignmentProcess( gradientpH ) 
	{
		Name "delta pH";

		StepperID	PSV;
		Priority	17;

		VariableReferenceList
			[ dpH    :.:dpH    1 ]
			[ Zvalue :.:Zvalue 0 ]
			[ pHcell :..:pH    0 ]
			[ pHmit  :.:pH     0 ];

		Expression "Zvalue.Value * ( pHmit.Value - pHcell.Value )";
	}

	@{'''
	<gradientP name="dP" initial_value="185.71905399208455" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.GradientP">
		<link name="dpH" initial_value="../dpH" units="dimensionless" />
		<parameter name="myu" initial_value="0.861" units="dimensionless" />
	</gradientP>
	'''}
	Variable Variable( dP )
	{
		Name "Delta P (mV)";
		Value 185.71905399208455;
	}

	Variable Variable( dP_myu )
	{
		Name "myu";
		Value 0.861;
	}

	Process ExpressionAssignmentProcess( gradientP ) 
	{
		Name "delta P";

		StepperID	PSV;
		Priority	16;

		VariableReferenceList
			[ dP  :.:dP      1 ]
			[ dpH :.:dpH     0 ]
			[ myu :.:dP_myu  0 ];

		Expression "dpH.Value * 1.0 / ( 1.0 - myu.Value )";
	}

	@{'''
	<MembranePotential name="dPsi" initial_value="-159.9041054871848" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.MembranePotential">
		<link name="dpH" initial_value="../dpH" units="dimensionless" />
		<link name="dP" initial_value="../dP" units="mV" />
	</MembranePotential>
	'''}
	Variable Variable( dPsi )
	{
		Name "Delta psi (mV)";
		Value -159.9041054871848;
	}

	Process ExpressionAssignmentProcess( dPsi ) 
	{
		Name "Membrane potential Delta Psi";

		StepperID	PSV;
		Priority	15;

		VariableReferenceList
			[ dPsi :.:dPsi 1 ]
			[ dpH  :.:dpH  0 ]
			[ dP   :.:dP   0 ];

		Expression "-( dP.Value - dpH.Value )";
	}

	@{'''
	<partialPotential name="dPsimit" initial_value="-103.93766856667013" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.PartialPotential">
		<link name="total" initial_value="../dPsi" units="mV" />
		<parameter name="ratio" initial_value="0.65" units="dimensionless" />
	</partialPotential>
	<partialPotential name="dPsicell" initial_value="55.96643692051468" units="mV">
		<link name="total" initial_value="../dPsi" units="mV" />
		<parameter name="ratio" initial_value="-0.35" units="dimensionless" />
	</partialPotential>
	'''}
	Variable Variable( dPsimit )
	{
		Name "Delta psi mit (mV)";
		Value -103.93766856667013;
	}

	Variable Variable( dPsicell )
	{
		Name "Delta psi cell (mV)";
		Value 55.96643692051468;
	}

	Process ExpressionAssignmentProcess( dPsimit ) 
	{
		Name "Partial potential Delta Psi_mit";

		StepperID	PSV;
		Priority	14;

		VariableReferenceList
			[ partial1 :.:dPsimit   1 ]
			[ total    :.:dPsi      0 ];

		ratio	0.65;

		Expression "total.Value * ratio";

	}

	Process ExpressionAssignmentProcess( dPsicell ) 
	{
		Name "Partial potential Delta Psi_mit";

		StepperID	PSV;
		Priority	14;

		VariableReferenceList
			[ partial2 :.:dPsicell -1 ]
			[ total    :.:dPsi      0 ];

		ratio	0.65;

		Expression "total.Value * ( 1.0 - ratio )";

	}

	@# <variable name="ATPtotal" initial_value="6.403037657787217" units="mM" />
	Variable Variable( ATPtotal )
	{
		Name "Total ATP";
		MolarConc 6.403037657787217e-3;
	}

	@{'''
	<freeconcentration name="ATPfree" initial_value="0.2741854916432813" units="mM">
		<link name="total" initial_value="../ATPtotal" units="mM" />
		<link name="metal" initial_value="../Mg" units="mM" />
		<parameter name="kD" initial_value="0.017" units="mM" />
	</freeconcentration>
	'''}
	Variable Variable( ATPfree )
	{
		Name "Free ATP";
		MolarConc 2.741854916432813e-4;
	}

	Process ExpressionAssignmentProcess( ATPfree ) 
	{
		Name "Free ATP";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ total :.:ATPtotal 0 ]
			[ metal :.:Mg       0 ]
			[ free  :.:ATPfree  1 ];

		kD 0.017e-3;  #  (M)

		Expression "total.Value / ( 1.0 + metal.MolarConc / kD)";
	}

	@{'''
	<massconservation name="ATPmg" initial_value="6.128852166143936" units="mM">
		<link name="total" initial_value="../ATPtotal" units="mM" />
		<link name="other" initial_value="../ATPfree" units="mM" />
	</massconservation>
	'''}
	Variable Variable( ATPmg )
	{
		Name "ATP-Mg";
		MolarConc 6.128852166143936e-3;
	}

	@# 最小値（1.0e-18 mM）に関する処理は未実装
	Process ExpressionAssignmentProcess( ATPmg ) 
	{
		Name "Mass conservation of ATP";

		StepperID	PSV;
		Priority	2;

		VariableReferenceList
			[ total :.:ATPtotal 0 ]
			[ other :.:ATPfree  0 ]
			[ self  :.:ATPmg    1 ];

		Expression "total.Value - other.Value";
	}

	@{'''
	<massconservation name="ADPtotal" initial_value="9.856962342212785" units="mM">
		<link name="other" initial_value="../ATPtotal" units="mM" />
		<parameter name="total" initial_value="16.26" units="mM" />
	</massconservation>
	'''}
	Variable Variable( ADPtotal )
	{
		Name "Total ADP";
		MolarConc 9.856962342212785e-3;
	}

	Process ExpressionAssignmentProcess( ADPtotal ) 
	{
		Name "Mass conservation of ADP";

		StepperID	PSV;
		Priority	4;

		VariableReferenceList
			[ other :.:ATPtotal  0 ]
			[ self  :.:ADPtotal  1 ];

		total	16.26e-3;  # M

		Expression "total * self.getSuperSystem().SizeN_A - other.Value";
	}

	@{'''
	<freeconcentration name="ADPfree" initial_value="4.198887281728104" units="mM">
		<link name="total" initial_value="../ADPtotal" units="mM" />
		<link name="metal" initial_value="../Mg" units="mM" />
		<parameter name="kD" initial_value="0.282" units="mM" />
	</freeconcentration>
	'''}
	Variable Variable( ADPfree )
	{
		Name "Free ADP";
		MolarConc 4.198887281728104e-3;
	}

	Process ExpressionAssignmentProcess( ADPfree ) 
	{
		Name "Free ADP";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ total :.:ADPtotal  0 ]
			[ metal :.:Mg        0 ]
			[ free  :.:ADPfree   1 ];

		kD 0.282e-3;  #  (M)

		Expression "total.Value / ( 1.0 + metal.MolarConc / kD)";
	}

	@{'''
	<massconservation name="ADPmg" initial_value="5.6580750604846815" units="mM">
		<link name="total" initial_value="../ADPtotal" units="mM" />
		<link name="other" initial_value="../ADPfree" units="mM" />
	</massconservation>
	'''}
	Variable Variable( ADPmg )
	{
		Name "ADP-Mg";
		MolarConc 5.6580750604846815e-3;
	}

	Process ExpressionAssignmentProcess( ADPmg ) 
	{
		Name "Mass conservation of ADP-Mg";

		StepperID	PSV;
		Priority	2;

		VariableReferenceList
			[ total :.:ADPtotal  0 ]
			[ other :.:ADPfree   0 ]
			[ self  :.:ADPmg     1 ];

		Expression "total.Value - other.Value";
	}

	@# <variable name="Pi" initial_value="5.247469299976676" units="mM" />
	Variable Variable( Pi )
	{
		Name "Pi";
		MolarConc 5.247469299976676e-3;
	}

	@# <variable name="NADH" initial_value="0.8948906751612181" units="mM" />
	Variable Variable( NADH )
	{
		Name "NADH";
		MolarConc 8.948906751612181e-4;
	}

	@{'''
	<massconservation name="NAD" initial_value="2.075109324838782" units="mM">
		<link name="other" initial_value="../NADH" units="mM" />
		<parameter name="total" initial_value="2.97" units="mM" />
	</massconservation>
	'''}
	Variable Variable( NAD )
	{
		Name "NAD";
		MolarConc 2.075109324838782e-3;
	}

	Process ExpressionAssignmentProcess( NAD ) 
	{
		Name "Mass conservation of NAD";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ other :.:NADH  0 ]
			[ self  :.:NAD   1 ];

		total	2.97e-3;  #  (M)

		Expression "total * self.getSuperSystem().SizeN_A - other.Value";
	}

	@# <variable name="UQH2" initial_value="1.0522454291006709" units="mM" />
	Variable Variable( UQH2 )
	{
		Name "UQH2";
		MolarConc 1.0522454291006709e-3;
	}

	@{'''
	<massconservation name="UQ" initial_value="0.2977545708993292" units="mM">
		<link name="other" initial_value="../UQH2" units="mM" />
		<parameter name="total" initial_value="1.35" units="mM" />
	</massconservation>
	'''}
	Variable Variable( UQ )
	{
		Name "UQ";
		MolarConc 2.977545708993292e-4;
	}

	Process ExpressionAssignmentProcess( UQ ) 
	{
		Name "Mass conservation of UQ";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ other :.:UQH2  0 ]
			[ self  :.:UQ    1 ];

		total	1.35e-3;  # (M)

		Expression "total * self.getSuperSystem().SizeN_A - other.Value";
	}

	@# <variable name="Cytc2" initial_value="0.05012887032447142" units="mM" />
	Variable Variable( Cytc2 )
	{
		Name "cytochrome c2";
		MolarConc 5.012887032447142e-5;
	}

	@{'''
	<massconservation name="Cytc3" initial_value="0.2198711296755286" units="mM">
		<link name="other" initial_value="../Cytc2" units="mM" />
		<parameter name="total" initial_value="0.27" units="mM" />
	</massconservation>
	'''}
	Variable Variable( Cytc3 )
	{
		Name "cytochrome c3";
		MolarConc 2.198711296755286e-4;
	}

	Process ExpressionAssignmentProcess( Cytc3 ) 
	{
		Name "Mass conservation of cytochrome c3";

		StepperID	PSV;
		Priority	3;

		VariableReferenceList
			[ other :.:Cytc2  0 ]
			[ self  :.:Cytc3  1 ];

		total	0.27e-3;  #  (M)

		Expression "total * self.getSuperSystem().SizeN_A - other.Value";
	}

	@{'''
	<RedoxPotential name="EmN" initial_value="-308.76432763447485" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.RedoxPotential">
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="Product" initial_value="../NAD" units="mM" />
		<link name="Substrate" initial_value="../NADH" units="mM" />
		<parameter name="Em0" initial_value="-320.0" units="mV" />
	</RedoxPotential>
	'''}
	Variable Variable( EmN )
	{
		Name "NAD redox potential (mV)";
		Value -308.76432763447485;
	}

	Process ExpressionAssignmentProcess( RedoxPotential_N ) 
	{
		Name "Calculate NAD redox potential";

		StepperID	PSV;
		Priority	17;

		VariableReferenceList
			[ Em        :.:EmN     1 ]
			[ Zvalue    :.:Zvalue  0 ]
			[ Product   :.:NAD     0 ]
			[ Substrate :.:NADH    0 ];

		Em0	-320.0;  # mV
		Zscale	1.0;

		Expression "Em0 + Zscale * Zvalue.Value * 0.5 * log10( Product.Value / Substrate.Value )";
	}

	@{'''
	<RedoxPotential name="EmU" initial_value="68.13566055321765" units="mV">
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="Product" initial_value="../UQ" units="mM" />
		<link name="Substrate" initial_value="../UQH2" units="mM" />
		<parameter name="Em0" initial_value="85.0" units="mV" />
	</RedoxPotential>
	'''}
	Variable Variable( EmU )
	{
		Name "ubiquinone redox potential (mV)";
		Value 68.13566055321765;
	}

	Process ExpressionAssignmentProcess( RedoxPotential_U ) 
	{
		Name "Calculate ubiquinone redox potential";

		StepperID	PSV;
		Priority	17;

		VariableReferenceList
			[ Em        :.:EmU     1 ]
			[ Zvalue    :.:Zvalue  0 ]
			[ Product   :.:UQ      0 ]
			[ Substrate :.:UQH2    0 ];

		Em0	85.0;  # mV
		Zscale	1.0;

		Expression "Em0 + Zscale * Zvalue.Value * 0.5 * log10( Product.Value / Substrate.Value )";
	}

	@{'''
	<RedoxPotential name="Emc" initial_value="289.50055595027567" units="mV">
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="Product" initial_value="../Cytc3" units="mM" />
		<link name="Substrate" initial_value="../Cytc2" units="mM" />
		<parameter name="Em0" initial_value="250.0" units="mV" />
		<parameter name="Zscale" initial_value="2.0" units="dimensionless" />
	</RedoxPotential>
	'''}
	Variable Variable( Emc )
	{
		Name "cytochrome c redox potential (mV)";
		Value 289.50055595027567;
	}

	Process ExpressionAssignmentProcess( RedoxPotential_c ) 
	{
		Name "Calculate cytochrome c redox potential";

		StepperID	PSV;
		Priority	17;

		VariableReferenceList
			[ Em        :.:Emc     1 ]
			[ Zvalue    :.:Zvalue  0 ]
			[ Product   :.:Cytc3   0 ]
			[ Substrate :.:Cytc2   0 ];

		Em0	250.0;  # mV
		Zscale	2.0;

		Expression "Em0 + Zscale * Zvalue.Value * 0.5 * log10( Product.Value / Substrate.Value )";
	}

	@{'''
	<RedoxPotential2 name="Ema" initial_value="635.123715429545" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.RedoxPotentialCyta">
		<link name="myu" initial_value="../dP/myu" units="mV" />
		<link name="Emc" initial_value="../Emc" units="mM" />
		<link name="dP" initial_value="../dP" units="mV" />
	</RedoxPotential2>
	'''}
	Variable Variable( Ema )
	{
		Name "cytochrome a3 redox potential (mV)";
		Value 635.123715429545;
	}

	Process ExpressionAssignmentProcess( RedoxPotential_a ) 
	{
		Name "Calculate cytochrome a3 redox potential";

		StepperID	PSV;
		Priority	15;

		VariableReferenceList
			[ Em  :.:Ema     1 ]
			[ myu :.:dP_myu  0 ]
			[ Emc :.:Emc     0 ]
			[ dP  :.:dP      0 ];

		Expression "Emc.Value + dP.Value * ( 2.0 + 2.0 * myu.Value ) / 2.0";
	}

	@{'''
	<cyta2concentration name="Cyta2" initial_value="0.0037318683311245" units="mM"
		className="org.simBio.bio.matsuoka_et_al_2004.function.ConcentrationCyta2">
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="Ema" initial_value="../Ema" units="mV" />
		<parameter name="Ema0" initial_value="540.0" units="mV" />
		<parameter name="total" initial_value="0.135" units="mM" />
	</cyta2concentration>
	'''}
	Variable Variable( Cyta2 )
	{
		Name "cytochrome a2";
		MolarConc 3.7318683311245e-6;
	}

	Variable Variable( Cyta_total )
	{
		Name "Total cytochrome a";
		MolarConc 1.35e-4;
	}

	Process ExpressionAssignmentProcess( cyta2concentration ) 
	{
		Name "Calculate cytochrome a2 concentration";

		StepperID	PSV;
		Priority	14;

		VariableReferenceList
			[ Cyta2  :.:Cyta2       1 ]
			[ Zvalue :.:Zvalue      0 ]
			[ Ema    :.:Ema         0 ]
			[ total  :.:Cyta_total  0 ];

		Ema0	540.0;  # mV

		Expression "total.Value / ( 1.0 + pow( 10.0, ( Ema.Value - Ema0 ) / Zvalue.Value ))";
	}

	@{'''
	<massconservation name="Cyta3" initial_value="0.13126813166887552" units="mM">
		<link name="other" initial_value="../Cyta2" units="mM" />
		<link name="total" initial_value="../Cyta2/total" units="mM" />
	</massconservation>
	'''}
	Variable Variable( Cyta3 )
	{
		Name "cytochrome a3";
		MolarConc 1.3126813166887552e-4;
	}

	Process ExpressionAssignmentProcess( Cyta3 ) 
	{
		Name "Mass conservation of cytochrome a3";

		StepperID	PSV;
		Priority	14;

		VariableReferenceList
			[ total :.:Cyta_total  0 ]
			[ other :.:Cyta2       0 ]
			[ self  :.:Cyta3       1 ];

		Expression "total.Value - other.Value";
	}

	@{'''
	<NADH_UQOxidoreductase name="vC1" initial_value="1.0875968955265928E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ComplexI">
		<link name="EmN" initial_value="../../EmN" units="mV" />
		<link name="EmU" initial_value="../../EmU" units="mV" />
		<link name="dP" initial_value="../../dP" units="mV" />
		<parameter name="kC1" initial_value="3.9825E-6" units="mM/mV/ms" />
		<link name="Amp" initial_value="../../Amp" units="dimension_less" />
	</NADH_UQOxidoreductase>
	'''}

	@# Complex I
	Variable Variable( vC1 )
	{
		Name "rate of Complex I (mM/ms)";
		Value 1.0875968955265928e-4;
	}

	Process ExpressionAssignmentProcess( vC1 ) 
	{
		Name "rate of Complex I (mM/ms)";

		StepperID	PSV;
		Priority	14;

		VariableReferenceList
			[ vC1 :.:vC1 1 ]
			[ vC3 :.:vC3 0 ]
			[ vC4 :.:vC4 0 ]
			[ EmN :.:EmN 0 ]
			[ EmU :.:EmU 0 ]
			[ dP  :.:dP  0 ]
			[ Amp :.:Amp 0 ];

		kC1	3.9825E-6;  # mM/mV/ms

		Expression "and( geq( vC1.Value, 0.0 ), and( geq( vC3.Value, 0.0 ), geq( vC4.Value, 0.0 ))) * Amp.Value * kC1 * ( EmU.Value - EmN.Value - dP.Value * 2.0 )";

	}

	Process ExpressionFluxProcess( NADH_UQOxidoreductase ) 
	{
		Name "NADH UQ Oxidoreductase (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vC1   :.:vC1     0 ]
			[ Rcm   :.:Rcm     0 ]
			[ NADH  :.:NADH   -1 ]
			[ UQH2  :.:UQH2    5 ]
			[ Hmito :.:Proton  0 ];

		Expression "vC1.Value * Rcm.Value / 5.0 / 1000.0 * self.getSuperSystem().SizeN_A";
		# Expression "vC1.Value / 5.0 / 1000.0 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	<Cytochrome_bc1 name="vC3" initial_value="1.1175267504158818E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ComplexIII">
		<link name="EmU" initial_value="../../EmU" units="mV" />
		<link name="Emc" initial_value="../../Emc" units="mV" />
		<link name="dP" initial_value="../../dP" units="mV" />
		<link name="myu" initial_value="../../dP/myu" units="mV" />
		<parameter name="kC3" initial_value="2.2735E-6" units="mM/mV/ms" />
		<link name="Amp" initial_value="../../Amp" units="dimension_less" />
	</Cytochrome_bc1>
	'''}

	@# Complex III
	Variable Variable( vC3 )
	{
		Name "rate of Complex III (mM/ms)";
		Value 1.1175267504158818e-4;
	}

	Process ExpressionAssignmentProcess( vC3 ) 
	{
		Name "rate of Complex III (mM/ms)";

		StepperID	PSV;
		Priority	15;

		VariableReferenceList
			[ vC3 :.:vC3     1 ]
			[ vC4 :.:vC4     0 ]
			[ EmU :.:EmU     0 ]
			[ Emc :.:Emc     0 ]
			[ dP  :.:dP      0 ]
			[ myu :.:dP_myu  0 ]
			[ Amp :.:Amp     0 ];

		kC3	2.2735e-6;  # mM/mV/ms

		Expression "and( geq( vC3.Value, 0.0 ), geq( vC4.Value, 0.0 )) * Amp.Value * kC3 * ( Emc.Value - EmU.Value - dP.Value * ( 4.0 - 2.0 * myu.Value ) / 2.0 )";

	}

	Process ExpressionFluxProcess( Cytochrome_bc1 ) 
	{
		Name "Cytochrome bc1 (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vC3   :.:vC3    0 ]
			[ Rcm   :.:Rcm    0 ]
			[ UQH2  :.:UQH2  -1 ]
			[ Cytc2 :.:Cytc2  2 ];

		Expression "vC3.Value * Rcm.Value / 1000.0 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	<CytochromecOxidase name="vC4" initial_value="5.593585025749086E-5" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ComplexIV">
		<link name="O2" initial_value="/model/Oxygen" units="mM" />
		<link name="a2" initial_value="../../Cyta2" units="mM" />
		<link name="c2" initial_value="../../Cytc2" units="mM" />
		<parameter name="KmO" initial_value="8.0E-4" units="mM" />
		<rateconstant name="kC4" initial_value="0.06" units="1/mM/ms"
			className="org.simBio.bio.matsuoka_et_al_2004.function.chemical.CN">
			<link name="CN" initial_value="../../../../../CN" units="mM" />
			<parameter name="initial" initial_value="0.06" units="1/mM/ms" />
		</rateconstant>
		<link name="Amp" initial_value="../../Amp" units="dimension_less" />
	</CytochromecOxidase>
	'''}

	@# Complex IV
	Variable Variable( vC4 )
	{
		Name "rate of Complex IV (mM/ms)";
		Value 5.593585025749086e-5;
	}

	Process ExpressionAssignmentProcess( vC4 ) 
	{
		Name "rate of Complex IV (mM/ms)";

		StepperID	PSV;
		Priority	16;

		VariableReferenceList
			[ vC4 :.:vC4     1 ]
			[ O2  :/:Oxygen  0 ]
			[ a2  :.:Cyta2   0 ]
			[ c2  :.:Cytc2   0 ]
			[ CN  :/:CN      0 ]
			[ Amp :.:Amp     0 ];

		KmO	0.0008e-3;   #  (M)
		initial	0.06;     #  1/mM/ms, CN/initial
		Km	0.12e-3;  #  (M)
		n	5.0;

		Expression "geq( vC4.Value, 0.0 ) * Amp.Value * ( initial / ( 1.0 + pow( CN.MolarConc / Km, n ))) * ( a2.MolarConc* 1000.0 ) * ( c2.MolarConc * 1000.0 ) * ( O2.MolarConc / ( O2.MolarConc + KmO ))";

	}

	Process ExpressionFluxProcess( CytochromecOxidase ) 
	{
		Name "Cytochrome c oxidase (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vC4   :.:vC4     0 ]
			[ Rcm   :.:Rcm     0 ]
			[ Cytc2 :.:Cytc2  -4 ];

		Expression "vC4.Value * Rcm.Value / 1000.0 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	<OxidativePhosphorylation name="vO2" initial_value="5.593585025749086E-5" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.OxidativePhosphorylation">
		<link name="Hmito" initial_value="../Proton" units="mM" />
		<link name="rbuffermito" initial_value="../rbuffer" units="mM Proton / pH" />
		<link name="NADH" initial_value="../NADH" units="mM" />
		<link name="UQH2" initial_value="../UQH2" units="mM" />
		<link name="Cytc2" initial_value="../Cytc2" units="mM" />
		<link name="Oxygen" initial_value="/model/Oxygen" units="mM" />
		<link name="myu" initial_value="../dP/myu" units="mV" />
		<link name="Rcm" initial_value="../Rcm" units="dimensionless" />
		<NADH_UQOxidoreductase name="vC1" initial_value="1.0875968955265928E-4" units="mM/ms"
			className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ComplexI">
			<link name="EmN" initial_value="../../EmN" units="mV" />
			<link name="EmU" initial_value="../../EmU" units="mV" />
			<link name="dP" initial_value="../../dP" units="mV" />
			<parameter name="kC1" initial_value="3.9825E-6" units="mM/mV/ms" />
			<link name="Amp" initial_value="../../Amp" units="dimension_less" />
		</NADH_UQOxidoreductase>
		<Cytochrome_bc1 name="vC3" initial_value="1.1175267504158818E-4" units="mM/ms"
			className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ComplexIII">
			<link name="EmU" initial_value="../../EmU" units="mV" />
			<link name="Emc" initial_value="../../Emc" units="mV" />
			<link name="dP" initial_value="../../dP" units="mV" />
			<link name="myu" initial_value="../../dP/myu" units="mV" />
			<parameter name="kC3" initial_value="2.2735E-6" units="mM/mV/ms" />
			<link name="Amp" initial_value="../../Amp" units="dimension_less" />
		</Cytochrome_bc1>
		<CytochromecOxidase name="vC4" initial_value="5.593585025749086E-5" units="mM/ms"
			className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ComplexIV">
			<link name="O2" initial_value="/model/Oxygen" units="mM" />
			<link name="a2" initial_value="../../Cyta2" units="mM" />
			<link name="c2" initial_value="../../Cytc2" units="mM" />
			<parameter name="KmO" initial_value="8.0E-4" units="mM" />
			<rateconstant name="kC4" initial_value="0.06" units="1/mM/ms"
				className="org.simBio.bio.matsuoka_et_al_2004.function.chemical.CN">
				<link name="CN" initial_value="../../../../../CN" units="mM" />
				<parameter name="initial" initial_value="0.06" units="1/mM/ms" />
			</rateconstant>
			<link name="Amp" initial_value="../../Amp" units="dimension_less" />
		</CytochromecOxidase>
	</OxidativePhosphorylation>
	'''}
	Process ExpressionFluxProcess( vO2 ) 
	{
		Name "Delta H (1/ms)";

		Priority	12;

		VariableReferenceList
			[ Hmito       :.:Proton  1 ]
			[ rbuffermito :.:rbuffer 0 ]
			[ myu         :.:dP_myu  0 ]
			[ Rcm         :.:Rcm     0 ]
			[ vC1         :.:vC1     0 ]
			[ vC3         :.:vC3     0 ]
			[ vC4         :.:vC4     0 ]
			[ vSN         :.:vSN     0 ]
			[ vANT        :.:vANT    0 ]
			[ vPI         :.:vPI     0 ]
			[ nA          :.:vSN_nA  0 ];

		# Expression "- (( 2.0 * ( 2.0 + 2.0 * myu.Value ) * vC4.Value ) + (( 4.0 - 2.0 * myu.Value ) * vC3.Value ) + ( 4.0 * vC1.Value ) - ( nA.Value * vSN.Value ) - ( myu.Value * vANT.Value ) - (( 1.0 - myu.Value ) * vPI.Value )) * Rcm.Value / rbuffermito.Value / 1000.0 * self.getSuperSystem().SizeN_A";
		Expression "(   - (( 2.0 * ( 2.0 + 2.0 * myu.Value ) * vC4.Value ) + (( 4.0 - 2.0 * myu.Value ) * vC3.Value ) + ( 4.0 * vC1.Value )) + nA.Value * vSN.Value + myu.Value * vANT.Value + ( 1.0 - myu.Value ) * vPI.Value   ) * Rcm.Value / rbuffermito.Value / 1000.0 * self.getSuperSystem().SizeN_A";
	}

	@{'''
	<ATPsynthase name="vSN" initial_value="2.636388261805263E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.RespiratoryChain.ATPsynthase">
		<link name="Hmito" initial_value="../Proton" units="mM" />
		<link name="rbuffermito" initial_value="../rbuffer" units="mM Proton / pH" />
		<link name="dP" initial_value="../dP" units="mV" />
		<link name="ATPtmito" initial_value="../ATPtotal" units="mM" />
		<link name="ADPtmito" initial_value="../ADPtotal" units="mM" />
		<link name="Pitmito" initial_value="../Pi" units="mM" />
		<link name="Rcm" initial_value="../Rcm" units="dimensionless" />
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="F" initial_value="/Faraday constant" units="J/mmol/mV" />
		<parameter name="dGp0" initial_value="31.9" units="J/mmol" />
		<parameter name="nA" initial_value="2.5" units="dimensionless" />
		<parameter name="kSN" initial_value="5.7193E-4" units="mM/ms" />
		<link name="Amp" initial_value="../Amp" units="dimension_less" />
	</ATPsynthase>
	'''}

	@# ATP synthase
	Variable Variable( vSN )
	{
		Name "rate of ATP synthase (mM/ms)";
		Value 2.636388261805263e-4;
	}

	Variable Variable( vSN_nA )
	{
		Name "nA of vSN";
		Value 2.5;
	}

	Process ExpressionAssignmentProcess( vSN ) 
	{
		Name "rate of ATP synthase (mM/ms)";

		StepperID	PSV;
		Priority	14;

		VariableReferenceList
			[ vSN      :.:vSN      1 ]
			[ Hmito    :.:Proton   0 ]
			[ dP       :.:dP       0 ]
			[ ATPtmito :.:ATPtotal 0 ]
			[ ADPtmito :.:ADPtotal 0 ]
			[ Pitmito  :.:Pi       0 ]
			[ Zvalue   :.:Zvalue   0 ]
			[ nA       :.:vSN_nA   0 ]
			[ Amp      :.:Amp      0 ];

		dGp0	31.9;  # J/mmol
		kSN	5.7193e-4;  # mM/ms

		Expression "Amp.Value * kSN * (pow( 10.0, ( nA.Value * dP.Value - ( dGp0 * 1000.0 / @F + Zvalue.Value * log10( ATPtmito.MolarConc / ADPtmito.MolarConc / Pitmito.MolarConc ))) / Zvalue.Value ) - 1.0) / (pow( 10.0, ( nA.Value * dP.Value - ( dGp0 * 1000.0 / @F + Zvalue.Value * log10( ATPtmito.MolarConc / ADPtmito.MolarConc / Pitmito.MolarConc ))) / Zvalue.Value ) + 1.0)";

	}

	Process ExpressionFluxProcess( ATPsynthase ) 
	{
		Name "ATP synthase (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vSN      :.:vSN       0 ]
			[ ATPtmito :.:ATPtotal  1 ]
			[ ADPtmito :.:ADPtotal -1 ]
			[ Pitmito  :.:Pi       -1 ]
			[ Rcm      :.:Rcm       0 ];

		Expression "vSN.Value * Rcm.Value / 1000.0 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	ATP/ADP carrier
	<ATPADPExchanger name="vANT" initial_value="1.8697025007886943E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.Transporter.ANT">
		<link name="dPsicell" initial_value="../dPsicell" units="mV" />
		<link name="dPsimito" initial_value="../dPsimit" units="mV" />
		<link name="ATPfcell" initial_value="../../ATPfree" units="mM" />
		<link name="ADPfcell" initial_value="../../ADPfree" units="mM" />
		<link name="ATPfmito" initial_value="../ATPfree" units="mM" />
		<link name="ADPfmito" initial_value="../ADPfree" units="mM" />
		<link name="ATPtcell" initial_value="../../ATPtotal" units="mM" />
		<link name="ADPtcell" initial_value="../../ADPtotal" units="mM" />
		<link name="ATPtmito" initial_value="../ATPtotal" units="mM" />
		<link name="Hmito" initial_value="../Proton" units="mM" />
		<link name="myu" initial_value="../dP/myu" units="dimensionless" />
		<link name="Rcm" initial_value="../Rcm" units="dimensionless" />
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="rbuffermito" initial_value="../rbuffer" units="mM Proton / pH" />
		<parameter name="kEX" initial_value="9.0953E-4" units="mM/ms" />
		<parameter name="KmADP" initial_value="0.0035" units="mM" />
		<link name="Amp" initial_value="../Amp" units="dimension_less" />
	</ATPADPExchanger>
	'''}
	Variable Variable( vANT )
	{
		Name "rate of ATP/ADP exchanger (mM/ms)";
		Value 1.8697025007886943e-4;
	}

	Process ExpressionAssignmentProcess( vANT ) 
	{
		Name "rate of ATP/ADP exchanger (mM/ms)";

		StepperID	PSV;
		Priority	13;

		VariableReferenceList
			[ vANT     :.:vANT     1 ]
			[ dPsicell :.:dPsicell 0 ]
			[ dPsimito :.:dPsimit  0 ]
			[ ATPfcell :..:ATPfree 0 ]
			[ ADPfcell :..:ADPfree 0 ]
			[ ATPfmito :.:ATPfree  0 ]
			[ ADPfmito :.:ADPfree  0 ]
			[ Zvalue   :.:Zvalue   0 ]
			[ Amp      :.:Amp      0 ];

		kEX	9.0953e-4;  #  mM/ms
		KmADP	0.0035e-3;  #  (M)

		Expression "Amp.Value * kEX * (( ADPfcell.MolarConc / (ADPfcell.MolarConc + pow( 10.0, ( -dPsicell.Value / Zvalue.Value )) * ATPfcell.MolarConc )) - ( ADPfmito.MolarConc / (ADPfmito.MolarConc + pow( 10.0, ( -dPsimito.Value / Zvalue.Value )) * ATPfmito.MolarConc ))) / ( 1.0 + KmADP / ADPfcell.MolarConc )";
	}

	Process ExpressionFluxProcess( ATPADPExchanger ) 
	{
		Name "ATP/ADP exchanger, Adenine Nucleotide Transporter (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vANT     :.:vANT       0 ]
			[ ATPtcell :..:ATPtotal  1 ]
			[ ADPtcell :..:ADPtotal -1 ]
			[ ATPtmito :.:ATPtotal  -1 ]
			[ Rcm      :.:Rcm        0 ];

		@# Rcmをかけるのか、かけないのか？→かける。ミトコンドリアでの濃度変化について濃度・分子数変換する必要があるから。
		# Expression "vANT.Value / 1000.0 * self.getSuperSystem().SizeN_A";

		Expression "vANT.Value * Rcm.Value / 1000.0 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	<PhosphateCarrier name="vPI" initial_value="2.52434188981354E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.Transporter.PhosphateCarrier">
		<link name="Pitcell" initial_value="../../Pi" units="mM" />
		<link name="Pitmito" initial_value="../Pi" units="mM" />
		<link name="Hcell" initial_value="../../Proton" units="mM" />
		<link name="Hmito" initial_value="../Proton" units="mM" />
		<link name="pHcell" initial_value="../../pH" units="dimensionless" />
		<link name="pHmito" initial_value="../pH" units="dimensionless" />
		<link name="Rcm" initial_value="../Rcm" units="dimensionless" />
		<link name="myu" initial_value="../dP/myu" units="dimentionless" />
		<link name="rbuffermito" initial_value="../rbuffer" units="mM Proton / pH" />
		<parameter name="kPI" initial_value="1.157016667" units="1/mM/ms" />
		<parameter name="pKa" initial_value="6.8" units="dimensionless" />
		<link name="Amp" initial_value="../Amp" units="dimension_less" />
	</PhosphateCarrier>
	'''}

	@# Phosphate carrier
	Variable Variable( vPI )
	{
		Name "rate of phosphate carrier (mM/ms)";
		Value 2.52434188981354e-4;
	}

	Process ExpressionAssignmentProcess( vPI ) 
	{
		Name "rate of phosphate carrier (mM/ms)";

		StepperID	PSV;
		Priority	13;

		VariableReferenceList
			[ vPI     :.:vPI     1 ]
			[ Pitcell :..:Pi     0 ]
			[ Pitmito :.:Pi      0 ]
			[ Hcell   :..:Proton 0 ]
			[ Hmito   :.:Proton  0 ]
			[ pHcell  :..:pH     0 ]
			[ pHmito  :.:pH      0 ]
			[ Amp     :.:Amp     0 ];

		kPI	1.157016667;  # 1/mM/ms
		pKa	6.8;

		Expression "Amp.Value * kPI * ((( Pitcell.MolarConc * 1000.0 / ( 1.0 + pow( 10.0, ( pHcell.Value - pKa )))) * Hcell.MolarConc * 1000.0 ) - (( Pitmito.MolarConc * 1000.0 / ( 1.0 + pow( 10.0, ( pHmito.Value - pKa )))) * Hmito.MolarConc * 1000.0 ))";
	}

	Process ExpressionFluxProcess( PhosphateCarrier ) 
	{
		Name "phosphate carrier (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vPI     :.:vPI 0 ]
			[ Pitmito :.:Pi  1 ]
			[ Rcm     :.:Rcm 0 ];

		Expression "vPI.Value * Rcm.Value / 1000.0 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	<ProtonLeak name="vLK" initial_value="2.4173630507944038E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.Transporter.ProtonLeak">
		<link name="Hcell" initial_value="../../Proton" units="mM" />
		<link name="Hmito" initial_value="../Proton" units="mM" />
		<link name="rbuffermito" initial_value="../rbuffer" units="mM Proton / pH" />
		<link name="Rcm" initial_value="../Rcm" units="dimensionless" />
		<link name="dP" initial_value="../dP" units="mV" />
		<rateconstant name="kLK1" initial_value="4.16667E-8" units="mM/ms"
			className="org.simBio.bio.matsuoka_et_al_2004.function.chemical.FCCP">
			<link name="FCCP" initial_value="../../../../FCCP" units="mM" />
			<parameter name="initial" initial_value="4.16667E-8" units="mM/ms" />
		</rateconstant>
		<parameter name="kLK2" initial_value="0.038" units="1/mV" />
		<link name="Amp" initial_value="../Amp" units="dimension_less" />
	</ProtonLeak>
	'''}

	@# Proton leak
	Variable Variable( vLK )
	{
		Name "rate of proton leak (mM/ms)";
		Value 2.4173630507944038E-4;
	}

	Process ExpressionAssignmentProcess( vLK ) 
	{
		Name "rate of proton leak (mM/ms)";

		StepperID	PSV;
		Priority	13;

		VariableReferenceList
			[ vLK         :.:vLK     1 ]
			[ pHcell      :..:pH     0 ]
			[ dP          :.:dP      0 ]
			[ FCCP        :/:FCCP    0 ]
			[ Amp         :.:Amp     0 ];

		kLK1	4.16667e-8;  # mM/ms
		initial	4.16667e-8;  # mM/ms
		kLK2	0.038;  # 1/mV

		Expression "Amp.Value * initial * ( 1.0 + 1.0e+4 * FCCP.MolarConc / ( FCCP.MolarConc + 1.0e-7 )) * ( exp( kLK2 * dP.Value ) - 1.0 )";

	}

	Process ExpressionFluxProcess( ProtonLeak ) 
	{
		Name "proton leak (1/ms)";

		Priority	12;

		VariableReferenceList
			[ Hmito       :.:Proton   1 ]
			[ rbuffermito :.:rbuffer  0 ]
			[ Rcm         :.:Rcm      0 ]
			[ vLK         :.:vLK      0 ];

		Expression "vLK.Value * Rcm.Value / rbuffermito.Value * 1.0e-3 * self.getSuperSystem().SizeN_A";

	}

	@{'''
	<SubstrateDehydrogenation name="vDH" initial_value="1.1307728142212603E-4" units="mM/ms"
		className="org.simBio.bio.matsuoka_et_al_2004.molecule.SubstrateDehydrogenation">
		<link name="NAD" initial_value="../NAD" units="mM" />
		<link name="NADH" initial_value="../NADH" units="mM" />
		<link name="Rcm" initial_value="../Rcm" units="mM" />
		<parameter name="kDH" initial_value="4.679E-4" units="mM/ms" />
		<parameter name="KmN" initial_value="100.0" units="dimensionless" />
		<parameter name="PD" initial_value="0.8" units="dimensionless" />
		<link name="Amp" initial_value="../Amp" units="dimension_less" />
	</SubstrateDehydrogenation>
	'''}

	@# Substrate dehydrogenation
	Variable Variable( vDH )
	{
		Name "rate of substrate dehydrogenation in mitochondria (mM/ms)";
		Value 1.1307728142212603E-4;
	}

	Process ExpressionAssignmentProcess( vDH ) 
	{
		Name "rate of substrate dehydrogenation in mitochondria (mM/ms)";

		StepperID	PSV;
		Priority	13;

		VariableReferenceList
			[ vDH  :.:vDH  1 ]
			[ NAD  :.:NAD  0 ]
			[ NADH :.:NADH 0 ]
			[ Amp  :.:Amp  0 ];

		kDH	4.679e-4;  # mM/ms
		KmN	100.0;  # dimensionless
		PD	0.8;  # dimensionless

		Expression "Amp.Value * kDH / pow( 1.0 + KmN * NADH.Value / NAD.Value, PD )";

	}

	Process ExpressionFluxProcess( SubstrateDehydrogenation ) 
	{
		Name "substrate dehydrogenation in mitochondria (1/ms)";

		Priority	12;

		VariableReferenceList
			[ vDH  :.:vDH  0 ]
			[ NADH :.:NADH 1 ]
			[ Rcm  :.:Rcm  0 ];

		Expression " vDH.Value * Rcm.Value / 5.0 * 1.0e-3 * self.getSuperSystem().SizeN_A";

	}

	@# <parameter name="Amp" initial_value="5.0" units="dimension_less" />
	Variable Variable( Amp )
	{
		Name "amplifying factor";
		Value 5.0;
	}

}
