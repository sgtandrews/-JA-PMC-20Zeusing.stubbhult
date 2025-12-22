/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_assignKillMission

Description:
    Assigns Player/Group a Kill Mission

Parameters:
    _caller   - The player calling it
    _faction  - Faction of The Target
	_missionGiver = The Object giving the mission

Returns:
	None

Examples:
    (begin example)
        [_caller, _faction, _missionGiver] call JA_MISSIONGEN_fnc_assignKillMission;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params ["_caller","_faction","_missionGiver"];

_caller = _this select 0;
_faction = _this select 1;
_missionGiver = _this select 2;


_nearestCitys = nearestLocations [getPosATL _caller, ["NameCity","NameVillage"], 3000];
private _hasLeftCamp = false;
private _composition = [];

profileNamespace setVariable ["killHelperMarkersHints",[]];
_LocationsPOS = [];
_taskDescription = selectRandom ["STR_TFA_DESCRIP_MISSION_KILL_TARGET","STR_TFA_DESCRIP_MISSION_KILL_TARGET2","STR_TFA_DESCRIP_MISSION_KILL_TARGET3","STR_TFA_DESCRIP_MISSION_KILL_TARGET4","STR_TFA_DESCRIP_MISSION_KILL_TARGET5","STR_TFA_DESCRIP_MISSION_KILL_TARGET6","STR_TFA_DESCRIP_MISSION_KILL_TARGET7","STR_TFA_DESCRIP_MISSION_KILL_TARGET8"];
_sleepingBags = ["Land_rhs_matress_flat","Land_Sleeping_bag_brown_F","Land_SleepingBag","Land_Cyt_SleepingBag_B","Land_Cyt_SleepingBag_A"];
_trashObjects = ["Land_Garbage_square5_F","Land_Garbage_square3_F","Land_Garbage_line_F"];
_helperTrash = selectRandom _trashObjects;
_breadCrumbList = ["MedicalGarbage_01_1x1_v1_F","MedicalGarbage_01_1x1_v3_F","MedicalGarbage_01_1x1_v2_F","MedicalGarbage_01_Bandage_F","MedicalGarbage_01_FirstAidKit_F","MedicalGarbage_01_Gloves_F","MedicalGarbage_01_Injector_F","MedicalGarbage_01_Packaging_F","BloodPool_01_Large_New_F","BloodPool_01_Medium_New_F","BloodSplatter_01_Large_New_F","BloodSplatter_01_Medium_New_F","BloodSplatter_01_Small_New_F","BloodSpray_01_New_F"];
_campFireList = ["Land_Campfire","Land_Campfire_burning","Fire","FireLit","Land_Fire","Land_Fire_burning"];
_tentsList = ["Land_TentA_F","Land_TentDome_F","Land_TentSolar_01_bluewhite_F","Land_TentSolar_01_olive_F","Land_TentSolar_01_redwhite_F","Land_TentSolar_01_sand_F","eo_dome_tent_blu","eo_dome_tent_gry","eo_dome_tent_grn"];
_foilageAndTrees = ["CUP_b_PinusM1s_EP1", "CUP_DD_borovice", "CUP_DD_borovice02", "CUP_t_pinusN1s", "CUP_t_pinusS2f", "CUP_t_pinusN2s", "CUP_t_PinusE2s_EP1", "CUP_t_PinusS3s_EP1", "CUP_Smrk_velky", "CUP_Smrk_maly", "CUP_les_singlestrom", "CUP_les_singlestrom_b", "CUP_parez"];
_CampLocations = ["Mount","Hill","RockArea"];

