
/// TPList(list,index)
function TPList()
{
	/// @param list
	/// @param index

	var _return, _data;

	_data[0] = argument[0];
	_data[1] = argument[1];
	_return[0] = ext_DSList__;
	_return[1] = _data;
	return _return;
}


/// __ext_DSList(data[list,index])
function __ext_DSList(argument0)
{
	return ds_list_find_value(argument0[0], argument0[1]);
}

/// ext_DSList__(value,data[list,index])
function ext_DSList__(argument0, argument1)
{
	ds_list_replace(argument1[0], argument1[1], argument0);
}


