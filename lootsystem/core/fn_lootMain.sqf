/*
Author: Sarogahtyp

Description:
Spawns weapons, items and bags in buildings near to alive players inside a trigger.
Deletes stuff if players are not close enough anymore.
The script doesnt care about any trigger preferences except the trigger area.
Main while loop runs every 8-12 seconds.
Soft delayed item spawning to prevent performance impact.

How to adjust/use the script: 
_trigger_array   -> contains the names of triggers in which area loot should spawn.

_spawnChance  ->  The chance to spawn loot on a specific house position. If the same house is the closest building to 

_item_chance -> chance to spawn an item instead of a weapon

_bagChance -> chance to spawn a bag instead of a item

_max_magazines -> the maximum of magazines spawned in an itembox. 

_house_distance -> houses inside of this radius of a player will spawn loot

_exclude_loot -> you can add classnames there and those stuff will never spawn

_civExclusiveLoot -> add classnames here and nothing else will be spawned

_debug -> if true then u get hints about places were stuff was spawned or deleted and how many spawn places are active


// Wreck Loot Spawn Code 
/*
if ( (JA_wrecks_loot_chance >= random 100) && JA_wrecks_loot) then {
            _veh_loot = createVehicle [_selectedLoot, _currentRoad, [], 0, "CAN_COLLIDE"];
            _veh_loot setPos [(getPos _veh_loot select 0)-2.5, getPos _veh_loot select 1, getPos _veh_loot select 2];
        };

["All","Thing","Wreck","TankWreck"]

["All","Static","Building","Strategic","Wreck_Base","Wreck_base_F"]


// Starter code to find vehicleClass 
_nearestBuilding = nearestObjects[player,["house","Building"], 200];
_selectedBuilding = _nearestBuilding select 1;
_building = getText (configFile >> "CfgVehicles" >> "Land_u_Barracks_V2_F" >> "vehicleClass");

_buildingClassName = typeOf _selectedBuilding;
_building = getText (configFile >> "CfgVehicles" >> _buildingClassName >> "vehicleClass");
_building

*/
params ["_lootToogle"];

systemChat "Loading Loot Generation Params...";
_trigger_array          = [JA_safezone_ShootingRange];  //names of triggers or area markers in editor. if empty then spawning occures everywhere

_emptyLootAreas         = [];


//***** EDIT BELOW TO ADJUST BEHAVIOR

// Spawn Chances and Options
_lootToggle             = ("TFA_p_loottogle" call BIS_fnc_getParamValue) isEqualTo 1; 
_spawnChance           = "TFA_p_spawn_chance" call BIS_fnc_getParamValue;    //chance to spawn loot at specific house position
_item_chance            = "TFA_p_item_chance" call BIS_fnc_getParamValue;   //chance to spawn an item instead of a weapon
_weapon_chance          = 5;
_lootFluidSystem        = ("TFA_p_spawnfluidity" call BIS_fnc_getParamValue) isEqualTo 1; 
_case_chance            = "TFA_p_box_chance" call BIS_fnc_getParamValue;  //chance to spawn a case with items instead of a weapon [[[NEW ADDITION ]]
_bagChance             = "TFA_p_bagChance" call BIS_fnc_getParamValue; // chance to spawn a backpack instead of an item
_vestChance             = "TFA_p_vest_chance" call BIS_fnc_getParamValue; // chance to spawn a vest instead of an item
_launcher_chance        = "TFA_p_launcher_chance" call BIS_fnc_getParamValue;  //chance to spawn a launcher as weapon instead of rifle, pistol or machine gun
_milLootinCiv           = ("TFA_p_mil_at_civbuildings" call BIS_fnc_getParamValue) isEqualTo 1; 
_civLootinMil           = ("TFA_p_civ_at_milbuildings" call BIS_fnc_getParamValue) isEqualTo 1; 
_medicalChanceIncrease  = "TFA_p_medical_chance_increase" call BIS_fnc_getParamValue; 
_milChanceIncrease      = "TFA_p_military_chance_increase" call BIS_fnc_getParamValue; 
_foodChanceIncrease     = "TFA_p_food_chance_increase" call BIS_fnc_getParamValue; 
_industChanceIncrease   = "TFA_p_indust_chance_increase" call BIS_fnc_getParamValue; 
_ruinLessLoot           = ("TFA_p_ruin_reduction_toggle" call BIS_fnc_getParamValue) isEqualTo 1; 
_ruinReductionChance   = "TFA_p_ruin_reduction_chance" call BIS_fnc_getParamValue; 
_chanceHashs            = ["milLootinCiv","medicalChanceIncrease","milChanceIncrease","foodChanceIncrease","industChanceIncrease"] createHashMapFromArray [_milLootinCiv,_medicalChanceIncrease,_milChanceIncrease,_foodChanceIncrease,_industChanceIncrease,_industChanceIncrease];
_house_distance         = "TFA_p_spawn_distance" call BIS_fnc_getParamValue;   // houses with that distance to players will spawn loot
_debug                  = ("TFA_p_spawn_debug" call BIS_fnc_getParamValue) isEqualTo 1;  //information about number of places where items were spawned or deleted

