
/// TPArray(array,x,[y])
function TPArray()
{
	/// @param array
	/// @param x
	/// @param [y]		(optional)

	var _return, _data;

	_data[0] = argument[0];
	_data[1] = argument[1];  

	if (argument_count == 2){
	    _return[0] = ext_Array1D__;    
	}
	else{
	    _return[0] = ext_Array2D__;
	    _data[2] = argument[2];
	}

	_return[1] = _data;
	return _return;
}


/// __ext_Array1D(data[array,index])
function __ext_Array1D(argument0)
{
	var _array = argument0[0];
	return _array[argument0[1]];
}

/// ext_Array1D__(value,data[array,index])
function ext_Array1D__(argument0, argument1)
{
	var _array = argument1[0];
	_array[@ argument1[1]] = argument0;
}


/// __ext_Array2D(data[array,x,y)
function __ext_Array2D(argument0)
{
	var _array = argument0[0];
	return _array[argument0[1], argument0[2]];
}

/// ext_Array2D__(value,data[array,x,y])
function ext_Array2D__(argument0, argument1)
{
	var _array = argument1[0];
	_array[@ argument1[1], argument1[2]] = argument0;
}

