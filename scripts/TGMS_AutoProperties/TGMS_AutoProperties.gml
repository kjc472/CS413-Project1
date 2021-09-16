global.TGMS_HIDE = TGMS_Variable_Global_Get + TGMS_Variable_Instance_Get + TGMS_Variable_Instance_Set;

function TGMS_Variable_Global_Get(variable) 
{
	return variable_global_get(variable);
}

function TGMS_Variable_Global_Set(value, undefined, target, variable)
{
	variable_global_set(variable, value);
}

function TGMS_Variable_Instance_Get(target, variable)
{
	return variable_instance_get(target, variable);
}

function TGMS_Variable_Instance_Set(value, undefined, target, variable) 
{
	variable_instance_set(target, variable, value);
}