// Loot Pool Options 
_min_magazines_gl       = "TFA_p_min_glrounds" call BIS_fnc_getParamValue;
_min_magazines_launcher = "TFA_p_min_launcherrounds" call BIS_fnc_getParamValue;
_max_magazines_gl       = "TFA_p_max_glrounds" call BIS_fnc_getParamValue; //maximum number of ammo to spawn for grenade launchers
_max_magazines_launcher = "TFA_p_max_launcherrounds" call BIS_fnc_getParamValue; //maximum number of ammo to spawn for rocket launchers

// Ground Loot Pool Options 
_spawnJunkGround        = ("TFA_p_groundloot_junkspawn" call BIS_fnc_getParamValue) isEqualTo 1;
_junkChanceGround       = "TFA_p_groundloot_junk_chance" call BIS_fnc_getParamValue;
_min_magazines          = "TFA_p_groundloot_min_mags" call BIS_fnc_getParamValue;
_max_magazines          = "TFA_p_groundloot_max_mags" call BIS_fnc_getParamValue;

// Medical Loot Pool Options
_spawnJunkMedical       = ("TFA_p_medical_junkspawn" call BIS_fnc_getParamValue) isEqualTo 1;
_junkChanceMedical      = "TFA_p_medical_junk_chance" call BIS_fnc_getParamValue;
_blood_chance           = "TFA_p_medical_blood_chance" call BIS_fnc_getParamValue; //Chance to spawn blood
_advanced_med_chance    = "TFA_p_medical_adv_med_chance" call BIS_fnc_getParamValue; //Chance to spawn advance Medical
_min_medical_loot       = "TFA_p_medical_min_items" call BIS_fnc_getParamValue; //minimum amount of medical supplies in a crate  
_max_medical_loot       = "TFA_p_medical_max_items" call BIS_fnc_getParamValue; //maximum amount of medical supplies in a crate  

// Ammobox Loot Pool Options 
_spawnJunkAmmoBox       = ("TFA_p_ammobox_junkspawn" call BIS_fnc_getParamValue) isEqualTo 1;
_junkChanceAmmoBox      = "TFA_p_ammobox_junk_chance" call BIS_fnc_getParamValue;
_min_magazines_box      = "TFA_p_ammobox_min_items" call BIS_fnc_getParamValue; //minimum amount of mags a box can contain
_max_magazines_box      = "TFA_p_ammobox_max_items" call BIS_fnc_getParamValue; //maximum amount of mags a box can contain

// Case Loot Pool Options
_spawnJunkCase          = ("TFA_p_case_junkspawn" call BIS_fnc_getParamValue) isEqualTo 1;
_junkChanceCase         = "TFA_p_case_junk_chance" call BIS_fnc_getParamValue;
_min_magazines_case     = "TFA_p_case_min_ammo" call BIS_fnc_getParamValue; //minimum amount of mags a case can contain
_max_magazines_case     = "TFA_p_case_max_ammo" call BIS_fnc_getParamValue; //maximum amount of mags a case can contain
_min_food_case          = "TFA_p_case_min_food" call BIS_fnc_getParamValue; 
_max_food_case          = "TFA_p_case_max_food" call BIS_fnc_getParamValue; 
_min_junk_case          = 5; //Minimum amount of items spawning in junk boxes
_max_junk_case          = 20;
_exclude_loot           = [];   //classnames of items which should never spawn


//***** LOOT TABLES 
//Seperate Firearm arrays to make it easier to organise 

// Civilian Loot and Weapons

_civMeleeArray              = ["WBK_survival_weapon_3_r","WBK_survival_weapon_3","WBK_survival_weapon_4_r","WBK_survival_weapon_4","Axe","Rod","WBK_SmallHammer","WBK_survival_weapon_1","FireAxe","CrudeAxe","Crowbar","WBK_craftedAxe","WBK_brush_axe","WBK_BrassKnuckles","Bat_Spike","Bat_Clear","WBK_axe","Pipe_aluminium","ACE_Flashlight_Maglite_ML300L","eo_flashlight"];

systemChat "Getting Loot Generation Items...";

// Pistols
_civPistolsArray =  missionNamespace getVariable "handguns1" select 1;
_civPistolMagsArray	= [];
 
{

_civPistolMagsArray pushBackUnique (compatibleMagazines _x);

}forEach _civPistolsArray; 

_civPistolMagsArray = flatten _civPistolMagsArray;


// SMGS
sleep 0.25;
_civSMGsArray = missionNamespace getVariable "smgs1" select 1;
diag_log "SMGS";
diag_log str (missionNamespace getVariable "smgs1" select 1);

_civSMGMagsArray = [];

{

_civSMGMagsArray pushBackUnique (compatibleMagazines _x);

}forEach _civSMGsArray; 

_civSMGMagsArray = flatten _civSMGMagsArray;

// Assault Rifles
sleep 0.25;
_civAssaultRiflesArray = missionNamespace getVariable "assaults1" select 1;
_civAssaultRifleMagsArray   = [];

{

_civAssaultRifleMagsArray pushBackUnique (compatibleMagazines _x);

}forEach _civAssaultRiflesArray; 

_civAssaultRifleMagsArray = flatten _civAssaultRifleMagsArray;

// Shotguns
sleep 0.25;
_civShotgunsArray = missionNamespace getVariable "shotguns1" select 1;
_civShotgunMagsArray = [];

{

_civShotgunMagsArray pushBackUnique (compatibleMagazines _x);

}forEach _civShotgunsArray; 

