
/// @description Returns calculated value from tween's current state
function TweenCalc(argument0)
{
	/// TweenCalc(tween)
	/// @param tween	tween id

	/// return: real

	/*
	    INFO:
	        Returns a calculated value using a tweens current state.
        
	        Note: Useful with null property setters which can be set by
	        using TPNull() for property argument.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenFire(id, EaseInOutQuint, 0, true, 0.0, 2.5, TPNull(), x, mouse_x);
        
	        // Calculate value of tween at its current state
	        x = TweenCalc(tween);
	*/

	var _t = TGMS_FetchTween(argument0);
	if (is_undefined(_t)){
	    return 0;
	}

	var _duration = _t[TWEEN.DURATION];

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], _t[TWEEN.TIME], 0, 1, _t[TWEEN.DURATION]);
    
	    repeat(array_length_1d(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid
	        if (_duration == 0){
	            _return[_dataIndex] = _start;
	        }
	        else{
	            _return[_dataIndex] = lerp(_start, _dest, _amount);
	        }
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_duration == 0){
	        return _t[TWEEN.START];
	    }

	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(_t[TWEEN.TIME], 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], _duration);
	}
}


global.TGMS_HIDE = TweenCalcAmount;
function TweenCalcAmount(argument0, argument1)
{
	/// @description Returns calculated value using tween's state and a set amount
	/// TweenCalcAmount(tween,amount)
	/// @param tween	tween id
	/// @param amount	relative time between 0.0 and 1.0
	/// return: real
	/*
	    INFO:
	        Returns a calculated value using a tweens current state
	        at a relative point in time.
        
	        Note: Useful with null property setters which can be set by
	        using TPNull() as the property argument.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5, TPNull(), x, mouse_x);
        
	        // Calculate value of tween at 25% through time
	        x = TweenCalcAmount(tween, 0.25);
	*/

	var _t = TGMS_FetchTween(argument0);
	if (is_undefined(_t)){
	    return 0;
	}

	var _duration = _t[TWEEN.DURATION];

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], argument1, 0, 1, 1);
    
	    repeat(array_length_1d(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid
	        if (_duration == 0){
	            _return[_dataIndex] = _start;
	        }
	        else{
	            _return[_dataIndex] = lerp(_start, _dest, _amount);
	        }
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_duration == 0){
	        return _t[TWEEN.START];
	    }

	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(argument1, 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], 1);
	}
}


global.TGMS_HIDE = TweenCalcTime;
function TweenCalcTime(argument0, argument1)
{
	/// @description Returns calculated value using a tween's state at a set time
	/// TweenCalcTime(tween,time)
	/// @param tween	tween id
	/// @param time		specific time in steps or seconds
	/// return: real
	/*      
	    INFO:
	        Returns a calculated value using a tween's current state
	        at a specified point in time.
        
	        Note: Useful with null property setters which can be set by
	        using TPNull() as the property argument.
        
	    EXAMPLE:
	        // Create defined tween
	        tween = TweenCreate(id, EaseInOutQuint, 0, true, 0.0, 2.5, TPNull(), x, mouse_x);
        
	        // Calculate value of tween at 1.5 seconds through time
	        x = TweenCalcAmount(tween, 1.5);
	*/

	var _t = TGMS_FetchTween(argument0);
	if (is_undefined(_t)){
	    return 0;
	}

	var _duration = _t[TWEEN.DURATION];

	if (_t[TWEEN.PROPERTY] == TGMS_MultiPropertySetter__)
	{
	    var _return;
	    var _data = _t[TWEEN.DATA];
	    var _dataIndex = -1;
	    var _amount = script_execute(_t[TWEEN.EASE], argument1, 0, 1, _t[TWEEN.DURATION]);
    
	    repeat(array_length_1d(_data) div 5)
	    {
	        ++_dataIndex;
	        var _start = _data[2 + 5*_dataIndex];
	        var _dest =  _data[3 + 5*_dataIndex];
        
	        // Return start if duration is invalid
	        if (_duration == 0){
	            _return[_dataIndex] = _start;
	        }
	        else{
	            _return[_dataIndex] = lerp(_start, _dest, _amount);
	        }
	    }
    
	    return _return;
	}
	else
	{
	    // Return start if duration is invalid
	    if (_duration == 0){
	        return _t[TWEEN.START];
	    }

	    // Return tween's calculated value for its current state
	    return script_execute(_t[TWEEN.EASE], clamp(argument1, 0, _duration), _t[TWEEN.START], _t[TWEEN.CHANGE], _duration);
	}
}
