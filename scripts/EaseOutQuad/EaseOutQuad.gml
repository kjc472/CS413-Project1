/// EaseOutQuad(time,start,change,duration)
function EaseOutQuad(argument0, argument1, argument2, argument3) {

	var _val = argument0 / argument3;
	return -argument2 * _val * (_val - 2) + argument1;





}
