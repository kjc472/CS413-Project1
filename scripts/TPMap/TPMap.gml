
/// TPMap(map,key)
function TPMap()
{
	/// @param map
	/// @param key

	var _return, _data;

	_data[0] = argument[0];
	_data[1] = argument[1];
	_return[0] = ext_DSMap__;
	_return[1] = _data;
	return _return;
}

/// __ext_DSMap(data[map,key])
function __ext_DSMap(argument0)
{
	return ds_map_find_value(argument0[0], argument0[1]);
}

/// ext_DSMap__(value,data[map,key])
function ext_DSMap__(argument0, argument1)
{
	ds_map_replace(argument1[0], argument1[1], argument0);
}

