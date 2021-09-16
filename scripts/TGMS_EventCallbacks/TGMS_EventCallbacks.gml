


global.TGMS_HIDE = TweenCallbackNull;
function TweenCallbackNull() 
{
	/// @description Returns a null callback id
	return undefined;
}


function TweenAddCallback()
{
	/// @description Adds script to be called on tween event
	/// TweenAddCallback(tween,event,target,script,[arg0...])
	/// @param tween		tween id
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param target		instance used to call script
	/// @param script		script to call on tween event
	/// @param [arg0,...]	(optional) arguments to pass to script
	/// return: callback id

	/*      
	    INFO:
	        Sets a script to be called on specified tween event.
	        Multiple callbacks can be added to the same event.
        
	        "event" can take any of the following TWEEN_EV_* macros:
	        TWEEN_EV_PLAY
	        TWEEN_EV_FINISH
	        TWEEN_EV_CONTINUE
	        TWEEN_EV_STOP
	        TWEEN_EV_PAUSE
	        TWEEN_EV_RESUME
	        TWEEN_EV_REVERSE 
		
			TWEEN_EV_FINISH_DELAY
			TWEEN_EV_STOP_DELAY
			TWEEN_EV_PAUSE_DELAY
			TWEEN_EV_RESUME_DELAY   
	*/

	var _tID = argument[0];
	var _t = TGMS_FetchTween(_tID);
	if (is_undefined(_t)) { return undefined; }

	var _events = _t[TWEEN.EVENTS];
	var _cb;

	// Create and assign events map if it doesn't exist
	if (_events == -1)
	{
	    _events = ds_map_create();
	    _t[@ TWEEN.EVENTS] = _events;
	}

	var _index = argument_count;
	repeat(_index-4)
	{
	    --_index;
	    _cb[_index] = argument[_index];
	}

	// Set default state as active
	_cb[TWEEN_CALLBACK.ENABLED] = true;
	// Assign target to callback
	_cb[TWEEN_CALLBACK.TARGET] = argument[2];
	// Assign script to callback
	_cb[TWEEN_CALLBACK.SCRIPT] = argument[3]; 
	// Assign tween id to callback
	_cb[TWEEN_CALLBACK.TWEEN] = _tID;

	// IF event type exists...
	if (ds_map_exists(_events, argument[1]))
	{
	    // Cache event
	    var _event = _events[? argument[1]];
	    // Add event to events map
	    ds_list_add(_event, _cb);
    
	    // Do some event callback cleanup if size starts to get larger than expected
	    if (ds_list_size(_event) mod 10 == 0)
	    {   
	        ds_priority_add(SharedTweener().eventCleaner, _event, _event);
	    }
	}
	else
	{
	    // Create event list
	    var _event = ds_list_create();
	    // Add STATE and CALLBACK to event
	    ds_list_add(_event, true, _cb);
	    // Add event to events map
	    _events[? argument[1]] = _event;
	}

	// Return callback array
	return _cb;
}



global.TGMS_HIDE = TweenAddCallbackUser;
function TweenAddCallbackUser(argument0, argument1, argument2, argument3) 
{
	/// @description Sets a user event to be called on tween event
	/// TweenAddCallbackUser(tween,event,target,user_event)
	/// @param tween		tween id
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param target		instance to call user event
	/// @param user_event	user event to be called (0-15)
	/// return: callback id

	/*        
	    INFO:
	        Sets a user event (0-15) to be called on specified tween event.
	        Multiple callbacks can be added to the same event.
        
	        "event" can take any of the following macros:
	        TWEEN_EV_PLAY
	        TWEEN_EV_FINISH
	        TWEEN_EV_CONTINUE
	        TWEEN_EV_STOP
	        TWEEN_EV_PAUSE
	        TWEEN_EV_RESUME
	        TWEEN_EV_REVERSE    

			TWEEN_EV_FINISH_DELAY
			TWEEN_EV_STOP_DELAY
			TWEEN_EV_PAUSE_DELAY
			TWEEN_EV_RESUME_DELAY  
	*/

	TweenAddCallback(argument0, argument1, argument2, TGMS_EventUser, argument3);
}


global.TGMS_HIDE = TweenCallbackEnable;
function TweenCallbackEnable(_cb, _enable) 
{
	/// @description Enables/disables specified callbacks
	/// TweenCallbackEnable(callback,enable)
	/// @param callback		callback id
	/// @param enable		perform callback?
	/// return: na

	if (is_array(_cb))
	{
	    _cb[@ TWEEN_CALLBACK.ENABLED] = _enable;
	}
}


