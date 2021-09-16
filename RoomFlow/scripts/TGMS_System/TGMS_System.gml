

// COMPILER OPTIMISATIONS -- You can set this to [1] if using many null properties, otherwise leave it as [0]
#macro TGMS_OPTIMISE_NULL_PROPERTY 0

// TWEEN PLAY MODES
#macro TWEEN_MODE_ONCE 0
#macro TWEEN_MODE_BOUNCE 1
#macro TWEEN_MODE_PATROL 2
#macro TWEEN_MODE_LOOP 3
#macro TWEEN_MODE_REPEAT 4

// TWEEN EVENT TYPES
#macro TWEEN_EV_PLAY 0
#macro TWEEN_EV_FINISH 1
#macro TWEEN_EV_STOP 2
#macro TWEEN_EV_PAUSE 3
#macro TWEEN_EV_RESUME 4
#macro TWEEN_EV_CONTINUE 5
#macro TWEEN_EV_REVERSE 6
#macro TWEEN_EV_STOP_DELAY 7
#macro TWEEN_EV_PAUSE_DELAY 8
#macro TWEEN_EV_RESUME_DELAY 9
#macro TWEEN_EV_FINISH_DELAY 10

// TWEEN USER PROPERTIES
#macro TWEEN_USER_VALUE global.TGMS_USER_VALUE
#macro TWEEN_USER_TARGET global.TGMS_USER_TARGET
#macro TWEEN_USER_GET global.TGMS_TWEEN_USER_GET
#macro TWEEN_USER_DATA global.TGMS_USER_DATA

// TWEEN SELECTION
#macro TWEENS_ALL 1
#macro TWEENS_GROUP 2
#macro TWEENS_TARGET 3


// Add obj_SharedTweener to the first room
global.TGMS_SharedTweener = noone;    // Declare global variable for holding shared tweener instance
room_instance_add(room_first, -1000, -1000, obj_SharedTweener);

// Used to clear previous environment data -- needs a name change for better clarity
global.TGMS_Environment = noone;

// Used for Tween Selection
global.TGMS_TweensStack = ds_stack_create();

//----------------------------------------------
// Build Properties
//----------------------------------------------
global.__PropertyGetters__ = ds_map_create();
global.__PropertySetters__ = ds_map_create();
global.__NormalizedProperties__ = ds_map_create();
TGMS_DefaultProperties();

//---------------------------
// Create ID Maps
//---------------------------
global.TGMS_MAP_TWEEN = ds_map_create();

//--------------------------------
// Initiate ID Indexes
//--------------------------------
global.TGMS_INDEX_TWEEN = 1;

//-------------------------------
// Declare Enum Constants
//-------------------------------
// CALLBACK DATA
enum TWEEN_CALLBACK{TWEEN,ENABLED,TARGET,SCRIPT,ARG0,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12,ARG13,ARG14,ARG15,ARG16,ARG17,ARG18,ARG19,ARG20,ARG21,ARG22,ARG23,ARG24,ARG25,ARG26,ARG27,ARG28,ARG29,ARG30,ARG31,ARG32,ARG33,ARG34,ARG35,ARG36,ARG37,ARG38};

// TWEEN STATES
enum TWEEN_STATE{DESTROYED=-4,STOPPED=-10,PAUSED=-11,DELAYED=-12};

// TWEEN DATA
enum TWEEN
{
	STATE,
	DURATION,
	DELTA,
	TIME_SCALE,
	TIME,
	CHANGE,
	START,
	TARGET,
	DATA,
	EASE,
	PROPERTY,
	PROPERTY_RAW,
	VARIABLE,
	GROUP,
	DIRECTION,
	EVENTS,
	DESTROY,
	MODE,
	DELAY,
	DELAY_START,
	ID,
	DATA_SIZE,
	DESTINATION,
	TIME_AMOUNT,
};

// Set defaults for TWEEN USER properties
TWEEN_USER_GET = 0;
TWEEN_USER_VALUE = 0;
TWEEN_USER_DATA = undefined;
TWEEN_USER_TARGET = noone;

