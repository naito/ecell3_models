#include <gsl/gsl_errno.h> 
#include <gsl/gsl_math.h> 
#include <gsl/gsl_roots.h> 
#include <vector>

#include <libecs/libecs.hpp>
#include <libecs/Process.hpp>
#include <libecs/Stepper.hpp>
#include <libecs/FullID.hpp>

USE_LIBECS;

LIBECS_DM_CLASS( IsotonicContractionProcess, Process )
{

 public:

	LIBECS_DM_OBJECT( IsotonicContractionProcess, Process )
	{
		INHERIT_PROPERTIES( Process ); 

		PROPERTYSLOT_SET_GET( Real, A );
		PROPERTYSLOT_SET_GET( Real, L0 );
		PROPERTYSLOT_SET_GET( Real, K );
		PROPERTYSLOT_SET_GET( Real, Kl );
		PROPERTYSLOT_SET_GET( Real, epsabs );
		PROPERTYSLOT_SET_GET( Real, epsrel );
	}
	
	IsotonicContractionProcess()
		:
		A( 3.06e6 ),
		L0( 0.97 ),
		K( 140000.0 ),
		Kl( 200.0 ),
		epsabs( 0.0 ),
		epsrel( 1.0e-6 )
	{
		// do nothing
	}
	
	SIMPLE_SET_GET_METHOD( Real, A );
	SIMPLE_SET_GET_METHOD( Real, L0 );
	SIMPLE_SET_GET_METHOD( Real, K );
	SIMPLE_SET_GET_METHOD( Real, Kl );
	SIMPLE_SET_GET_METHOD( Real, epsabs );
	SIMPLE_SET_GET_METHOD( Real, epsrel );
	
	virtual void initialize()
	{
		Process::initialize();
		
		L        = getVariableReference( "L" ).getVariable();
		forceExt = getVariableReference( "forceExt" ).getVariable();
		X        = getVariableReference( "X" ).getVariable();
		TCaCB    = getVariableReference( "TCaCB" ).getVariable();
		TCB      = getVariableReference( "TCB" ).getVariable();

		max_iter = 100;

		// パラメータ内容を代入
		params.push_back( TCaCB->getMolarConc() * 1000.0 );
		params.push_back( TCB->getMolarConc() * 1000.0 );
		params.push_back( X->getValue() );
		params.push_back( forceExt->getValue() );
		params.push_back( K );
		params.push_back( Kl );
		params.push_back( L0 );
		params.push_back( A );
		
		// FDFに関数、導関数、パラメータを指定する
		FDF.f      = &IsotonicContractionProcess::the_f; 
		FDF.df     = &IsotonicContractionProcess::the_df; 
		FDF.fdf    = &IsotonicContractionProcess::the_fdf; 
		FDF.params = &params; 

		// 求根法のインスタンスsを生成する。simBioではsecant method
		//T = gsl_root_fdfsolver_secant;
		T = gsl_root_fdfsolver_steffenson;
		//T = gsl_root_fdfsolver_newton;

		s = gsl_root_fdfsolver_alloc( T ); 

	}

	virtual void fire();

 protected:

	Real A;
	Real L0;
	Real K;
	Real Kl;
	Real epsabs;
	Real epsrel;
	
	Variable* L;
	Variable* forceExt;
	Variable* X;
	Variable* TCaCB;
	Variable* TCB;

 private:
	
	int status;
	
	int iter;
	int max_iter;
	
	Real x0;
	Real x;
	
	// Pointer of a derivative-based solver instance of type T
	const gsl_root_fdfsolver_type *T; 
	gsl_root_fdfsolver *s; 
	
	// A general function with parameters and its first derivative.
	gsl_function_fdf FDF; 
	
	// Defintion of parameters of the function.
	std::vector< Real > params;
	
	// Prototypes of the function to solve (f), its derivative (df), and set of f & df (fdf)
	// They are set as static because their POINTERs will be called by a gsl_function_fdf instance. 
	static Real the_f (Real x, void *params);
	static Real the_df (Real x, void *params);
	static void the_fdf (Real x, void *params, Real *y, Real *dy);

};

LIBECS_DM_INIT( IsotonicContractionProcess, Process );

Real IsotonicContractionProcess::the_f (Real x, void *params)
{
	std::vector< Real > *p = ( std::vector< Real > * ) params;
	Real cTCaCB   = p->at( 0 );
	Real cTCB     = p->at( 1 );
	Real ex       = p->at( 2 );
	Real forceExt = p->at( 3 );
	Real K        = p->at( 4 );
	Real Kl       = p->at( 5 );
	Real L0       = p->at( 6 );
	Real A        = p->at( 7 );

	double strain = x - L0;
	double dforceNonLinear = K * pow( strain, 4.0 );

	double dforceB = A * (cTCaCB + cTCB);

	return forceExt - dforceNonLinear * strain - Kl * strain - dforceB * (x - ex);

	/*
	double f = forceExt - dforceNonLinear * strain - Kl * strain - dforceB * (x - ex);
	printf( "\nf   = %1.12e", f );
	return f;
	*/
}

