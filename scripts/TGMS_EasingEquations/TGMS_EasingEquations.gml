

/*
	This is used when you want to manually tween values.
	It is very similar to lerp() but takes an ease algorithm type.
*/
global.TGMS_HIDE = Ease;
function Ease(value1, value2, amount, ease)
{
	/// @description Interpolates two values by a given amount using a specified easing algorithm
	/// Ease(value1,value2,amount,ease)
	/// @param value1	start value
	/// @param value2	end value
	/// @param amount	(0-1) amount to interpolate values
	/// @param ease		ease algorithm script
	/// return: real
	/*  
	    Example:
	        var _start = x;
	        var _dest  = mouse_x;
	        var _amount = 0.25;
	        var _ease = EaseInOutQuad;
        
	        x = Ease(_start, _dest, _amount, _ease);
	*/

	gml_pragma("forceinline");

	return script_execute(ease, amount, value1, value2-value1, 1);
}


/*
===================================
  TERMS OF USE - EASING EQUATIONS
===================================
Open source under the BSD License.
Copyright (c)2001 Robert Penner
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


function EaseLinear(time, start, change, duration)
{
	return change * time / duration + start;
}

global.TGMS_HIDE = EaseInSine;
function EaseInSine(time, start, change, duration) 
{
	return change * (1 - cos(time / duration * (pi / 2))) + start;
}

global.TGMS_HIDE = EaseOutSine;
function EaseOutSine(time, start, change, duration)
{
	return change * sin(time/duration * (pi/2)) + start;
}

global.TGMS_HIDE = EaseInOutSine;
function EaseInOutSine(time, start, change, duration)
{
	return change * 0.5 * (1 - cos(pi*time/duration)) + start;
}

global.TGMS_HIDE = EaseInQuad;
function EaseInQuad(time, start, change, duration)
{
	var _val = time / duration;
	return change * _val * _val + start;   
}

global.TGMS_HIDE = EaseOutQuad;
function EaseOutQuad(time, start, change, duration)
{
	var _val = time / duration;
	return -change * _val * (_val - 2) + start;
}

global.TGMS_HIDE = EaseInOutQuad;
function EaseInOutQuad(time, start, change, duration)
{
	var _arg0 = 2*time/duration;

	if (_arg0 < 1)
	{
	    return change * 0.5 * _arg0 * _arg0 + start;
	}

	return change * -0.5 * ((_arg0-1) * (_arg0 - 3) - 1) + start;
}

global.TGMS_HIDE = EaseInCubic;
function EaseInCubic(time, start, change, duration) 
{
	return change * power(time/duration, 3) + start;
}

global.TGMS_HIDE = EaseOutCubic;
function EaseOutCubic(time, start, change, duration) 
{
	return change * (power(time/duration - 1, 3) + 1) + start;
}

global.TGMS_HIDE = EaseInOutCubic;
function EaseInOutCubic(time, start, change, duration)
{
	var _val = 2 * time / duration;

	if (_val < 1) { return change * 0.5 * power(_val, 3) + start; }

	return change * 0.5 * (power(_val - 2, 3) + 2) + start;
}

global.TGMS_HIDE = EaseInQuart;
function EaseInQuart(time, start, change, duration) 
{
	return change * power(time / duration, 4) + start;
}

global.TGMS_HIDE = EaseOutQuart;
function EaseOutQuart(time, start, change, duration)
{
	return -change * (power(time / duration - 1, 4) - 1) + start;
}

global.TGMS_HIDE = EaseInOutQuart;
function EaseInOutQuart(time, start, change, duration) {

	var _val = 2 * time / duration;

	if (_val < 1) { return change * 0.5 * power(_val, 4) + start; }

	return change * -0.5 * (power(_val - 2, 4) - 2) + start;
}

global.TGMS_HIDE = EaseInQuint;
function EaseInQuint(time, start, change, duration) 
{
	return change * power(time / duration, 5) + start;
}

global.TGMS_HIDE = EaseOutQuint;
function EaseOutQuint(time, start, change, duration) 
{
	return change * (power(time/duration - 1, 5) + 1) + start;
}

global.TGMS_HIDE = EaseInOutQuint;
function EaseInOutQuint(time, start, change, duration)
{
	var _val = 2 * time / duration;

	if (_val < 1) { return change * 0.5 * power(_val, 5) + start; }

	return change * 0.5 * (power(_val - 2, 5) + 2) + start;
}

global.TGMS_HIDE = EaseInExpo;
function EaseInExpo(time, start, change, duration) 
{
	return change * power(2, 10 * (time/duration - 1)) + start;
}

global.TGMS_HIDE = EaseOutExpo;
function EaseOutExpo(time, start, change, duration)
{
	return change * (-power(2, -10 * time / duration) + 1) + start;
}

global.TGMS_HIDE = EaseInOutExpo;
function EaseInOutExpo(time, start, change, duration)
{
	var _val = 2 * time / duration;

	if (_val < 1) { return change * 0.5 * power(2, 10 * --_val) + start; }

	return change * 0.5 * (-power(2, -10 * --_val) + 2) + start;
}

global.TGMS_HIDE = EaseInCirc;
function EaseInCirc(time, start, change, duration)
{
	var _val = time/duration;
	return change * (1 - sqrt(1 - _val * _val)) + start;
}

global.TGMS_HIDE = EaseOutCirc;
function EaseOutCirc(time, start, change, duration)
{
	var _val = time/duration - 1;
	return change * sqrt(abs(1 - _val * _val)) + start;
}

global.TGMS_HIDE = EaseInOutCirc;
function EaseInOutCirc(time, start, change, duration)
{
	var _val = 2 * time / duration;

	if (_val < 1) { return change * 0.5 * (1 - sqrt(abs(1 - _val * _val))) + start; }

	_val -= 2;
	return change * 0.5 * (sqrt(abs(1 - _val * _val)) + 1) + start;
}

global.TGMS_HIDE = EaseInBack;
function EaseInBack(time, start, change, duration)
{
	var _s = 1.70158;
	var _val = time/duration;
	return change * _val * _val * ((_s + 1) * _val - _s) + start;
}

global.TGMS_HIDE = EaseOutBack;
function EaseOutBack(time, start, change, duration)
{
	var _s = 1.70158;
	var _val = time/duration - 1;
	return change * (_val * _val * ((_s + 1) * _val + _s) + 1) + start;
}

global.TGMS_HIDE = EaseInOutBack;
function EaseInOutBack(time, start, change, duration)
{
	var _s = 1.70158;
	var _val = time/duration*2;

	if (_val < 1)
	{
	    _s *= 1.525;
	    return change * 0.5 * (((_s + 1) * _val - _s) * _val * _val) + start;
	}

	_val -= 2;
	_s *= 1.525;

	return change * 0.5 * (((_s + 1) * _val + _s) * _val * _val + 2) + start;
}

global.TGMS_HIDE = EaseInElastic;
function EaseInElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = change;
	var _val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration;

	if (_val == 1) { return start+change; }

	if (_p == 0) { _p = duration*0.3; }

	if (_a < abs(change)) 
	{ 
	    _a = change; 
	    _s = _p*0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (change / _a);
	}

	return -(_a * power(2,10 * (--_val)) * sin((_val * duration - _s) * (2 * pi) / _p)) + start;
}

global.TGMS_HIDE = EaseOutElastic;
function EaseOutElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = change;
	var _val = time;

	if (_val == 0 || _a == 0){ return start; }

	_val /= duration;

	if (_val == 1){ return start + change; }

	if (_p == 0){ _p = duration * 0.3; }

	if (_a < abs(change)) 
	{ 
	    _a = change;
	    _s = _p * 0.25; 
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (change / _a);
	}

	return _a * power(2, -10 * _val) * sin((_val * duration - _s) * (2 * pi) / _p ) + change + start;
}

global.TGMS_HIDE = EaseInOutElastic;
function EaseInOutElastic(time, start, change, duration)
{
	var _s = 1.70158;
	var _p = 0;
	var _a = change;
	var _val = time;

	if (_val == 0 || _a == 0) { return start; }

	_val /= duration*0.5;

	if (_val == 2) { return start+change; }

	if (_p == 0) { _p = duration * (0.3 * 1.5); }

	if (_a < abs(change)) 
	{ 
	    _a = change;
	    _s = _p * 0.25;
	}
	else
	{
	    _s = _p / (2 * pi) * arcsin (change / _a);
	}

	if (_val < 1) { return -0.5 * (_a * power(2, 10 * (--_val)) * sin((_val * duration - _s) * (2 * pi) / _p)) + start; }

	return _a * power(2, -10 * (--_val)) * sin((_val * duration - _s) * (2 * pi) / _p) * 0.5 + change + start;
}

global.TGMS_HIDE = EaseInBounce;
function EaseInBounce(time, start, change, duration)
{
	return change - EaseOutBounce(duration - time, 0, change, duration) + start;
}

global.TGMS_HIDE = EaseOutBounce;
function EaseOutBounce(time, start, change, duration)
{
	var _val = time/duration;

	if (_val < 1/2.75)
	{
	    return change * 7.5625 * _val * _val + start;
	}
	else
	if (_val < 2/2.75)
	{
	    _val -= 1.5/2.75;
	    return change * (7.5625 * _val * _val + 0.75) + start;
	}
	else
	if (_val < 2.5/2.75)
	{
	    _val -= 2.25/2.75;
	    return change * (7.5625 * _val * _val + 0.9375) + start;
	}
	else
	{
	    _val -= 2.625/2.75;
	    return change * (7.5625 * _val * _val + 0.984375) + start;
	}
}

global.TGMS_HIDE = EaseInOutBounce;
function EaseInOutBounce(time, start, change, duration)
{
	if (time < duration*0.5)
	{
	    return (EaseInBounce(time*2, 0, change, duration)*0.5 + start);
	}

	return (EaseOutBounce(time*2 - duration, 0, change, duration)*0.5 + change*0.5 + start);
}


