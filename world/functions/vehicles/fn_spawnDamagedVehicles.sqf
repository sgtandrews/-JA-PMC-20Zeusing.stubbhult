/*
Function: JA_World_fnc_spawnDamagedVehicles

Description:
    Spawns damaged vehicles in the given area.
    Function must be ran in scheduled environment.

Parameters:
    Position2D center:
        The area center to find roads.
    Number radius:
        The radius from the center to find roads.

Returns:
    Array
        An array of simple objects that were spawned.

Author:
    thegamecracks

*/
params ["_center", "_radius"];
private _vehicleCount = (floor (_radius / 1000 * (1 + random 1))) * 2;
private _vehicleTypes = ["UK3CB_CHC_C_MMT","UK3CB_C_Landcruiser","UK3CB_ADC_C_Hilux_Civ_Open","UK3CB_ADC_C_Forklift","UK3CB_ADC_C_Hatchback","UK3CB_ADC_C_Datsun_Civ_Closed","UK3CB_ADC_C_Datsun_Civ_Open","UK3CB_ADC_C_Hilux_Civ_Closed","UK3CB_ADC_C_Kamaz_Covered","UK3CB_ADC_C_LR_Closed","UK3CB_ADC_C_LR_Open","UK3CB_ADC_C_Old_Bike","UK3CB_ADC_C_Pickup","UK3CB_ADC_C_V3S_Closed","UK3CB_ADC_C_V3S_Open","UK3CB_ADC_C_Sedan","UK3CB_ADC_C_Skoda","UK3CB_ADC_C_S1203","UK3CB_ADC_C_Lada_Taxi","UK3CB_ADC_C_SUV","UK3CB_ADC_C_Tractor","UK3CB_ADC_C_Tractor_Old","UK3CB_ADC_C_TT650","UK3CB_ADC_C_UAZ_Closed","UK3CB_ADC_C_UAZ_Open","UK3CB_ADC_C_Ural_Empty","UK3CB_ADC_C_Ural_Open","UK3CB_ADC_C_Gaz24","UK3CB_ADC_C_Golf","UK3CB_ADC_C_YAVA","UK3CB_CHC_C_Octavia","UK3CB_CHC_C_S1203_Amb","CUP_C_Skoda_CR_CIV","CUP_C_Skoda_Blue_CIV","CUP_C_Skoda_Green_CIV","CUP_C_Skoda_Red_CIV","CUP_C_Skoda_White_CIV","CUP_C_Bus_City_CRCIV","CUP_C_SUV_CIV","CUP_LADA_LM_CIV","CUP_C_Lada_Red_CIV","CUP_C_Lada_White_CIV","CUP_C_Volha_Gray_TKCIV","CUP_C_V3S_Open_TKC","CUP_C_Lada_GreenTK_CIV"];
private _vehicles = [];
_wreckLoot = ["rhsusf_props_ScepterMFC_OD","rhsusf_props_ScepterMWC_OD","ACE_Wheel"];

_roadList= _center nearroads _radius;

_showRoads=false;
if (_showRoads) then {
			{
		_txt=format ["RoadPos:%1",_X];
		_debug=createMarker [_txt,_X];
		_debug setMarkerShape "ICON";
		_debug setMarkerType "hd_dot";
			}foreach _roadList;
				};
			
		{
_roadConnectedTo = roadsConnectedTo _x;
	if (count _roadConnectedTo > 2) then {	
	_roadlist=_roadlist - [_x];};
		}foreach _roadlist;


_roadlist=_roadlist call BIS_fnc_arrayShuffle;

for "_i" from 1 to _vehicleCount do {

	_currentRoad=_roadlist select _i;
	
	_roadConnectedTo = roadsConnectedTo _currentRoad;
	_connectedRoad = _roadConnectedTo select 0;
	_direction = [_currentRoad, _connectedRoad] call BIS_fnc_DirTo;
	_workingVehicle = selectRandom 	_vehicleTypes;
    _partDamage = [0,0.2,0.2,0.6,0.6,0.6,0.6,0.8,0.8,0.8,0.8,0.8,0.8,1,1,1,1,1,1,1,1];
	_fuelLevel = [1,0.4,0.2,0.2,0.2,0.2,0,0,0,0,0,0,0,0];
	_partsList = ["hitbody","hitengine","hitfuel","hithull","hitglass1","hitglass2","hitglass3","hitglass4","hitrglass","hitlglass","hitglass5","hitglass6","hitlfwheel","hitlf2wheel","hitlmwheel","hitlbwheel","hitrfwheel","hitrf2wheel","hitrmwheel","hitrbwheel","#hitlightleft","#hitlightright"];	

    _vehPos = getPos _currentRoad findEmptyPosition [0,100, _workingVehicle];
    if ([_vehPos] call JA_World_fnc_inAreaSafezone isNotEqualTo []) then {continue};
    if (isNil {_vehPos select 1}) then {
        diag_log "Nil EmptyPosition found";
    }
    else{
    _veh = createVehicle [_workingVehicle , _vehPos, [], 0, "CAN_COLLIDE"];

    _veh setFuel selectRandomWeighted _fuelLevel;
    {
        if (_x == "hithull") then{
            _veh setHitPointDamage [_x, selectRandomWeighted _partDamage - 0.3];
        }
        else{
        _veh setHitPointDamage [_x, selectRandomWeighted _partDamage];
        }

    }forEach _partsList;
    _veh setPos [(getPos _veh select 0)-4.5, getPos _veh select 1, getPos _veh select 2];
    [_veh,["Claim this vehicle",{[(_this select 0)] call HG_fnc_setOwner},"",0,false,false,"",'(alive player) && !dialog && player distance _target < 3']] remoteExec ["addAction",-2,true];
    _veh setdir _direction;	
    };

    // Checks and Spawns Wheels etc 
    if ((random 100 < (JA_wrecks_loot_chance + JA_wrecks_loot_chance_small)) && JA_wrecks_loot) then {
        private _selectedLoot = selectRandom _wreckLoot;
        _veh_loot = createVehicle [_selectedLoot, _vehPos, [], 0, "CAN_COLLIDE"];
        _veh_loot setPos [(getPos _veh_loot select 0)-2.5, getPos _veh_loot select 1, getPos _veh_loot select 2];
        _veh_loot spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
    };	
	};
