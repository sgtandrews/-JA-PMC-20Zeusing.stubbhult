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

_spawn_chance  ->  The chance to spawn loot on a specific house position. If the same house is the closest building to 

_item_chance -> chance to spawn an item instead of a weapon

_bagChance -> chance to spawn a bag instead of a item

_max_magazines -> the maximum of magazines spawned in an itembox. 

_house_distance -> houses inside of this radius of a player will spawn loot

_exclude_loot -> you can add classnames there and those stuff will never spawn

_civExclusiveLoot -> add classnames here and nothing else will be spawned

_debug -> if true then u get hints about places were stuff was spawned or deleted and how many spawn places are active


// Starter code to find vehicleClass 
_nearestBuilding = nearestObjects[player,["house","Building"], 200];
_selectedBuilding = _nearestBuilding select 1;
_building = getText (configFile >> "CfgVehicles" >> "Land_u_Barracks_V2_F" >> "vehicleClass");

_buildingClassName = typeOf _selectedBuilding;
_building = getText (configFile >> "CfgVehicles" >> _buildingClassName >> "vehicleClass");
_building

*/

_trigger_array          = [lootTrigger_1, "marker1", lootTrigger_2, lootTrigger_3,lootTrigger_4];  //names of triggers or area markers in editor. if empty then spawning occures everywhere

//***** EDIT BELOW TO ADJUST BEHAVIOR

// Spawn Chances and Options
_lootToggle             = ("TFA_p_loottogle" call BIS_fnc_getParamValue) isEqualTo 1; 
_spawn_chance           = "TFA_p_spawn_chance" call BIS_fnc_getParamValue;    //chance to spawn loot at specific house position
_item_chance            = "TFA_p_item_chance" call BIS_fnc_getParamValue;   //chance to spawn an item instead of a weapon
_case_chance            = "TFA_p_box_chance" call BIS_fnc_getParamValue;  //chance to spawn a case with items instead of a weapon [[[NEW ADDITION ]]
_bagChance             = "TFA_p_bagChance" call BIS_fnc_getParamValue; // chance to spawn a backpack instead of an item
_launcher_chance        = "TFA_p_launcher_chance" call BIS_fnc_getParamValue;  //chance to spawn a launcher as weapon instead of rifle, pistol or machine gun
_milLootinCiv           = ("TFA_p_mil_at_civbuildings" call BIS_fnc_getParamValue) isEqualTo 1; 
_medicalChanceIncrease  = "TFA_p_medical_chance_increase" call BIS_fnc_getParamValue; 
_milChanceIncrease      = "TFA_p_military_chance_increase" call BIS_fnc_getParamValue; 
_foodChanceIncrease     = "TFA_p_food_chance_increase" call BIS_fnc_getParamValue; 
_industChanceIncrease   = "TFA_p_indust_chance_increase" call BIS_fnc_getParamValue; 
_ruinLessLoot           = "TFA_p_ruin_reduction_toggle" call BIS_fnc_getParamValue; 
_ruinReducationChance   = "TFA_p_ruin_reduction_chance" call BIS_fnc_getParamValue; 
_chanceHashs            = ["milLootinCiv","medicalChanceIncrease","milChanceIncrease","foodChanceIncrease","industChanceIncrease","ruinLessLoot","ruinReducationChance"] createHashMapFromArray [_milLootinCiv,_medicalChanceIncrease,_milChanceIncrease,_foodChanceIncrease,_industChanceIncrease,_industChanceIncrease,_ruinLessLoot,_ruinReducationChance];
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

_exclude_loot           = [];   //classnames of items which should never spawn
_min_junk_case          = 5; //Minimum amount of items spawning in junk boxes

