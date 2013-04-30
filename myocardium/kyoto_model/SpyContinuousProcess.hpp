/** @file
 * @brief 他のEntityオブジェクトのPropertyを取得できるProcessの基底クラス
 *
 * SpyContinuousProcess.hpp
 * @author Yasuhiro Naito
 * @date Apr. 29, 2013
 */

#include "SpyProcess.hpp"

USE_LIBECS;

LIBECS_DM_CLASS( SpyContinuousProcess, SpyProcess )
{

 public:

	LIBECS_DM_OBJECT_ABSTRACT( SpyContinuousProcess )
	{
		INHERIT_PROPERTIES( SpyProcess );
	}

	SpyContinuousProcess()
	{
		; // do nothing
	}

	virtual ~SpyContinuousProcess()
	{
		;
	}

	virtual bool isContinuous() const
	{
		return true;
	}

};

LIBECS_DM_INIT_STATIC( SpyContinuousProcess, SpyProcess );

