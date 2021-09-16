

global.TGMS_HIDE = SharedTweenerActivate;
function SharedTweenerActivate() 
{	
	/// @description Activates shared tweener instance
	instance_activate_object(obj_SharedTweener);
}


global.TGMS_HIDE = SharedTweenerDestroy;
function SharedTweenerDestroy()
{
	/// @description Destroys shared tweener instance
	instance_destroy(obj_SharedTweener, true);
}


global.TGMS_HIDE = TweenSystemClearRoom;
function TweenSystemClearRoom(room_id)
{
	/// @description Clears tweens in inactive persistent room(s)
	/// @param room		room index or [all] keyword for all rooms

	TGMS_ClearRoom(room_id);
}


global.TGMS_HIDE = TweenSystemCount;
function TweenSystemCount() 
{
	/// TweenSystemCount(label: "all" "playing" "paused" "stopped")
	/// @description Returns count of tweens in system
	/// @param ["dataLabel"] (optional)
	/// return: real
	/*
	    INFO:
	        Returns total number of tweens in system, excluding those in inactive persistent rooms.
			Can pass optional label in for counting only specific tweens
        
		SUPPORTED DATA LABELS:
	        "all"
	        "playing"
	        "paused"
	        "stopped"
	*/

	if (argument_count == 0)
	{
	    return ds_list_size(SharedTweener().tweens);
	}

	var _tweens = SharedTweener().tweens;
	var _total = 0;
	var _index = -1;

	switch(argument[0])
	{
	    case "all":
	        _total = ds_list_size(_tweens);
	    break;
    
	    case "playing":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] >= 0;
	        }
	    break;
    
	    case "paused":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] == TWEEN_STATE.PAUSED;
	        }
	    break;
    
	    case "stopped":
	        repeat(ds_list_size(_tweens))
	        {
	            var _tween = _tweens[| ++_index];
	            _total += _tween[TWEEN.STATE] == TWEEN_STATE.STOPPED;
	        }
	    break;
	}

	return _total;
}


global.TGMS_HIDE = TweenSystemFlushDestroyed;
function TweenSystemFlushDestroyed()
{
	/// @description Override memory manager to immediately clear destroyed tweens

	if (instance_exists(global.TGMS_SharedTweener))
	{
	    global.TGMS_SharedTweener.flushDestroyed = true;
	}
}


global.TGMS_HIDE = TweenSystemGet;
function TweenSystemGet(data_label)
{
	/// @description Returns value for selected tweening system property
	/// @param "dataLabel"		Type of data to retrieve. Must be a string.
	/// return: real
	/*
	    SUPPORTED DATA LABELS:
	        "enabled"			// is system enabled?
	        "time_scale"		// global time scale
	        "update_interval"	// how often system should update in steps (default = 1)
	        "min_delta_fps"		// minimum frame rate before delta time lags begin (default=10)
	        "auto_clean_count"	// number of tweens to check for auto-cleaning each step (default=10)
	        "delta_time"		// tweening systems internal delta time
	        "delta_time_scaled" // tweening systems scaled delta time
	*/

	switch(data_label)
	{
	    case "delta_time":
	        return SharedTweener().deltaTime;
	    break;
    
	    case "delta_time_scaled":
	        return SharedTweener().deltaTime * global.TGMS_TimeScale;
	    break;
    
	    case "enabled":
	        return global.TGMS_IsEnabled;
	    break;
    
	    case "time_scale":
	        return global.TGMS_TimeScale;
	    break;
    
	    case "update_interval":
	        return global.TGMS_UpdateInterval;
	    break;
    
	    case "min_delta_fps":
	        return global.TGMS_MinDeltaFPS;
	    break;
    
	    case "auto_clean_count":
	        return global.TGMS_AutoCleanIterations;
	    break; 
	}
}


global.TGMS_HIDE = TweenSystemSet;
function TweenSystemSet(data_label, value)
{
	/// @description Sets value for specified tweening system property
	/// @param "dataLabel"
	/// @param value
	/*
	    SUPPORTED DATA LABELS:
	        "enabled"
	        "time_scale"
	        "update_interval"
	        "min_delta_fps"
	        "auto_clean_count"
	*/

	var _sharedTweener = SharedTweener();

	switch(data_label)
	{
	    case "enabled":
	        _sharedTweener.isEnabled = value;
	        global.TGMS_IsEnabled = value;
	    break;
    
	    case "time_scale":
	        _sharedTweener.timeScale = value;
	        global.TGMS_TimeScale = value;
	    break;
    
	    case "update_interval":
	        _sharedTweener.updateInterval = value;
	        global.TGMS_UpdateInterval = value;
	    break;
    
	    case "min_delta_fps":
	        global.TGMS_MinDeltaFPS = value;
	        _sharedTweener.minDeltaFPS = value;
	        _sharedTweener.maxDelta = 1/_sharedTweener.minDeltaFPS;
	    break;
    
	    case "auto_clean_count":
	        global.TGMS_AutoCleanIterations = value;
	        _sharedTweener.autoCleanIterations = value;
	    break; 
	}
}

