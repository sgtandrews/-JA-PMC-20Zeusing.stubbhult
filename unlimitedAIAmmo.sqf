_unit = _this select 0;
_ammoCount = _this select 1;
_primeWpn = "";
_prevWpn = "";
_magazineType = "";
mags_array = [];
_mags_array_Temp = [];

_foundMags = 0;

while {alive _unit} do {
waitUntil {sleep 0.5; currentWeapon _unit != ""};
_primeWpn = currentWeapon _unit;
mags_array = [_primeWpn] call BIS_fnc_compatibleMagazines;

{
  // code...
  _mags_array_Temp pushBack (toLower _x);
} forEach mags_array;
//diag_log "Mags Array";
//diag_log mags_array;

mags_array_lower = _mags_array_Temp;

if (_primeWpn != _prevWpn) then
{
	_prevWpn = _primeWpn;
	_compact_mags = _primeWpn call BIS_fnc_compatibleMagazines;
	_intersected_mags = mags_array_lower arrayIntersect _compact_mags;
	_magazineType = _intersected_mags select 0;
	if (isNil _magazineType) then {diag_log "Naughty Weapons";diag_log _prevWpn; diag_log _primeWpn;};
};

_foundMags = 0;
{
	if (_x == _magazineType) then
	{
		_foundMags = _foundMags + 1;
	};
} forEach (magazines _unit);

if (_foundMags < _ammoCount) then
{
	for "_i" from 1 to (_ammoCount - _foundMags) do
	{
		_unit addMagazine _magazineType;
	};
};

sleep 1;
};