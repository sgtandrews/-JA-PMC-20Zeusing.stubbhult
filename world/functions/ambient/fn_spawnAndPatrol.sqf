/*
  Spawn_and_Patrol Script
  by Rydygier and Gunter Severloh
  
       This script spawns infantry groups at a marker you set, they will patrol the radius of 
	   the marker based on the distance in meters that you defined in the parameters.
	       During their patrol the group will move in a circular path from a starting angle
		 from an order of: North (0°), East (90°), South (180°), and West (270°).
	   Each new group spawned will move in a new direction which will be opposite of
	   the previous group's direction, but random.
	   
	   If a group comes into contact with enemy and engages them, any nearby group
	   also patrolling will come and support the initial group and then return to their patrol 
	   when the engagement has ended provided their not all dead.
=============	   
How to setup:
=============
    1. Move the script Spawn_and_Patrol.sqf into your mission folder.
	
	2. Place a marker on the map and name it, then define the name in the parameter code. 
	   The marker will be where you want infantry groups to spawn and patrol.
	   Be sure to place the marker in a central location, as the infantry groups spawned
	   will patrol the radius of that marker based on the distance you define in the parameters.
	   
    3. For the script based parameter put the following code into a trigger's init.

	      call compile preprocessFile "Spawn_and_Patrol.sqf";
		  
	4. For a trigger based parameter, adjust the parameter code below to what you 
	   want and then put it into a trigger's init:
	   
	     [1, "Mark1", 1, 10, 100, ["B_Soldier_SL_F", "B_Soldier_F", "B_Soldier_AR_F"]] 
	      call compile preprocessFile "Spawn_and_Patrol.sqf";
=====================
Parameter Information
=====================
    Parameters:
      [numberofGroups, markerName, respawnLimit, spawnDelay, patrolRadius, unitClassArray]

    Example usage:
      [4, "Mark1", 1, 10, 100, ["B_Soldier_SL_F", "B_Soldier_F", "B_Soldier_AR_F"]] call compile preprocessFile "Spawn_and_Patrol.sqf";
*/

// Define which faction side is to patrol (default is WEST).
spawnGroup = {
    params ["_spawnPos", "_classNames"];
    private _grp = createGroup EAST;
    {
        _grp createUnit [_x, _spawnPos, [], 0, "NONE"];
    } forEach _classNames;
    _grp
};

unitIsFightingSomeone =
	{
	params ["_unit"];

	private _attackTarget = getAttackTarget _unit;

	((alive _attackTarget) and {((_unit distance _attackTarget) < 300) and {((_unit knowsAbout _attackTarget) > 1.5)}})
	};


// Define the parameters below if your not using the full parameters in a trigger.
params [
    ["_numGroups", 1],                   // Number of groups to spawn.
    ["_markerName", "Mark1"],            // Marker name of the spawn point.
    ["_respawnLimit", -1],                // Number of times a group can respawn when killed.
    ["_spawnDelay", 10],                 // Delay in seconds before the group respawns.
    ["_patrolRadius", 1000],              // Patrol radius distance around the marker in meters.
    ["_classNames", ["CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer"]]  // Classnames for each group.
];

private _spawnPos = markerPos _markerName;

// Cached parameters.
private _ng = _numGroups;
private _rl = _respawnLimit;
private _sd = _spawnDelay;
private _pr = _patrolRadius;
private _cn = _classNames;

