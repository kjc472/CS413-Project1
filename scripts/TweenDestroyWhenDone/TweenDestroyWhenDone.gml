/// @description Forces a tween to be destroyed when finished or stopped
function TweenDestroyWhenDone() {

	/// TweenDestroyWhenDone(tween[s], destroy, [kill_target])
	/// @param	tween[s]	tween id(s)
	/// @param	destroy?		destroy tween[s] when finished or stopped?
	/// @param	[kill_target?]	(optional) destroy target when tween finished or stopped?

	/// return: na

	var _t = argument[0];

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (argument_count == 2)
	    {
	        _t[@ TWEEN.DESTROY] = argument[1];
	    }
	    else
	    {
			var _doDestroy = argument[1];
	        _t[@ TWEEN.DESTROY] = (_doDestroy+argument[2])*_doDestroy;
	    }
	}

	if (is_string(_t))
	{
	    if (argument_count == 2)
	    {
	        TGMS_TweensExecute(_t, TweenDestroyWhenDone, argument[1]);
	    }
	    else
	    {
	        TGMS_TweensExecute(_t, TweenDestroyWhenDone, argument[1], argument[2]);
	    }
	}



}
