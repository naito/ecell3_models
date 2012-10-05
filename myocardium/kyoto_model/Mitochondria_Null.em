@{
Mitochondria_Mg = 0.38e-3
Mitochondria_Proton = 3.8052117309416624E-8
Mitochondria_pH = 7.419621173053379
Mitochondria_rbuffer = 251378.46458038045
Mitochondria_ATPtotal = 6.403037657787217e-3
Mitochondria_ATPfree = 2.741854916432813e-4
Mitochondria_ATPmg = 6.128852166143936e-3
Mitochondria_ADPtotal = 9.856962342212785e-3
Mitochondria_ADPfree = 4.198887281728104e-3
Mitochondria_ADPmg = 5.6580750604846815e-3
Mitochondria_ANP_total = 16.26e-3
Mitochondria_Pi = 5.247469299976676e-3
Mitochondria_NADH = 8.948906751612181e-4
Mitochondria_NAD = 2.075109324838782e-3
Mitochondria_NAD_H_total = 2.97e-3
Mitochondria_UQH2 = 1.0522454291006709e-3
Mitochondria_UQ = 2.977545708993292e-4
Mitochondria_UQ_H2_total = 1.35e-3
Mitochondria_Cytc2 = 5.012887032447142e-5
Mitochondria_Cytc3 = 2.198711296755286e-4
Mitochondria_Cytc_23_total = 0.27e-3
Mitochondria_EmN = -308.76432763447485
Mitochondria_EmU = 68.13566055321765
Mitochondria_Emc = 289.50055595027567
Mitochondria_Ema = 635.123715429545
Mitochondria_Cyta2 = 3.7318683311245e-6
Mitochondria_Cyta3 = 1.3126813166887552e-4
Mitochondria_Cyta_total = 1.35e-4
Mitochondria_vC1 = 1.0875968955265928e-4
Mitochondria_vC3 = 1.1175267504158818e-4
Mitochondria_vC4 = 5.593585025749086e-5
Mitochondria_vSN = 2.636388261805263e-4
Mitochondria_vANT = 1.8697025007886943e-4
Mitochondria_vPI = 2.52434188981354e-4
Mitochondria_vLK = 2.4173630507944038E-4
Mitochondria_vDH = 1.1307728142212603E-4
Mitochondria_Amp = 5.0

#Mitochondria_Amp = {
#	"V" : 5.0,
#	"EMB" : 0.5, #5.0/10
#	"LAT" : 2.5, #5.0/2
#	"NEO" : 2.5, #5.0/2
#	"SAN" : 1.2,
#	"A" : 1.2,
#}

}