_civShotgunMagsArray = flatten _civShotgunMagsArray;

// Rifles
sleep 0.25;
_civRiflesArray			 = missionNamespace getVariable "rifles1" select 1;
_civRifleMagArray		   = [];

{

_civRifleMagArray pushBackUnique (compatibleMagazines _x);

}forEach _civRiflesArray; 

_civRifleMagArray = flatten _civRifleMagArray;

_civMagsCombined			= flatten _civPistolMagsArray + _civSMGMagsArray + _civAssaultRifleMagsArray + _civShotgunMagsArray + _civRifleMagArray;
_civFirearmLoot			 = _civPistolsArray + _civRiflesArray + _civSMGsArray + _civAssaultRiflesArray + _civShotgunsArray;
_civWeaponsMagsArray		= [];
_civPistolsMagsLootArray	= [];
_civRiflesMagsLootArray	 = [];

//Need to code in to convert strs in array to lowercase
_civMagsCombinedArray	   = flatten _civPistolMagsArray + _civSMGMagsArray + _civAssaultRifleMagsArray + _civShotgunMagsArray + _civRifleMagArray;

// Military Loot and Weapons
_milRadiosLoot              = ["ACRE_PRC117F","ACRE_PRC148","ACRE_PRC152","ACRE_PRC343","ACRE_PRC77","ACRE_SEM70"];
_milMiscLoot                = _milRadiosLoot + ["diw_armor_plates_main_plate","crowsew_ctrack","ACE_IR_Strobe_Item","CBRN_gasmaskFilter","CBRN_gasmaskFilter","ACE_SpareBarrel","MRH_FoldedSatcomAntenna","ACE_UAVBattery","MRH_TacticalDisplay","ACRE_VHF30108SPIKE","ACRE_VHF30108","ACRE_VHF30108MAST","CBRN_sealant","ACE_Sandbag_empty","MRH_BluForTransponder","ACE_ATragMX","ChemicalDetector_01_black_F","ChemicalDetector_01_olive_F","ChemicalDetector_01_tan_F","ACE_DefusalKit","ACE_EntrenchingTool","ACE_Fortify","ACE_Flashlight_MX991","ACE_HuntIR_monitor","ACE_Kestrel4500","ACE_Flashlight_KSF1","ACE_M26_Clacker","ACE_Clacker","ACE_MapTools","ACE_microDAGR","acex_intelitems_notepad","ACE_PlottingBoard","ACE_RangeCard","ACE_SpottingScope","ACE_Tripod"];
_milPistolsArray            = ["rhs_weap_pya","rhs_weap_cz99"];
_milPistolMagsArray         = ["rhs_mag_9x19_17","rhssaf_mag_15Rnd_9x19_FMJ","rhssaf_mag_15Rnd_9x19_FMJ"];
_milAssaultRiflesArray      = ["rhs_weap_ak74"];
_milAssaultRifleMagsArray   = ["rhs_30Rnd_545x39_7N10_2mag_AK","rhs_30Rnd_545x39_7N10_2mag_camo_AK","rhs_30Rnd_545x39_7N10_2mag_desert_AK","rhs_30Rnd_545x39_7N10_2mag_plum_AK","rhs_30Rnd_545x39_AK_plum_green","rhs_30Rnd_545x39_7N10_plum_AK","rhs_30Rnd_545x39_7N22_plum_AK","rhs_30Rnd_545x39_7N6M_plum_AK"];
_milMagsCombined            = _milPistolMagsArray + _milAssaultRifleMagsArray;
_milFirearmLoot             = _milPistolsArray + _milAssaultRiflesArray;
_milUniformLoot             = ["rhssaf_uniform_m10_digital_summer","rhssaf_uniform_m10_digital","rhsgref_uniform_gorka_1_f","rhsgref_uniform_para_ttsko_mountain","rhsgref_uniform_para_ttsko_oxblood","rhsgref_uniform_para_ttsko_urban","rhsgref_uniform_dpm","rhsgref_uniform_ERDL","rhsgref_uniform_flecktarn_full","rhsgref_uniform_og107","rhsgref_uniform_olive","rhsgref_uniform_woodland"];
_milHeadgearLoot            = ["rhssaf_bandana_digital","rhssaf_bandana_md2camo","rhssaf_bandana_oakleaf","rhssaf_bandana_smb","rhssaf_beret_para","rhssaf_beret_green","rhssaf_booniehat_digital","rhssaf_booniehat_md2camo","rhssaf_booniehat_woodland","rhssaf_helmet_m59_85_oakleaf","rhssaf_helmet_m59_85_nocamo","rhssaf_helmet_m97_black_nocamo","rhssaf_helmet_m97_black_nocamo_black_ess","rhssaf_helmet_m97_black_nocamo_black_ess_bare","rhssaf_helmet_m97_digital","rhssaf_helmet_m97_digital_black_ess","rhssaf_helmet_m97_digital_black_ess_bare","rhssaf_helmet_m97_md2camo","rhssaf_helmet_m97_md2camo_black_ess","rhssaf_helmet_m97_md2camo_black_ess_bare","rhssaf_helmet_m97_oakleaf","rhssaf_helmet_m97_oakleaf_black_ess","rhssaf_helmet_m97_oakleaf_black_ess_bare","rhssaf_helmet_m97_olive_nocamo","rhssaf_helmet_m97_woodland"];
_milVestLoot                = ["rhsgref_6b23_khaki_medic","rhsgref_6b23_khaki_nco","rhsgref_6b23_khaki_officer","rhsgref_6b23_khaki_rifleman","rhsgref_6b23_khaki_sniper","rhsgref_6b23_khaki","rhsgref_6b23_ttsko_digi_medic","rhsgref_6b23_ttsko_digi_nco","rhsgref_6b23_ttsko_digi_officer","rhsgref_6b23_ttsko_digi_rifleman","rhsgref_6b23_ttsko_digi_sniper","rhsgref_6b23_ttsko_digi","rhsgref_6b23_ttsko_forest_rifleman","rhsgref_6b23_ttsko_forest","rhsgref_6b23_ttsko_mountain_medic","rhsgref_6b23_ttsko_mountain_nco","rhsgref_6b23_ttsko_mountain_officer","rhsgref_6b23_ttsko_mountain_rifleman","rhsgref_6b23_ttsko_mountain_sniper","rhsgref_6b23_ttsko_mountain","rhsgref_otv_digi","rhsgref_otv_khaki","rhsgref_TacVest_ERDL","rhssaf_vest_otv_md2camo","rhssaf_vest_md12_digital","rhssaf_vest_md12_m70_rifleman","rhssaf_vest_md98_digital","rhssaf_vest_md98_md2camo","rhssaf_vest_md98_woodland","rhssaf_vest_md98_rifleman","rhssaf_vest_md99_digital","rhssaf_vest_md99_digital_radio","rhssaf_vest_md99_digital_rifleman","rhssaf_vest_md99_digital_rifleman_radio","rhssaf_vest_md99_md2camo","rhssaf_vest_md99_md2camo_radio","rhssaf_vest_md99_md2camo_rifleman","rhssaf_vest_md99_md2camo_rifleman_radio","rhssaf_vest_md99_woodland","rhssaf_vest_md99_woodland_radio","rhssaf_vest_md99_woodland_rifleman","rhssaf_vest_md99_woodland_rifleman_radio"];
_milBagLoot                 = ["WarTech","TriZip","TakedownM","MBSS","milgp_bp_Breacher_rgr","milgp_bp_hydration_rgr","milgp_bp_Pointman_rgr","milgp_bp_Tomahawk_rgr","daypack","rhssaf_alice_md2camo","rhssaf_alice_smb","rhssaf_kitbag_digital","rhssaf_kitbag_md2camo","rhssaf_kitbag_smb","B_FieldPack_oli","UK3CB_LDF_B_B_ASS_OLI","B_TacticalPack_oli","CUP_B_Kombat_Olive","CUP_B_Kombat_Radio_Olive","UK3CB_GAF_B_B_ENG_OLI","B_Carryall_oli","B_DuffleBag_Olive_NoLogo_RF","UK3CB_ION_B_B_RIF_OLI_01","UK3CB_LFR_B_B_Tacticalpack_Eng_Oli","UK3CB_KDF_B_B_Sidor_MD_OLI","UK3CB_KDF_B_B_Sidor_RIF_OLI","UK3CB_B_Backpack_Med_OLI","B_DuffleBag_Olive_RF","UK3CB_B_TacticalPack_Med_Oli"];
_milNVGs                    = ["CUP_NVG_1PN138","CUP_NVG_PVS14","CUP_NVG_HMNVS","SAN_Headlamp_v1","SAN_Headlamp_v2"];
_milFacewearLoot            = [];
_milWeaponsMagsArray        = [];
_milPistolsMagsLootArray    = [];
_milRiflesMagsLootArray     = [];
_milExclusiveLoot           = _milMiscLoot + _milRadiosLoot + _milMagsCombined + _milFirearmLoot + _milUniformLoot + _milHeadgearLoot + _milVestLoot + _milBagLoot + _milNVGs;

