
//***** EDIT BELOW TO ADJUST BEHAVIOR

// Spawn Chances and Options
_lootToggle             = ("TFA_p_loottogle" call BIS_fnc_getParamValue) isEqualTo 1; 
_spawn_chance           = "TFA_p_spawn_chance" call BIS_fnc_getParamValue;    //chance to spawn loot at specific house position
_item_chance            = "TFA_p_item_chance" call BIS_fnc_getParamValue;   //chance to spawn an item instead of a weapon
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

// Civilian Loot and Weapons
_civPistolsArray            = ["CUP_hgun_Colt1911","rhs_weap_makarov_pm","rhs_weap_6p53"];
_civPistolMagsArray         = ["rhsusf_mag_7x45acp_MHP","rhs_mag_9x18_8_57N181S","rhs_18rnd_9x21mm_7BT3","rhs_18rnd_9x21mm_7N28"];
_civMeleeArray              = ["WBK_survival_weapon_3_r","WBK_survival_weapon_3","WBK_survival_weapon_4_r","WBK_survival_weapon_4","Axe","Rod","WBK_SmallHammer","WBK_survival_weapon_1","FireAxe","CrudeAxe","Crowbar","WBK_craftedAxe","WBK_brush_axe","WBK_BrassKnuckles","Bat_Spike","Bat_Clear","WBK_axe","Pipe_aluminium","ACE_Flashlight_Maglite_ML300L","eo_flashlight"];
_civSMGsArray               = ["UK3CB_MP5A2","rhs_weap_scorpion","uk3cb_ppsh41","rhs_weap_m3a1","uk3cb_mat49","uk3cb_mat49m","UK3CB_Tec9_Full","UK3CB_Tec9"];
_civSMGMagsArray            = ["UK3CB_Tec9_32Rnd_Magazine","UK3CB_MAT49_35Rnd_762x25_Magazine","UK3CB_MAT49_32Rnd_9x19_Magazine","uk3cb_mp5_30rnd_9x19_magazine","rhsgref_20rnd_765x17_vz61","uk3cb_mp5_30rnd_9x19_magazine_g","uk3cb_ppsh_71rnd_magazine","rhsgref_30rnd_1143x23_m1t_smg"];
_civAssaultRiflesArray      = ["rhs_weap_aks74u","rhs_weap_MP44"];
_civAssaultRifleMagsArray   = ["rhs_30rnd_545x39_7n6m_ak","rhs_30rnd_545x39_ak_green","rhsgref_30rnd_792x33_sme_stg"];
_civShotgunsArray           = ["CUP_sgun_CZ584_RIS","CUP_sgun_slamfire","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_F"];
_civShotgunMagsArray        = ["cup_1rnd_12gauge_pellets_no00_buck","cup_1rnd_12gauge_slug","cup_2rnd_12gauge_pellets_no00_buck","cup_2rnd_12gauge_pellets_no4_bird","cup_2rnd_12gauge_slug"];
_civRiflesArray             = ["CUP_srifle_Remington700","CUP_srifle_LeeEnfield_rail","CUP_srifle_LeeEnfield","UK3CB_CZ550","rhs_weap_m38","uk3cb_sks_01","CUP_srifle_Mosin_Nagant","srifle_DMR_06_hunter_F","CUP_srifle_CZ550_rail"];
_civRifleMagArray           = ["CUP_6Rnd_762x51_R700","CUP_10x_303_M","CUP_5x_22_LR_17_HMR_M","10Rnd_Mk14_762x51_Mag","uk3cb_cz550_5rnd_mag","uk3cb_cz550_5rnd_mag_g","uk3cb_10rnd_magazine_sks","rhsgref_5rnd_762x54_m38","rhsgref_10rnd_792x57_m76"];
_civMagsCombined            = _civPistolMagsArray + _civSMGMagsArray + _civAssaultRifleMagsArray + _civShotgunMagsArray + _civRifleMagArray;
_civFirearmLoot             = _civPistolsArray + _civRiflesArray + _civSMGsArray + _civAssaultRiflesArray + _civShotgunsArray;
_civWeaponsMagsArray        = [];
_civPistolsMagsLootArray    = [];
_civRiflesMagsLootArray     = [];

