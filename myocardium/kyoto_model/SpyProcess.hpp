/** @file
 * @brief 他のEntityオブジェクトのPropertyを取得できるProcessの基底クラス
 *
 * SpyProcess.hpp
 * @author Yasuhiro Naito
 * @date Apr. 29, 2013
 */

#include "libecs.hpp"
#include "libecs/Model.hpp"
#include "libecs/Process.hpp"


USE_LIBECS;

/**
 * SpyProcess
 */

LIBECS_DM_CLASS( SpyProcess, Process )
{

 public:

	LIBECS_DM_OBJECT_ABSTRACT( SpyProcess )
	{
		INHERIT_PROPERTIES( Process );
	}

	SpyProcess()
	{
		; // do nothing
	}

	virtual ~SpyProcess()
	{
		;
	}

 protected:

	inline Real getPropertyValue( String& aFullPNString )
	{
		FullPN aFullPN( aFullPNString );
		return convertTo< Real >( getModel()->getEntity( aFullPN.getFullID() )->getProperty( aFullPN.getPropertyName() ) );
	}
};

LIBECS_DM_INIT_STATIC( SpyProcess, Process );