_composition_trail = [["Land_Garbage_square3_F",0.0175363,[0.238281,-0.379883,0.00983906]],["MedicalGarbage_01_Gloves_F",0.0138911,[0.330078,0.300781,0.00741005]],["MedicalGarbage_01_1x1_v2_F",240.174,[0.819336,-0.562988,0.0313606]],["MedicalGarbage_01_Packaging_F",0.0120268,[-0.333008,-0.770996,-0.00609493]],["MedicalGarbage_01_Bandage_F",189.484,[1.12109,0.380859,0.0318489]],["MedicalGarbage_01_1x1_v3_F",275.179,[-0.704102,-0.563477,-0.0214443]],["MedicalGarbage_01_FirstAidKit_F",189.938,[0.445312,-1.24414,0.0259485]],["MedicalGarbage_01_1x1_v1_F",0.0177751,[-0.24707,-1.229,0.00235081]],["BloodPool_01_Large_New_F",233.713,[-0.313477,1.04785,-0.0230532]],["MedicalGarbage_01_Injector_F",0.0120268,[-0.714844,1.08447,-0.0377874]]];
_composition_camp = [["Land_CamoNetVar_EAST",71.5305,[1.0752,1.34814,-0.0291166]],[(selectRandom _tentsList),76.1925,[-0.832031,-2.52197,0.0249362]],[(selectRandom _tentsList),94.496,[2.42676,0.880859,-0.0141063]],["inv_garrison_point",104.195,[1.03418,-0.987305,0.00646639]],["Land_Cyt_Chemlight_Green_01_A",94.4959,[0.74707,0.777832,-0.0212407]],["Land_Cyt_Chemlight_Green_01_A",200.079,[-1.47754,-0.685059,0.00638723]],[(selectRandom _campFireList),94.4954,[-1.81543,1.55615,-0.0257039]],[(selectRandom _foilageAndTrees),175.763,[-5.65137,-4.98535,0.0404167]],["inv_garrison_point",104.806,[0.452148,2.84033,-0.031178]],["CBA_BuildingPos",104.088,[2.27148,-2.02686,0.0160146]],[(selectRandom _foilageAndTrees),230.942,[-5.81836,-0.227051,0.00114155]],["inv_garrison_point",12.6539,[-3.27344,-1.76074,-0.00621128]],["inv_garrison_point",104.258,[-3.77441,0.358398,-0.00512171]],["Land_Cyt_Chemlight_Green_01_A",106.056,[-1.94824,3.59131,0.120714]],["Land_Cyt_Chemlight_Green_01_A",94.4953,[1.89941,-3.49658,0.029676]],["Land_TablePlastic_01_F",77.9921,[2.2998,4.10352,0.000595093]],["inv_garrison_point",17.5429,[2.91309,2.91846,0.0021081]],[(selectRandom _tentsList),34.5185,[-0.746094,5.31836,-0.0604172]],["Land_ChairPlastic_F",164.074,[3.55762,4.0874,0.00269604]],["inv_garrison_point",12.6538,[-3.7832,2.87988,-0.0100732]],["Land_Cyt_Chemlight_Green_01_A",94.4957,[5.04199,0.136719,-0.0113678]],["Land_ChairPlastic_F",40.6446,[1.34375,5.58887,-0.00208521]],["inv_garrison_point",67.358,[4.21582,3.15039,0.00348568]],["CUP_Krovi_long",1.73058,[-0.852539,-6.32275,0.0586863]],["inv_garrison_point",17.5428,[-5.42285,-2.53955,-0.0112572]],[(selectRandom _foilageAndTrees),67.8075,[6.5918,-6.70117,0.0462337]],["Land_Cyt_Chemlight_Green_01_A",94.4957,[5.33984,-2.85791,0.018991]],[(selectRandom _foilageAndTrees),94.4953,[-0.763672,-7.58447,0.0592475]],["inv_garrison_point",17.5428,[-5.91309,3.23096,-0.0162106]],[(selectRandom _foilageAndTrees),70.0065,[3.09863,-7.7583,0.0573716]],["CUP_Krovi_long",315.176,[-3.70117,6.70752,-0.0555058]],["CUP_Krovi_long",135.991,[5.6123,-5.38525,0.0126348]],["inv_garrison_point",67.358,[3.41797,6.31104,0.00144148]],[(selectRandom _foilageAndTrees),249.755,[-3.05078,-8.12646,0.0633636]],[(selectRandom _foilageAndTrees),340.171,[-2.18359,10.0054,-0.109958]],[(selectRandom _foilageAndTrees),193.244,[6.82812,5.96387,-0.0733719]],[(selectRandom _foilageAndTrees),251.528,[-7.97266,-5.5752,0.0378928]],[(selectRandom _foilageAndTrees),345.924,[0.772461,-9.96533,0.0748658]],["CUP_Krovi_long",1.73061,[0.9375,9.12402,-0.0901489]],[(selectRandom _foilageAndTrees),249.757,[9.91211,-0.328125,-0.0189257]],[(selectRandom _foilageAndTrees),123.989,[10.5312,-3.20215,0.0113149]],[(selectRandom _foilageAndTrees),300.766,[-5.71289,9.64453,-0.110634]],[(selectRandom _foilageAndTrees),340.169,[12.0254,1.54883,-0.0443616]],["FxWindGrass2",196.407,[10.5137,1.17969,0.223577]],[(selectRandom _foilageAndTrees),104.863,[-11.1494,3.8125,-0.0511198]],[(selectRandom _foilageAndTrees),202.958,[6.01172,11.3701,-0.113171]],[(selectRandom _foilageAndTrees),357.836,[-2.47754,12.1108,-0.120607]],[(selectRandom _foilageAndTrees),249.755,[-0.676758,12.4229,-0.121876]],["FxWindGrass2",87.141,[12.457,-1.85352,0.304946]],[(selectRandom _foilageAndTrees),95.1989,[12.4678,5.27393,-0.0805364]],[(selectRandom _foilageAndTrees),122.616,[11.0635,12.3882,-0.118315]]];
_composition_camp2 = [[(selectRandom _campFireList),160.718,[0,0,0]],["babe_helper",128.484,[-0.00976562,-0.370117,5.72205e-06]],["BW_roadway_obj",160.718,[-0.00976562,-0.370117,5.72205e-06]],["Land_WoodenLog_F",24.1375,[-0.771484,-2.02588,5.43594e-05]],["Land_WoodenLog_F",82.0348,[-2.17578,-0.26123,6.48499e-05]],["FxWindLeaf1",285.193,[-1.7998,-2.02246,0.392315]],["inv_garrison_point",160.718,[-0.467773,-1.30176,2.76566e-05]],["Land_WoodenLog_F",339.293,[1.06055,-2.11133,6.67572e-06]],["inv_garrison_point",160.718,[-1.41602,-0.499512,4.1008e-05]],["Land_WoodenLog_F",157.264,[-0.6875,2.33643,-1.90735e-06]],["inv_garrison_point",160.718,[1.35645,-1.08594,-2.09808e-05]],["inv_garrison_point",160.718,[-1.51465,0.911621,2.57492e-05]],["inv_garrison_point",160.718,[1.69043,0.588379,-5.05447e-05]],["Land_WoodenLog_F",118.045,[-2.24219,1.36328,4.95911e-05]],["Land_Sleeping_bag_blue_folded_F",179.363,[-2.14062,0.121094,0.00023365]],["inv_garrison_point",160.718,[0.392578,2.02344,-3.52859e-05]],["inv_garrison_point",160.718,[-1.69141,-1.20459,5.72205e-05]],["inv_garrison_point",160.718,[0.106445,-2.15576,2.28882e-05]],["inv_garrison_point",160.718,[-1.49316,1.96631,1.33514e-05]],[_helperTrash,155.929,[2.67871,0.325195,-7.72476e-05]],[(selectRandom _sleepingBags),210.189,[2.45898,-1.03418,-3.71933e-05]],["Land_Ground_sheet_folded_yellow_F",160.416,[1.89648,2.27148,-6.19888e-05]],[(selectRandom _sleepingBags),147.827,[2.52344,1.33447,-9.34601e-05]],["inv_garrison_point",104.296,[1.17871,2.771,-7.53403e-05]]];
_campComps = []; 
_campComps pushBack  _composition_camp;
_campComps pushBack  _composition_camp2;

