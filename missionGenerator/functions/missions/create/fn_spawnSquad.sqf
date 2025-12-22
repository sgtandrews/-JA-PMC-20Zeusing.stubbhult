/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_spawnSquad

Description:
    Spawns a Squad given the variables and returns data if requested. 

Parameters:
    _position 	<OBJECT>/<ARRAY> 	Variables used for createUnit, Object or Array format Position or Position2D
	_side 		<STRING>  			Side for the spawned group. EAST/WEST/CIV/INDE (civilian/independent for CIV and GUER)
	_amount 	<ARRAY>/<NUMBER> 	Array with the Min and Max amount of Units or just a certain amount if one number.	
	_return 	<BOOLEAN>			Returns Array of Squad

Returns:
	true if _return is false or empty, Squad Array if _return is true. 

Examples:
    (begin example)
        [position player,"WEST",[1,6],true] call JA_MISSIONGEN_fnc_spawnSquad;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */

params [
    ["_position", [0, 0, 0], [[],player]],
    ["_side", "EAST", [""]],
    ["_amount", [8,8], [[]]],
    ["_return", false, [false]]
];


private _group = nil;
private _squad = [];
private _returnData = true;
private _maxAmount = floor random(_amount select 1) max 1;

switch (_side) do  
{
	case "EAST": {_group = createGroup east};
	case "WEST": {_group = createGroup west};
	case "CIV": {_group = createGroup civilian};
	case "INDE": {_group = createGroup resistance};  
	default {_group = createGroup east};
};

for "_i" from 0 to (_maxAmount) do {
	//sleep 0.1;
	//private _spawnPosition = [_position,25,false] call JA_MISSIONGEN_fnc_randomizePos;
	
	//_args = [((_spawnPosition) vectorAdd [0, 0, 0.4]),_group,"thisUnit = this;_squad pushBack thisUnit;[this] call HG_fnc_aiUnitSetup;"];
	//["CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer",_args] remoteExec ["createUnit",2];
	thisUnit = _group createUnit ["CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer",_position, [], 25, "FORM"];
	_squad pushBack thisUnit;
	//systemChat (str _squad);
	//[(str _squad)]remoteExec["systemChat",player];
};

if (_return) then {
	_returnData = _squad;
};

_returnData