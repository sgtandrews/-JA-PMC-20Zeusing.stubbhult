_mkr=(_this select 0);
_pos=markerpos _mkr;
_carSpawns=40;
_lootChance = 15;
_workingVehicleChance = 5;

_roadList= _pos nearroads 1000;

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

for "_i" from 1 to _carSpawns do {

	_currentRoad=_roadlist select _i;
	
	_roadConnectedTo = roadsConnectedTo _currentRoad;
	_connectedRoad = _roadConnectedTo select 0;
	_direction = [_currentRoad, _connectedRoad] call BIS_fnc_DirTo;
	_workingVehicle = selectRandom ["UK3CB_CHC_C_MMT","UK3CB_C_Landcruiser","UK3CB_ADC_C_Hilux_Civ_Open", "UK3CB_ADC_C_Forklift", "UK3CB_ADC_C_Hatchback", "UK3CB_ADC_C_Datsun_Civ_Closed", "UK3CB_ADC_C_Datsun_Civ_Open", "UK3CB_ADC_C_Hilux_Civ_Closed", "UK3CB_ADC_C_Kamaz_Covered", "UK3CB_ADC_C_LR_Closed","UK3CB_ADC_C_LR_Open", "UK3CB_ADC_C_Old_Bike", "UK3CB_ADC_C_Pickup", "UK3CB_ADC_C_V3S_Closed", "UK3CB_ADC_C_V3S_Open", "UK3CB_ADC_C_Sedan", "UK3CB_ADC_C_Skoda", "UK3CB_ADC_C_S1203", "UK3CB_ADC_C_Lada_Taxi", "UK3CB_ADC_C_SUV", "UK3CB_ADC_C_Tractor", "UK3CB_ADC_C_Tractor_Old", "UK3CB_ADC_C_TT650", "UK3CB_ADC_C_UAZ_Closed", "UK3CB_ADC_C_UAZ_Open", "UK3CB_ADC_C_Ural_Empty", "UK3CB_ADC_C_Ural_Open", "UK3CB_ADC_C_Gaz24", "UK3CB_ADC_C_Golf", "UK3CB_ADC_C_YAVA", "UK3CB_CHC_C_Octavia","UK3CB_CHC_C_S1203_Amb","CUP_C_Skoda_CR_CIV", "CUP_C_Skoda_Blue_CIV", "CUP_C_Skoda_Green_CIV", "CUP_C_Skoda_Red_CIV", "CUP_C_Skoda_White_CIV", "CUP_C_Bus_City_CRCIV", "CUP_C_SUV_CIV", "CUP_LADA_LM_CIV", "CUP_C_Lada_Red_CIV", "CUP_C_Lada_White_CIV"];
	_partDamage = [0,0.2,0.2,0.6,0.6,0.6,0.6,0.8,0.8,0.8,0.8,0.8,0.8,1,1,1,1,1,1,1,1];
	_fuelLevel = [1,0.4,0.2,0.2,0.2,0.2,0,0,0,0,0,0,0,0];
	_partsList = ["hitbody","hitengine","hitfuel","hithull","hitglass1","hitglass2","hitglass3","hitglass4","hitrglass","hitlglass","hitglass5","hitglass6","hitlfwheel","hitlf2wheel","hitlmwheel","hitlbwheel","hitrfwheel","hitrf2wheel","hitrmwheel","hitrbwheel","#hitlightleft","#hitlightright"];
	
 _selectedVehicle = selectRandom ["Land_chz_avtobus", "Land_chz_avtobus2", "Land_chz_benzovoz_gaz", "Land_chz_buldozer", "Land_chz_gaz", "Land_chz_gaz66_02", "Land_chz_kamaz_fura", "Land_chz_kamaz_pricep", "Land_chz_molokovoz_01","Land_chz_moskvich","Land_chz_moskvich_2","Land_chz_niva_01","Land_chz_niva_02","Land_chz_niva_03","Land_chz_traktor_2","Land_chz_uaz_1","Land_chz_uazik_01","Land_chz_uazik_02","Land_chz_zaz968_1","Land_V3S_open","Land_V3S_refuel","Land_Volha","Land_Volha_1","Land_Volha_2","land_bmp2_wrecked","UralWreck","Land_chz_kamaz_korpus3","Land_Wreck_BRDM2_F","Land_Wreck_Skodovka_F","Land_Wreck_Truck_F","Land_Wreck_Car2_F","Land_Wreck_Car3_F","Land_Wreck_Offroad_F","Land_Wreck_Offroad2_F","Land_Wreck_UAZ_F","Land_Wreck_Ural_F","Land_V3S_wreck_F"];	
 _selectedLoot = selectRandom ["rhsusf_props_ScepterMFC_OD","rhsusf_props_ScepterMWC_OD","ACE_Wheel"];	

                                 if (random 100 < _workingVehicleChance) then {
									_vehPos = getPos _currentRoad findEmptyPosition [0,100, _workingVehicle];
									if (isNil {_vehPos select 1}) then {
										diag_log "Nil EmptyPosition found";
									}
									else{
                                    _veh = createVehicle [_workingVehicle , _vehPos, [], 0, "NONE"];

									_veh setFuel selectRandomWeighted _fuelLevel;
									{
										if (_x == "hithull") then{
											_veh setHitPointDamage [_x, selectRandomWeighted _partDamage - 0.3];
										}
										else{
										_veh setHitPointDamage [_x, selectRandomWeighted _partDamage];
										}

									}forEach _partsList;

									_veh addAction["Claim this vehicle",{[(_this select 0)] call HG_fnc_setOwner;(_this select 0) removeaction (_this select 2)},"",0,true,true,"",'(alive player) && !dialog && player distance _target < 12' ];
									_veh setdir _direction;	
									};

									// Checks and Spawns Wheels etc 
									if (random 100 < _lootChance) then {
										_veh_loot = createVehicle [_selectedLoot, _currentRoad, [], 0, "CAN_COLLIDE"];
										_veh_loot setPos [(getPos _veh_loot select 0)-2.5, getPos _veh_loot select 1, getPos _veh_loot select 2];
									}
									
                                }
                                else{ 
                                    _veh = createVehicle [_selectedVehicle , _currentRoad, [], 0, "CAN_COLLIDE"];
									
									_veh setdir _direction;
									_veh setPos [(getPos _veh select 0)-4.5, getPos _veh select 1, getPos _veh select 2];

									// Checks and Spawns Wheels etc 
									if (random 100 < _lootChance) then {
										_veh_loot = createVehicle [_selectedLoot, _currentRoad, [], 0, "CAN_COLLIDE"];
										_veh_loot setPos [(getPos _veh_loot select 0)-2.5, getPos _veh_loot select 1, getPos _veh_loot select 2];
									}
                                }; 
 
 
		_txt=format ["Veh:%1",_i];
		_debug=createMarker [_txt,_currentRoad];
		_debug setMarkerShape "ICON";
		_debug setMarkerType "hd_dot";
		_debug setMarkerText _txt;	
		};