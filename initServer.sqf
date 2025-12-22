/*
    Author - HoverGuy
	GitHub - https://github.com/Ppgtjmad/SimpleShops
	Steam - https://steamcommunity.com/id/HoverGuy/
    Server initialization
*/

[] execVM "HALs\Addons\store\data\storeWarehouse.sqf";
[] execVM "HG\Setup\fn_serverInitialization.sqf";


_debugCity = nearestLocation [
		[0,0,0],
		["Airport", "NameVillage", "NameCity", "NameCityCapital"],
		1000
	];
	
deleteLocation _debugCity;

/*
fnc_spawn_loot = compileFinal preprocessFile "lootsystem\core\fn_lootMain.sqf";
_d = [] spawn fnc_spawn_loot;*/

//0 spawn {[("TFA_p_loottogle" call BIS_fnc_getParamValue) isEqualTo 1]call JA_LOOTGEN_fnc_lootMain};

_buildingMarkers = ["BuildingMarker","BuildingMarker_1","BuildingMarker_2","BuildingMarker_3"];
//Eden Placed Buildings marked on map  

if (isServer) then {
	_sleep_delay = 4;
	sleep _sleep_delay;
{
////Find marker and get the size

_mkr= _x;
_mkr setmarkerAlpha 0;
_pos=markerpos _mkr;
_mkrY= getmarkerSize _mkr select 0;
_mkrX= getmarkerSize _mkr select 1;
_distance= _mkrX;
if (_mkrY > _mkrX)
then {
_distance=_mkrY;
};

////Create New House Markers

_HouseArray = ["Building","House"];
_nearestBuildings = nearestObjects [_pos, _HouseArray, _distance];
{

_x setVectorUp [0,0,1];
//_x enableSimulation true;

_boundingBox = boundingBox _x;
_dir = getDir _x;
_position = getPosATL _x;

_size = _boundingBox select 1;
_size resize 1.5;
_markername = "marker" + str(floor(random 500)) + str(floor(random 500));
//Marker creation
createMarker [_markername, _position];
_markername setMarkerShape "RECTANGLE";
_markername setMarkerSize _size;
_markername setMarkerBrush "SolidFull";
_markername setMarkerColor "ColorGrey";
_markername setMarkerDir _dir;
} forEach _nearestBuildings;
}forEach _buildingMarkers;
};


fnc_spawn_markers = compileFinal preprocessFile "markerSpawn.sqf";
sleep 2;
_d = [] spawn fnc_spawn_markers;

// Dynamic Groups 

["Initialize", [true]] call BIS_fnc_dynamicGroups;

if (("TFA_p_spawn_debug" call BIS_fnc_getParamValue) isEqualTo 1) then {
	_debugContainer = "Boxloader_Ammo_West" createVehicle getMarkerPos "_debugContainerMrk";
	missionNamespace setVariable ["debugContainer", _debugContainer];
	_debugContainer addBackpackCargo ["eo_bergan", 25]
	 
	};

/*
_oldVillage = createLocation ["NameVillage", [2105.29,11074.4,0.00158691], 150, 150];
_oldVillage setText "Old Village Ruins";

_lowerEssekerHospital = createLocation ["SafetyZone", [10459.7,5431.47,0.00187159], 150, 150];
_lowerEssekerHospital setText "Lower Esseker Hospital";


_destroyedBridge = createLocation ["ViewPoint", [8050.19,5291.53,6.50503], 150, 150];
_destroyedBridge setText "Destroyed Bridge";

_oldEstate = createLocation ["NameVillage", [7596.19,4489.31,0.0011673], 150, 150];
_oldEstate setText "Old Estate";
*/
execVM "scripts\helpers\show_fps.sqf";
execVM "world\scripts\server\manage_weather.sqf";
//execVM "world\scripts\server\fucking_set_fog.sqf";

// Wrecks and Damaged Vehicles - Zombie Framework 
if (SHZ_wrecks_enabled) then {
    [[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize] spawn JA_World_fnc_spawnCarWrecks;
};
[[worldSize / 2, worldSize / 2], sqrt 2 / 2 * worldSize] spawn JA_World_fnc_spawnDamagedVehicles;

[{[true, 30] call grad_persistence_fnc_saveMission}, 600, []] call CBA_fnc_addPerFrameHandler;



[] execVM "world\functions\ambient\fn_ambientEnemys.sqf";