[_ng,_rl,_sd,_pr,_cn,_spawnPos] spawn 
	{
	params ["_ng","_rl","_sd","_pr","_cn","_spawnPos"];
    private _respawnCount = 0;
    while { _respawnCount < _rl } do 
		{
		private _groups = [];
        for "_i" from 1 to _ng do 
			{
			
            // Group initial behaviour 
            private _group = [_spawnPos, _cn] call spawnGroup;
            private _leader = leader _group;
            _group setBehaviour "SAFE";
            _group setCombatMode "YELLOW";
            _group setSpeedMode "LIMITED";
			
            // Direction a group will start patrolling: [0, 90, 180, 270] = North, East, South, West.
            private _orderArray = [0, 90, 180, 270];
            private _initialAngle = selectRandom _orderArray;
			private _signum = selectRandom [-1,1];
			private _leaderPosition = getPosATL _leader;
			
			for "_i" from _initialAngle to (_initialAngle + (345 * _signum)) step (15 * _signum) do
				{
				private _intermediateNavigationPoint = _leaderPosition getPos [_pr,_i];

				private _waypoint = _group addWaypoint [_intermediateNavigationPoint,0];
				_waypoint setWaypointType "MOVE";
				
							_mk = "markWaypoint_" + (str _intermediateNavigationPoint);
							_mk = createMarker [_mk,_intermediateNavigationPoint];
							_mk setMarkerColor "ColorGreen";
							_mk setMarkerShape "ICON";
							_mk setMarkerType "mil_circle";
							_mk setMarkerSize [0.5,0.5];
							_mk setMarkerText (format ["%1",_group]);
				};
				
			private _cycleNavigationPoint = _leaderPosition getPos [_pr,_initialAngle];
			
			private _waypoint = _group addWaypoint [_cycleNavigationPoint,0];
			_waypoint setWaypointType "CYCLE";

            _groups pushBack _group;
			};
		
		_supportRange = 1000 max (_pr * 3);
		
        waitUntil 
			{
			sleep 5;
			
				{
				_group = _x;
				_leader = leader _x;
				if ((((units _group) findIf {(alive _x) and {[_x] call unitIsFightingSomeone}}) >= 0) and {isNull (_group getVariable ["isSupportedBy",grpNull])}) then
					{
					_group setVariable ["isFighting",true];
					_otherGroups = _groups select 
						{
						not (_x isEqualTo _group) and 
							{
							not (_x getVariable ["isFighting",false]) and 
								{
								(isNull (_x getVariable ["isSupporting",grpNull])) and 
									{
									(({alive _x} count (units _x)) > 0) and 
										{
										(((leader _x) distance (leader _group)) < _supportRange)
										}
									}
								}
							}
						};

						{
						_supportGroup = _x;

						_enemy = _leader findNearestEnemy _leader;
						_supportPosition = if not ((isNull _enemy) or ((_enemy distance (leader _supportGroup)) > _supportRange)) then
							{
							(getPosATL _enemy)
							}
						else
							{
							(getPosATL _leader)
							};
						
						_supportLeader = leader _supportGroup;
						if not ((_supportPosition distance _supportLeader) > _supportRange) exitWith
							{
							_group setVariable ["isSupportedBy",_supportGroup];
							_supportGroup setVariable ["isSupporting",_group];
							_supportPosition set [2,0];
							_supportGroup setSpeedMode "NORMAL";
							_supportGroup setBehaviour "AWARE";
							_supportGroup move _supportPosition;
							
							_mk = "suppWaypoint_" + (str _supportPosition);
							_mk = createMarker [_mk,_supportPosition];
							_mk setMarkerColor "ColorRed";
							_mk setMarkerShape "ICON";
							_mk setMarkerType "mil_circle";
							_mk setMarkerSize [0.5,0.5];
							_mk setMarkerText (format ["%1",_group]);
							
							hintSilent format ["%2 supports %1 at %3",_group,_supportGroup,_supportPosition];
							};
						}
					foreach _otherGroups;
					}
				else
					{
					if (_group getVariable ["isFighting",false]) then
						{						
						_group setVariable ["isFighting",nil];
						_supportGroup = _group getVariable ["isSupportedBy",grpNull];
						_supportGroup setVariable ["isSupporting",nil];
						_group setVariable ["isSupportedBy",nil];

						_supportGroup setSpeedMode "LIMITED";
						_supportGroup setBehaviour "SAFE";
						};
					};
				}
			foreach _groups;

            (_groups findIf {({alive _x} count (units _x)) > 0} == -1)
			};
		};

	sleep ((_sd - 5) max 1);
	_respawnCount = _respawnCount + 1;
    };
