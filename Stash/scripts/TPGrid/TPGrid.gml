
/// TPGrid(grid,x,y)
function TPGrid()
{
	/// @param grid
	/// @param x
	/// @param y

	var _return, _data;

	_return[0] = ext_DSGrid__;
	_data[0] = argument[0];
	_data[1] = argument[1];
	_data[2] = argument[2];
	_return[1] = _data;
	return _return;
}

/// __ext_DSGrid(data[grid,x,y])
function __ext_DSGrid(argument0)
{
	return ds_grid_get(argument0[0], argument0[1], argument0[2]);
}

/// ext_DSGrid__(value,data[grid,x,y])
function ext_DSGrid__(argument0, argument1)
{
	ds_grid_set(argument1[0], argument1[1], argument1[2], argument0);
}