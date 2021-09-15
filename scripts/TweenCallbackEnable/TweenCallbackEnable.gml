/// @description Enables/disables specified callbacks
function TweenCallbackEnable(argument0, argument1) {

	/// TweenCallbackEnable(callback,enable)
	/// @callback		callback id
	/// @enable			perform callback?

	/// return: na

	var _cb = argument0;

	if (is_array(_cb))
	{
	    _cb[@ TWEEN_CALLBACK.ENABLED] = argument1;
	}





}
