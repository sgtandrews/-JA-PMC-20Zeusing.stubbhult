
[] execVM "HALs\Addons\store\data\storeWarehouse.sqf";
// Wrecks and Random Vehicles 
if (!isMultiplayer) then {
    // Will run before initPlayerLocal.sqf and initServer.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };
};
/*
if (!isServer) then {
	player addRating -9999;
};
*/
//enableSaving [false, false];


//EOS SYSTEM
//[]execVM "eos\OpenMe.sqf";

//Briefing 
BoundaryTriggers = []call JA_GENERAL_fnc_createMapBoundaries;

JA_SafeAreaZones = compileFinal preprocessFileLineNumbers "core\triggers\safeAreaZones.sqf";


[{!isNull player},{

	// Add Actions 
	[] call JA_GENERAL_fnc_addActions;

}] call CBA_fnc_waitUntilAndExecute;

//Random Weather Script  

//[] execVM "setRandomWeather.sqf";

ufo_started = false;

NOVA_FNC_UFOS = {
  if (!ufo_started) then {
    ufo_started = true;
    player sideChat "Starting UFO Encounter";
    [30] execvm "world\scripts\aliens\Nova_UFO\ufo_encounter_cross.sqf";
    player sideChat "Starting Seeker";
    [40] execvm "world\scripts\aliens\Nova_UFO\ufo_encounter_seek.sqf";
  };
};

[] spawn
{
    waitUntil {player inArea "ufoarea1"};
    [] remoteExec ["NOVA_FNC_UFOS", 0, true];
};


// Medical Case Medical Facility ( Eden placed only ) 
["CaseMeds", "InitPost", {
    params ["_vehicle"];
    _vehicle setVariable ["ace_medical_isMedicalFacility", true];
}, nil, nil, true] call CBA_fnc_addClassEventHandler;

grantUnlimitedAmmo = compile preprocessFileLineNumbers "unlimitedAIAmmo.sqf";


/*
//Eden Placed Buildings marked on map  

if (isServer) then {

////Find marker and get the size

_mkr= "BuildingMarker";
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
_x enableSimulation false;

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
};
*/