global.TGMS_TweenDataIndexes = ds_map_create();
global.TGMS_TweenDataIndexes[? "target"] = TWEEN.TARGET;
global.TGMS_TweenDataIndexes[? "property"] = TWEEN.PROPERTY;
global.TGMS_TweenDataIndexes[? "time"] = TWEEN.TIME;
global.TGMS_TweenDataIndexes[? "time_scale"] = TWEEN.TIME_SCALE;
global.TGMS_TweenDataIndexes[? "time_amount"] = TWEEN.TIME_AMOUNT;
global.TGMS_TweenDataIndexes[? "ease"] = TWEEN.EASE;
global.TGMS_TweenDataIndexes[? "start"] = TWEEN.START;
global.TGMS_TweenDataIndexes[? "destination"] = TWEEN.DESTINATION;
global.TGMS_TweenDataIndexes[? "duration"] = TWEEN.DURATION;
global.TGMS_TweenDataIndexes[? "delay"] = TWEEN.DELAY;
global.TGMS_TweenDataIndexes[? "delay_start"] = TWEEN.DELAY_START;
global.TGMS_TweenDataIndexes[? "group"] = TWEEN.GROUP;
global.TGMS_TweenDataIndexes[? "state"] = TWEEN.STATE;
global.TGMS_TweenDataIndexes[? "mode"] = TWEEN.MODE;
global.TGMS_TweenDataIndexes[? "delta"] = TWEEN.DELTA;

global.TGMS_TweenDataIndexes[? TWEEN.TARGET] = TWEEN.TARGET;
global.TGMS_TweenDataIndexes[? TWEEN.PROPERTY] = TWEEN.PROPERTY;
global.TGMS_TweenDataIndexes[? TWEEN.TIME] = TWEEN.TIME;
global.TGMS_TweenDataIndexes[? TWEEN.TIME_SCALE] = TWEEN.TIME_SCALE;
global.TGMS_TweenDataIndexes[? TWEEN.TIME_AMOUNT] = TWEEN.TIME_AMOUNT;
global.TGMS_TweenDataIndexes[? TWEEN.EASE] = TWEEN.EASE;
global.TGMS_TweenDataIndexes[? TWEEN.START] = TWEEN.START;
global.TGMS_TweenDataIndexes[? TWEEN.DESTINATION] = TWEEN.DESTINATION;
global.TGMS_TweenDataIndexes[? TWEEN.DURATION] = TWEEN.DURATION;
global.TGMS_TweenDataIndexes[? TWEEN.DELAY] = TWEEN.DELAY;
global.TGMS_TweenDataIndexes[? TWEEN.DELAY_START] = TWEEN.DELAY_START;
global.TGMS_TweenDataIndexes[? TWEEN.GROUP] = TWEEN.GROUP;
global.TGMS_TweenDataIndexes[? TWEEN.STATE] = TWEEN.STATE;
global.TGMS_TweenDataIndexes[? TWEEN.MODE] = TWEEN.MODE;
global.TGMS_TweenDataIndexes[? TWEEN.DELTA] = TWEEN.DELTA;


function TGMS_NULL__()
{

}


function SharedTweener()
{
	// Return shared tweener if it already exists
	if (instance_exists(global.TGMS_SharedTweener))
	{
	    return global.TGMS_SharedTweener;
	}
	else
	{
	    // Attempt to activate shared tweener
	    instance_activate_object(global.TGMS_SharedTweener);
    
	    // Return shared tweener if it now exists
	    if (instance_exists(global.TGMS_SharedTweener))
	    {
	        return global.TGMS_SharedTweener;
	    }
	    else
	    {
	        // Create new shared tweener if it doesn't exist
	        global.TGMS_SharedTweener = instance_create_depth(-100000, -100000, 0, obj_SharedTweener);
	        return global.TGMS_SharedTweener;
	    }
	}
}


