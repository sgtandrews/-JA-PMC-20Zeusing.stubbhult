/* ----------------------------------------------------------------------------
Function: JA_GENERAL_fnc_addActions

Description:
    Add actions use in game.

Parameters:

Returns:

Examples:
    (begin example)
        _result = [] call JA_GENERAL_fnc_addActions;
    (end)

Author:
    J. Andrews

---------------------------------------------------------------------------- */


JA_type_units = ["CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer"];
// Intel 
_action = ["Search_body", localize "STR_TFA_SEARCHING_BODY_TIP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {
     [JA_GENERAL_fnc_searchBody, [_target]] call CBA_fnc_execNextFrame;
}, {!alive _target}] call ace_interact_menu_fnc_createAction;
{[_x, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;} forEach JA_type_units;