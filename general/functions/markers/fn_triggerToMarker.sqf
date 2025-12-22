/* ----------------------------------------------------------------------------
Function: JA_GENERAL_fnc_triggerToMarker 

Description:
    Converts trigger to Marker.

Parameters:
    _trigger 	<OBJECT> 	Trigger to be converted

Returns:
	Marker Data <STRING>

Examples:
    (begin example)
        [_trigger]call JA_GENERAL_fnc_triggerToMarker;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params [
    ["_trigger", objNull, [objNull]],
    ["_triggerName", "", [""]]
];
 // returns "var_1"

_size = [(triggerArea _trigger) select 0,(triggerArea _trigger) select 1];
_position = getPos _trigger;

_markername = _triggerName + "Marker";
//Marker creation
_markerData = createMarker [_markername, _position];
_markername setMarkerShape "RECTANGLE";
_markername setMarkerSize _size;
_markername setMarkerBrush "SolidFull";
_markername setMarkerColor "ColorGrey";
_markername setMarkerAlpha 0;

_markerData

