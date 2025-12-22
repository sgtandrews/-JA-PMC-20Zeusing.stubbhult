
/* ----------------------------------------------------------------------------
Function: JA_GENERAL_fnc_searchBody

Description:
    Search a body for intel.

Parameters:
    _target - Body to search. [Object]

Returns:

Examples:
    (begin example)
        _result = [] call JA_GENERAL_fnc_searchBody;
    (end)

Author:
    Giallustio

---------------------------------------------------------------------------- */

params [
    ["_target", objNull, [objNull]]
];
private _radius = 7;
if (_target isKindOf "Man") then {_radius = 4;};
if (_target isKindOf "Helicopter") then {_radius = 20;};

private _onFinish = {
    params ["_args"];
    _args params ["_target", "_player"];
    _currencyAmount = [15, 150] call BIS_fnc_randomInt; 
    _moneyAmount = [str _currencyAmount, "rubles"] joinString " ";
    [_player, _currencyAmount] call HALs_money_fnc_addFunds;
    playSoundUI ["PDA_Tip"]; 

 
[["You found",0.4,1],[_moneyAmount,0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;
    hideBody _target;
    //[_target, _player] remoteExecCall ["btc_info_fnc_has_intel", 2];
};
private _condition = {
    params ["_args"];
    _args params ["_target", "_player", "_radius"];

    (_target distance _player < _radius) && {[_player, objNull, ["isnotinside"]] call ace_common_fnc_canInteractWith}
};

[localize "STR_TFA_SEARCHING_BODY_BAR", 5, _condition, _onFinish, {}, [_target, player, _radius]] call CBA_fnc_progressBar;
