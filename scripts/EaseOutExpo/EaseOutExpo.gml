/// EaseOutExpo(time,start,change,duration)
function EaseOutExpo(argument0, argument1, argument2, argument3) {

	return argument2 * (-power(2, -10 * argument0 / argument3) + 1) + argument1;





}
