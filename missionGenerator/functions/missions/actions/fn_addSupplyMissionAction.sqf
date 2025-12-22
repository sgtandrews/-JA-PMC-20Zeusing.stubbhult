/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_addSupplyMissionAction

Description:
    Gives an Object or Unit the Supply Mission Action

Parameters:
    _missionGiver - Object or Unit that gives the Mission

Returns:
	None

Examples:
    (begin example)
        [recruitMissionBoard,"Medical"] call JA_MISSIONGEN_fnc_addSupplysMissionAction;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */

params ["_missionGiver",["_supplyType","Random"],["_supplySize","Random"]];
_supplyType = _this select 1;
_supplySize = _this select 2;
_contractTitle = nil; 
switch (_supplyType) do {
	case "Advanced Medical": {_contractTitle = localize "STR_TFA_TITLE_MISSION_ADVMEDICAL_BOARD";};
	case "Advanced Industrial": {_contractTitle = localize "STR_TFA_TITLE_MISSION_ADVINDUST_BOARD";};
	case "Firearm": {_contractTitle = localize "STR_TFA_TITLE_MISSION_GUNRUN_BOARD";};
	default {_contractTitle = localize "STR_TFA_TITLE_MISSION_SUPPLY_BOARD"};
};

_this select 0 addAction
[
	_contractTitle,	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		_supplyType = (_this select 3 select 0);
		_supplySize = (_this select 3 select 1);
		[_this select 1, _supplyType,(_this select 0),_supplySize] call JA_MISSIONGEN_fnc_assignSupplyMission;
		(_this select 0) removeAction (_this select 2);
	},
	[_supplyType,_supplySize],		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	10,			
	false,		
	"",			
	""			
];