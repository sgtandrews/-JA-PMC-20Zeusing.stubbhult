/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_hintAction

Description:
    Adds a Tracking ACE Action to track a target. Best used with remoteExec.

Parameters:
    _helperObject 		<OBJECT>	Object that has the action.
	_targetObject		<OBJECT>	Object that is being tracked.

Returns:
	true

Examples:
    (begin example)
		[_helperObject,_targetObject]remoteExec["JA_MISSIONGEN_fnc_hintAction",_caller];
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params [
    ["_helperObject", objNull, [objNull]],
	["_targetObject", objNull, [objNull]]
];
_helperObject = _this select 0;
targetObject = _targetObject;

_action = ["Get_CardDir", localize "STR_TFA_TRACKING_TARGET_TIP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {
	[JA_MISSIONGEN_fnc_getTargetDirection, [_target,targetObject,true]] call CBA_fnc_execNextFrame;
	}, {alive targetObject},{},[targetObject]] call ace_interact_menu_fnc_createAction;

	[_helperObject, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

true