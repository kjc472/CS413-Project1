/// EaseInBounce(time,start,change,duration)
function EaseInBounce(argument0, argument1, argument2, argument3) {

	return argument2 - EaseOutBounce(argument3 - argument0, 0, argument2, argument3) + argument1;






}
