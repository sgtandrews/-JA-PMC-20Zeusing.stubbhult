/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_contractText

Description:
    Spawns Text when assigning Contract

Parameters:
	_target 			<STRING> 					Targeted player, either local or all.
    _contractType 		<STRING> 					The Contract type.
	_contractTarget 	<STRING>/<OBJECT>/<ARRAY>	What the Contract needs to be fulfilled, either an item (String), kill unit (Object), or multiple (Array)


Returns:
	true

Examples:
    (begin example)
        ["ALL","Killer",[_killTarget,_itemTarget]]call JA_MISSIONGEN_fnc_contractText;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */

params [
	["_target", "ALL", [""]],
    ["_contractType", "Supply", [""]],
	["_contractTarget", "ACE_fieldDressing", ["",player,[]]]
];