//Need to code in to convert strs in array to lowercase
_milMagsCombinedArray       = _milPistolMagsArray + _milAssaultRifleMagsArray;

//Medical Loot table
_bandagesList               = ["ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_quikclot"];
missionNamespace setVariable ["bandagesList",_bandagesList];
_medical_loot_drugs_misc      = ["ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_painkillers","ACE_suture"];
missionNamespace setVariable ["medical_loot_drugs_misc",_medical_loot_drugs_misc];
_medical_loot_general       = ["ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_painkillers","ACE_suture"] + _bandagesList;
missionNamespace setVariable ["medical_loot_general",_medical_loot_general];
_medical_loot_blood         = ["ACE_bloodIV_250","ACE_bloodIV_500","ACE_bloodIV","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500"];
missionNamespace setVariable ["medical_loot_blood",_medical_loot_blood];
_medical_loot_advanced      = ["ACE_personalAidKit","FSGm_ItemMedicBag","FSGm_ItemMedicBagMil","ACE_surgicalKit"];
missionNamespace setVariable ["medical_loot_advanced",_medical_loot_advanced];

// Food and Commercial Loot
_food_loot                  = ["ACE_MRE_BeefStew","ACE_MRE_ChickenTikkaMasala","ACE_MRE_ChickenHerbDumplings","ACE_MRE_CreamChickenSoup","ACE_MRE_CreamTomatoSoup","ACE_MRE_LambCurry","ACE_MRE_MeatballsPasta","ACE_MRE_SteakVegetables","ACE_Banana","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit","ACE_Canteen","ACE_Canteen_Empty","ACE_Canteen_Half","ACE_Canteen_Nearly_Empty","ACE_Canteen_Nearly_Full","ACE_WaterBottle","ACE_WaterBottle_Empty","ACE_WaterBottle_Half","ACE_WaterBottle_Nearly_Empty","ACE_Humanitarian_Ration"];
missionNamespace setVariable ["food_loot",_food_loot];
_civUniformLoot             = missionNamespace getVariable "uniforms1" select 1;