System System( /CELL/CYTOPLASM/MITOCHONDRIA )
{
	StepperID	ODE;

	@{'''
	<volume me="volume" initial_value="3531.2679767719696" units="um^3">
		<link name="total" initial_value="../../volume" units="um^3" />
		<parameter name="ratio" initial_value="0.23" units="/cell volume" />
	</volume>
	'''}

	Variable Variable( SIZE )
	{
		Value @(MITOCHONDRIA_SIZE_init);
	}


	@{'''
	<volumeratio name="Rcm" initial_value="4.3478260869565215" units="dimensionless"
		className="org.simBio.bio.matsuoka_et_al_2004.function.VolumeRatio">
		<link name="ratio" initial_value="../volume/ratio" units="/cell volume" />
	</volumeratio>
	'''}

	Variable Variable( volumeRatio )
	{
		Value @Mit_volumeRatio;
	}

	Variable Variable( Rcm )
	{
		Name "Volume ratio between cell and mitochondria";
		Value @Mit_Rcm_init;
	}

	@# 細胞質 Pi の計算だが、ミトコンドリア内のリン酸関連物質量も計算に用いるため、Processをここに置く。Cytoplasmに置くと、Mitochondria.emを外したときにミトコンドリア内のVariableを参照できずエラーとなってしまう。

	@# 体積の変動を表現しているのに、総イオン濃度が変化しないと仮定しているのは厳密には不適切。無視して差し支えない程度かもしれないが。

	@{'''
	<Zvalue name="Zvalue" initial_value="61.51965192093832" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.Zvalue">
		<link name="T" initial_value="/absolute temperature" units="K" />
		<link name="R" initial_value="/Gas constant" units="mVC/K/mmol" />
		<link name="F" initial_value="/Faraday constant" units="C/mmol" />
	</Zvalue>
	'''}


	@# <parameter name="Mg" initial_value="0.38" units="mM" />
	Variable Variable( Mg )
	{
		Name "Mg";
		MolarConc @Mitochondria_Mg;
	}

	@# <variable name="Proton" initial_value="3.8052117309416624E-5" units="mM" />
	Variable Variable( Proton )
	{
		Name "Proton";
		MolarConc @Mitochondria_Proton;
	}

	@{'''
	<Acidity name="pH" initial_value="7.419621173053379" units="dimensionless">
		<link name="Proton" initial_value="../Proton" units="mM" />
	</Acidity>
	'''}
	Variable Variable( pH )
	{
		Name "pH";
		Value @Mitochondria_pH;
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
		Value @Mitochondria_rbuffer;
	}


	@{'''
	<gradientpH name="dpH" initial_value="25.814948504899753" units="dimensionless"
		className="org.simBio.bio.matsuoka_et_al_2004.function.GradientpH">
		<link name="Zvalue" initial_value="../Zvalue" units="mV" />
		<link name="pHcell" initial_value="../../pH" units="dimensionless" />
		<link name="pHmit" initial_value="../pH" units="dimensionless" />
	</gradientpH>
	'''}

	@{'''
	<gradientP name="dP" initial_value="185.71905399208455" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.GradientP">
		<link name="dpH" initial_value="../dpH" units="dimensionless" />
		<parameter name="myu" initial_value="0.861" units="dimensionless" />
	</gradientP>
	'''}

	@{'''
	<MembranePotential name="dPsi" initial_value="-159.9041054871848" units="mV"
		className="org.simBio.bio.matsuoka_et_al_2004.function.MembranePotential">
		<link name="dpH" initial_value="../dpH" units="dimensionless" />
		<link name="dP" initial_value="../dP" units="mV" />
	</MembranePotential>
	'''}

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

	@# <variable name="ATPtotal" initial_value="6.403037657787217" units="mM" />
	Variable Variable( ATPtotal )
	{
		Name "Total ATP";
		MolarConc @Mitochondria_ATPtotal;
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
		MolarConc @Mitochondria_ATPfree;
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
		MolarConc @Mitochondria_ATPmg;
	}

	@# 最小値（1.0e-18 mM）に関する処理は未実装

	@{'''
	<massconservation name="ADPtotal" initial_value="9.856962342212785" units="mM">
		<link name="other" initial_value="../ATPtotal" units="mM" />
		<parameter name="total" initial_value="16.26" units="mM" />
	</massconservation>
	'''}
	Variable Variable( ADPtotal )
	{
		Name "Total ADP";
		MolarConc @Mitochondria_ADPtotal;
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
		MolarConc @Mitochondria_ADPfree;
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
		MolarConc @Mitochondria_ADPmg;
	}

	@# <variable name="Pi" initial_value="5.247469299976676" units="mM" />
	Variable Variable( Pi )
	{
		Name "Pi";
		MolarConc @Mitochondria_Pi;
	}

	@# <variable name="NADH" initial_value="0.8948906751612181" units="mM" />
	Variable Variable( NADH )
	{
		Name "NADH";
		MolarConc @Mitochondria_NADH;
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
		MolarConc @Mitochondria_NAD;
	}

	@# <variable name="UQH2" initial_value="1.0522454291006709" units="mM" />
	Variable Variable( UQH2 )
	{
		Name "UQH2";
		MolarConc @Mitochondria_UQH2;
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
		MolarConc @Mitochondria_UQ;
	}

	@# <variable name="Cytc2" initial_value="0.05012887032447142" units="mM" />
	Variable Variable( Cytc2 )
	{
		Name "cytochrome c2";
		MolarConc @Mitochondria_Cytc2;
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
		MolarConc @Mitochondria_Cytc3;
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
		Value @Mitochondria_EmN;
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
		Value @Mitochondria_EmU;
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
		Value @Mitochondria_Emc;
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
		Value @Mitochondria_Ema;
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
		MolarConc @Mitochondria_Cyta2;
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
		MolarConc @Mitochondria_Cyta3;
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
		Value @Mitochondria_vC1;
	}

	Variable Variable( jC1 )  # jC1 は、量論係数の都合上 vC1 の 1/5 になっている
	{
		Name "jC1";
		Value 201118.214403;
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
		Value @Mitochondria_vC3;
	}

	Variable Variable( jC3 )
	{
		Name "jC3";
		Value 1033264.18784;
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
		Value @Mitochondria_vC4;
	}

	Variable Variable( jC4 )
	{
		Name "jC4";
		Value 517182.348127;
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

	Variable Variable( jO2 )
	{
		Name "jO2";
		Value -9.22582150713;
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
		Value @Mitochondria_vSN;
	}

	Variable Variable( jSN )
	{
		Name "jSN";
		Value 2437602.12017;
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
		Value @Mitochondria_vANT;
	}

	Variable Variable( jANT )
	{
		Name "jANT";
		Value 1728725.18287;
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

		vPI = Amp * kPI * (forward - backward);
		setValue(vPI);

		// [Pi]tcell is not regulated by differential equations.
		//		Pitcell.addDydt(- vPI);
		// [H+]cell is fixed.
		//
		// d[Pi]tmit/dt = (vPI - vSN)*Rcm - vSL
		Pitmito.addDydt(vPI * Rcm.getValue());
		// d[H+]mit/dt = -(2*(2+2*u)*vC4+(4-2*u)*vC3+4*vC1-nA*vSN-u*vEX-(1-u)*vPI-vLK)*Rcm/rbuffi
		Hmito.addDydt(
			(1.0 - myu) * vPI * Rcm.getValue() / rbuffermito.getValue());
	'''}

	@# Phosphate carrier
	Variable Variable( vPI )
	{
		Name "rate of phosphate carrier (mM/ms)";
		Value @Mitochondria_vPI;
	}

	Variable Variable( jPI )
	{
		Name "jPI";
		Value 2334064.60115;
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
		Value @Mitochondria_vLK;
	}

	Variable Variable( jLK )
	{
		Name "jLK";
		Value 8.89134086618;
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
		Value @Mitochondria_vDH;
	}

	Variable Variable( jDH )
	{
		Name "jDH";
		Value 209102.297208;
	}

	@# <parameter name="Amp" initial_value="5.0" units="dimension_less" />

}
