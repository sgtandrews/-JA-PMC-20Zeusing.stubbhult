/*
Function: JA_World_fnc_spawnCarWrecks

Description:
    Spawns car wrecks along roads in the given area.

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
private _wrecks = [];
private _roads = _center nearRoads _radius;
_model = [];
_position = [];
_vectorDirUp = [];
_wreckLoot = ["rhsusf_props_ScepterMFC_OD","rhsusf_props_ScepterMWC_OD","ACE_Wheel"];
systemChat "Spawning Wrecks...";
{
	getRoadInfo _x params ["_mapType", "_width", "_isPedestrian", "", "", "", "_begPos", "_endPos"];
	if (_isPedestrian) then {continue};
	if !(_mapType in ["ROAD", "MAIN ROAD", "TRACK"]) then {continue};

	_width = _width max 8;

	private _lengthVector = _endPos vectorDiff _begPos;
	private _lengthDir = acos (_lengthVector vectorCos [0, 1, 0]);
	private _length = vectorMagnitude _lengthVector;

	private _density = SHZ_wrecks_density;
	private _town = nearestLocation [
		_begPos,
		["Airport", "NameVillage", "NameCity", "NameCityCapital"],
		SHZ_wrecks_townFactor_distance
	];
	if (!isNull _town) then {
		private _distance = _begPos distance2D locationPosition _town;
		private _factor = linearConversion [
			0,
			SHZ_wrecks_townFactor_distance,
			_distance,
			SHZ_wrecks_townFactor,
			1,
			true
		];
		_density = _density / _factor;
	};

	for "_i" from 1 to random (_length / _density + 1) do {
		// NOTE: this could generate two vehicles beside each other,
		//	   either on the same road segment or across two segments
		private _objPos = vectorLinearConversion [0, 1, random 1, _begPos, _endPos];
		private _normal = vectorNormalized _lengthVector vectorCrossProduct [0, 0, 1];
		private _normalScale = random _width - _width / 2;
		_normal = _normal vectorMultiply _normalScale;
		_objPos = _objPos vectorAdd _normal;

		if (
			!SHZ_wrecks_safezones
			&& {[_objPos] call JA_World_fnc_inAreaSafezone isNotEqualTo []}
		) then {continue};

		private _objDir = _lengthDir + random [-180, 0, 180];
		switch (true) do {
			case (SHZ_wrecks_rightHandDrive && {_normalScale < 0});
			case (!SHZ_wrecks_rightHandDrive && {_normalScale > 0}): {
				_objDir = _objDir + 180;
			};
		};
		_objDir = _objDir + 180; // all the wreck types are facing the wrong way
		private _selectedWreck = selectRandom SHZ_wrecks_vehicleTypes;
		_objPos = _objPos findEmptyPosition [sizeOf _selectedWreck,(sizeOf _selectedWreck) * 2, _selectedWreck];
		if (_objPos isEqualto []) then {diag_log "No Viable Wreck Position"; Continue;} else {
			_vehObj = createVehicleLocal [_selectedWreck , _objPos, [], 0, "CAN_COLLIDE"];
			_position = getPosWorld _vehObj;
			_vectorDirUp = [vectorDir _vehObj, vectorUp _vehObj];
			_model = getModelInfo _vehObj select 1;
			deleteVehicle _vehObj;
			_obj = createSimpleObject [_model, _position];
			_obj setVectorDirAndUp _vectorDirUp;
			
			_obj setDir _objDir;
			_obj setVectorUp surfaceNormal _objPos;
			_wrecks pushBack _obj;
			//private _obj = createSimpleObject [_selectedWreck, _objPos];
			// Checks and Spawns Wheels etc
			if (JA_wrecks_loot) then {
			_spawnType = selectRandom["inv_garrison_point","CBA_BuildingPos"];
			_objPos = _objPos findEmptyPosition [sizeOf _spawnType,(sizeOf _spawnType) * 15, _spawnType];
			if (_objPos isEqualTo []) then {diag_log "Can't Spawn Wreck Loot";} else {

            _lootSpawn = createVehicle [_spawnType, _objPos, [], 0, "CAN_COLLIDE"];
			_lootSpawn spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
            
            };
			
			}; 
			if ((random 100 < (JA_wrecks_loot_chance + JA_wrecks_loot_chance_small)) && JA_wrecks_loot) then {
				private _selectedLoot = selectRandom _wreckLoot;
				_veh_loot = createVehicle [_selectedLoot, position _obj, [], 0, "CAN_COLLIDE"];
				_veh_loot setPos [(getPos _veh_loot select 0)-2.5, getPos _veh_loot select 1, getPos _veh_loot select 2];
				_veh_loot spawn {sleep 1; [_this, true] remoteExec ["enableDynamicSimulation"]};
			};
		};
		
		
		
		
	};
} forEach _roads;
systemChat "Wrecks Spawned";
systemChat format ["%1 car wrecks spawned", count _wrecks];
diag_log text format ["%1 car wrecks spawned", count _wrecks]; 
_wrecks