/// TGMS_ClearRoom(room)
function TGMS_ClearRoom(argument0) 
{
	/*
	    @room = persistent room
    
	    return:
	        na

	    INFO:
	        Clears persistent room's stored tween data
	*/
	
	var _sharedTweener = SharedTweener();
	var _pRoomTweens = _sharedTweener.pRoomTweens;
	var _pRoomDelays = _sharedTweener.pRoomDelays;
	var _key = argument0;

	// Clear all rooms if "all" keyword is used
	if (_key == all)
	{
		repeat(ds_map_size(_pRoomTweens))
		{
			TGMS_ClearRoom(ds_map_find_first(_pRoomTweens));
		}
	
		return 0;
	}

	// Destroy tweens for persistent room
	if (ds_map_exists(_pRoomTweens, _key))
	{
	    // Delete stored delays
	    ds_queue_destroy(ds_map_find_value(_pRoomDelays, _key));
	    ds_map_delete(_pRoomDelays, _key)
    
	    // Get stored tweens queue
	    var _queue = ds_map_find_value(_pRoomTweens, _key);
    
	    // Destroy all stored tweens in queue
	    repeat(ds_queue_size(_queue))
	    {
	        var _t = ds_queue_dequeue(_queue); // Get next tween from room's queue
        
	        // Invalidate tween handle
	        if (ds_map_exists(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]))
	        {
	            ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);
	        }
        
	        _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
	        _t[@ TWEEN.ID] = undefined; // Nullify self reference
        
	        // Destroy tween events if events map exists
	        if (_t[TWEEN.EVENTS] != -1)
	        {
	            var _events = _t[TWEEN.EVENTS];        // Cache events
	            var _key = ds_map_find_first(_events); // Find key to first event
            
	            // Cycle through and destroy all events
	            repeat(ds_map_size(_events))
	            {
	                ds_list_destroy(_events[? _key]);       // Destroy event list
	                _key = ds_map_find_next(_events, _key); // Find key for next event
	            }
            
	            ds_map_destroy(_events); // Destroy events map
	        }
	    }
    
	    ds_queue_destroy(_queue);          // Destroy room's queue for stored tweens
	    ds_map_delete(_pRoomTweens, _key); // Delete persistent room id from stored tweens map
	}
}


