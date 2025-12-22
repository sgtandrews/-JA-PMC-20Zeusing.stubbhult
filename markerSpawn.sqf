//Uncomment/Comment which you want to use

//All Markers
//_marker_area_array = allMapMarkers;
//Array of Markers
_marker_area_array = ["sparky_marker","meat_grinder_marker","chili_marker"];
/* 
_markerPos_array = [];
_loopPosCounter = 0;
{
  // code...
  _markerType = getMarkerType _x;
  diag_log _markerType;
  _newmarkerText = markerText _x;
  diag_log _newmarkerText;
  _markerColor = getMarkerColor _x;
  diag_log _markerColor;
  _markerSize = getMarkerSize _x;
  diag_log _markerSize;
  _markerPos_array append [getMarkerPos _x];
  diag_log _markerPos_array;
  _markerName = format ["TempMarker%1",_loopPosCounter];
  diag_log _markerName;
  _tempMarker = createMarker["TempMarker", _markerPos_array select _loopPosCounter];
  diag_log _markerPos_array select _loopPosCounter;
  "TempMarker" setMarkerShape "ICON";
  "TempMarker" setMarkerType _markerType;
  "TempMarker" setMarkerColor _markerColor;
  "TempMarker" setMarkerText _newmarkerText;
  "TempMarker" setMarkerAlpha 1;
  diag_log _loopPosCounter;
  _loopPosCounter = _loopPosCounter + 1;
  diag_log _loopPosCounter;
  sleep 1;
  deleteMarker _x;

} forEach _marker_area_array;
*/

//
_loopPosCounter = 0;
_markerString = [];
{
	_markerString append [_x call BIS_fnc_markerToString];
	diag_log _markerString;
	diag_log _x;
	deleteMarker _x;

} forEach _marker_area_array;

{
	_markerString select _loopPosCounter call BIS_fnc_stringToMarker;
	_loopPosCounter = _loopPosCounter + 1;
} forEach _marker_area_array;