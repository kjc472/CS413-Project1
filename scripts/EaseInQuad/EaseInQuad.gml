/// EaseInQuad(time,start,change,duration)
function EaseInQuad(argument0, argument1, argument2, argument3) {

	var _val = argument0 / argument3;
	return argument2 * _val * _val + argument1;   



}