/// TGMS_ExecuteEvent(event_list,event_type)
function TGMS_ExecuteEvent(argument0, argument1) {
	/*
	    DON'T CALL THIS DIRECTLY!!!
	*/

	// IF events and event type initialized...
	if (argument0 != -1)
	{
	    if (ds_map_exists(argument0, argument1))
	    {
	        // Get event data
	        var _event = ds_map_find_value(argument0, argument1);
        
	        // Iterate through all event callbacks (isEnabled * event list size)
	        var _index = 0;
	        repeat(_event[| 0] * (ds_list_size(_event)-1))
	        {
	            var _cb = _event[| ++_index];             // Cache callback
	            var _target = _cb[TWEEN_CALLBACK.TARGET]; // Cache target
        
	            with(_target) // Using target environment...
	            {
	                // Execute callback script with proper number of arguments
	                switch(array_length_1d(_cb) * _cb[TWEEN_CALLBACK.ENABLED])
	                {
	                case TWEEN_CALLBACK.ARG0: _cb[TWEEN_CALLBACK.SCRIPT](); break;
	                case TWEEN_CALLBACK.ARG1: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0]); break;
	                case TWEEN_CALLBACK.ARG2: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1]); break;
	                case TWEEN_CALLBACK.ARG3: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2]); break;
	                case TWEEN_CALLBACK.ARG4: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3]); break;
	                case TWEEN_CALLBACK.ARG5: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4]); break;
	                case TWEEN_CALLBACK.ARG6: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5]); break;
	                case TWEEN_CALLBACK.ARG7: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6]); break;
	                case TWEEN_CALLBACK.ARG8: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7]); break;
	                case TWEEN_CALLBACK.ARG9: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8]); break;
	                case TWEEN_CALLBACK.ARG10: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9]); break;
	                case TWEEN_CALLBACK.ARG11: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10]); break;
	                case TWEEN_CALLBACK.ARG12: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11]); break;
	                case TWEEN_CALLBACK.ARG13: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12]); break;   
	                case TWEEN_CALLBACK.ARG14: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13]); break; 
					case TWEEN_CALLBACK.ARG15: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14]); break; 
					case TWEEN_CALLBACK.ARG16: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15]); break; 
					case TWEEN_CALLBACK.ARG17: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16]); break; 
					case TWEEN_CALLBACK.ARG18: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17]); break;
					case TWEEN_CALLBACK.ARG19: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18]); break;
					case TWEEN_CALLBACK.ARG20: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19]); break;
					case TWEEN_CALLBACK.ARG21: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20]); break;
					case TWEEN_CALLBACK.ARG22: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21]); break;
					case TWEEN_CALLBACK.ARG23: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22]); break;
					case TWEEN_CALLBACK.ARG24: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23]); break;
					case TWEEN_CALLBACK.ARG25: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24]); break;
					case TWEEN_CALLBACK.ARG26: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25]); break;
					case TWEEN_CALLBACK.ARG27: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26]); break;
					case TWEEN_CALLBACK.ARG28: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27]); break;
					case TWEEN_CALLBACK.ARG29: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28]); break;
					case TWEEN_CALLBACK.ARG30: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29]); break;
					case TWEEN_CALLBACK.ARG31: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30]); break;
					case TWEEN_CALLBACK.ARG32: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30], _cb[TWEEN_CALLBACK.ARG31]); break;
					case TWEEN_CALLBACK.ARG33: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30], _cb[TWEEN_CALLBACK.ARG31], _cb[TWEEN_CALLBACK.ARG32]); break;
					case TWEEN_CALLBACK.ARG34: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30], _cb[TWEEN_CALLBACK.ARG31], _cb[TWEEN_CALLBACK.ARG32], _cb[TWEEN_CALLBACK.ARG33]); break;
					case TWEEN_CALLBACK.ARG35: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30], _cb[TWEEN_CALLBACK.ARG31], _cb[TWEEN_CALLBACK.ARG32], _cb[TWEEN_CALLBACK.ARG33], _cb[TWEEN_CALLBACK.ARG34]); break;
					case TWEEN_CALLBACK.ARG36: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30], _cb[TWEEN_CALLBACK.ARG31], _cb[TWEEN_CALLBACK.ARG32], _cb[TWEEN_CALLBACK.ARG33], _cb[TWEEN_CALLBACK.ARG34], _cb[TWEEN_CALLBACK.ARG35]); break;
					case TWEEN_CALLBACK.ARG37: _cb[TWEEN_CALLBACK.SCRIPT](_cb[TWEEN_CALLBACK.ARG0], _cb[TWEEN_CALLBACK.ARG1], _cb[TWEEN_CALLBACK.ARG2], _cb[TWEEN_CALLBACK.ARG3], _cb[TWEEN_CALLBACK.ARG4], _cb[TWEEN_CALLBACK.ARG5], _cb[TWEEN_CALLBACK.ARG6], _cb[TWEEN_CALLBACK.ARG7], _cb[TWEEN_CALLBACK.ARG8], _cb[TWEEN_CALLBACK.ARG9], _cb[TWEEN_CALLBACK.ARG10], _cb[TWEEN_CALLBACK.ARG11], _cb[TWEEN_CALLBACK.ARG12], _cb[TWEEN_CALLBACK.ARG13], _cb[TWEEN_CALLBACK.ARG14], _cb[TWEEN_CALLBACK.ARG15], _cb[TWEEN_CALLBACK.ARG16], _cb[TWEEN_CALLBACK.ARG17], _cb[TWEEN_CALLBACK.ARG18], _cb[TWEEN_CALLBACK.ARG19], _cb[TWEEN_CALLBACK.ARG20], _cb[TWEEN_CALLBACK.ARG21], _cb[TWEEN_CALLBACK.ARG22], _cb[TWEEN_CALLBACK.ARG23], _cb[TWEEN_CALLBACK.ARG24], _cb[TWEEN_CALLBACK.ARG25], _cb[TWEEN_CALLBACK.ARG26], _cb[TWEEN_CALLBACK.ARG27], _cb[TWEEN_CALLBACK.ARG28], _cb[TWEEN_CALLBACK.ARG29], _cb[TWEEN_CALLBACK.ARG30], _cb[TWEEN_CALLBACK.ARG31], _cb[TWEEN_CALLBACK.ARG32], _cb[TWEEN_CALLBACK.ARG33], _cb[TWEEN_CALLBACK.ARG34], _cb[TWEEN_CALLBACK.ARG35], _cb[TWEEN_CALLBACK.ARG36]); break;
					}
	            }
            
	            // IF target does not exist
	            if (instance_exists(_target) == false)
	            {
	                // Attempt to activate target
	                instance_activate_object(_target);
                
	                // IF target now exists
	                if (instance_exists(_target))
	                {
	                    // Put target back to deactivated state
	                    instance_deactivate_object(_target);
	                }
	                else
	                {
	                    // Delete callback from event list -- decrement loop index
	                    ds_list_delete(_event, _index--);
	                }
	            }
	        }
	    }
	}
}


/// TGMS_EventUser(user_event)
function TGMS_EventUser(argument0)
{
	event_user(argument0);
}