//***** LOOT TABLES 
//Seperate Firearm arrays to make it easier to organise 
_civPistolsArray            = ["CUP_hgun_Colt1911","rhsusf_weap_m9"];
_civPistolMagsArray         = ["rhsusf_mag_7x45acp_MHP","rhsusf_mag_15rnd_9x19_fmj"];
_civSMGsArray               = ["UK3CB_MP5A2","rhs_weap_scorpion","uk3cb_ppsh41","rhs_weap_m3a1"];
_civSMGMagsArray            = ["uk3cb_mp5_30rnd_9x19_magazine","rhsgref_20rnd_765x17_vz61","uk3cb_mp5_30rnd_9x19_magazine_g","uk3cb_ppsh_71rnd_magazine","rhsgref_30rnd_1143x23_m1t_smg"];
_civAssaultRiflesArray      = ["rhs_weap_aks74u","rhs_weap_MP44"];
_civAssaultRifleMagsArray   = ["rhs_30rnd_545x39_7n6m_ak","rhs_30rnd_545x39_ak_green","rhsgref_30rnd_792x33_sme_stg"];
_civShotgunsArray           = ["CUP_sgun_slamfire","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_F"];
_civShotgunMagsArray        = ["cup_1rnd_12gauge_pellets_no00_buck","cup_1rnd_12gauge_slug","cup_2rnd_12gauge_pellets_no00_buck","cup_2rnd_12gauge_pellets_no4_bird","cup_2rnd_12gauge_slug"];
_civRiflesArray             = ["UK3CB_CZ550","rhs_weap_m38","uk3cb_sks_01","CUP_srifle_Mosin_Nagant"];
_civRifleMagArray           = ["uk3cb_cz550_5rnd_mag","uk3cb_cz550_5rnd_mag_g","uk3cb_10rnd_magazine_sks","rhsgref_5rnd_762x54_m38","rhsgref_10rnd_792x57_m76"];
//Need to code in to convert strs in array to lowercase
_civMagsCombinedArray       = _civPistolMagsArray + _civSMGMagsArray + _civAssaultRifleMagsArray + _civShotgunMagsArray + _civRifleMagArray;
//Medical Loot table
_medical_loot_general       = ["ACE_elasticBandage","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine"];
_medical_loot_blood         = ["ACE_bloodIV_250","ACE_bloodIV_500","ACE_bloodIV"];
_medical_loot_advanced      = ["ACE_personalAidKit"];
_food_loot                  = ["ACE_MRE_BeefStew","ACE_MRE_ChickenTikkaMasala","ACE_MRE_ChickenHerbDumplings","ACE_MRE_CreamChickenSoup","ACE_MRE_CreamTomatoSoup","ACE_MRE_LambCurry","ACE_MRE_MeatballsPasta","ACE_MRE_SteakVegetables","ACE_Banana","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit","ACE_Canteen","ACE_Canteen_Empty","ACE_Canteen_Half","ACE_Canteen_Nearly_Empty","ACE_Canteen_Nearly_Full","ACE_WaterBottle","ACE_WaterBottle_Empty","ACE_WaterBottle_Half","ACE_WaterBottle_Nearly_Empty","ACE_Humanitarian_Ration"];
_civFirearmLoot             = _civPistolsArray + _civRiflesArray + _civSMGsArray + _civAssaultRiflesArray + _civShotgunsArray;
_uniform_loot               = ["Project_BJC_PCU_Cargo25","Project_BJC_PCU_Cargo20","Project_BJC_PCU_Cargo21","Project_BJC_PCU_Cargo23","Project_BJC_PCU_Cargo24","Project_BJC_PCU_Cargo22","Project_BJC_PCU_Cargo28","Project_BJC_PCU_Cargo2","Project_BJC_PCU_Cargo10","Project_BJC_PCU_Cargo14","Project_BJC_PCU_Cargo18","Project_BJC_PCU_Cargo6","Project_BJC_PCU_Cargo8","Project_BJC_PCU_Cargo26","Project_BJC_PCU_Cargo""Project_BJC_PCU_Cargo12,","Project_BJC_PCU_Cargo16","Project_BJC_PCU_Cargo4","Project_BJC_PCU_Cargo29","Project_BJC_PCU_Cargo3","Project_BJC_PCU_Cargo11","Project_BJC_PCU_Cargo15","Project_BJC_PCU_Cargo19","Project_BJC_PCU_Cargo7","Project_BJC_PCU_Cargo5","Project_BJC_PCU_Cargo27","Project_BJC_PCU_Cargo1","Project_BJC_PCU_Cargo9","Project_BJC_PCU_Cargo13","Project_BJC_PCU_Cargo17","Project_BJC_Shirt_Cargo16","Project_BJC_Shirt_Cargo17","Project_BJC_Shirt_Cargo18","Project_BJC_Shirt_Cargo19","Project_BJC_Shirt_Cargo2","Project_BJC_Shirt_Cargo6","Project_BJC_Shirt_Cargo10","Project_BJC_Shirt_Cargo14","Project_BJC_Shirt_Cargo","Project_BJC_Shirt_Cargo4","Project_BJC_Shirt_Cargo8","Project_BJC_Shirt_Cargo12","Project_BJC_Shirt_Cargo3","Project_BJC_Shirt_Cargo7","Project_BJC_Shirt_Cargo11","Project_BJC_Shirt_Cargo15","Project_BJC_Shirt_Cargo1","Project_BJC_Shirt_Cargo5","Project_BJC_Shirt_Cargo9","Project_BJC_Shirt_Cargo13","Project_BJC_Shirt_Cut_Cargo16","Project_BJC_Shirt_Cut_Cargo17","Project_BJC_Shirt_Cut_Cargo18","Project_BJC_Shirt_Cut_Cargo19","Project_BJC_Shirt_Cut_Cargo2","Project_BJC_Shirt_Cut_Cargo6","Project_BJC_Shirt_Cut_Cargo10","Project_BJC_Shirt_Cut_Cargo14","Project_BJC_Shirt_Cut_Cargo","Project_BJC_Shirt_Cut_Cargo4","Project_BJC_Shirt_Cut_Cargo8","Project_BJC_Shirt_Cut_Cargo12","Project_BJC_Shirt_Cut_Cargo3","Project_BJC_Shirt_Cut_Cargo7","Project_BJC_Shirt_Cut_Cargo11","Project_BJC_Shirt_Cut_Cargo15","Project_BJC_Shirt_Cut_Cargo1","Project_BJC_Shirt_Cut_Cargo5","Project_BJC_Shirt_Cut_Cargo9","Project_BJC_Shirt_Cut_Cargo13","Project_BJC_Cargo16""Project_BJC_Cargo17","Project_BJC_Cargo19","Project_BJC_Cargo18","Project_BJC_Cargo2","Project_BJC_Cargo6","Project_BJC_Cargo14","Project_BJC_Cargo10","Project_BJC_Cargo","Project_BJC_Cargo4","Project_BJC_Cargo12","Project_BJC_Cargo8","Project_BJC_Cargo3","Project_BJC_Cargo7","Project_BJC_Cargo15","Project_BJC_Cargo11","Project_BJC_Cargo1","Project_BJC_Cargo5","Project_BJC_Cargo13","Project_BJC_Cargo9","Project_BJC_PCU_Jean5","Project_BJC_PCU_Jean,""Project_BJC_PCU_Jean2","Project_BJC_PCU_Jean3,""Project_BJC_PCU_Jean4,""Project_BJC_PCU_Jean1,""Project_BJC_Shirt_Jean,","Project_BJC_Shirt_Jean1","Project_BJC_Shirt_Jean2","Project_BJC_Shirt_Jean3","Project_BJC_Shirt_Cut_Jean","Project_BJC_Shirt_Cut_Jean1","Project_BJC_Shirt_Cut_Jean2","Project_BJC_Shirt_Cut_Jean3","Project_BJC""Project_BJC_2","Project_BJC_3","Project_BJC_1","Project_BJC_PCU_Jean_blk5","Project_BJC_PCU_Jean_blk","Project_BJC_PCU_Jean_blk2","Project_BJC_PCU_Jean_blk3","Project_BJC_PCU_Jean_blk4","Project_BJC_PCU_Jean_blk1","Project_BJC_Shirt_Jean_blk","Project_BJC_Shirt_Jean_blk1","Project_BJC_Shirt_Jean_blk2","Project_BJC_Shirt_Jean_blk3","Project_BJC_Shirt_Cut_Jean_blk","Project_BJC_Shirt_Cut_Jean_blk1","Project_BJC_Shirt_Cut_Jean_blk2","Project_BJC_Shirt_Cut_Jean_blk3","Project_BJC_blk""Project_BJC_blk_2","Project_BJC_blk_3","Project_BJC_blk_1","PMC_Cargo_BJCP_Tshirt_BLU","PMC_Cargo_BJCP_Tshirt_PPL","PMC_Cargo_BLK_Tshirt_BLU","PMC_Cargo_BLK_Tshirt_GRN","PMC_Cargo_BLK_Tshirt_Noori","PMC_Cargo_BLK_Tshirt_PPL","PMC_Cargo_MC_Tshirt_BLU","PMC_Cargo_MC_Tshirt_PPL","PMC_Cargo_RGR_Tshirt_BLU","PMC_Cargo_RGR_Tshirt_GRN","PMC_Cargo_RGR_Tshirt_Noori","PMC_Cargo_RGR_Tshirt_PPL","PMC_Cargo_TAN_Tshirt_BLU","PMC_Cargo_TAN_Tshirt_GRN","PMC_Cargo_TAN_Tshirt_Noori","PMC_Cargo_TAN_Tshirt_PPL","PMC_Jeans_BLK_Shirt_BLU","PMC_Jeans_BLK_Shirt_BLU_Dirty","PMC_Jeans_BLK_Shirt_WHT","PMC_Jeans_BLK_Shirt_WHT_Dirty","PMC_Jeans_Shirt_BLU""PMC_Jeans_Shirt_BLU_Dirty","PMC_Jeans_Shirt_WHT""PMC_Jeans_Shirt_WHT_Dirty","PMC_Jeans_BLK_Shirt_Cut_BLU","PMC_Jeans_BLK_Shirt_Cut_BLU_Dirty","PMC_Jeans_BLK_Shirt_Cut_WHT","PMC_Jeans_BLK_Shirt_Cut_WHT_Dirty","PMC_Jeans_Shirt_Cut_BLU","PMC_Jeans_Shirt_Cut_BLU_Dirty","PMC_Jeans_Shirt_Cut_WHT","PMC_Jeans_Shirt_Cut_WHT_Dirty","PMC_Jeans_BLK_Tshirt_BLU","PMC_Jeans_BLK_Tshirt_GRN","PMC_Jeans_BLK_Tshirt_Noori","PMC_Jeans_BLK_Tshirt_PPL","PMC_Jeans_Tshirt_BLU""PMC_Jeans_Tshirt_GRN","PMC_Jeans_Tshirt_Noori","PMC_Jeans_Tshirt_PPL"];
_civHeadgearLoot              = ["rhs_beanie_green","UK3CB_H_Beanie_02_BLK"];
_civFacewearLoot              = ["G_Balaclava_blk","G_Balaclava_lowprofile","G_Bandanna_aviator","G_Bandanna_shades"];
_item_loot                  = ["rhssaf_zrak_rd7j","ACRE_BF888S","ACE_EntrenchingTool","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_MapTools","ACE_Cellphone","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_wirecutter","ACE_Sandbag_empty","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow"];
_attachment_loot            = ["rhs_acc_pbs4","cup_optic_pem","rhs_acc_6p9_suppressor","muzzle_snds_acp"];
_civVestLoot                  = ["rhsgref_alice_webbing","CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing"];
_civBagLoot                   = ["B_Respawn_Sleeping_bag_blue_F","B_Respawn_Sleeping_bag_brown_F","B_Respawn_TentDome_F","B_Respawn_Sleeping_bag_F","B_Respawn_TentA_F","B_LegStrapBag_coyote_F"];
_civExclusiveLoot             = _civFirearmLoot + _item_loot + _attachment_loot + _food_loot + _uniform_loot + _civHeadgearLoot + _civFacewearLoot + _civPistolMagsArray + _civSMGMagsArray + _civAssaultRifleMagsArray + _civShotgunMagsArray + _civRifleMagArray; //add classnames here and nothing else will be spawned
_smokegren_loot             = ["rhs_mag_rdg2_white"]; //Smoke Grenades
_hiexplogren_loot           = ["CUP_HandGrenade_RGO"]; //Offensive Grenades
_chemlightgren_loot         = ["Chemlight_blue","Chemlight_green","ACE_Chemlight_HiBlue","ACE_Chemlight_HiGreen","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite","ACE_Chemlight_HiYellow","ACE_Chemlight_Orange","Chemlight_red","ACE_Chemlight_UltraHiOrange","ACE_Chemlight_White","Chemlight_yellow"]; //Chemlight Grenades
_grenade_loot               = _smokegren_loot + _hiexplogren_loot + _chemlightgren_loot;


