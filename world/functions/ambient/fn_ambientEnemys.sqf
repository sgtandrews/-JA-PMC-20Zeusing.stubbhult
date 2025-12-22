//Roaming
ambientSpawnsOn = true; publicVariable "ambientSpawnsOn";
0 spawn {
	// type (nearestLocation [player,""]) spawn distanced based by location
	private _trigger_array		  = [JA_safezone_ShootingRange];  //names of triggers or area markers in editor. if empty then spawning occures everywhere
	private _squadLimitPerPlayer = 1.5;
	private _currentSquads = 0;
	private _squadUnits = [];
	private _zombieHordeLimitPerPlayer = 0;
	private _currentHorde = 0;
	private _zombieUnits = [];
	private _zombieGroups = [];
	private _banditGroups = [];
	private _zombieClassesDay = ["RyanZombieCrawler1","RyanZombieC_man_1walker","RyanZombieC_man_1slow","RyanZombieSpider1"];
	private _zombieClassesNight = ["RyanZombieC_man_1","RyanZombieC_man_1medium"];
	private _house_distance = 500;
	private _nightZs = true;
	private _timeForFastZs = [20,6]; // dayTime
	private _amountOfZs = 25;
	private _sleepTime = 0;
	
	while {ambientSpawnsOn} do {
	
		// Goes through and Deletes any Groups 
		if (count(_zombieGroups) > 0) then {
		_zombieGroupsTemp = _zombieGroups;
			{
			_zGrpIndex = _forEachIndex;
			if (count(units _x)isEqualTo 0) then {deleteGroup _x; _currentHorde = _currentHorde - 1; _zombieGroupsTemp deleteAt _zGrpIndex;diag_log "Deleting Zombie Group";};
			}forEach _zombieGroups;
		_zombieGroups = _zombieGroupsTemp;
		} else {};
		
		if (_zombieHordeLimitPerPlayer > 0) then {
			{
				deleteGroup _x	   
			}forEach groups resistance;
		};
		
		// Now for East/Bandits 
		if (count(_banditGroups) > 0) then {
		_banditGroupsTemp = _banditGroups;
			{ 
			_GrpIndex = _forEachIndex;
			if((([allPlayers,[],{(leader _x) distance _x},"ASCEND"]call BIS_fnc_sortBy)select 0) distance (leader _x) >= 1500) then {
				diag_log "Group Out of Range";
				{
				deleteVehicle _x;
				sleep 0.1;
				}forEach (units _x);
			};
			if (count(units _x)isEqualTo 0) then {deleteGroup _x; _currentSquads = _currentSquads - 1; _banditGroupsTemp deleteAt _GrpIndex;diag_log "Deleting Bandit Group";};

			}forEach _banditGroups;
		_banditGroups = _banditGroupsTemp;
		} else {};

		if ((count(_banditGroups) > 0) && (count(_zombieGroups) > 0)) then {private _sleepTime = 100;};
	
	//Get Player Locations
		_loot_players = [];
		_justPlayers = (allPlayers - entities "HeadlessClient_F") select {alive _x};			
		if(count _trigger_array > 0) then {
			{
				{
					_loot_players pushBack _x;
					true
				} count (_justPlayers inAreaArray _x);
				true
			} count _trigger_array;
			private _justPlayersTemp = _justPlayers;
			{
			private _index = _justPlayersTemp find _x;
			if (_index != -1) then
			{
				_justPlayersTemp deleteAt _index;
			};
		} forEach _loot_players;
		   
			_loot_players = _justPlayersTemp;	
			
		}
		else {
			_loot_players = _justPlayers;
			
			};

		{
		
			
		sleep 3;

		   
	   // Will only go through the spawn if it's bellow limits  
		while {(_squadLimitPerPlayer * (count (allPlayers - entities "HeadlessClient_F")) > _currentSquads or _zombieHordeLimitPerPlayer * (count (allPlayers - entities "HeadlessClient_F")) > _currentHorde) && (count (_loot_players) > 0)} do {
			
			
	
			//Get Player Locations
			_loot_players = [];
			_justPlayers = (allPlayers - entities "HeadlessClient_F") select {alive _x};			
			if(count _trigger_array > 0) then {
				{
					{
						_loot_players pushBack _x;
						true
					} count (_justPlayers inAreaArray _x);
					true
				} count _trigger_array;
				private _justPlayersTemp = _justPlayers;
				{
				private _index = _justPlayersTemp find _x;
				if (_index != -1) then
				{
					_justPlayersTemp deleteAt _index;
				};
			} forEach _loot_players;
			   
				_loot_players = _justPlayersTemp;	
				
			}
			else {
				_loot_players = _justPlayers;
				
				};
	
			{
				true
			} count _loot_players;
			sleep 3;
			if (count(_loot_players) > 0) then {_sleepTime = 0};
			
			// Bandit Spawning				 
			if (_squadLimitPerPlayer * (count (allPlayers - entities "HeadlessClient_F")) > _currentSquads) then {
	
				diag_log "Spawning Squad";				
				 
					_spawnPosition = [getPos _x,500,1000,2,false] call JA_MISSIONGEN_fnc_findsafepos;
					//_spawnPosition = [_x,25,false] call JA_MISSIONGEN_fnc_randomizePos;

					_nearestLocations = nearestLocations [player, ["Name","NameCity","NameCityCapital","NameVillage"], 2000];
					//Check if position is in Safe/No Loot Areas
					private _isInArea = false;	  
					{
						if ((_spawnPosition inArea _x)isEqualto true) then {_isInArea = true;};
					}forEach _trigger_array; 
	
					if ((_isInArea)isEqualto false) then 
					{
						private _banditGroup = createGroup EAST;
						for "_i" from 1 to (random 12) do {
							_spawnPosRandom = [_spawnPosition,25,false] call JA_MISSIONGEN_fnc_randomizePos;
							_squadUnits pushBack "CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer";
							private _unit = _banditGroup createUnit ["CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer", _spawnPosRandom,[],0,"FORM"];	 
							[_unit] call HG_fnc_aiUnitSetup;
						};
						_banditGroup setFormation "DIAMOND";
						_banditGroup setCombatMode "RED";
						_banditGroups pushBack _banditGroup;
						_banditGroup deleteGroupWhenEmpty  true;
						switch (floor random 5) do {
						
							case 0: {[_banditGroup, (selectRandom _nearestLocations), 1000,4,[],true,true] call lambs_wp_fnc_taskPatrol};
							case 1: {[_banditGroup, (selectRandom _nearestLocations), 100,[],false] call lambs_wp_fnc_taskCamp};
							case 2: {[_banditGroup, (selectRandom _nearestLocations), 75,[],false,true,-1,false] call lambs_wp_fnc_taskgarrison};
							case 3: {[_banditGroup, 2000,15,[],getPos (selectRandom _nearestLocations),false] spawn lambs_wp_fnc_taskRush};
							case 4: {[_banditGroup, 2000,15,[],[],false,true,(dayTime > 15.30) or (dayTime < 7)] spawn lambs_wp_fnc_taskHunt};
						};
						_currentSquads = _currentSquads + 1;
					};
	 
				
			};
			
			//Zombie Spawning
			if (_zombieHordeLimitPerPlayer * (count (allPlayers - entities "HeadlessClient_F")) > _currentHorde) then {
	
				diag_log "Spawning Horde";				
				 
				_spawnPosition = [getPos _x,500,1000,15,false] call JA_MISSIONGEN_fnc_findsafepos;
				_nearestLocations = nearestLocations [player, ["Name","NameCity","NameCityCapital","NameVillage"], 2000];
				//Check if position is in Safe/No Loot Areas
				private _isInArea = false;	  
				{
					if ((_spawnPosition inArea _x)isEqualto true) then {_isInArea = true;};
				}forEach _trigger_array; 

				if ((_isInArea)isEqualto false) then 
				{
					private _selectedZombie = "";
					if (dayTime > (_timeForFastZs select 0) or dayTime < (_timeForFastZs select 1)) then {_selectedZombie = selectRandom _zombieClassesNight} else {_selectedZombie = selectRandom _zombieClassesDay}; 
											
					private _zombieGroup = createGroup resistance;
					for "_i" from 1 to (random 35) do {
						if ((1 > random 100 && (dayTime > (_timeForFastZs select 0) or dayTime < (_timeForFastZs select 1)))) then {_selectedZombie = "RyanZombieboss1"};
						_spawnPosRandom = [_spawnPosition,50,false] call JA_MISSIONGEN_fnc_randomizePos;	 
						private _unit = _zombieGroup createUnit [_selectedZombie, _spawnPosRandom,[],0,"FORM"];
						_unit setUnitPos "UP";							
						_zombieUnits pushBack _unit;
						_unit setVariable ["lambs_danger_disableAI", true];
																	
					};
				
					sleep 1;
					_zombieGroup setVariable ["lambs_danger_disableGroupAI", true];
					switch (floor random 2) do {
						case 0: {[_zombieGroup, (selectRandom _nearestLocations), 1000,4,[],true,true] call lambs_wp_fnc_taskPatrol}; 
						case 1: {;[_zombieGroup, getPos (selectRandom _nearestLocations)] call BIS_fnc_taskAttack};
					};
					_zombieGroup setBehaviourStrong  "CARELESS";
					_zombieGroups pushBack _zombieGroup;
					_zombieGroup setFormation "DIAMOND";
					_zombieGroup setCombatMode "RED";
					_zombieGroup deleteGroupWhenEmpty  true;
					_currentHorde = _currentHorde + 1;
				};
					
					
			};
		};
	sleep _sleepTime;
	sleep (((_currentHorde max _currentSquads)max 1)*10);
	true
	} count _loot_players;
	};
diag_log "Finished Spawning Squads";
};