/// TGMS_FetchTween(tween_id)
function TGMS_FetchTween(argument0) {

	if (ds_map_exists(global.TGMS_MAP_TWEEN, argument0))
	{
	    return global.TGMS_MAP_TWEEN[? argument0];
	}

	if (is_undefined(argument0))
	{
	    return undefined;
	}

	// Show "invalid tween id" error message
	show_error(@"!!! INVALID TWEEN ID !!!
	" ,false);
}


/// TGMS_MultiPropertySetter__(amount,data[],target)
function TGMS_MultiPropertySetter__(amount, data, target)
{
	switch(data[0]) // Property Count
	{
	    case 2:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        return script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
    
	    case 3:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        return script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
    
	    case 4:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        return script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
    
	    case 5:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
	        return script_execute(data[25] , lerp(data[26], data[27], amount), data[28], target, data[29]);
    
	    case 6:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
	        script_execute(data[25] , lerp(data[26], data[27], amount), data[28], target, data[29]);
	        return script_execute(data[31] , lerp(data[32], data[33], amount), data[34], target, data[35]);
    
	    case 7:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
	        script_execute(data[25] , lerp(data[26], data[27], amount), data[28], target, data[29]);
	        script_execute(data[31] , lerp(data[32], data[33], amount), data[34], target, data[35]);
	        return script_execute(data[37] , lerp(data[38], data[39], amount), data[40], target, data[41]);
    
	    case 8:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
	        script_execute(data[25] , lerp(data[26], data[27], amount), data[28], target, data[29]);
	        script_execute(data[31] , lerp(data[32], data[33], amount), data[34], target, data[35]);
	        script_execute(data[37] , lerp(data[38], data[39], amount), data[40], target, data[41]);
	        return script_execute(data[43] , lerp(data[44], data[45], amount), data[46], target, data[47]);
    
	    case 9:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
	        script_execute(data[25] , lerp(data[26], data[27], amount), data[28], target, data[29]);
	        script_execute(data[31] , lerp(data[32], data[33], amount), data[34], target, data[35]);
	        script_execute(data[37] , lerp(data[38], data[39], amount), data[40], target, data[41]);
	        script_execute(data[43] , lerp(data[44], data[45], amount), data[46], target, data[47]);
	        return script_execute(data[49] , lerp(data[50], data[51], amount), data[52], target, data[53]);
    
	    case 10:
	        script_execute(data[1] , lerp(data[2], data[3], amount), data[4], target, data[5]);
	        script_execute(data[7] , lerp(data[8], data[9], amount), data[10], target, data[11]);
	        script_execute(data[13] , lerp(data[14], data[15], amount), data[16], target, data[17]);
	        script_execute(data[19] , lerp(data[20], data[21], amount), data[22], target, data[23]);
	        script_execute(data[25] , lerp(data[26], data[27], amount), data[28], target, data[29]);
	        script_execute(data[31] , lerp(data[32], data[33], amount), data[34], target, data[35]);
	        script_execute(data[37] , lerp(data[38], data[39], amount), data[40], target, data[41]);
	        script_execute(data[43] , lerp(data[44], data[45], amount), data[46], target, data[47]);
	        script_execute(data[49] , lerp(data[50], data[51], amount), data[52], target, data[53]);
	        return script_execute(data[55] , lerp(data[56], data[57], amount), data[58], target, data[59]);
	}
}


/// TGMS_TargetExists(target)
function TGMS_TargetExists(argument0)
{
	if (global.TGMS_TweensIncludeDeactivated)
	{
	    if (instance_exists(argument0)){
	        return true;
	    }

	    instance_activate_object(argument0);
    
	    if (instance_exists(argument0)){
	        instance_deactivate_object(argument0);
	        return true;
	    }
    
	    return false;
	}

	return (instance_exists(argument0));
}


/// TGMS_TweensExecute(tweens_string,script,arg0,...)
function TGMS_TweensExecute() {
	/*
	    @tweens         Tweens to select for performing script (0=TWEENS_ALL, 1=TWEENS_GROUP, 2=TWEEN_TARGET)
	    @data           Relevant group or target when using TWEENS_GROUP or TWEENS_TARGET -- not important when using TWEENS_ALL
	    @script         Script to execute for each tween
	    @arg0...        (optional) Arguments to pass to executed script (up to 3)
    
	    return:
	        na
        
	    INFO:
	        Iterates through all relevant tweens and executes a specified script for each.
	        The following macros can be used for selecting tweens:
        
	        0 = TWEENS_ALL
	        1 = TWEENS_GROUP
	        2 = TWEENS_TARGET
        
	        Currently takes only a max of 3 optional arguments.
        
	    Example:
	        // Execute 'TweenStop' for all tweens, including those with deactivated targets
	        TweensExecute(TWEENS_ALL, 0, TweenStop);
        
	        // Execute 'TweenPause' with tweens belonging to group 2
	        TweensExecute(TWEENS_GROUP, 2, TweenPause)
        
	        // Execute 'TweenSetTime' for tweens associated with obj_Jumpy
	        TweensExecute(TWEENS_TARGET, obj_Jumpy, TweenSetTime, 2.0);
	*/

	var _tweensString = argument[0];
	var _selection = real(string_char_at(_tweensString,1));
	var _selectionData = real(string_delete(_tweensString,1,1));
	var _script = argument[1];
	var _argCount = argument_count-2;
	var _arg0,_arg1,_arg2;

	switch(_argCount)
	{
	    case 3: _arg2 = argument[4];
	    case 2: _arg1 = argument[3];
	    case 1: _arg0 = argument[2];
	}

	var _tIndex = -1;

	switch(_selection)
	{
	    case 0:
	        var _tweens = ds_stack_pop(global.TGMS_TweensStack);
        
	        switch(_argCount)
	        {
	            case 0:
	                repeat(array_length_1d(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);   
	                }
	            break;
	            case 1:
	                repeat(array_length_1d(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);   
	                }
	            break;
	            case 2:
	                repeat(array_length_1d(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);   
	                }
	            break;
	            case 3:
	                repeat(array_length_1d(_tweens)){
	                    var _t = TGMS_FetchTween(_tweens[++_tIndex]);
	                    if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);   
	                }
	            break;
	        }
	    break;
    
	    case TWEENS_ALL:
	        var _tweens = SharedTweener().tweens;
        
	        switch(_argCount)
	        {    
	        case 0:
	            repeat(ds_list_size(_tweens)){  
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);
	            }
	        break;
	        case 1:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);
	            }
	        break;
	        case 2:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);
	            }
	        break;
	        case 3:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);
	            }
	        break;
	        }
	    break;
    
	    case TWEENS_GROUP:
	        var _tweens = SharedTweener().tweens;
        
	        switch(_argCount)
	        {    
	        case 0:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t);
	            }
	        break;
	        case 1:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0);
	            }
	        break;
	        case 2:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1);
	            }
	        break;
	        case 3:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                if (_t[TWEEN.GROUP] == _selectionData && TGMS_TargetExists(_t[TWEEN.TARGET])) script_execute(_script, _t, _arg0, _arg1, _arg2);
	            }
	        break;
	        }
	    break;
    
	    case TWEENS_TARGET:
	        var _tweens = SharedTweener().tweens;
        
	        switch(_argCount)
	        {    
	        case 0:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
				
					if (TGMS_TargetExists(_target)) 
					if (_target == _selectionData || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData)){
						script_execute(_script, _t);
					}
	            }
	        break;
	        case 1:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
					if (TGMS_TargetExists(_target)) 
					if (_target == _selectionData || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData)){
	                    script_execute(_script, _t, _arg0);
	                }
	            }
	        break;
	        case 2:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
					if (TGMS_TargetExists(_target)) 
					if (_target == _selectionData || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData)){
	                    script_execute(_script, _t, _arg0, _arg1);
	                }
	            }
	        break;
	        case 3:
	            repeat(ds_list_size(_tweens)){
	                var _t = _tweens[| ++_tIndex];
	                var _target = _t[TWEEN.TARGET];
                
					if (TGMS_TargetExists(_target)) 
					if (_target == _selectionData || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData)){
	                    script_execute(_script, _t, _arg0, _arg1, _arg2);
	                }
	            }
	        break;
	        }
	    break;
	}
}


/// @description Forces tween to re-calculate and immediately update its property
function TweenForcePropertyUpdate(argument0) 
{
	/// TweenForcePropertyUpdate(tween)
	/// @param tween	tween id

	var _t = argument0;

	if (is_real(_t))
	{
	    _t = TGMS_FetchTween(_t);
	}

	if (is_array(_t))
	{
	    if (_t[TWEEN.STATE] >= 0 && _t[TWEEN.DURATION]!= 0)
	    {
	        if (_t[TWEEN.PROPERTY] != TGMS_NULL__)
	        {
	            script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], clamp(_t[TWEEN.TIME], 0, _t[TWEEN.DURATION]), _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]), _t[TWEEN.DATA], _t[TWEEN.TARGET], _t[TWEEN.VARIABLE]);
	        }
	    }
	}

	if (is_string(_t))
	{
		TGMS_TweensExecute(_t, TweenForcePropertyUpdate);
	}
}