global.TGMS_HIDE = TweenCallbackInvalidate;
function TweenCallbackInvalidate(_cb)
{
	/// @description Removes callback from its associated tween event
	/// TweenCallbackInvalidate(callback)
	/// @param callback		callback id
	/// return: na
	/*      
	    Example:
	        // Create tween and add callback to finish event
	        tween = TweenCreate(id);
	        cb = TweenEventAddCallback(tween, TWEEN_EV_FINISH, id, ShowMessage, "Finished!");
        
	        // Invalidate callback -- effectively removes it from tween event
	        TweenInvalidate(cb);
	*/

	if (is_array(_cb))
	{
	    // Set target as noone -- used for system cleaning
	    _cb[@ TWEEN_CALLBACK.TARGET] = noone;
	    _cb[@ TWEEN_CALLBACK.TWEEN] = TweenNull();
	}
}


global.TGMS_HIDE = TweenCallbackIsEnabled;
function TweenCallbackIsEnabled(_cb) 
{
	/// @description Checks if callback is enabled
	/// TweenCallbackIsEnabled(callback)
	/// @param callback		callback id
	/// return: bool

	if (is_array(_cb))
	{
	    return _cb[TWEEN_CALLBACK.ENABLED] && _cb[@ TWEEN_CALLBACK.TARGET] != noone;;
	}
}


global.TGMS_HIDE = TweenCallbackIsValid;
function TweenCallbackIsValid(_cb)
{
	/// @description Checks if callback id is valid
	/// TweenCallbackIsValid(callback)
	/// @param callback		callback id
	/// return: bool
	/*      
	    Example:
	        if (TweenCallbackValid(callback))
	        {
	            TweenCallbackInvalidate(callback);
	        }
	*/

	if (is_array(_cb))
	{
	    return TweenExists(_cb[TWEEN_CALLBACK.TWEEN]);
	}

	return false;
}


function TweenEventClear(_t, _event_type)
{
	/// @description Invalidates all callbacks associated with tween event
	/// TweenEventClear(tween[s],event)
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)
	/// return: na

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    var _events = _t[TWEEN.EVENTS];
    
	    if (_events != -1)
	    {    
	        if (ds_map_exists(_events, _event_type))
	        {
	            var _event = _events[? _event_type]; 
	            var _index = 0;
            
	            repeat(ds_list_size(_event)-1)
	            {
	                // Get callback
	                var _cb = _event[| ++_index];
	                // Invalidate target
	                _cb[@ TWEEN_CALLBACK.TARGET] = noone;
	            }
	        }
	    }
	}
	else if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenEventClear, _event_type);
	}
}


function TweenEventEnable(_t, _event_type, _enable)
{
	/// @description Enables/disables specified tween event
	/// TweenEventEnable(tween[s],event,enable)
	/// @param tween[s]		tween id[s]
	/// @param event		tween event macro (TWEEN_EV_*)
	/// @param enable		enable event?
	/// return: na

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    var _events = _t[TWEEN.EVENTS];
    
	    // Create and assign events map if it doesn't exist
	    if (_events == -1)
	    {
	        _events = ds_map_create();
	        _t[@ TWEEN.EVENTS] = _events;
	    }
    
	    if (ds_map_exists(_events, _event_type) == false)
	    {
	        // Create event list
	        var _event = ds_list_create();
	        // Add event to events map
	        _events[? _event_type] = _event;
	    }
    
	    // Set tween event state
	    var _event = _events[? _event_type];
	    _event[| 0] = _enable;
	}
	else
	if (is_string(_t))
	{
	    TGMS_TweensExecute(_t, TweenEventEnable, argument1, _enable);
	}
}


global.TGMS_HIDE = TweenEventIsEnabled;
function TweenEventIsEnabled(argument0, argument1)
{
	/// @description Checks if tween event is enabled
	/// TweenEventIsEnabled(tween,event)
	/// @param tween	tween id
	/// @param event	tween event macro (TWEEN_EV_*)
	/// return: bool

	var _t = TGMS_FetchTween(argument0);
	if (is_undefined(_t)) { return 0; }

	var _events = _t[TWEEN.EVENTS];
	var _eventType = argument1;

	// Return true if events don't exist
	if (_events == -1) { return true; }

	// Return true if event type doesn't exist
	if (ds_map_exists(_events, _eventType) == false) { return true; }

	// Return event's [enabled] state boolean
	return ds_list_find_value(_events[? _eventType], 0);
}

