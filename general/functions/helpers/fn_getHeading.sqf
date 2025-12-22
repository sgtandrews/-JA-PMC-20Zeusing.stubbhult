/* ----------------------------------------------------------------------------
Function: JA_GENERAL_fnc_getHeading

Description:
    Gets a Cardinal Direction

Parameters:
    Can be an Object, Position2D or Position3D
        _firstPos  - First position to compare 
        _secondPos  - Second position to compare
        _isNumber - If True, returns a number instead. ( Default false ) 

Returns:

    Returns Cardinal Direction in String or Bearing in Number 

Examples:
    (begin example)
        _result = [player,debugContainer,true] call JA_GENERAL_fnc_getHeading;
    (end)

Author:
    J. Andrews

---------------------------------------------------------------------------- */

params ["_firstPos", "_secondPos",["_isNumber",false]];

_currentHeading = (_firstPos getDirVisual _secondPos);

_dirString = "";
_return = nil;

if (_currentHeading > 337.5 or _currentHeading < 22.5) then {
	_dirString = "North";
};
if (_currentHeading >= 22.5 && _currentHeading <= 67.5) then {
	_dirString = "North-East";
};
if (_currentHeading > 67.5 && _currentHeading < 112.5) then {
	_dirString = "East";
};
if (_currentHeading >= 112.5 && _currentHeading <= 157.5) then {
	_dirString = "South-East";
};
if (_currentHeading > 157.5 && _currentHeading < 202.5) then {
	_dirString = "South";
};
if (_currentHeading >= 202.5 && _currentHeading <= 247.5) then {
	_dirString = "South-West";
};
if (_currentHeading > 247.5 && _currentHeading < 292.5) then {
	_dirString = "West";
}; 
if (_currentHeading >= 292.5 && _currentHeading <= 337.5) then {	
_dirString = "North-West";
};

if (_isNumber) then {_return = _currentHeading;} else {_return = _dirString;};

_return