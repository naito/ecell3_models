#include "libecs.hpp"

#include "ContinuousProcess.hpp"
#include<vector>
#include <iostream>
USE_LIBECS;

LIBECS_DM_CLASS( AGSProcess, ContinuousProcess )
{

public:

 LIBECS_DM_OBJECT( AGSProcess, Process )
   {
     INHERIT_PROPERTIES( ContinuousProcess );
     PROPERTYSLOT_SET_GET( Real, 	Km_acCoA  );
     PROPERTYSLOT_SET_GET( Real, 	Km_Glu  );
     PROPERTYSLOT_SET_GET( Real, 	Ki_acCoA  );
     PROPERTYSLOT_SET_GET( Real, 	Ka_Arg  );
     PROPERTYSLOT_SET_GET( Real, 	Ki_CoA  );
     PROPERTYSLOT_SET_GET( Real, 	Ki_NAG  );
      PROPERTYSLOT_SET_GET( Real, 	kcat  );
   }

 AGSProcess()
   :
   Km_acCoA(0.0),
   Km_Glu(0.0),
   Ki_acCoA(0.0),
   Ka_Arg(0.0),
   Ki_CoA(0.0),
   Ki_NAG(0.0),
   kcat(0.0)
    {
      ; // do nothing
    }
           SIMPLE_SET_GET_METHOD( Real, 	Km_acCoA  );
     SIMPLE_SET_GET_METHOD( Real, 	Km_Glu  );
     SIMPLE_SET_GET_METHOD( Real, 	Ki_acCoA  );
     SIMPLE_SET_GET_METHOD( Real, 	Ka_Arg  );
     SIMPLE_SET_GET_METHOD( Real, 	Ki_CoA  );
     SIMPLE_SET_GET_METHOD( Real, 	Ki_NAG  );
      SIMPLE_SET_GET_METHOD( Real, 	kcat  );
  //void setvs( RealCref value ) { vs = value; }
  //const Real getvs() const { return vs; }
  //void setKI( RealCref value ) { KI = value; }
  //const Real getKI() const { return KI; }

   virtual void initialize()
     {
	Process::initialize();
	Glu1= getVariableReference( "Glu" ).getVariable();  
	acCoA2= getVariableReference( "acCoA" ).getVariable(); 
	CoA3= getVariableReference( "CoA" ).getVariable();  
	NAG4= getVariableReference( "NAG" ).getVariable(); 
	Arg5= getVariableReference( "Arg" ).getVariable();  
	AGS6= getVariableReference( "AGS" ).getVariable(); 
	//velocity=N_A/60;
     }

   virtual void fire()
   {
Real Glu( Glu1->getMolarConc() );
Real acCoA( acCoA2->getMolarConc() );
Real CoA( CoA3->getMolarConc() );
Real NAG( NAG4->getMolarConc() );
Real Arg( Arg5->getMolarConc() );
Real AGS( AGS6->getMolarConc() );
Real size( Glu1->getSuperSystem()->getSize());

Real velocity = kcat * AGS * acCoA * Glu;

Real DENOM = Ki_acCoA * ( 1 + CoA / Ki_CoA ) * Km_Glu * ( 1 + NAG / Ki_NAG )
	    + Km_Glu * ( 1 + NAG / Ki_NAG ) * acCoA 
	    + Km_acCoA * ( 1 + CoA / Ki_CoA ) * Glu
	    + acCoA * Glu;

Real activate =  1 + (Ka_Arg / Arg);

velocity /= DENOM;
velocity /= activate;
velocity *= N_A *size ;

//std::cout <<"velocity="<<velocity<<"\n";
setFlux(velocity);

     }

protected:
   Real  	Km_acCoA ;			
   Real	Km_Glu 		;
   Real	Ki_acCoA 		;
   Real	Ka_Arg 		;
   Real	Ki_CoA 		;
   Real	Ki_NAG 	;
   Real	kcat ;
   Variable*	Glu1;  
   Variable*	acCoA2; 
   Variable*	CoA3; 
   Variable*	NAG4; 
   Variable*	Arg5; 
   Variable*	AGS6; 
 private:

};

LIBECS_DM_INIT( AGSProcess, Process );