//Need to code in to convert strs in array to lowercase
_civMagsCombinedArray       = _civPistolMagsArray + _civSMGMagsArray + _civAssaultRifleMagsArray + _civShotgunMagsArray + _civRifleMagArray;


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
_medical_loot_general       = ["ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_painkillers"] + _bandagesList;
_medical_loot_blood         = ["ACE_bloodIV_250","ACE_bloodIV_500","ACE_bloodIV","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500"];
_medical_loot_advanced      = ["ACE_personalAidKit","FSGm_ItemMedicBag","FSGm_ItemMedicBagMil"];

// Food and Commercial Loot
_food_loot                  = ["ACE_MRE_BeefStew","ACE_MRE_ChickenTikkaMasala","ACE_MRE_ChickenHerbDumplings","ACE_MRE_CreamChickenSoup","ACE_MRE_CreamTomatoSoup","ACE_MRE_LambCurry","ACE_MRE_MeatballsPasta","ACE_MRE_SteakVegetables","ACE_Banana","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit","ACE_Canteen","ACE_Canteen_Empty","ACE_Canteen_Half","ACE_Canteen_Nearly_Empty","ACE_Canteen_Nearly_Full","ACE_WaterBottle","ACE_WaterBottle_Empty","ACE_WaterBottle_Half","ACE_WaterBottle_Nearly_Empty","ACE_Humanitarian_Ration"];
_civUniformLoot             = ["Project_BJC_PCU_Cargo25","Project_BJC_PCU_Cargo20","Project_BJC_PCU_Cargo21","Project_BJC_PCU_Cargo23","Project_BJC_PCU_Cargo24","Project_BJC_PCU_Cargo22","Project_BJC_PCU_Cargo28","Project_BJC_PCU_Cargo2","Project_BJC_PCU_Cargo10","Project_BJC_PCU_Cargo14","Project_BJC_PCU_Cargo18","Project_BJC_PCU_Cargo6","Project_BJC_PCU_Cargo8","Project_BJC_PCU_Cargo26","Project_BJC_PCU_Cargo""Project_BJC_PCU_Cargo12,","Project_BJC_PCU_Cargo16","Project_BJC_PCU_Cargo4","Project_BJC_PCU_Cargo29","Project_BJC_PCU_Cargo3","Project_BJC_PCU_Cargo11","Project_BJC_PCU_Cargo15","Project_BJC_PCU_Cargo19","Project_BJC_PCU_Cargo7","Project_BJC_PCU_Cargo5","Project_BJC_PCU_Cargo27","Project_BJC_PCU_Cargo1","Project_BJC_PCU_Cargo9","Project_BJC_PCU_Cargo13","Project_BJC_PCU_Cargo17","Project_BJC_Shirt_Cargo16","Project_BJC_Shirt_Cargo17","Project_BJC_Shirt_Cargo18","Project_BJC_Shirt_Cargo19","Project_BJC_Shirt_Cargo2","Project_BJC_Shirt_Cargo6","Project_BJC_Shirt_Cargo10","Project_BJC_Shirt_Cargo14","Project_BJC_Shirt_Cargo","Project_BJC_Shirt_Cargo4","Project_BJC_Shirt_Cargo8","Project_BJC_Shirt_Cargo12","Project_BJC_Shirt_Cargo3","Project_BJC_Shirt_Cargo7","Project_BJC_Shirt_Cargo11","Project_BJC_Shirt_Cargo15","Project_BJC_Shirt_Cargo1","Project_BJC_Shirt_Cargo5","Project_BJC_Shirt_Cargo9","Project_BJC_Shirt_Cargo13","Project_BJC_Shirt_Cut_Cargo16","Project_BJC_Shirt_Cut_Cargo17","Project_BJC_Shirt_Cut_Cargo18","Project_BJC_Shirt_Cut_Cargo19","Project_BJC_Shirt_Cut_Cargo2","Project_BJC_Shirt_Cut_Cargo6","Project_BJC_Shirt_Cut_Cargo10","Project_BJC_Shirt_Cut_Cargo14","Project_BJC_Shirt_Cut_Cargo","Project_BJC_Shirt_Cut_Cargo4","Project_BJC_Shirt_Cut_Cargo8","Project_BJC_Shirt_Cut_Cargo12","Project_BJC_Shirt_Cut_Cargo3","Project_BJC_Shirt_Cut_Cargo7","Project_BJC_Shirt_Cut_Cargo11","Project_BJC_Shirt_Cut_Cargo15","Project_BJC_Shirt_Cut_Cargo1","Project_BJC_Shirt_Cut_Cargo5","Project_BJC_Shirt_Cut_Cargo9","Project_BJC_Shirt_Cut_Cargo13","Project_BJC_Cargo16""Project_BJC_Cargo17","Project_BJC_Cargo19","Project_BJC_Cargo18","Project_BJC_Cargo2","Project_BJC_Cargo6","Project_BJC_Cargo14","Project_BJC_Cargo10","Project_BJC_Cargo","Project_BJC_Cargo4","Project_BJC_Cargo12","Project_BJC_Cargo8","Project_BJC_Cargo3","Project_BJC_Cargo7","Project_BJC_Cargo15","Project_BJC_Cargo11","Project_BJC_Cargo1","Project_BJC_Cargo5","Project_BJC_Cargo13","Project_BJC_Cargo9","Project_BJC_PCU_Jean5","Project_BJC_PCU_Jean,""Project_BJC_PCU_Jean2","Project_BJC_PCU_Jean3,""Project_BJC_PCU_Jean4,""Project_BJC_PCU_Jean1,""Project_BJC_Shirt_Jean,","Project_BJC_Shirt_Jean1","Project_BJC_Shirt_Jean2","Project_BJC_Shirt_Jean3","Project_BJC_Shirt_Cut_Jean","Project_BJC_Shirt_Cut_Jean1","Project_BJC_Shirt_Cut_Jean2","Project_BJC_Shirt_Cut_Jean3","Project_BJC""Project_BJC_2","Project_BJC_3","Project_BJC_1","Project_BJC_PCU_Jean_blk5","Project_BJC_PCU_Jean_blk","Project_BJC_PCU_Jean_blk2","Project_BJC_PCU_Jean_blk3","Project_BJC_PCU_Jean_blk4","Project_BJC_PCU_Jean_blk1","Project_BJC_Shirt_Jean_blk","Project_BJC_Shirt_Jean_blk1","Project_BJC_Shirt_Jean_blk2","Project_BJC_Shirt_Jean_blk3","Project_BJC_Shirt_Cut_Jean_blk","Project_BJC_Shirt_Cut_Jean_blk1","Project_BJC_Shirt_Cut_Jean_blk2","Project_BJC_Shirt_Cut_Jean_blk3","Project_BJC_blk""Project_BJC_blk_2","Project_BJC_blk_3","Project_BJC_blk_1","PMC_Cargo_BJCP_Tshirt_BLU","PMC_Cargo_BJCP_Tshirt_PPL","PMC_Cargo_BLK_Tshirt_BLU","PMC_Cargo_BLK_Tshirt_GRN","PMC_Cargo_BLK_Tshirt_Noori","PMC_Cargo_BLK_Tshirt_PPL","PMC_Cargo_MC_Tshirt_BLU","PMC_Cargo_MC_Tshirt_PPL","PMC_Cargo_RGR_Tshirt_BLU","PMC_Cargo_RGR_Tshirt_GRN","PMC_Cargo_RGR_Tshirt_Noori","PMC_Cargo_RGR_Tshirt_PPL","PMC_Cargo_TAN_Tshirt_BLU","PMC_Cargo_TAN_Tshirt_GRN","PMC_Cargo_TAN_Tshirt_Noori","PMC_Cargo_TAN_Tshirt_PPL","PMC_Jeans_BLK_Shirt_BLU","PMC_Jeans_BLK_Shirt_BLU_Dirty","PMC_Jeans_BLK_Shirt_WHT","PMC_Jeans_BLK_Shirt_WHT_Dirty","PMC_Jeans_Shirt_BLU""PMC_Jeans_Shirt_BLU_Dirty","PMC_Jeans_Shirt_WHT""PMC_Jeans_Shirt_WHT_Dirty","PMC_Jeans_BLK_Shirt_Cut_BLU","PMC_Jeans_BLK_Shirt_Cut_BLU_Dirty","PMC_Jeans_BLK_Shirt_Cut_WHT","PMC_Jeans_BLK_Shirt_Cut_WHT_Dirty","PMC_Jeans_Shirt_Cut_BLU","PMC_Jeans_Shirt_Cut_BLU_Dirty","PMC_Jeans_Shirt_Cut_WHT","PMC_Jeans_Shirt_Cut_WHT_Dirty","PMC_Jeans_BLK_Tshirt_BLU","PMC_Jeans_BLK_Tshirt_GRN","PMC_Jeans_BLK_Tshirt_Noori","PMC_Jeans_BLK_Tshirt_PPL","PMC_Jeans_Tshirt_BLU""PMC_Jeans_Tshirt_GRN","PMC_Jeans_Tshirt_Noori","PMC_Jeans_Tshirt_PPL"];
_civHeadgearLoot            = ["rhs_beanie_green","UK3CB_H_Beanie_02_BLK"];
_civFacewearLoot            = ["G_Balaclava_blk","G_Balaclava_lowprofile","G_Bandanna_aviator","G_Bandanna_shades"];
_item_loot                  = ["rhssaf_zrak_rd7j","ACRE_BF888S","ACE_EntrenchingTool","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_MapTools","ACE_Cellphone","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_wirecutter","ACE_Sandbag_empty","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow"];
_attachment_loot            = ["rhs_acc_pbs4","cup_optic_pem","rhs_acc_6p9_suppressor","muzzle_snds_acp"];
_civNVGs                    = ["SAN_Headlamp_v1","SAN_Headlamp_v2"];
_civVestLoot                = ["rhsgref_alice_webbing","CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing","rhsgref_chestrig","rhsgref_chicom"];
_civBagLoot                 = ["VKBO","TakedownB","Transformer","medbag","Max_Fuchs","LK3F","dikogo","DuffleBag","B_LegStrapBag_coyote_F"];
_civExclusiveLoot           = _civNVGs + _civFirearmLoot + _item_loot + _attachment_loot + _food_loot + _civUniformLoot + _civHeadgearLoot + _civFacewearLoot + _civMagsCombined + _civMagsCombined + _civFirearmLoot; //add classnames here and nothing else will be spawned
_flareLoot                  = ["ACE_HandFlare_Green","ACE_HandFlare_Red","ACE_HandFlare_White","ACE_HandFlare_Yellow"];
_civThrowables              = ["GrenadeMolotovPSRUS"];
_civGrenadesLoot            = _flareLoot + _civThrowables;
_smokegren_loot             = ["rhs_mag_rdg2_white"]; //Smoke Grenades
_hiexplogren_loot           = ["CUP_HandGrenade_RGO"]; //Offensive Grenades
_chemlightgren_loot         = ["Chemlight_blue","Chemlight_green","ACE_Chemlight_HiBlue","ACE_Chemlight_HiGreen","ACE_Chemlight_HiRed","ACE_Chemlight_HiWhite","ACE_Chemlight_HiYellow","ACE_Chemlight_Orange","Chemlight_red","ACE_Chemlight_UltraHiOrange","ACE_Chemlight_White","Chemlight_yellow"]; //Chemlight Grenades
_grenade_loot               = _smokegren_loot + _hiexplogren_loot + _chemlightgren_loot;
_industWeapons              = ["Pipe_aluminium","WBK_axe","Crowbar","WBK_survival_weapon_2","IceAxe","WBK_pipeStyledSword","Rod","Shovel_Russian_Rotated","Shovel_Russian","Axe","WBK_SmallHammer"];
_industLootAll                 = ["bolts_infinite","UK3CB_Cocaine_Brick","ACE_Flashlight_Maglite_ML300L","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_Sandbag_empty","ACE_CableTie","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow","ACE_EHP","ACE_EarPlugs","ACRE_BF888S","ACE_Chemlight_Shield","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_wirecutter","ACE_DeadManSwitch"] + _industWeapons;
_junkLoot                   = ["bolts_single","bolts_infinite"];

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
_debugObjects           = ["Sign_arrow_down_large_EP1","VR_3DSelector_01_incomplete_F","VR_3DSelector_01_exit_F","VR_3DSelector_01_default_F","VR_3DSelector_01_complete_F"];
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

