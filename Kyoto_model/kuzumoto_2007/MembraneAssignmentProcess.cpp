#include "libecs.hpp"
#include "Process.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( MembraneAssignmentProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( MembraneAssignmentProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 
	}
	
	MembraneAssignmentProcess()
	{
		// do nothing
	}

	virtual void initialize()
	{
		Process::initialize();
		
		T  = getVariableReference( "T" ).getVariable();
		Vm  = getVariableReference( "Vm" ).getVariable();
		R  = getVariableReference( "R" ).getVariable();
		F  = getVariableReference( "F" ).getVariable();
		zK  = getVariableReference( "zK" ).getVariable();
		zNa  = getVariableReference( "zNa" ).getVariable();
		zCa  = getVariableReference( "zCa" ).getVariable();
		zCl  = getVariableReference( "zCl" ).getVariable();
		vrtf  = getVariableReference( "vrtf" ).getVariable();
		EK  = getVariableReference( "EK" ).getVariable();
		Ke  = getVariableReference( "Ke" ).getVariable();
		Ki  = getVariableReference( "Ki" ).getVariable();
		CFNa  = getVariableReference( "CFNa" ).getVariable();
		Nae  = getVariableReference( "Nae" ).getVariable();
		Nai  = getVariableReference( "Nai" ).getVariable();
		CFK  = getVariableReference( "CFK" ).getVariable();
		CFCa  = getVariableReference( "CFCa" ).getVariable();
		Cae  = getVariableReference( "Cae" ).getVariable();
		Cai  = getVariableReference( "Cai" ).getVariable();
		CFCl  = getVariableReference( "CFCl" ).getVariable();
		Cle  = getVariableReference( "Cle" ).getVariable();
		Cli  = getVariableReference( "Cli" ).getVariable();
		///*
		current  = getVariableReference( "current" ).getVariable();
		currentNa  = getVariableReference( "currentNa" ).getVariable();
		currentK  = getVariableReference( "currentK" ).getVariable();
		currentCa  = getVariableReference( "currentCa" ).getVariable();
		currentCl  = getVariableReference( "currentCl" ).getVariable();
		//*/
		
		_R_F = R->getValue() / F->getValue();
		_R_FzK  = _R_F /  zK->getValue();
		_R_FzNa = _R_F / zNa->getValue();
		_R_FzCa = _R_F / zCa->getValue();
		_R_FzCl = _R_F / zCl->getValue();
	}

	virtual void fire()
	{
		_T = T->getValue();
		_V_T = Vm->getValue() / _T;

		_Ke_MolarConc = Ke->getMolarConc();
		_Ki_MolarConc = Ki->getMolarConc();

		EK->setValue( _R_FzK * _T * log( _Ke_MolarConc / _Ki_MolarConc ) );

		CFK->setValue( _ConstantField( _Ke_MolarConc, _Ki_MolarConc, ( _V_T / _R_FzK )));
		CFNa->setValue( _ConstantField( Nae->getMolarConc(), Nai->getMolarConc(), ( _V_T / _R_FzNa )));
		CFCa->setValue( _ConstantField( Cae->getMolarConc(), Cai->getMolarConc(), ( _V_T / _R_FzCa )));
		CFCl->setValue( _ConstantField( Cle->getMolarConc(), Cli->getMolarConc(), ( _V_T / _R_FzCl )));

		vrtf->setValue( _V_T / _R_F );

		///*
		current->setValue( 0.0 );
		currentNa->setValue( 0.0 );
		currentK->setValue( 0.0 );
		currentCa->setValue( 0.0 );
		currentCl->setValue( 0.0 );
		//*/
	}

 protected:

	Variable* T;
	Variable* Vm;
	Variable* R;
	Variable* F;
	Variable* zK;
	Variable* zNa;
	Variable* zCa;
	Variable* zCl;
	Variable* vrtf;

	Variable* EK;
	Variable* Ke;
	Variable* Ki;

	Variable* CFNa;
	Variable* Nae;
	Variable* Nai;

	Variable* CFK;

	Variable* CFCa;
	Variable* Cae;
	Variable* Cai;

	Variable* CFCl;
	Variable* Cle;
	Variable* Cli;

	///*
	Variable* current;
	Variable* currentNa;
	Variable* currentK;
	Variable* currentCa;
	Variable* currentCl;
	//*/
	
 private:

	Real _T;
	Real _R_F;
	Real _R_FzK;
	Real _R_FzNa;
	Real _R_FzCa;
	Real _R_FzCl;
	Real _V_T;
	Real _Ke_MolarConc;
	Real _Ki_MolarConc;

	Real _ConstantField( Real Xe_MolarConc, Real Xi_MolarConc, Real zFV_RT )
	{
		return ( zFV_RT * ( Xi_MolarConc - Xe_MolarConc * exp( -zFV_RT )) / ( 1.0 - exp( -zFV_RT ) ) * 1000.0 );
	}
};

LIBECS_DM_INIT( MembraneAssignmentProcess, Process );

