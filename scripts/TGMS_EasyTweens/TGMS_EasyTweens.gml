

global.TGMS_HIDE = TweenEasyUseDelta;
function TweenEasyUseDelta(argument0) 
{
	/// @description Toggle between using step or delta timing for "Easy Tweens"
	/// @param use_seconds?		Use seconds timing? true = seconds | false = steps
	
	global.TGMS_EasyDelta = argument0;
}


global.TGMS_HIDE = TweenEasyMove;
function TweenEasyMove() 
{
	/// @description Tweens instance's x/y position
	/// @param x1
	/// @param y1
	/// @param x2
	/// @param y2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	var _mode;
	if (argument_count == 8) _mode = argument[7];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyMove"))
	{
		if (TweenExists(__TweenEasyMove))
		{
			TweenDestroy(__TweenEasyMove);
		}
	}

	__TweenEasyMove = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "x", argument[0], argument[2], "y", argument[1], argument[3]);
	return __TweenEasyMove;
}


global.TGMS_HIDE = TweenEasyScale;
function TweenEasyScale()
{
	/// @description Tweens instance's image scale
	/// @param x1
	/// @param y1
	/// @param x2
	/// @param y2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	var _mode;
	if (argument_count == 8) _mode = argument[7];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyScale"))
	{
		if (TweenExists(__TweenEasyScale))
		{
			TweenDestroy(__TweenEasyScale);
		}
	}

	__TweenEasyScale = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "image_xscale", argument[0], argument[2], "image_yscale", argument[1], argument[3]);
	return __TweenEasyScale;
}


global.TGMS_HIDE = TweenEasyRotate;
function TweenEasyRotate()
{
	/// @description Tweens instance's image angle
	/// @param angle1
	/// @param angle2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyRotate"))
	{
		if (TweenExists(__TweenEasyRotate))
		{
			TweenDestroy(__TweenEasyRotate);
		}
	}

	__TweenEasyRotate = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_angle", argument[0], argument[1]);
	return __TweenEasyRotate;
}


global.TGMS_HIDE = TweenEasyFade;
function TweenEasyFade()
{
	/// @description Tweens instance's image alpha
	/// @param alpha1
	/// @param alpha2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]
	
	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyFade"))
	{
		if (TweenExists(__TweenEasyFade))
		{
			TweenDestroy(__TweenEasyFade);
		}
	}

	__TweenEasyFade = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_alpha", argument[0], argument[1]);
	return __TweenEasyFade;
}


global.TGMS_HIDE = TweenEasyTurn;
function TweenEasyTurn()
{
	/// @description Tweens instance's direction
	/// @param dir1
	/// @param dir2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]
	
	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyTurn"))
	{
		if (TweenExists(__TweenEasyTurn))
		{
			TweenDestroy(__TweenEasyTurn);
		}
	}

	__TweenEasyTurn = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "direction", argument[0], argument[1]);
	return __TweenEasyTurn;
}


global.TGMS_HIDE = TweenEasyBlend;
function TweenEasyBlend()
{
	/// @description Tweens instance's image blend colour
	/// @param col1
	/// @param col2
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyBlend"))
	{
		if (TweenExists(__TweenEasyBlend))
		{
			TweenDestroy(__TweenEasyBlend);
		}
	}

	__TweenEasyBlend = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_blend", argument[0], argument[1]);
	return __TweenEasyBlend;
}


global.TGMS_HIDE = TweenEasyImage;
function TweenEasyImage()
{
	/// @description Tweens instance's image index
	/// @param index1
	/// @param index2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]
	
	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasyImage"))
	{
		if (TweenExists(__TweenEasyImage))
		{
			TweenDestroy(__TweenEasyImage);
		}
	}

	__TweenEasyImage = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "image_index", argument[0], argument[1]);
	return __TweenEasyImage;
}


global.TGMS_HIDE = TweenEasySpeed;
function TweenEasySpeed()
{
	/// @description Tweens instance's speed
	/// @param spd1
	/// @param spd2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	var _mode;
	if (argument_count == 6) _mode = argument[5];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasySpeed"))
	{
		if (TweenExists(__TweenEasySpeed))
		{
			TweenDestroy(__TweenEasySpeed);
		}
	}

	__TweenEasySpeed = TweenFire(id, argument[4], _mode, global.TGMS_EasyDelta, argument[2], argument[3], "speed", argument[0], argument[1]);
	return __TweenEasySpeed;
}


global.TGMS_HIDE = TweenEasySpeedHV;
function TweenEasySpeedHV()
{
	/// @description Tweens instance's hspeed/vspeed
	/// @param hspd1
	/// @param vspd1 
	/// @param hspd2
	/// @param vspd2 
	/// @param delay
	/// @param duration
	/// @param ease
	/// @param [mode]

	var _mode;
	if (argument_count == 8) _mode = argument[7];
	else                     _mode = 0;

	if (variable_instance_exists(id, "__TweenEasySpeedHV"))
	{
		if (TweenExists(__TweenEasySpeedHV))
		{
			TweenDestroy(__TweenEasySpeedHV);
		}
	}

	__TweenEasySpeedHV = TweenFire(id, argument[6], _mode, global.TGMS_EasyDelta, argument[4], argument[5], "hspeed", argument[0], argument[2], "vspeed", argument[1], argument[3]);
	return __TweenEasySpeedHV;
}

