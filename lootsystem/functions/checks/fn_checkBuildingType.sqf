/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_checkBuildingType

Description:
    Finds what sort of building it is and returns what sort of loot should spawn within it.

Parameters:
    _position - Position of where the loot will spawn

Returns:
	Returns Loot Spawn Array

Examples:
    (begin example)
        _lootTypes = [position player] call JA_LootGen_fnc_checkBuildingType;
    (end)

Author:
    J. Andrews



// Script to find building naming conventions 

_nearestBuildings = nearestObjects[player,["house","Building"], 200];
_selectedBuilding = _nearestBuildings select 0;

_buildingClassName = typeOf _selectedBuilding;

_building = getText (configFile >> "CfgVehicles" >> _buildingClassName >> "vehicleClass");

_buildingvehicleEditSubcat = getText (configFile >> "CfgVehicles" >> _buildingClassName >> "editorSubcategory");

_buildingStr=[_buildingClassName,_building,_buildingvehicleEditSubcat] joinString ": ";

_buildingStr


---------------------------------------------------------------------------- */
params ["_position"];

_lootFluidSystem        = ("TFA_p_spawnfluidity" call BIS_fnc_getParamValue) isEqualTo 1; 
_lootSpawnTypes = [];
_nearestBuildings = [];
_nearestBuilding = [];
_buildings = [];
_selectedSpawnCat = "";
_militaryNames = ["Military","Barracks","Guard","Bunker","Radar","barrack","Mil_","Airport_F","TentHangar"];
_foodNames = ["Commercial","Store","Shops","FuelStation","Kiosk","Pub"];
_industrialNames = ["Industrial","Workshop","Utilities","Farm","Barn","FuelStation","Shed","Construct"];
_medicalNames = ["Medevac","Research","Hospital","mash"];
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
		scopeName "MilitaryCheck";
		{
			if ([_x, _buildingClassName] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique "Military";
			breakTo "MilitaryCheck";
			};

			if ([_x, _buildingvehicleClass] call BIS_fnc_inString == true) then {	
			_lootSpawnTypes pushBackUnique "Military";
			breakTo "MilitaryCheck";
			};

			if ([_x, _buildingvehicleEditSubcat] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique "Military";
			breakTo "MilitaryCheck";
			};

		} forEach _militaryNames;
	};

	call {
		scopeName "FoodCheck";
		{
			if ([_x, _buildingClassName] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Food";
			breakTo "FoodCheck";
			};

			if ([_x, _buildingvehicleClass] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Food";
			breakTo "FoodCheck";
			};

			if ([_x, _buildingvehicleEditSubcat] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Food";
			breakTo "FoodCheck";
			};

		} forEach _foodNames;
	};

	call {
		scopeName "IndustrialCheck";
		{
			if ([_x, _buildingClassName] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Industrial";
			breakTo "IndustrialCheck";
			};

			if ([_x, _buildingvehicleClass] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Industrial";
			breakTo "IndustrialCheck";
			};

			if ([_x, _buildingvehicleEditSubcat] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Industrial";
			breakTo "IndustrialCheck";
			};

		} forEach _industrialNames;
	};

	call {
		scopeName "MedicalCheck";
		{
			if ([_x, _buildingClassName] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Medical";
			breakTo "MedicalCheck";
			};

			if ([_x, _buildingvehicleClass] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Medical";
			breakTo "MedicalCheck";
			};

			if ([_x, _buildingvehicleEditSubcat] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique  "Medical";
			breakTo "MedicalCheck";
			};


		} forEach _medicalNames;
	};

	call {
		scopeName "RuinCheck";
		{
			if ([_x, _buildingClassName] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique "Ruins";
			breakTo "RuinCheck";
			};

			if ([_x, _buildingvehicleClass] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique "Ruins";
			breakTo "RuinCheck";
			};

			if ([_x, _buildingvehicleEditSubcat] call BIS_fnc_inString == true) then {
			_lootSpawnTypes pushBackUnique "Ruins";
			breakTo "RuinCheck";
			};


		} forEach _ruinNames;
	};



} forEach _nearestBuildings;


_isMil = !((_lootSpawnTypes find "Military") isEqualTo -1);

if (_milLootinCiv) then {_lootSpawnTypes pushBackUnique "Military";};
if (!_isMil or _civLootinMil ) then {_lootSpawnTypes pushBackUnique "Civilian";};

_lootSpawnTypes;