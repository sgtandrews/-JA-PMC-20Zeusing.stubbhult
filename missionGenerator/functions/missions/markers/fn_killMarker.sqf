/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_killMarker

Description:
    Spawns a Marker for the Kill Contract. Best used with remoteExec.

Parameters:
    _player 	<OBJECT> 	The player that gains the marker.
	_leaderName	<STRING>	Name of the Leader.
	_unitLeader <OBJECT> 	Object of the Leader.

Returns:
	Marker Data

Examples:
    (begin example)
        [_caller,_leaderName,_unitLeader]remoteExec["JA_MISSIONGEN_fnc_killMarker",_caller];
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params [
    ["_player", player, [player]],
	["_leaderName", ([player] call BIS_fnc_getName), [""]],
    ["_unitLeader", player, [player]]
];

profileNamespace setVariable ["killHelperMarkersLocation",[]];

_marker = createMarkerLocal [format["%1",_leaderName],visiblePosition _unitLeader,1,_player];
_marker setMarkerColorLocal "ColorEAST";
_marker setMarkerTypeLocal "Contact_pencilCircle3";
_marker setMarkerTextLocal format["%1 - [Last seen %2]",(_leaderName),if(!isNull objectParent _unitLeader) then {"IN A VEHICLE"} else {"ON FOOT"}];

profileNamespace setVariable ["killHelperMarkersLocation",[_marker]];

_marker