_civHeadgearLoot            = ["rhs_beanie_green","UK3CB_H_Beanie_02_BLK"];
missionNamespace setVariable ["civHeadgearLoot",_civHeadgearLoot];
_civFacewearLoot            = ["G_Balaclava_blk","G_Balaclava_lowprofile","G_Bandanna_aviator","G_Bandanna_shades"];
missionNamespace setVariable ["civFacewearLoot",_civFacewearLoot];
_item_loot                  = ["rhssaf_zrak_rd7j","ACE_EntrenchingTool","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_MapTools","ACE_Cellphone","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_Sandbag_empty","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow"];
_attachment_loot            = ["rhs_acc_pbs4","cup_optic_pem","rhs_acc_6p9_suppressor","muzzle_snds_acp"];
_civNVGs                    = ["SAN_Headlamp_v1","SAN_Headlamp_v2"];
_civVestLoot                = missionNamespace getVariable "vests1" select 1;
_civBagLoot                 = missionNamespace getVariable "bags1" select 1;
_civExclusiveLoot           = _civNVGs + _civFirearmLoot + _item_loot + _attachment_loot + _food_loot + _civUniformLoot + _civHeadgearLoot + _civFacewearLoot + _civMagsCombined; //add classnames here and nothing else will be spawned
_civExclusiveLoot = flatten _civExclusiveLoot;

_flareLoot                  = ["ACE_HandFlare_Green","ACE_HandFlare_Red","ACE_HandFlare_White","ACE_HandFlare_Yellow"];
missionNamespace setVariable ["flareLoot",_flareLoot];
_civThrowables              = ["rhs_mag_an_m14_th3"];
missionNamespace setVariable ["civThrowables",_civThrowables];
_civGrenadesLoot            = _flareLoot + _civThrowables;
missionNamespace setVariable ["civGrenadesLoot",_civGrenadesLoot];
_smokegren_loot             = ["rhs_mag_rdg2_white"]; //Smoke Grenades
missionNamespace setVariable ["smokegren_loot",_smokegren_loot];
_hiexplogren_loot           = ["CUP_HandGrenade_RGO","rhs_grenade_mkii_mag","rhs_grenade_nbhgr39_mag"]; //Offensive Grenades
missionNamespace setVariable ["hiexplogren_loot",_hiexplogren_loot];
_chemlightgren_loot         = ["Chemlight_blue","Chemlight_green","ACE_Chemlight_HiBlue","ACE_Chemlight_HiGreen","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite","ACE_Chemlight_HiYellow","ACE_Chemlight_Orange","Chemlight_red","ACE_Chemlight_UltraHiOrange","ACE_Chemlight_White","Chemlight_yellow"]; //Chemlight Grenades
missionNamespace setVariable ["chemlightgren_loot",_chemlightgren_loot];
_grenade_loot               = _smokegren_loot + _hiexplogren_loot + _chemlightgren_loot + _flareLoot;
missionNamespace setVariable ["grenade_loot",_grenade_loot];
_industAdv                  = ["ACRE_BF888S","ToolKit","ACE_wirecutter"];
missionNamespace setVariable ["industAdv",_industAdv];
_industWeapons              = ["Pipe_aluminium","WBK_axe","Crowbar","WBK_survival_weapon_2","IceAxe","WBK_pipeStyledSword","Rod","Shovel_Russian_Rotated","Shovel_Russian","Axe","WBK_SmallHammer"];
_industLoot                 = ["ACE_Flashlight_Maglite_ML300L","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_Sandbag_empty","ACE_CableTie","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow","ACE_EHP","ACE_EarPlugs","ACE_Chemlight_Shield","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_DeadManSwitch"];
missionNamespace setVariable ["industLoot",_industLoot];
_industLootAll                 = ["bolts_infinite","ACE_Flashlight_Maglite_ML300L","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_Sandbag_empty","ACE_CableTie","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow","ACE_EHP","ACE_EarPlugs","ACE_Chemlight_Shield","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_DeadManSwitch"] + _industWeapons;
missionNamespace setVariable ["industLootAll",_industLootAll];
_junkLoot                   = ["bolts_single","bolts_infinite"];
missionNamespace setVariable ["junkLoot",_junkLoot];
_specialLoot                = ["UK3CB_Cocaine_Brick"];



//",Turn ararys into lowercase
_civMagsCombinedArray_Temp = [];
_milMagsCombinedArray_Temp = [];

{
  // code...
  _civMagsCombinedArray_Temp pushBack (toLower _x);
} forEach _civMagsCombinedArray;

{
  // code...
  _milMagsCombinedArray_Temp pushBack (toLower _x);
} forEach _milMagsCombinedArray;

