
/// @description Eases instance position using a path resource
function TweenPath(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
{
	/// TweenPath(target,ease,mode,delta,delay,dur,path,absolute)
	/// @param target
	/// @param ease
	/// @param mode
	/// @param delta
	/// @param delay
	/// @param dur
	/// @param path
	/// @param absolute
	/// return: tween id

	if (!ds_map_exists(global.__PropertySetters__, ext_path__))
	{
	    TGMS_BuildProperty("ext_path", ext_path__, undefined);
	}

	var _repeat = (argument2 == TWEEN_MODE_REPEAT);

	with(argument0)
	{
	    // IF absolute
	    if (argument7)
	    {
	        var _data;
	        _data[6] = _repeat;
	        _data[0] = argument6;
	        _data[1] = argument7;
	        _data[2] = 0;
	        _data[3] = 0;
	        _data[4] = 0;
	        _data[5] = 0;
        
	        return TGMS_TweenFire(argument0, ext_path__, argument1, argument2, argument3, argument4, argument5, 0, 1, _data);
	    }
	    else
	    {
	        var _path_xstart = path_get_x(argument6, 0);
	        var _path_ystart = path_get_y(argument6, 0);
        
	        var _data;
	        _data[6] = _repeat;
	        _data[0] = argument6;
	        _data[1] = argument7;
	        _data[2] = _path_xstart;
	        _data[3] = _path_ystart;
	        _data[4] = x-_path_xstart;
	        _data[5] = y-_path_ystart;
        
	        return TGMS_TweenFire(argument0, ext_path__, argument1, argument2, argument3, argument4, argument5, 0, 1, _data);
	    }
	}
}


/// ext_path__(amount,data[path|absolute|xstart|ystart|xrelative|yrelative|repeat],target)
function ext_path__(argument0, argument1, argument2)
{
	var _amount = argument0;
	var _data = argument1;
	var _target = argument2;
	var _path = _data[0];
	var _xstart = _data[2];
	var _ystart = _data[3];
	var _xrelative = _data[4];
	var _yrelative = _data[5];
	var _repeat = _data[6];

	with(_target)
	{
	    if (_repeat)
	    {
	        var _xDif = path_get_x(_path, 1) - path_get_x(_path, 0); // Could cache these two??
	        var _yDif = path_get_y(_path, 1) - path_get_y(_path, 0);
            
	        if (_amount > 0)
	        {   
	            _xrelative = _xstart + _xDif * floor(_amount);
	            _yrelative = _ystart + _yDif * floor(_amount);
	            _amount = _amount mod 1;
	        }
	        else if (_amount < 0)
	        {
	            _xrelative = _xstart + _xDif * ceil(_amount-1);
	            _yrelative = _ystart + _yDif * ceil(_amount-1);
	            _amount = 1 + _amount mod 1;
	        }
	        else
	        {
	            _xrelative = _xstart;
	            _yrelative = _ystart;
	        }
        
	        x = path_get_x(_path, _amount) + _xrelative;
	        y = path_get_y(_path, _amount) + _yrelative;
	    }
	    else
	    {
	        if (_amount > 0)
	        {
	            if (path_get_closed(_path) || _amount < 1)
	            {
	                x = path_get_x(_path, _amount mod 1) + _xrelative;
	                y = path_get_y(_path, _amount mod 1) + _yrelative;
	            }
	            else
	            {
	                var _length = path_get_length(_path) * (abs(_amount)-1);
	                var _direction = point_direction(path_get_x(_path, 0.999), path_get_y(_path, 0.999), path_get_x(_path, 1), path_get_y(_path, 1));
                
	                x = path_get_x(_path, 1) + _xrelative + lengthdir_x(_length, _direction);
	                y = path_get_y(_path, 1) + _yrelative + lengthdir_y(_length, _direction);
	            }
	        }
	        else if (_amount < 0)
	        {
	            if (path_get_closed(_path))
	            {
	                x = path_get_x(_path, 1+_amount) + _xrelative;
	                y = path_get_y(_path, 1+_amount) + _yrelative;
	            }
	            else
	            {
	                var _length = path_get_length(_path) * abs(_amount);
	                var _direction = point_direction(path_get_x(_path, 0), path_get_y(_path, 0), path_get_x(_path, 0.001), path_get_y(_path, 0.001));
                
	                x = path_get_x(_path, 0) + _xrelative - lengthdir_x(_length, _direction);
	                y = path_get_y(_path, 0) + _yrelative - lengthdir_y(_length, _direction);
	            }
	        }
	        else
	        {
	            x = path_get_x(_path, 0) + _xrelative;
	            y = path_get_y(_path, 0) + _yrelative;
	        }
	    }
	}
}

