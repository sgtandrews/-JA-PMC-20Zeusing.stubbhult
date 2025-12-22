/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_addKillMissionAction

Description:
    Gives an Object or Unit the Kill Mission Action

Parameters:
    _missionGiver - Object or Unit that gives the Mission

Returns:
	None

Examples:
    (begin example)
        [recruitMissionBoard] call JA_MISSIONGEN_fnc_addKillMissionAction;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */

params ["_missionGiver"];

_this select 0 addAction
[
	localize "STR_TFA_TITLE_MISSION_KILL_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, "Bandits",(_this select 0)] remoteExec ["JA_MISSIONGEN_fnc_assignKillMission",2];
		//[_this select 1, "Bandits",(_this select 0)] call JA_MISSIONGEN_fnc_assignKillMission;
	},
	nil,		
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