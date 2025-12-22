/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_deleteKillMarker

Description:
    Deletes the Kill Contract Marker. Best used with remoteExec.

Parameters:
    _player 	<OBJECT> 	The player that marker gets deleted.

Returns:
	Marker Data

Examples:
    (begin example)
        [player]remoteExec["JA_MISSIONGEN_fnc_deleteKillMarker",_caller];
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params [
    ["_player", player, [player]]
];

private _killHelperMarkersLocation = profileNamespace getVariable ["killHelperMarkersLocation",0];
{
deleteMarkerLocal _x;
}forEach _killHelperMarkersLocation;

profileNamespace setVariable ["killHelperMarkersLocation",_killHelperMarkersLocation];

true