_civMagsCombinedArray = _civMagsCombinedArray_Temp;
_milMagsCombinedArray = _milMagsCombinedArray_Temp;




systemChat "Getting Crate Classnames...";
//***** EDIT ABOVE TO ADJUST BEHAVIOR

//***** init variables
_checked_positions      = [];
_spawned_positions      = [];


_launchers_mags_array   = [];
/*
_Muzzles_array          = [];
_Cows_array             = [];
_PointerSlot_array      = [];
_UnderBarrelSlot_array  = [];
*/
_attachment_list        = [];
_items_array            = [];
_bags_array             = [];
_groundBox              = "WeaponHolderSimulated_Scripted";
_debugObjects           = ["Sign_arrow_down_large_EP1","VR_3DSelector_01_incomplete_F","VR_3DSelector_01_exit_F","VR_3DSelector_01_default_F","VR_3DSelector_01_complete_F","VR_Billboard_01_F"];
_militaryCases          = ["plp_ct_PlasticBoxBlack","CaseAmmo","CaseGrenade","CaseMag","CasePistol","CaseWeapon","CaseMeds"];
_medicalCases           = ["Land_FirstAidKit_01_closed_F","Box_B_UAV_06_medical_F","Land_PaperBox_01_small_closed_brown_F"];
_foodCases              = ["plp_ct_CartonLightFlat","plp_ct_CartonLightMedium","plp_ct_CartonLightSmall","Casefood","rhsusf_props_ScepterMWC_OD"];
_industrialCases        = ["plp_ct_CartonDarkFlat","plp_ct_CartonDarkMedium","plp_ct_CartonDarkSmall","ACE_Wheel","rhsusf_props_ScepterMFC_OD"];
_junkCases              = ["plp_ct_CartonRottenSmall","plp_ct_CartonRottenMedium","plp_ct_CartonRottenFlat"];
_civilianCases          = ["CaseMoney","plp_ct_WeathCrateSmallWorn","plp_ct_WeathCrateMediumWorn"] + _junkCases;
_deleteCases            = [_groundBox] + _militaryCases + _medicalCases + _foodCases + _industrialCases + _civilianCases + _debugObjects;
_case_classnames        = _medicalCases + _foodCases + _industrialCases + _junkCases + _civilianCases + _militaryCases;
_caseClassHash          = ["medicalCases","foodCases","industrialCases","junkCases","civilianCases","militaryCases"] createHashMapFromArray [_medicalCases,_foodCases,_industrialCases,_junkCases,_civilianCases,_militaryCases];
//Debugging
//_case_classnames        = ["CaseAmmo"];
//_unused_cases           = ["plp_ct_RifleCaseBlack","plp_ct_ULD_MD1_Magn"];

//debug: Getting Load/Ballastic/Explosive for Vests/Bags  


