// Toggling a light simply trades out one sprite for another. We are maintaining 
// the state of the object (i.e., off/on) through the sprite_index.  That's fine
// for a simple game like this but often the object state will be more complex.
// This is a helper function for "toggle" which toggles multiple lights.
function toggle_once(light) {
	if (light == noone) return;
	with (light) {
		if (sprite_index == spr_light_on) sprite_index = spr_light_off;
		else sprite_index = spr_light_on;
	}
}

// We toggle all the adjacent lights by calling toggle_once on the selected light
// and all its neighbors.
function toggle(light) {
	toggle_once(light);
	toggle_once(light.left);
	toggle_once(light.right);
	toggle_once(light.up);
	toggle_once(light.down);
}

// We when the game when the board is clear.  This function accomplished that by
// finding all the obj_light instances and checking which sprite_index they are referencing.
function is_clear() {
	for (var i=0; i < instance_number(obj_light); i+=1) {
		var inst_light = instance_find(obj_light, i);
		if (inst_light.sprite_index == spr_light_on) {
			return false;
		}
	}
	return true;
}