/*This is for the demo mission
if (!isDedicated) then {
	// Give the player 10,000 starting money
	[player, 1000] call HALs_money_fnc_addFunds;
};
*/ 
/* private _trader1 = trader1;
if (isServer) then {
	[_trader1, "weapon1"] call HALs_store_fnc_addTrader; 
	
	_trader1 enableSimulationGlobal false; 
	_trader1 allowDamage false;   

	//[_trader1, "LEAN_ON_TABLE", "ASIS", pointer] remoteExecCall ["BIS_fnc_ambientAnim", 0, true];
};

private _trader2 = trader2;
if (isServer) then {
	[_trader2, "medical1"] call HALs_store_fnc_addTrader; 
	_trader2 enableSimulationGlobal false; 
	_trader2 allowDamage false;
	_trader2 setCaptive true;
	

	//[_trader2, "GUARD", "ASIS"] remoteExecCall ["BIS_fnc_ambientAnim", 0, true];
};

_allTraders = [];


private _weapons_traderlvl1 = weapons_traderlvl1;
_allTraders pushBack weapons_traderlvl1;
if (isServer) then {
	[_weapons_traderlvl1, "weapon1"] call HALs_store_fnc_addTrader; 
	
	//_weapons_traderlvl1 enableSimulationGlobal false; 
	_weapons_traderlvl1 allowDamage false;  
	_weapons_traderlvl1 setCaptive true; 

	//[_weapons_traderlvl1, "LEAN_ON_TABLE", "ASIS", pointer] remoteExecCall ["BIS_fnc_ambientAnim", 0, true];
};

private _medical_traderlvl1 = medical_traderlvl1;
_allTraders pushBack medical_traderlvl1;
if (isServer) then {
	[_medical_traderlvl1, "medical1"] call HALs_store_fnc_addTrader; 
	//_medical_traderlvl1 enableSimulationGlobal false; 
	_medical_traderlvl1 allowDamage false;
	_medical_traderlvl1 setCaptive true;
};

private _food_traderlvl1 = food_traderlvl1;
_allTraders pushBack food_traderlvl1;
if (isServer) then {
	[_food_traderlvl1, "food1"] call HALs_store_fnc_addTrader; 
	//_food_traderlvl1 enableSimulationGlobal false; 
	_food_traderlvl1 allowDamage false;
	_food_traderlvl1 setCaptive true;
};

private _equipment_traderlvl1 = equipment_traderlvl1;
_allTraders pushBack equipment_traderlvl1;
if (isServer) then {
	[_equipment_traderlvl1, "equipment1"] call HALs_store_fnc_addTrader; 
	//_equipment_traderlvl1 enableSimulationGlobal true; 
	_equipment_traderlvl1 allowDamage false;
	_equipment_traderlvl1 setCaptive true;
};

private _mechanic_traderlvl1 = mechanic_traderlvl1;
_allTraders pushBack mechanic_traderlvl1;
if (isServer) then {
	[_mechanic_traderlvl1, "mechanic1"] call HALs_store_fnc_addTrader; 
	//_mechanic_traderlvl1 enableSimulationGlobal false; 
	_mechanic_traderlvl1 allowDamage false;
	_mechanic_traderlvl1 setCaptive true;
};

missionNamespace setVariable ["allTraders", _allTraders];


//_allTraders [weapons_traderlvl1,medical_traderlvl1,food_traderlvl1,equipment_traderlvl1,mechanic_traderlvl1]

_allTraderItems = [];
HALs_item_price = [];
HALs_category_items = [];
private _categories = [];
{
	private _categoriesTemp = getArray (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "stores" >> _x getVariable ["HALs_store_trader_type", ""] >> "categories");
	 _categories append _categoriesTemp;	
}forEach _allTraders; 

// _categories ["handguns1","mainarms1","magazines1","attachments1","grenades1","medical1","food1","uniforms1","vests1","bags1","headgear1","facewear1","tools1","toolthrowables1"]

{
	//private _categoryItems = "true" configClasses (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x) apply {[configName _x, getNumber (_x >> "price") max 0]};
	_categoryItems = [];
		if (isNil {missionNamespace getVariable _x select 0}) then {
				_categoryItems = "true" configClasses (missionConfigFile >> "cfgHALsAddons" >> "cfgHALsStore" >> "categories" >> _x) apply {[configName _x, getNumber (_x >> "price") max 0]};
			} 
			else 
			{ 
				_categoryItems = missionNamespace getVariable _x select 0;
				
			};
  //[HALs_store_category_allTraderItems, handguns1, _categoryItems apply {_x select 0}] call HALs_store_fnc_hashSet;	
	[HALs_store_category_allTraderItems, _x, _categoryItems apply {_x select 0}] call HALs_store_fnc_hashSet;
	
	{
	  //[HALs_item_price, "ACE_HandFlare_Green", 1500] call HALs_store_fnc_hashSet
		[HALs_item_price, _x select 0, _x select 1] call HALs_store_fnc_hashSet
		
	} forEach _categoryItems;
				
	_allTraderItems append _categoryItems;
} forEach _categories;

// _allTraderItems - [["CUP_hgun_Colt1911",8100],["rhs_weap_tt33",9200],["rhs_weap_makarov_pm",4600],["rhs_weap_pb_6p9",5200],["rhs_weap_savz61_folded",14000],["rhs_weap_6p53",4900],["rhs_weap_cz99",5100],["hgun_P07_blk_F",5000],["rhsusf_weap_m9",7000],["uk3cb_ppsh41",21000],["uk3cb_sks_01",18000],["UK3CB_MP5A2",19000],["CUP_sgun_slamfire",7500],["sgun_HunterShotgun_01_sawedoff_F",12000],["sgun_HunterShotgun_01_F",15000],["CUP_srifle_Mosin_Nagant",18000],["UK3CB_CZ550",20000],["rhs_weap_m38",16000],["rhs_weap_m3a1",16500],["rhs_weap_MP44",21000],["rhs_weap_scorpion",14000],["rhs_weap_aks74u",26000],["rhsusf_mag_7x45acp_MHP",410],["CUP_8Rnd_762x25_TT",488],["rhs_mag_9x18_8_57N181S",432],["rhsgref_20rnd_765x17_vz61",1260],["rhs_18rnd_9x21mm_7BT3",990],["rhssaf_mag_15Rnd_9x19_FMJ",818],["16Rnd_9x21_green_Mag",880],["UK3CB_MP5_30Rnd_9x19_Magazine",1635],["UK3CB_MP5_30Rnd_9x19_Magazine_G",1635],["uk3cb_PPSH_71rnd_magazine",4331],["rhsgref_30rnd_1143x23_M1T_SMG",1755],["rhs_30Rnd_545x39_7N6M_AK",2430],["rhs_30Rnd_545x39_AK_green",2430],["rhsgref_30Rnd_792x33_SmE_StG",2280],["CUP_1Rnd_12Gauge_Pellets_No00_Buck",48],["CUP_1Rnd_12Gauge_Slug",52],["CUP_2Rnd_12Gauge_Pellets_No00_Buck",96],["CUP_2Rnd_12Gauge_Pellets_No4_Bird",96],["CUP_2Rnd_12Gauge_Slug",104],["UK3CB_CZ550_5rnd_Mag",510],["UK3CB_CZ550_5rnd_Mag_G",510],["rhsgref_5Rnd_762x54_m38",470],["rhsgref_10Rnd_792x57_m76",980],["rhs_acc_6p9_suppressor",1500],["CUP_optic_PEM",2500],["muzzle_snds_acp",1600],["uk3cb_muzzle_sks_bayonet",1000],["rhs_mag_rdg2_white",800],["CUP_HandGrenade_RGO",5500],["ACE_elasticBandage",325],["ACE_fieldDressing",200],["ACE_packingBandage",250],["ACE_quikclot",200],["ACE_morphine",900],["ACE_epinephrine",250],["ACE_adenosine",200],["ACE_tourniquet",100],["ACE_splint",200],["ACE_bloodIV_250",500],["ACE_bloodIV_500",1000],["ACE_bloodIV",1500],["ACE_plasmaIV_250",500],["ACE_plasmaIV_500",1000],["ACE_plasmaIV",1500],["ACE_salineIV_250",500],["ACE_salineIV_500",1000],["ACE_salineIV",1500],["ACE_personalAidKit",8000],["ACE_painkillers",1200],["ACE_suture",50],["ACE_surgicalKit",12000],["FSGm_ItemMedicBag",20000],["FSGm_ItemMedicBagMil",20000],["ACE_MRE_BeefStew",1000],["ACE_MRE_ChickenTikkaMasala",1000],["ACE_MRE_ChickenHerbDumplings",1000],["ACE_MRE_CreamChickenSoup",1000],["ACE_MRE_CreamTomatoSoup",1000],["ACE_MRE_LambCurry",1000],["ACE_MRE_MeatballsPasta",1000],["ACE_MRE_SteakVegetables",1000],["ACE_Banana",1000],["ACE_Humanitarian_Ration",1000],["ACE_Can_Franta",500],["ACE_Can_RedGull",500],["ACE_Can_Spirit",500],["ACE_Canteen",1500],["ACE_WaterBottle",1000],["CUP_U_C_Tracksuit_01",250],["CUP_U_C_Tracksuit_02",250],["CUP_U_C_Tracksuit_03",250],["CUP_U_C_Tracksuit_04",250],["Project_BJC_PCU_Cargo25",500],["Project_BJC_PCU_Cargo20",500],["Project_BJC_PCU_Cargo21",500],["Project_BJC_PCU_Cargo23",500],["Project_BJC_PCU_Cargo24",500],["Project_BJC_PCU_Cargo22",500],["Project_BJC_PCU_Cargo28",500],["Project_BJC_PCU_Cargo2",500],["Project_BJC_PCU_Cargo10",500],["Project_BJC_PCU_Cargo14",500],["Project_BJC_PCU_Cargo18",500],["Project_BJC_PCU_Cargo6",500],["Project_BJC_PCU_Cargo8",500],["Project_BJC_PCU_Cargo26",500],["Project_BJC_PCU_Cargo",500],["Project_BJC_PCU_Cargo12",500],["Project_BJC_PCU_Cargo16",500],["Project_BJC_PCU_Cargo4",500],["Project_BJC_PCU_Cargo29",500],["Project_BJC_PCU_Cargo3",500],["Project_BJC_PCU_Cargo11",500],["Project_BJC_PCU_Cargo15",500],["Project_BJC_PCU_Cargo19",500],["Project_BJC_PCU_Cargo7",500],["Project_BJC_PCU_Cargo5",500],["Project_BJC_PCU_Cargo27",500],["Project_BJC_PCU_Cargo1",500],["Project_BJC_PCU_Cargo9",500],["Project_BJC_PCU_Cargo13",500],["Project_BJC_PCU_Cargo17",500],["Project_BJC_Shirt_Cargo16",500],["Project_BJC_Shirt_Cargo17",500],["Project_BJC_Shirt_Cargo18",500],["Project_BJC_Shirt_Cargo19",500],["Project_BJC_Shirt_Cargo2",500],["Project_BJC_Shirt_Cargo6",500],["Project_BJC_Shirt_Cargo10",500],["Project_BJC_Shirt_Cargo14",500],["Project_BJC_Shirt_Cargo",500],["Project_BJC_Shirt_Cargo4",500],["Project_BJC_Shirt_Cargo8",500],["Project_BJC_Shirt_Cargo12",500],["Project_BJC_Shirt_Cargo3",500],["Project_BJC_Shirt_Cargo7",500],["Project_BJC_Shirt_Cargo11",500],["Project_BJC_Shirt_Cargo15",500],["Project_BJC_Shirt_Cargo1",500],["Project_BJC_Shirt_Cargo5",500],["Project_BJC_Shirt_Cargo9",500],["Project_BJC_Shirt_Cargo13",500],["Project_BJC_Shirt_Cut_Cargo16",500],["Project_BJC_Shirt_Cut_Cargo17",500],["Project_BJC_Shirt_Cut_Cargo18",500],["Project_BJC_Shirt_Cut_Cargo19",500],["Project_BJC_Shirt_Cut_Cargo2",500],["Project_BJC_Shirt_Cut_Cargo6",500],["Project_BJC_Shirt_Cut_Cargo10",500],["Project_BJC_Shirt_Cut_Cargo14",500],["Project_BJC_Shirt_Cut_Cargo",500],["Project_BJC_Shirt_Cut_Cargo4",500],["Project_BJC_Shirt_Cut_Cargo8",500],["Project_BJC_Shirt_Cut_Cargo12",500],["Project_BJC_Shirt_Cut_Cargo3",500],["Project_BJC_Shirt_Cut_Cargo7",500],["Project_BJC_Shirt_Cut_Cargo11",500],["Project_BJC_Shirt_Cut_Cargo15",500],["Project_BJC_Shirt_Cut_Cargo1",500],["Project_BJC_Shirt_Cut_Cargo5",500],["Project_BJC_Shirt_Cut_Cargo9",500],["Project_BJC_Shirt_Cut_Cargo13",500],["Project_BJC_Cargo16",500],["Project_BJC_Cargo17",500],["Project_BJC_Cargo19",500],["Project_BJC_Cargo18",500],["Project_BJC_Cargo2",500],["Project_BJC_Cargo6",500],["Project_BJC_Cargo14",500],["Project_BJC_Cargo10",500],["Project_BJC_Cargo",500],["Project_BJC_Cargo4",500],["Project_BJC_Cargo12",500],["Project_BJC_Cargo8",500],["Project_BJC_Cargo3",500],["Project_BJC_Cargo7",500],["Project_BJC_Cargo15",500],["Project_BJC_Cargo11",500],["Project_BJC_Cargo1",500],["Project_BJC_Cargo5",500],["Project_BJC_Cargo13",500],["Project_BJC_Cargo9",500],["Project_BJC_PCU_Jean5",500],["Project_BJC_PCU_Jean",500],["Project_BJC_PCU_Jean2",500],["Project_BJC_PCU_Jean3",500],["Project_BJC_PCU_Jean4",500],["Project_BJC_PCU_Jean1",500],["Project_BJC_Shirt_Jean",500],["Project_BJC_Shirt_Jean1",500],["Project_BJC_Shirt_Jean2",500],["Project_BJC_Shirt_Jean3",500],["Project_BJC_Shirt_Cut_Jean",500],["Project_BJC_Shirt_Cut_Jean1",500],["Project_BJC_Shirt_Cut_Jean2",500],["Project_BJC_Shirt_Cut_Jean3",500],["Project_BJC",500],["Project_BJC_2",500],["Project_BJC_3",500],["Project_BJC_1",500],["Project_BJC_PCU_Jean_blk5",500],["Project_BJC_PCU_Jean_blk",500],["Project_BJC_PCU_Jean_blk2",500],["Project_BJC_PCU_Jean_blk3",500],["Project_BJC_PCU_Jean_blk4",500],["Project_BJC_PCU_Jean_blk1",500],["Project_BJC_Shirt_Jean_blk",500],["Project_BJC_Shirt_Jean_blk1",500],["Project_BJC_Shirt_Jean_blk2",500],["Project_BJC_Shirt_Jean_blk3",500],["Project_BJC_Shirt_Cut_Jean_blk",500],["Project_BJC_Shirt_Cut_Jean_blk1",500],["Project_BJC_Shirt_Cut_Jean_blk2",500],["Project_BJC_Shirt_Cut_Jean_blk3",500],["Project_BJC_blk",500],["Project_BJC_blk_2",500],["Project_BJC_blk_3",500],["Project_BJC_blk_1",500],["PMC_Cargo_BJCP_Tshirt_BLU",500],["PMC_Cargo_BJCP_Tshirt_PPL",500],["PMC_Cargo_BLK_Tshirt_BLU",500],["PMC_Cargo_BLK_Tshirt_GRN",500],["PMC_Cargo_BLK_Tshirt_Noori",500],["PMC_Cargo_BLK_Tshirt_PPL",500],["PMC_Cargo_MC_Tshirt_BLU",500],["PMC_Cargo_MC_Tshirt_PPL",500],["PMC_Cargo_RGR_Tshirt_BLU",500],["PMC_Cargo_RGR_Tshirt_GRN",500],["PMC_Cargo_RGR_Tshirt_Noori",500],["PMC_Cargo_RGR_Tshirt_PPL",500],["PMC_Cargo_TAN_Tshirt_BLU",500],["PMC_Cargo_TAN_Tshirt_GRN",500],["PMC_Cargo_TAN_Tshirt_Noori",500],["PMC_Cargo_TAN_Tshirt_PPL",500],["PMC_Jeans_BLK_Shirt_BLU",500],["PMC_Jeans_BLK_Shirt_BLU_Dirty",500],["PMC_Jeans_BLK_Shirt_WHT",500],["PMC_Jeans_BLK_Shirt_WHT_Dirty",500],["PMC_Jeans_Shirt_BLU",500],["PMC_Jeans_Shirt_BLU_Dirty",500],["PMC_Jeans_Shirt_WHT",500],["PMC_Jeans_Shirt_WHT_Dirty",500],["PMC_Jeans_BLK_Shirt_Cut_BLU",500],["PMC_Jeans_BLK_Shirt_Cut_BLU_Dirty",500],["PMC_Jeans_BLK_Shirt_Cut_WHT",500],["PMC_Jeans_BLK_Shirt_Cut_WHT_Dirty",500],["PMC_Jeans_Shirt_Cut_BLU",500],["PMC_Jeans_Shirt_Cut_BLU_Dirty",500],["PMC_Jeans_Shirt_Cut_WHT",500],["PMC_Jeans_Shirt_Cut_WHT_Dirty",500],["PMC_Jeans_BLK_Tshirt_BLU",500],["PMC_Jeans_BLK_Tshirt_GRN",500],["PMC_Jeans_BLK_Tshirt_Noori",500],["PMC_Jeans_BLK_Tshirt_PPL",500],["PMC_Jeans_Tshirt_BLU",500],["PMC_Jeans_Tshirt_GRN",500],["PMC_Jeans_Tshirt_Noori",500],["PMC_Jeans_Tshirt_PPL",500],["rhsgref_alice_webbing",3100],["CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing",3900],["SP_Bandolier1_Green",2200],["CUP_V_CDF_CrewBelt",2500],["V_Chestrig_khk",3500],["V_SmershVest_01_F",3650],["CUP_V_RUS_Smersh_New_Full",3500],["UK3CB_TKA_I_V_6Sh92_vog_Khk",3500],["UK3CB_TKA_I_V_vydra_3m_Tan",3400],["UK3CB_ADA_B_V_TacVest_KHK",4500],["SE_Loner_Belt",2500],["B_Respawn_Sleeping_bag_blue_F",40000],["B_Respawn_Sleeping_bag_brown_F",40000],["B_Respawn_TentDome_F",80000],["B_Respawn_Sleeping_bag_F",40000],["B_Respawn_TentA_F",80000],["B_LegStrapBag_coyote_F",1800],["rhs_medic_bag",2000],["UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF",2600],["B_Messenger_Coyote_F",2800],["CUP_B_AssaultPack_Coyote",3200],["rhs_beanie_green",500],["UK3CB_H_Beanie_02_BLK",500],["H_Cap_tan",500],["CUP_H_PMC_Cap_Back_Tan",500],["UK3CB_ARD_B_H_Crew_Cap",500],["H_ShemagOpen_tan",500],["UK3CB_H_Shemag_blk",500],["rhs_tsh4",500],["UK3CB_H_Ushanka_Cap_01",500],["rhs_ushanka",500],["CUP_H_C_Ushanka_03",500],["CUP_H_C_Ushanka_02",500],["CUP_H_C_Ushanka_04",500],["rhsgref_M56",800],["rhs_ssh60",800],["rhs_ssh68_2",800],["H_Tank_eaf_F",900],["rhssaf_helmet_m59_85_nocamo",1200],["CUP_H_SLA_Helmet_OD_worn",1400],["CUP_H_SLA_TankerHelmet",1400],["G_Balaclava_blk",800],["G_Balaclava_lowprofile",800],["G_Bandanna_aviator",800],["G_Bandanna_shades",800],["ACRE_BF888S",6500],["ACE_Flashlight_Maglite_ML300L",500],["ACE_EntrenchingTool",600],["ACE_MapTools",250],["ToolKit",6000],["ACE_rope3",300],["ACE_rope6",600],["ACE_rope12",1200],["ACE_rope15",1500],["ACE_rope18",1800],["ACE_rope27",2700],["ACE_rope36",3600],["ACE_Sandbag_empty",100],["ACE_CableTie",50],["ACE_SpraypaintBlack",500],["ACE_SpraypaintBlue",500],["ACE_SpraypaintGreen",500],["ACE_SpraypaintRed",500],["ACE_SpraypaintWhite",500],["ACE_SpraypaintYellow",500],["ACE_EHP",600],["ACE_EarPlugs",5],["ACE_Chemlight_Shield",250],["ACE_Flashlight_XL50",600],["acex_intelitems_notepad",200],["ACE_wirecutter",1500],["ACE_DeadManSwitch",2000],["ACE_Cellphone",2500],["ACE_HandFlare_Green",1500],["ACE_HandFlare_Red",1500],["ACE_HandFlare_White",1500],["ACE_HandFlare_Yellow",1500],["Chemlight_blue",2500],["Chemlight_green",2500],["Chemlight_red",2500],["Chemlight_yellow",2500],["ACE_Chemlight_White",2500],["ACE_Chemlight_HiBlue",3500],["ACE_Chemlight_HiGreen",3500],["ACE_Chemlight_HiRed",3500],["ACE_Chemlight_HiWhite",3500],["ACE_Chemlight_HiYellow",3500],["ACE_Chemlight_Orange",2500],["ACE_Chemlight_UltraHiOrange",4500]]

missionNamespace setVariable ["allTraderItems", _allTraderItems];
*/



//[] call compileScript ["core\def\mission.sqf"];



//player setVariable ["greenmag_main_MagSkillCoef", parseNumber (0.05 toFixed 1), true];



/**
* Arma_not - init
* 
* Author: Jeroen%20not
* 
* Description:
* Not given
* 
* Parameter(s):
* 0: None <Any>
* 
* Return Value:
* None <Any>
* 


 


call JN_fnc_ammo_init;

call JN_fnc_fuel_init;

call JN_fnc_test_init;*/