Real IsotonicContractionProcess::the_df (Real x, void *params)
{
	std::vector< Real > *p = ( std::vector< Real > * ) params;
	Real cTCaCB   = p->at( 0 );
	Real cTCB     = p->at( 1 );
	Real ex       = p->at( 2 );
	Real forceExt = p->at( 3 );
	Real K        = p->at( 4 );
	Real Kl       = p->at( 5 );
	Real L0       = p->at( 6 );
	Real A        = p->at( 7 );

	return - 5.0 * K * pow( x - L0, 4.0 ) - Kl - A * (cTCaCB + cTCB);

	/*
	double df =  - 5.0 * K * pow( x - L0, 4.0 ) - Kl - A * (cTCaCB + cTCB);
	printf( "   df  = %1.12e", df );
	return df;
	*/
}

void IsotonicContractionProcess::the_fdf (Real x, void *params, Real *y, Real *dy)
{
	/*
	*y  = the_f(  x, params);
	*dy = the_df( x, params);
	*/
	
	std::vector< Real > *p = ( std::vector< Real > * ) params;
	Real cTCaCB   = p->at( 0 );
	Real cTCB     = p->at( 1 );
	Real ex       = p->at( 2 );
	Real forceExt = p->at( 3 );
	Real K        = p->at( 4 );
	Real Kl       = p->at( 5 );
	Real L0       = p->at( 6 );
	Real A        = p->at( 7 );

	double strain = x - L0;
	double dforceNonLinear = 5.0 * K * pow( strain, 4.0 );

	double dforceB = A * (cTCaCB + cTCB);

	*y  = forceExt - dforceNonLinear / 5.0 * strain - Kl * strain - dforceB * (x - ex);
	*dy = - dforceNonLinear - Kl - dforceB;
	
}

void IsotonicContractionProcess::fire()
{
	
	iter = 0; 

	// パラメータ内容を代入
	//params = t->getValue();
	params[ 0 ] = TCaCB->getMolarConc() * 1000.0 ;
	params[ 1 ] = TCB->getMolarConc() * 1000.0;
	params[ 2 ] = X->getValue();
	params[ 3 ] = forceExt->getValue();

	x  = L->getValue(); 

	// x1に相当する値を計算してx0に格納
	x0 = x - ( the_f( x, &params ) / the_df( x, &params ) );

	// Secant法のインスタンスsを関数FDFに適用するために初期化し、探索点の初期値をxに設定する。
	gsl_root_fdfsolver_set( s, &FDF, x ); 

/*
	//すでに十分な解に達していた場合、求根を行わずに脱出
	if ( gsl_root_test_delta ( x, x0, epsabs, epsrel ) == GSL_CONTINUE ) {

		do
		{
			iter++; 

			// 求根法の繰り返し計算を１回実行。

			printf( "x0  = %12.10f\n", x0 );
			printf( "x   = %12.10f\n", x  );
			printf( "dx  = %e\n", x - x0 );

			status = gsl_root_fdfsolver_iterate( s ); 

			printf( "status: %d\n\n", status );

			x0 = x; 
			x = gsl_root_fdfsolver_root( s ); 

			status = gsl_root_test_delta ( x, x0, epsabs, epsrel ); 
		}
		while ( status == GSL_CONTINUE && iter < max_iter );
	}
*/
	for ( iter = 0; iter < max_iter; iter++ )
	{
		if ( gsl_root_test_delta ( x, x0, epsabs, epsrel ) == GSL_SUCCESS ) break;

		// 求根法の繰り返し計算を１回実行。

		//printf( "\nx0  = %12.10f", x0 );
		//printf( "\nx   = %12.10f", x  );
		//printf( "\ndx  = %e", x - x0 );

		status = gsl_root_fdfsolver_iterate( s );
		if ( status ) {
			
			if ( status  == GSL_EBADFUNC ) printf( "gsl_root_fdfsolver_iterate: GSL_EBADFUNC" ); 
			if ( status  == GSL_EZERODIV ) printf( "gsl_root_fdfsolver_iterate: GSL_EZERODIV" ); 
		}
		
		//printf( "\nstatus: %d\n", status );

		x0 = x; 
		x = gsl_root_fdfsolver_root( s ); 
	}


	L->setValue( x );
	setActivity( x );

}