{
	_cityToPos = locationPosition _x;
	_LocationsPOS pushBack _cityToPos;
	 
}forEach _nearestCitys;

_nearestPossibleSpawns = nearestLocations [(selectRandom _LocationsPOS), ["Mount","RockArea"], 500];
{
	_cityToPos = locationPosition _x;
	_LocationsPOS pushBack _cityToPos;
	 
}forEach _nearestPossibleSpawns;


private _selectedLocationPOS = selectRandom _LocationsPOS;

_m_pos = [_selectedLocationPOS,1000] call JA_MISSIONGEN_fnc_randomizePos;
//systemChat (str _m_pos);
private _searchRadius = 1000;
private _spawnPosition= [([[[_m_pos,_searchRadius]], [JA_safezone_ShootingRange,mapBoundariesEast,mapBoundariesWest,mapBoundariesSouth,mapBoundariesNorth,"water"]] call BIS_fnc_randomPos), 0, 100, 0, false] call JA_MISSIONGEN_fnc_findsafepos;
//systemChat (str _spawnPosition);
//_debugMarker = createMarkerLocal [format["%1-%2",_spawnPosition,_caller],_spawnPosition];
//_debugMarker setMarkerColorLocal "ColorEAST";
//_debugMarker setMarkerTypeLocal "Contact_pencilCircle3";
while {(_spawnPosition isEqualTo  [0,0,0])} do {
	_searchRadius = _searchRadius + (_searchRadius / 2);
	_spawnPosition= [([[[_m_pos,_searchRadius]], [JA_safezone_ShootingRange,mapBoundariesEast,mapBoundariesWest,mapBoundariesSouth,mapBoundariesNorth,"water"]] call BIS_fnc_randomPos), 0, 100, 0, false] call JA_MISSIONGEN_fnc_findsafepos;
	//systemChat (str _spawnPosition);
	//_debugMarker = createMarkerLocal [format["%1-%2",_spawnPosition,_caller],_spawnPosition];
	//_debugMarker setMarkerColorLocal "ColorEAST";
	//_debugMarker setMarkerTypeLocal "Contact_pencilCircle3";
	};
