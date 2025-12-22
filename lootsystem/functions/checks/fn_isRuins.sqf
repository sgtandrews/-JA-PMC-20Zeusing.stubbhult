/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_isRuins

Description:
    Finds if the position is in ruins.

Parameters:
    _position - Position of where the loot will spawn

Returns:
	Returns Boolean

Examples:
    (begin example)
        _lootTypes = [position player] call JA_LootGen_fnc_isRuins;
    (end)

Author:
    J. Andrews

---------------------------------------------------------------------------- */
params ["_position"];

_lootFluidSystem        = ("TFA_p_spawnfluidity" call BIS_fnc_getParamValue) isEqualTo 1; 
_isRuins = false;
_nearestBuildings = [];
_nearestBuilding = [];
_buildings = [];
_selectedSpawnCat = "";
_ruinNames = ["Castle","Historical","Rusty","Destroyed","Ruin","Abandoned","Unfinished","WIP","_dam","_d_","_u_","Wreck"];
_buildings = nearestObjects[_position,["house","Building"], 50]; 
_classNameFilters = ["Lamp","Stairs","inv_garrison_point","hatg_mirror"];

{	  
	_nearestBuildings pushBack _x;
} forEach _buildings;
	
/* Filter function, super slow af

_nbArrays = +_buildings; 

{
	{ 
		_selectedFilter = _classNameFilters select _forEachIndex;	  
		{
			_selectedBuilding = _nbArrays select _forEachIndex;
			_buildingClassName = typeOf _selectedBuilding;

			if ([_selectedFilter, _buildingClassName] call BIS_fnc_inString == true) then {
			_nearestBuildings deleteAt _forEachIndex; 
			
			};
		} forEach _nbArrays;
	}forEach _classNameFilters;

} forEach _nbArrays;*/


if ( _lootFluidSystem == false ) then {
_nearestBuilding pushback (_nearestBuildings select 0);
_nearestBuildings = _nearestBuilding;
	
 };

if (count _nearestBuildings == 0) then { _nearestBuildings pushback (nearestBuilding _position);};

{
	_selectedBuilding = _nearestBuildings select _forEachIndex;
	_buildingClassName = typeOf _selectedBuilding;
	_buildingvehicleClass = getText (configFile >> "CfgVehicles" >> _buildingClassName >> "vehicleClass");
	_buildingvehicleEditSubcat = getText (configFile >> "CfgVehicles" >> _buildingClassName >> "editorSubcategory");

	call {
		scopeName "RuinCheck";
		{
			if ([_x, _buildingClassName] call BIS_fnc_inString == true) then {
			_isRuins = true;
			breakTo "RuinCheck";
			};

			if ([_x, _buildingvehicleClass] call BIS_fnc_inString == true) then {
			_isRuins = true;
			breakTo "RuinCheck";
			};

			if ([_x, _buildingvehicleEditSubcat] call BIS_fnc_inString == true) then {
			_isRuins = true;
			breakTo "RuinCheck";
			};


		} forEach _ruinNames;
	};

} forEach _nearestBuildings;


_isRuins;