systemChat "Loot Generation System Loaded. Loop Initialized.";
//***** get weapon and magazine classnames from config file
if (_spawnChance > 0) then {
        _cfgWeapons = ("true" configClasses (configFile >> "cfgWeapons")) select {
        _parents = [_x,true] call BIS_fnc_returnParents; 
        ("Rifle" in _parents) or ("MGun" in _parents) or ("Pistol" in _parents)
    }; 

    {
        //Weapon name
        _weaponString = configName (_x);
        _muzzle_class = (getArray (configFile >> "CfgWeapons" >> _weaponString >> "muzzles")) select 1;
        _muzzle_magazines = [];

        //Gets weapon mags
        if !(isNil {_muzzle_class}) then {	
            _muzzle_magazines = getArray (configFile >> "CfgWeapons" >> _weaponString >> _muzzle_class >> "magazines")
        };


        if (!(_weaponString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_weaponString in _civExclusiveLoot))) then {
            _compat_mags = [_weaponString] call BIS_fnc_compatibleMagazines;
            _muzzle_magazines2 = _civMagsCombinedArray arrayIntersect _compat_mags;
            _d = _civWeaponsMagsArray pushBack [_weaponString, _muzzle_magazines2, _muzzle_magazines];
        };

        if (!(_weaponString in _exclude_loot) and ((count _milExclusiveLoot == 0) or (_weaponString in _milExclusiveLoot))) then {
            _compat_mags = [_weaponString] call BIS_fnc_compatibleMagazines;
            _muzzle_magazines2 = _milMagsCombinedArray arrayIntersect _compat_mags;
            _d = _milWeaponsMagsArray pushBack [_weaponString, _muzzle_magazines2, _muzzle_magazines];
        };
    } count _cfgWeapons;

    //***** same as above but for pistols only
    _cfgWeapons = ("true" configClasses (configFile >> "cfgWeapons")) select {
        _parents = [_x,true] call BIS_fnc_returnParents; 
        ("Pistol" in _parents)
    }; 

    {
        _PistolString = configName (_x);
        _pistol_muzzle_class = (getArray (configFile >> "CfgWeapons" >> _PistolString >> "muzzles")) select 1;
        _pistol_muzzle_magazines = [];

        if !(isNil {_pistol_muzzle_class}) then {	
            _pistol_muzzle_magazines = getArray (configFile >> "CfgWeapons" >> _PistolString >> _pistol_muzzle_class >> "magazines")
        };


        if (!(_PistolString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_PistolString in _civExclusiveLoot))) then {
            _pistol_compat_mags = [_PistolString] call BIS_fnc_compatibleMagazines;
            _pistol_muzzle_magazines2 = _civMagsCombinedArray arrayIntersect _pistol_compat_mags;
            _d = _civPistolsMagsLootArray pushBack [_PistolString, _pistol_muzzle_magazines2, _pistol_muzzle_magazines];
        };

        if (!(_PistolString in _exclude_loot) and ((count _milExclusiveLoot == 0) or (_PistolString in _milExclusiveLoot))) then {
            _pistol_compat_mags = [_PistolString] call BIS_fnc_compatibleMagazines;
            _pistol_muzzle_magazines2 = _milMagsCombinedArray arrayIntersect _pistol_compat_mags;
            _d = _milPistolsMagsLootArray pushBack [_PistolString, _pistol_muzzle_magazines2, _pistol_muzzle_magazines];
        };
    } count _cfgWeapons;

    //*****Same as above but for everything but Pistols
    _cfgWeapons = ("true" configClasses (configFile >> "cfgWeapons")) select {
        _parents = [_x,true] call BIS_fnc_returnParents; 
        ("Rifle" in _parents) or ("MGun" in _parents)
        }; 

        {
        _RifleString = configName (_x);
        _Rifle_muzzle_class = (getArray (configFile >> "CfgWeapons" >> _RifleString >> "muzzles")) select 1;
        _civRifle_muzzle_magazines = [];
        _milRifle_muzzle_magazines = [];

        if !(isNil {_Rifle_muzzle_class}) then {	
            _civRifle_muzzle_magazines = getArray (configFile >> "CfgWeapons" >> _RifleString >> _Rifle_muzzle_class >> "magazines")
        };

        _civRifle_muzzle_magazines = _civRifle_muzzle_magazines arrayIntersect _civMagsCombinedArray;
        _milRifle_muzzle_magazines = _milRifle_muzzle_magazines arrayIntersect _milMagsCombinedArray;

        if (!(_RifleString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_RifleString in _civExclusiveLoot))) then {
            _rifle_compat_mags = [_RifleString] call BIS_fnc_compatibleMagazines;
            _civRifle_muzzle_magazines2 = _civMagsCombinedArray arrayIntersect _rifle_compat_mags;
            _d = _civRiflesMagsLootArray pushBack [_RifleString, _civRifle_muzzle_magazines2, _civRifle_muzzle_magazines];
        };

        if (!(_RifleString in _exclude_loot) and ((count _milExclusiveLoot == 0) or (_RifleString in _milExclusiveLoot))) then {
            _rifle_compat_mags = [_RifleString] call BIS_fnc_compatibleMagazines;
            _milRifle_muzzle_magazines2 = _milMagsCombinedArray arrayIntersect _rifle_compat_mags;
            _d = _milRiflesMagsLootArray pushBack [_RifleString, _milRifle_muzzle_magazines2, _milRifle_muzzle_magazines];
        };
    } count _cfgWeapons;


    //***** get launchers and rocket/grenade classnames from config file
    if (_launcher_chance > 0) then {
        _cfgLaunchers = ("true" configClasses (configFile >> "cfgWeapons")) select {
            _parents = [_x,true] call BIS_fnc_returnParents; 
            ("Launcher" in _parents)
        }; 

        {
            _launcherString = configName (_x);
            if (!(_launcherString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_launcherString in _civExclusiveLoot))) then {
                _d = _launchers_mags_array pushBack [_launcherString, (getArray (configFile >> "CfgWeapons" >> _launcherString >> "magazines"))];
            };
        } count _cfgLaunchers;
    };


    //*****get items classnames from config file
    if (_item_chance > 0) then {
        _cfgItems = ("true" configClasses (configFile >> "cfgWeapons")) select {
            _parents = [_x,true] call BIS_fnc_returnParents; 
            ("ItemCore" in _parents)
        };

        {
            _itemString = configName (_x);
            if (!(_itemString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_itemString in _civExclusiveLoot))) then {
                _d = _items_array pushBack _itemString;
            };
        } count _cfgItems;
    };

    //*****get bag classnames from config file
    if (_bagChance > 0) then {
        _cfgBags = ("true" configClasses (configFile >> "cfgVehicles")) select {
            _parents = [_x,true] call BIS_fnc_returnParents; 
            ("Bag_Base" in _parents)
        }; 

        {
            _bagString = configName (_x);
            if (!(_bagString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_bagString in _civExclusiveLoot))) then {
                _d = _bags_array pushBack _bagString;
            };
        } count _cfgBags;
    };

    //*****get random case from array
    if (_case_chance > 0) then {
        _selectedCase = (selectRandom _case_classnames);
    };


    while {true} do {
        _actual_positions = [];
        _new_positions = [];
        _loot_players = [];
        _justPlayers = (allPlayers - entities "HeadlessClient_F") select {alive _x};

        //***** get desired spawn positions for loot in the buildings close to players
        //***** which are outside the loot triggers
        
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
            {
                //Check if position is in Safe/No Loot Areas
                private _isInArea = false;
                _buildingPos = position _x;         
                {
                    if ((_buildingPos inArea _x)isEqualto true) then {_isInArea = true;};
                }forEach _trigger_array; 

                if ((_isInArea)isEqualto false) then 
                {
                    {
                        _isRuins = [_x] call JA_LootGen_fnc_isRuins;
                        _currentPosition = _x;                    
                        if ((_isRuins == true) && (_ruinLessLoot == true)) then {
                            if (!(_currentPosition in _checked_positions) && (random 100 < (_spawnChance - ((_ruinReductionChance / 100) * _spawnChance)))) then {
                                _new_positions pushBackUnique _currentPosition;
                                _spawned_positions pushBackUnique _currentPosition;                                 
                            };
                            if ( _debug == true) then {
                            createVehicle ["VR_Billboard_01_F", ( _currentPosition vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                            };
                        } else {
                            if (!(_currentPosition in _checked_positions) && (random 100 < _spawnChance)) then {
                                _new_positions pushBackUnique _currentPosition;
                                _spawned_positions pushBackUnique _currentPosition;
                            };
                        };

                        _checked_positions pushBackUnique _x;
                        _actual_positions pushBackUnique _x;
                        true
                    } count (_x buildingPos -1); 
                };
 
                true
            } count (nearestObjects [_x, ["house","Building"], _house_distance]);
            true
        } count _loot_players;

        // Checks if positions are in Safe/No Loot Zones
        private _new_positionsTemp = [];
        private _spawned_positionsTemp = [];
        private _positionsInArea = [];
        private _spawnedPositionsInArea = [];
        {
				{
					_positionsInArea pushBack _x;
					true
				} count (_new_positions inAreaArray _x);

                {
					_spawnedPositionsInArea pushBack _x;
					true
				} count (_positionsInArea inAreaArray _x);
                
				true
		} count _trigger_array;

        if(_debug) then {

            diag_log "_new_positions";
            diag_log count _new_positions;
            diag_log "_spawned_positions";
            diag_log count _spawned_positions;
        };
        

        _new_positionsTemp = _new_positions;
        _spawned_positionsTemp = _spawned_positions;

        {
			private _index = _new_positions find _x;
			if (_index != -1) then
			{
				_new_positions deleteAt _index;
			};
		} forEach _new_positionsTemp;

        {
			private _index = _spawned_positions find _x;
			if (_index != -1) then
			{
				_spawned_positions deleteAt _index;
			};
		} forEach _spawned_positionsTemp;

        _spawned_positions = _spawned_positionsTemp;
        _new_positions = _new_positionsTemp;

        //***** delete loot out of range
        _checked_positions = _checked_positions select {_x in _actual_positions};
        _delete_positions = _spawned_positions select {!(_x in _actual_positions)};
        _spawned_positions = _spawned_positions - _delete_positions;

        _del_pos_num = count _delete_positions;
       //Need to make loop for _deleteCases to delete
       // Does not work on Dedicated 
       [_delete_positions,_deleteCases] spawn 
       {

        {

            [_x,(_this select 1)] call JA_LootGen_fnc_deleteLoot;

        } count (_this select 0);

       };

       

        //***** spawn loot within 60 seconds (delay to prevent performance impact)
        _new_pos_num = count _new_positions; 
        // debug things
        if(_debug) then {
            _spawned_num = count _spawned_positions;
            _checked_num = count _checked_positions;

            hint parseText format ["spawned new: %1, deleted old: %2 <br /> 
                                    spawned places: %3, overall places: %4",  
                                    _new_pos_num, _del_pos_num, _spawned_num, _checked_num];
        };

        if (_new_pos_num > 0) then {
            _sleep_delay = 60 / _new_pos_num;
        //Checks to see if _casechance overwrites _itembox, otherwise continue.

                /*
                _ruinReductionChance = number eg 70;
                _spawnChance = number eg 40;
                _overAllChance = _spawnChance - ((_ruinReductionChance / 100) * _spawnChance);
                returns 12

                */
            {
                _currentPosition = _x;
                _buildingTypes = [_x] call JA_LootGen_fnc_checkBuildingType;
                if ( _debug == true) then {
                {
                    if (_x == "Civilian") then {
                        createVehicle ["Sign_arrow_down_large_EP1", ( _currentPosition vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                        };
                    if (_x == "Military") then {
                        createVehicle ["VR_3DSelector_01_incomplete_F", ( _currentPosition vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                        };
                    if (_x == "Medical") then {
                        createVehicle ["VR_3DSelector_01_exit_F", ( _currentPosition vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                        };
                    if (_x == "Food") then {
                        createVehicle ["VR_3DSelector_01_default_F", ( _currentPosition vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                        };
                    if (_x == "Industrial") then {
                        createVehicle ["VR_3DSelector_01_complete_F", (_currentPosition vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                        };

                } forEach _buildingTypes;
                };
                // Finds what sort of building the position is in
                if (random 100 < _case_chance) then {

                    _caseBox = [_x,_buildingTypes,_caseClassHash,_chanceHashs] call JA_LootGen_fnc_spawnCase;
                    [_caseBox,_buildingTypes] call JA_LootGen_fnc_spawnCaseLoot;
                sleep _sleep_delay;
                }
                else {
                    _itembox = createVehicle [_groundBox, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "NONE"];
                    [_itembox,_buildingTypes] call JA_LootGen_fnc_spawnCaseLoot;
                    sleep _sleep_delay;
                };
            } count _new_positions;
        };
        sleep (1 + random 2);
    };
};