_nearestCityName = _spawnPosition call BIS_fnc_locationDescription;
sleep 1;
private _targets = [_spawnPosition,"EAST",[1,6],true] call JA_MISSIONGEN_fnc_spawnSquad;

//sleep 10;
private _group = group (_targets select 0);
private _moneyReward = (count _targets) * 2000;
//systemChat (str _group);
private _unitLeader = objNull;
_unitLeader = (leader _group);
private _isBugged = false;
try {if (isNull _unitLeader) throw "_unitLeader is nil";} catch {systemChat "_unitLeader is nil"; systemChat str(_targets);systemChat str(_group); _isBugged = true;}; 
if (_isBugged) exitWith {

	[_missionGiver]remoteExec["JA_MISSIONGEN_fnc_addKillMissionAction",_caller];
};
//systemChat (str _unitLeader);
private _leaderName = [_unitLeader] call BIS_fnc_getName;
//systemChat _leaderName;


/*
_campMarker = createMarkerLocal [format["%1",_leaderName],visiblePosition _unitLeader];
_campMarker setMarkerColorLocal "ColorEAST";
_campMarker setMarkerTypeLocal "Contact_pencilCircle3";
_campMarker setMarkerTextLocal format["%1 - [Last seen %2]",(_leaderName),if(!isNull objectParent _unitLeader) then {"IN A VEHICLE"} else {"ON FOOT"}];
*/
_campMarker = "";

//_campMarker = [_caller,_leaderName,_unitLeader] call JA_MISSIONGEN_fnc_killMarker;


