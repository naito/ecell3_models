

	Variable Variable( VGPA_maxf )
	{
		Value 20.0;
	}

	Variable Variable( VGPB_maxf )
	{
		Value 30.0;
	}

	Variable Variable( VGP_GX )
	{
		Value @( Lambeth[Glycolysis]);
		#Value 1.0;
	}
	
	Variable Variable( frac_a )
       	{	
		Value 0.4;
        }

        Variable Variable( frac_b )
	{
                Value 0.6;
        }

	Process GP_Process( V_GP )
	{
		StepperID  ODE;
		Priority   0;

		VariableReferenceList
			[ VGPA_maxf     :.:VGPA_maxf   0 ]
			[ VGPB_maxf     :.:VGPB_maxf   0 ]
			[ frac_a     	:.:frac_a      0 ]
			[ frac_b     	:.:frac_b      0 ]
			[ GLY           :.:GLY         0 ]
#			[ Pi            :.:PiTotal    -1 ]
			[ Pi            :.:Pi         -1 ]
			[ AMP           :.:AMP         0 ]
			[ GX           :.:VGP_GX       0 ]
			[ G1P           :.:G1P         1 ];
	
			KGPA_GLYf 1.7;
			KGPA_iGLYf 2;
			KGPA_Pi 4;
			KGPA_iPi 4.7;
			KGPA_GLYb 0.15;
			KGPA_iGLYb 0.56;
			KGPA_iG1P 10.1;
			KGPA_eq 0.42;

			KGPB_iGLYf 15;
			KGPB_Pi 0.2;
			KGPB_iPi 4.6;
			KGPB_iGLYb 4.4;
			KGPB_G1P 1.5;
			KGPB_iG1P 7.4;
			KGPB_eq 0.42;
			KGPB_AMP 0.0000019;
			nH_GPB 1.75;
	}