//",Turn ararys into lowercase
_civMagsCombinedArray_Temp = [];

{
  // code...
  _civMagsCombinedArray_Temp pushBack (toLower _x);
} forEach _civMagsCombinedArray;

_civMagsCombinedArray = _civMagsCombinedArray_Temp;





//***** EDIT ABOVE TO ADJUST BEHAVIOR

//***** init variables
_checked_positions      = [];
_spawned_positions      = [];
_civWeaponsMagsArray     = [];
_civPistolsMagsLootArray     = [];
_civRiflesMagsLootArray      = [];
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
_box_classname          = "WeaponHolderSimulated_Scripted";
_militaryCases          = ["CaseAmmo","CaseGrenade","CaseMag","CasePistol","CaseWeapon","CaseMeds"];
_medicalCases           = ["Land_FirstAidKit_01_closed_F"];
_foodCases              = ["plp_ct_CartonLightFlat","plp_ct_CartonLightMedium","plp_ct_CartonLightSmall","Casefood","rhsusf_props_ScepterMWC_OD"];
_industrialCases        = ["plp_ct_CartonDarkFlat","plp_ct_CartonDarkMedium","plp_ct_CartonDarkSmall","ACE_Wheel","rhsusf_props_ScepterMFC_OD"];
_junkCases              = ["plp_ct_CartonRottenSmall","plp_ct_CartonRottenMedium","plp_ct_CartonRottenFlat"];
_civilianCases          = ["CaseMoney"] + _junkCases;
_case_classnames        = _medicalCases + _foodCases + _industrialCases + _junkCases + _civilianCases + _militaryCases;
_caseClassHash          = ["medicalCases","foodCases","industrialCases","junkCases","civilianCases","militaryCases"] createHashMapFromArray [_medicalCases,_foodCases,_industrialCases,_junkCases,_civilianCases,_militaryCases];
//Debugging
//_case_classnames        = ["CaseAmmo"];
//_unused_cases           = ["plp_ct_RifleCaseBlack","plp_ct_ULD_MD1_Magn"];