private _helperObjs = [];
private _helperObjsStart = [];
private _helperObjsCrumbs = [];
if (floor (random 2) == 1) then {
	_debugWP = "Camp";
	{ _x hideObjectGlobal true } foreach (nearestTerrainObjects [_spawnPosition,[],20]);
	if (type (nearestLocation [getPos _unitLeader,""]) in _CampLocations && (((nearestTerrainObjects [player, ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"], 2000]) select 0) distance _unitLeader >= 100)) then {
		if (((count (nearestTerrainObjects [_unitLeader,["Tree", "Bush"], 20])) < 5)) then {_foilageAndTrees = ["Land_HelipadEmpty_F"];};
		
		_composition = [_spawnPosition, random 360, selectRandom _campComps] call JA_World_fnc_createComposition;
	} else {

		_composition = [_spawnPosition, random 360,  _composition_trail] call JA_World_fnc_createComposition;
	};

	
	[_group, (_spawnPosition), 10,[50],true,true] call lambs_wp_fnc_taskCamp;
	
} else {
	[_group, _group, 400] call lambs_wp_fnc_taskPatrol; 
	_hasLeftCamp = true;
	{ _x hideObjectGlobal true } foreach (nearestTerrainObjects [_spawnPosition,[],20]);
	//sleep 3;
	if (type (nearestLocation [getPos _unitLeader,""]) in _CampLocations && (((nearestTerrainObjects [player, ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"], 2000]) select 0) distance _unitLeader >= 100)) then {
		if (((count (nearestTerrainObjects [_unitLeader,["Tree", "Bush"], 20])) < 5)) then {_foilageAndTrees = ["Land_HelipadEmpty_F"];};

		_composition = [_spawnPosition, random 360, selectRandom _campComps] call JA_World_fnc_createComposition;
	} else {

		_composition = [_spawnPosition, random 360,  _composition_trail] call JA_World_fnc_createComposition;
	};
	// Limit amount of Helper Objs
	_helperTrash = createVehicle [(selectRandom _trashObjects) , ([_spawnPosition,5,15,5,false] call JA_MISSIONGEN_fnc_findsafepos), [], 0, "CAN_COLLIDE"];
	_helperCutter = createVehicle ["ClutterCutter_small_2_EP1", _helperTrash,[],0,"NONE"];
	_helperArrow = createVehicle ["Sign_arrow_down_EP1", _helperTrash,[],0,"NONE"];
	_helperObjsStart pushBackUnique _helperTrash;
	_helperObjsStart pushBackUnique _helperCutter;
	_helperObjsStart pushBackUnique _helperArrow;
	[_helperArrow,_unitLeader]remoteExec["JA_MISSIONGEN_fnc_hintAction",_caller];
	/*
	_action = ["Get_CardDir", localize "STR_TFA_TRACKING_TARGET_TIP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {
		[JA_MISSIONGEN_fnc_getTargetDirection, [_target,_unitLeader,true]] call CBA_fnc_execNextFrame;
	}, {alive _unitLeader},{},[_unitLeader]] call ace_interact_menu_fnc_createAction;

	[_helperArrow, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	*/
	};
	
[_caller,_leaderName,_unitLeader]remoteExec["JA_MISSIONGEN_fnc_killMarker",_caller];
[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Killer</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Target: %1</t><br/>",_leaderName],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Location: %1</t><br/>",_nearestCityName],0.4,4,2]] remoteExec["BIS_fnc_EXP_camp_SITREP",_caller];
//[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Killer</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Target: %1</t><br/>",_leaderName],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Location: %1</t><br/>",_nearestCityName],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;

format ["%1,%2",_leaderName,_nearestCityName];
_taskID = [_caller,_leaderName,_missionGiver] joinString "-";
//playSoundUI ["PDA_guide"];
[["PDA_guide"]]remoteExec ["playSoundUI",_caller];





/*
[_caller, 
_taskID,
[ 
 [_taskDescription,_leaderName,_nearestCityName],["STR_TFA_TITLE_MISSION_KILL_TARGET",_leaderName,_nearestCityName],""
],
objNull, 
"ASSIGNED", 
-1, false, 
"KILL", 
false
] call BIS_fnc_taskCreate;
*/

[_caller, 
_taskID,
[ 
 [_taskDescription,_leaderName,_nearestCityName],["STR_TFA_TITLE_MISSION_KILL_TARGET",_leaderName,_nearestCityName],""
],
objNull, 
"ASSIGNED", 
-1, false, 
"KILL", 
false
]remoteExec["BIS_fnc_taskCreate",_caller];

// Seperate into seperate Functions bellow

[_unitLeader,_leaderName,_missionGiver,_campMarker,_taskID,_moneyReward,_caller,_hasLeftCamp,_spawnPosition,_composition,_helperObjs,_trashObjects,_breadCrumbList,_group,_helperObjsCrumbs,_helperObjsStart] spawn {
	
	_unitLeader = _this select 0;
	_leaderName = _this select 1; 
	_moneyReward = _this select 5;
	_caller = _this select 6;
	_hasLeftCamp = _this select 7;
	_spawnPosition = _this select 8;
	_composition = _this select 9;
	_helperObjs = _this select 10;
	_trashObjects = _this select 11;
	_breadCrumbList = _this select 12;
	_group = _this select 13;
	_helperObjsCrumbs = _this select 14;
	_helperObjsStart = _this select 15;
	if (_hasLeftCamp) then {
		while {sleep 9; alive (_this select 0)} do {
			if (not alive(_this select 0)) then {continue};
			if (count(_helperObjs) >= 18) then {
				private _deletedHelpers = [];
				for "_i" from 0 to 2 do {
					_deletedHelpers pushBack (_helperObjs select _i);
				};
				{
					deleteVehicle _x;
				}forEach _deletedHelpers;
				_helperObjs deleteAt [0,2];
			};
			uiSleep 20; 
			_helperTrash = createVehicle [(selectRandom _trashObjects) , _unitLeader, [], 0, "CAN_COLLIDE"];
			_helperCutter = createVehicle ["ClutterCutter_small_2_EP1", _helperTrash,[],0,"CAN_COLLIDE"];
			_helperArrow = createVehicle ["Sign_arrow_down_EP1", _helperTrash,[],0,"CAN_COLLIDE"];
			_helperObjs pushBackUnique _helperTrash;
			_helperObjs pushBackUnique _helperCutter;
			_helperObjs pushBackUnique _helperArrow;

			[_helperArrow,_unitLeader]remoteExec["JA_MISSIONGEN_fnc_hintAction",_caller];
			/*
			_action = ["Get_CardDir", localize "STR_TFA_TRACKING_TARGET_TIP", "\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa", {
				[JA_MISSIONGEN_fnc_getTargetDirection, [_target,_unitLeader,true]] call CBA_fnc_execNextFrame;
			}, {alive _unitLeader},{},[_unitLeader]] call ace_interact_menu_fnc_createAction;

			[_helperArrow, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
			*/
			uiSleep 10;
			if (count(_helperObjsCrumbs) >= 6) then {
				private _deletedCrumbs = _helperObjsCrumbs select 0;
				deleteVehicle _deletedCrumbs;
				_helperObjsCrumbs deleteAt [0];
				
			};
			_helperCrumb = createVehicle [(selectRandom _breadCrumbList), _unitLeader,[],0,"CAN_COLLIDE"];
			_helperObjsCrumbs pushBackUnique _helperCrumb;
			if (not alive(_this select 0)) then {continue};
			uiSleep 30;

		};
	};
	
	waitUntil {sleep 9; not alive _unitLeader};
	//playSoundUI ["PDA_beep_2"];
	[["PDA_beep_2"]]remoteExec ["playSoundUI",_caller];
	[(_moneyReward / 200),0] remoteExecCall ["HG_fnc_addOrSubXP",_caller,false];
	[_moneyReward,0,1] remoteExecCall ["HG_fnc_addOrSubCash",_caller,false];
	//[_caller, _moneyReward] call HALs_money_fnc_addFunds;
	[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Fulfilled</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Target: %1 Elimiated</t><br/>",_leaderName],0.4,1],[format["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Recieved: %1 rubles</t><br/>",_moneyReward],0.4,4,2]] remoteExec["BIS_fnc_EXP_camp_SITREP",_caller];
	//[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Fulfilled</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Target: %1 Elimiated</t><br/>",_leaderName],0.4,1],[format["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Recieved: %1 rubles</t><br/>",_moneyReward],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP; 
	sleep 3;
	//[(_this select 4), "SUCCEEDED", true] call BIS_fnc_taskSetState;
	[(_this select 4), "SUCCEEDED", false]remoteExec["BIS_fnc_taskSetState",_caller];
	[(_this select 4),_caller]remoteExec["BIS_fnc_deleteTask",_caller];
	//[(_this select 4),_caller] call BIS_fnc_deleteTask;
	//deleteMarkerLocal (_this select 3);
	//[_this select 2] call JA_MISSIONGEN_fnc_addKillMissionAction;
	[_this select 2]remoteExec["JA_MISSIONGEN_fnc_addKillMissionAction",_caller];
	{
		deleteVehicle _x
	}forEach _helperObjs;
	{
		deleteVehicle _x
	}forEach _helperObjsCrumbs;

	{
		deleteVehicle _x
	}forEach _helperObjsStart;
	
	
	deleteGroup  _group;
	[_spawnPosition,_composition,_caller] spawn {
		_spawnPosition = _this select 0;
		_composition = _this select 1;
		_caller = _this select 2;
		
		private _killHelperMarkersHints = profileNamespace getVariable ["killHelperMarkersHints",0];
		{
		deleteMarkerLocal _x;

		}forEach _killHelperMarkersHints;
		profileNamespace setVariable ["killHelperMarkersHints",_killHelperMarkersHints];

		[_caller]remoteExec["JA_MISSIONGEN_fnc_deleteKillMarker",_caller];
		waitUntil {sleep 10; _nearestPlayer=([allPlayers,[],{_spawnPosition distance _x},"ASCEND"]call BIS_fnc_sortBy)select 0;_nearestPlayer distance _spawnPosition >= 1000;};
		sleep 3;
		//systemChat "Deleting Camp";
		[_spawnPosition,_composition,true,20]remoteExec["JA_MISSIONGEN_fnc_delComp",2];
	};
	
_unitLeader = nil;
};
















