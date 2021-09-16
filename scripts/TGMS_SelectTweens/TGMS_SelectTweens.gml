

global.TGMS_HIDE = TweensIncludeDeactivated;
function TweensIncludeDeactivated(argument0)
{
	/// @description Whether or not to include tweens associated with deactivated target instances
	/// TweensIncludeDeactivated(include_deactivated)
	/// @param include_deactivated?
	/*
		When true, Tweens*() scripts will include tweens belonging to deactivated target instances.
		By default, this is set to false.

		e.g. 
			TweensIncludeDeactiavted(true); // include deactivated targets with Tweens*() scripts
	*/

	global.TGMS_TweensIncludeDeactivated = argument0;
}


global.TGMS_HIDE = Tweens;
function Tweens()
{
	/// @description Returns selected tween ids, for scripts supporting 'tween[s]' argument
	/// Tweens(tween1,tween2,...)
	/// @param tween1	first selected tween
	/// @param tween2	second selected tween
	/// @param ...		additional tweens
	/*
	    The Tweens*() selection scripts can be used with any tween scripts
	    which show 'tween[s]' as an argument.
    
	    e.g.
			var _tweens = Tweens(tween1, tween2);
	        TweenSet(_tweens, "time_scale", 0.5); // Set time scale for tween1 and tween2
	*/

	var _tweens;
	var i = -1;

	repeat(argument_count)
	{
	    ++i;
	    _tweens[i] = argument[i];
	}

	ds_stack_push(global.TGMS_TweensStack, _tweens);

	return "00";
}


global.TGMS_HIDE = TweensAll;
function TweensAll()
{
	/// @description Returns all tween ids, for scripts supporting 'tween[s]' argument
	/*
	    The Tweens*() scripts can be used with any tween scripts
	    which show 'tween[s]' as an argument.
    
	    e.g.
	        TweenStop(TweensAll()); // Stop all tweens
        
	    The keyword [all] can be used as a shortand version for TweensAll()
    
	    e.g.
	        TweensPause(all);
	        TweensResume(all);
	*/

	return "10";
}


global.TGMS_HIDE = TweensTarget;
function TweensTarget(argument0) 
{
	/// @description returns tween ids associated with target, for scripts supporting 'tween[s]' argument
	/// TweensTarget(target)
	/// @param target	target instance associated with tween
	/*
	    The Tweens*() scripts can be used with any tween scripts
	    which show 'tween[s]' as an argument.
    
	    e.g.
			TweenPause(TweensTarget(id)); // pause all tweens associated with target instance
			TweenResume(TweensTarget(obj_Player)); // resume all tweens associated with obj_Player
	*/

	return "3"+string(argument0);
}


global.TGMS_HIDE = TweensGroup;
function TweensGroup(argument0)
{
	/// @description Returns tween ids associated with a group, for scripts supporting 'tween[s]' argument
	/// TweensGroup(group)
	/// @param group	tween group

	/*
	    The Tweens*() scripts can be used with any tween scripts
	    which show 'tween[s]' as an argument.
    
	    e.g.
			TweenPause(TweensGroup(2)); // pause all tweens associated with group '2'
	*/

	return "2"+string(argument0);
}


