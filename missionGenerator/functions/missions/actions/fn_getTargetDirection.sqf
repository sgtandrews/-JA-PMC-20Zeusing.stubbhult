
/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_getTargetDirection

Description:
    Assigns Player/Group a Kill Mission

Parameters:
     Can be an Object, Position2D or Position3D
        _firstPos  - First position to compare 
        _secondPos  - Second position to compare 

Returns:
	Displays Cardinal Direction with BIS_fnc_EXP_camp_SITREP

Examples:
    (begin example)
        [player, debugContainer] call JA_MISSIONGEN_fnc_getTargetDirection;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */

params ["_firstPos","_secondPos",["_marker",false]];
private _radius = 4;
private _onFinish = {
	params ["_args"];
	_args params ["_target", "_player","_radius","_firstPos", "_secondPos","_marker"];
	systemChat str _args;
	_dirString = [_firstPos,_secondPos] call JA_GENERAL_fnc_getHeading;	
	[["<t align = 'right' shadow = '2' size = '0.8' font='Caveat'>They seemed to have headed...</t><br/>", 0.3, 1, 0.3], [format ["<t align = 'right' shadow = '2' size = '0.8' font='Caveat'>... %1.</t><br/>",_dirString]
, 0.3, 5, 0.3]] spawn BIS_fnc_EXP_camp_SITREP;
	if (_marker) then {
		private _killHelperMarkersHints = profileNamespace getVariable ["killHelperMarkersHints",0];
		_helperMarker = createMarkerLocal [format["%1: Helper Arrow",_firstPos],_firstPos];
		_helperMarker setMarkerColorLocal "ColorWEST";
		_helperMarker setMarkerTypeLocal "hd_arrow_noShadow";
		_helperMarker setMarkerDirLocal ([_firstPos,_secondPos,true] call JA_GENERAL_fnc_getHeading);
		_killHelperMarkersHints pushBack _helperMarker;
		profileNamespace setVariable ["killHelperMarkersHints",_killHelperMarkersHints];
	};
	

};
private _condition = {
	params ["_args"];
	_args params ["_target", "_player","_radius"];

	(_target distance _player < _radius) && {[_player, objNull, ["isnotinside"]] call ace_common_fnc_canInteractWith}
};

[localize "STR_TFA_TRACKING_TARGET_BAR", 5, _condition, _onFinish, {}, [_target, player, _radius,_firstPos,_secondPos,_marker]] call CBA_fnc_progressBar;
