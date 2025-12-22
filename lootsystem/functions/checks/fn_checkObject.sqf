/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_checkObject

Description:
    Returns the object classname

Parameters:
    _object 

Returns:
	Returns Object Classname

Examples:
    (begin example)
        _className = _object call JA_LootGen_fnc_checkObject;
    (end)

Author:
    J. Andrews

---------------------------------------------------------------------------- */

params ["_Object"];

private _returnClassStr = "";
_ObjectToStr = str _Object;
_SplitStr = [_ObjectToStr, " "] call BIS_fnc_splitString;
_returnClassStr = _SplitStr select 3;

_returnClassStr;