//debug: Getting Load/Ballastic/Explosive for Vests/Bags  



//***** get weapon and magazine classnames from config file
if (_spawn_chance > 0) then {
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
            //debug [ Intersecting wasn't working due to arrayIntersect can't compare lower n upper cases ]
            /*private _weapon_mags_log = (getArray (configFile >> "CfgWeapons" >> _weaponString >> "magazines"));
            private _weapon_mags_fnclog = [_weaponString] call BIS_fnc_compatibleMagazines;
            private _test_intersect = _weapon_mags_log arrayIntersect _civMagsCombinedArray;
            private _test_fnc_intersect = _weapon_mags_fnclog arrayIntersect _civMagsCombinedArray;
            diag_log "";
            diag_log "Weapon Selected";
            diag_log _weaponString;
            diag_log "Weapon Mags in Config";
            diag_log _weapon_mags_log;
            diag_log "Function Call";
            diag_log _weapon_mags_fnclog;
            diag_log "_civMagsCombinedArray";
            diag_log _civMagsCombinedArray;
            diag_log "Intersect _civMagsCombinedArray with pulling from config file";
            diag_log _test_intersect;
            diag_log "Intersect _civMagsCombinedArray with compat fnc";
            diag_log _test_fnc_intersect;
            */
            _compat_mags = [_weaponString] call BIS_fnc_compatibleMagazines;
            _muzzle_magazines2 = _civMagsCombinedArray arrayIntersect _compat_mags;
            //diag_log "_muzzle_magazines2";
            //diag_log _muzzle_magazines2;
            _d = _civWeaponsMagsArray pushBack [_weaponString, _muzzle_magazines2, _muzzle_magazines];
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
    } count _cfgWeapons;

    //*****Same as above but for everything but Pistols
    _cfgWeapons = ("true" configClasses (configFile >> "cfgWeapons")) select {
        _parents = [_x,true] call BIS_fnc_returnParents; 
        ("Rifle" in _parents) or ("MGun" in _parents)
        }; 

        {
        _RifleString = configName (_x);
        _Rifle_muzzle_class = (getArray (configFile >> "CfgWeapons" >> _RifleString >> "muzzles")) select 1;
        _Rifle_muzzle_magazines = [];

        if !(isNil {_Rifle_muzzle_class}) then {	
            _Rifle_muzzle_magazines = getArray (configFile >> "CfgWeapons" >> _RifleString >> _Rifle_muzzle_class >> "magazines")
        };

        _Rifle_muzzle_magazines = _Rifle_muzzle_magazines arrayIntersect _civMagsCombinedArray;

        if (!(_RifleString in _exclude_loot) and ((count _civExclusiveLoot == 0) or (_RifleString in _civExclusiveLoot))) then {
            _rifle_compat_mags = [_RifleString] call BIS_fnc_compatibleMagazines;
            _rifle_muzzle_magazines2 = _civMagsCombinedArray arrayIntersect _rifle_compat_mags;
            _d = _civRiflesMagsLootArray pushBack [_RifleString, _rifle_muzzle_magazines2, _Rifle_muzzle_magazines];
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
        //***** which are inside of a loot trigger area
        if(count _trigger_array > 0) then {
            {
                {
                    _loot_players pushBack _x;
                    true
                } count (_justPlayers inAreaArray _x);
                true
            } count _trigger_array;
        }
        else {
            _loot_players = _justPlayers;
        };

        {
            {
                {
                    if (!(_x in _checked_positions) && (random 100 < _spawn_chance)) then {
                        _new_positions pushBackUnique _x;
                        _spawned_positions pushBackUnique _x;
                    };

                    _checked_positions pushBackUnique _x;
                    _actual_positions pushBackUnique _x;
                    true
                } count (_x buildingPos -1); 
                true
            } count (nearestObjects [_x, ["house","Building"], _house_distance]);
            true
        } count _loot_players;

        //***** delete loot out of range
        _checked_positions = _checked_positions select {_x in _actual_positions};
        _delete_positions = _spawned_positions select {!(_x in _actual_positions)};
        _spawned_positions = _spawned_positions - _delete_positions;

        _del_pos_num = count _delete_positions;
       //Need to make loop for _case_classnames to delete
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, [_box_classname], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["CaseAmmo"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["CaseGrenade"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["Casefood"], 3]);
            true
        } count _delete_positions;   
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["plp_ct_CartonRottenSmall"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["CaseMag"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["Land_FirstAidKit_01_closed_F"], 3]);
            true
        } count _delete_positions; 
                {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["plp_ct_CashBoxBlack"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["CasePistol"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["plp_ct_RifleCaseBlack"], 3]);
            true
        } count _delete_positions;   
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["plp_ct_CartonRottenMedium"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["CaseWeapon"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["plp_ct_ULD_MD1_Magn"], 3]);
            true
        } count _delete_positions;   
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["VR_3DSelector_01_default_F"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["VR_3DSelector_01_complete_F"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["Sign_arrow_down_large_EP1"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["VR_3DSelector_01_incomplete_F"], 3]);
            true
        } count _delete_positions;
        {
            {
                deleteVehicle _x;
                true
            } count (nearestObjects [_x, ["VR_3DSelector_01_exit_F"], 3]);
            true
        } count _delete_positions;

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

            
                    
                    _selectedCase = (selectRandom _case_classnames);
                    

                     //Checks what box and then adds loot
                //CaseAmmo

                     if (_selectedCase == "CaseAmmo") then {
                            _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                           _weapon_mag = selectRandom _civWeaponsMagsArray;
                           _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];

                            private _max_magazines_box =  _min_magazines_box + (random(3));
                           for "_i" from 1 to ([_min_magazines_box,_max_magazines_box] call BIS_fnc_randomInt) do 
                            {
                                _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];
                            };
                            
                            if (count (_weapon_mag select 2) > 0) then
                            {
                                for "_i" from 1 to (ceil random _max_magazines_gl) do {
                                    _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 2)), 1];
                                };
                            };
                           
                        };
                //CaseMag
                     if (_selectedCase == "CaseMag") then {
                            _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                           _weapon_mag = selectRandom _civWeaponsMagsArray;
                           _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];

                           private _max_magazines_case = _min_magazines_case + (random(5));
                           for "_i" from 1 to ([_min_magazines_case,_max_magazines_case] call BIS_fnc_randomInt) do 
                            {
                                _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];
                            };
                            
                            if (count (_weapon_mag select 2) > 0) then
                            {
                                for "_i" from 1 to (ceil random _max_magazines_gl) do {
                                    _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 2)), 1];
                                };
                            };
                           
                        };
                //CaseWeapon
                     if (_selectedCase == "CaseWeapon") then {
                        _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                           _rifle_mag = selectRandom _civRiflesMagsLootArray;
                           _casebox addItemCargoGlobal [(_rifle_mag select 0), 1];

                           private _max_magazines_case = _min_magazines_case + (random(5));
                           for "_i" from 1 to ([_min_magazines_case,_max_magazines_case] call BIS_fnc_randomInt) do
                            {
                                _casebox addItemCargoGlobal [(selectRandom (_rifle_mag select 1)), 1];
                            };
                            
                            if (count (_rifle_mag select 2) > 0) then
                            {
                                for "_i" from 1 to (ceil random _max_magazines_gl) do {
                                    _casebox addItemCargoGlobal [(selectRandom (_rifle_mag select 2)), 1];
                                };
                            };
                           
                        };
                //Land_FirstAidKit_01_closed_F
                     if (_selectedCase == "Land_FirstAidKit_01_closed_F") then {
                            _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];

                                //Enables ACE Medical Facility
                                ["Land_FirstAidKit_01_closed_F", "InitPost", {
                                    params ["_vehicle"];
                                    _vehicle setVariable ["ace_medical_isMedicalFacility", true];
                                    }, nil, nil, true] call CBA_fnc_addClassEventHandler;

                                if (random 100< _advanced_med_chance) then {
                                    _casebox addItemCargoGlobal [(selectRandom _medical_loot_advanced),1];
                                };
                                //hint format ["Medical loot chance",_max_medical_loot];
                                private _max_medical_loot = _min_medical_loot + (random(25));
                           for "_i" from 1 to ([_min_medical_loot,_max_medical_loot] call BIS_fnc_randomInt) do 
                            {
                                _casebox addItemCargoGlobal [(selectRandom _medical_loot_general),1];
                                _casebox addItemCargoGlobal ["ACE_elasticBandage",1];

                                if (random 100< _blood_chance) then {
                                    _casebox addItemCargoGlobal [(selectRandom _medical_loot_blood), 1];
                                }; 
                           };                          
                        };
                //CasePistol
                    if (_selectedCase == "CasePistol") then {
                            _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                           _pistol_mag = selectRandom _civPistolsMagsLootArray;
                           _casebox addItemCargoGlobal [(_pistol_mag select 0), 1];

                           private _max_magazines_case = _min_magazines_case + (random(5));
                           for "_i" from 1 to ([_min_magazines_case,_max_magazines_case] call BIS_fnc_randomInt) do
                            {
                                _casebox addItemCargoGlobal [(selectRandom (_pistol_mag select 1)), 1];
                            };
                            
                            if (count (_pistol_mag select 2) > 0) then
                            {
                                for "_i" from 1 to (ceil random _max_magazines_gl) do {
                                    _casebox addItemCargoGlobal [(selectRandom (_pistol_mag select 2)), 1];
                                };
                            };
                           
                        };
                //CaseGrenade
                    if (_selectedCase == "CaseGrenade") then {
                        _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                           private _max_magazines_case = _min_magazines_case + (random(5));
                           for "_i" from 1 to ([_min_magazines_case,_max_magazines_case] call BIS_fnc_randomInt) do
                            {
                                _casebox addItemCargoGlobal [(selectRandom _grenade_loot ), 1];
                            };                      
                        };
                //Casefood
                    if (_selectedCase == "Casefood") then {
                        _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                           private _max_food_case = _min_food_case + (random(6));
                           for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
                            {
                                _casebox addItemCargoGlobal [(selectRandom _food_loot ), 1];
                            };                      
                        };
                //plp_ct_CartonRottenSmall
                    if (_selectedCase == "plp_ct_CartonRottenSmall") then {
                        _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                            //Need to make Junk item
                           private _max_junk_case = _min_junk_case + (random(5));
                           private _bagsAndvests_combined = _civVestLoot + _civBagLoot;
                           private _junk_loot = _item_loot + _attachment_loot + _food_loot + _uniform_loot + _civHeadgearLoot + _civFacewearLoot;;
                           private _general_loot_chance = 25;
                           private _medical_loot_chance = 15;
                           private _grenade_loot_chance = 5;
                           private _loadequip_loot_chance = 2;
                           for "_i" from 1 to ([_min_junk_case,_max_junk_case] call BIS_fnc_randomInt) do
                            {
                                if (random 100 < _general_loot_chance) then {
                                    _casebox addItemCargoGlobal [(selectRandom _civExclusiveLoot ), 1];
                                }; 
                                if (random 100 < _medical_loot_chance) then {
                                    _casebox addItemCargoGlobal [(selectRandom _medical_loot_general ), 1];
                                };
                                if (random 100 < _grenade_loot_chance) then {
                                    _casebox addItemCargoGlobal [(selectRandom _grenade_loot ), 1];
                                }; 
                                if (random 100 < _loadequip_loot_chance) then {
                                    _casebox addBackpackCargoGlobal [(selectRandom _bagsAndvests_combined ), 1];
                                }
                                else{ 
                                    _casebox addItemCargoGlobal ["ACE_CableTie", 1]; 
                                };                                                                   
                            };                      
                        };
                //plp_ct_CartonRottenMedium
                    if (_selectedCase == "plp_ct_CartonRottenMedium") then {
                        _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                            private _max_junk_case = _min_junk_case + (random(6));
                           for "_i" from 1 to ([_min_junk_case,_max_junk_case] call BIS_fnc_randomInt) do
                            {
                                _compatibleItems = [];
                                _weapon_select = selectRandom _civFirearmLoot;
                                //diag_log _weapon_select;
                                //_weaponSlots = configFile >> "CfgWeapons" >> _weapon_select >> "WeaponSlotsInfo";

                                //{_compatibleItems append (getArray (_weaponSlots >> _x >> "compatibleItems"))} forEach ["CowsSlot", "MuzzleSlot", "PointerSlot", "UnderBarrelSlot"];
                                _compatibleItems = [_weapon_select] call BIS_fnc_compatibleItems;
                                diag_log _compatibleItems;
                                //_casebox addItemCargoGlobal ["ACE_CableTie", 1];
                                _casebox addItemCargoGlobal [(selectRandom _compatibleItems), 1]; 
                                if (count _compatibleItems <= 0) then {
                                     _weapon_mag = selectRandom _civWeaponsMagsArray;
                                     _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];                                
                                    }                              
                            };                      
                        };
                // CaseMoney
                    if (_selectedCase == "CaseMoney") then {
                        _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"];
                        [_casebox] call JA_LootGen_fnc_giveCurrency;		
                        _casebox lockInventory true;
                                                  
                    };
                    //Floor Item Spawning
                }
                else {
                    _itembox = createVehicle [_box_classname, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "NONE"];

                    if (random 100 > _item_chance) then {
                        if (random 100 > _launcher_chance) then
                        {
                            _weapon_mag = selectRandom _civWeaponsMagsArray;
                            _itembox addItemCargoGlobal [(_weapon_mag select 0), 1];

                            for "_i" from 1 to (ceil random _max_magazines) do 
                            {
                                _itembox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];
                            };
                            
                            if (count (_weapon_mag select 2) > 0) then
                            {
                                for "_i" from 1 to (ceil random _max_magazines_gl) do {
                                    _itembox addItemCargoGlobal [(selectRandom (_weapon_mag select 2)), 1];
                                };
                            };
                        }
                        else {
                            _launcher_mag = selectRandom _launchers_mags_array;
                            _itembox addItemCargoGlobal [(_launcher_mag select 0), 1];

                            for "_i" from 1 to (ceil random _max_magazines_launcher) do {
                                _itembox addItemCargoGlobal [(selectRandom (_launcher_mag select 1)), 1];
                            };
                        };
                    }
                    else {
                        if (random 100 > _bagChance) then {
                            _item = selectRandom _items_array;
                            _itembox addItemCargoGlobal [_item, 1];
                        }
                        else {
                            _bag = selectRandom _civBagLoot;
                            _itembox addBackpackCargoGlobal [_bag, 1];
                        };
                    };
                    /*
                    {
                        if (random 100> _case_chance) then {
                            _casebox = createVehicle [_selectedCase, (_x vectorAdd [0, 0, 0.5]), [], 0.2, "NONE"];
                            _item = selectRandom _items_array;
                            _casebox addItemCargoGlobal [_item, 1];
                        }
                        else {

                        };
                    };
                    */
                    sleep _sleep_delay;
                };
            } count _new_positions;
        };
        sleep (1 + random 2);
    };
};