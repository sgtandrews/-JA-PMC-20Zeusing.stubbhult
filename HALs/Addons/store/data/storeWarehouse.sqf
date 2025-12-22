_magazines1 = [];
_magazines1Costs = [];
_magazines1All = [];
_smgMagazines1Costs = [];
_smgMagazines1All = [];
_smgs1 = [];
_assaults1 = [];
_shotguns1 = [];
_rifles1 = [];
_machineguns1 = [];
_launchers1 = [];
_misc1 = [];
_handguns1 = [];
_headgear1 = ["rhs_beanie_green","UK3CB_H_Beanie_02_BLK","H_Cap_tan","CUP_H_PMC_Cap_Back_Tan","UK3CB_ARD_B_H_Crew_Cap","H_ShemagOpen_tan","UK3CB_H_Shemag_blk","rhs_tsh4","UK3CB_H_Ushanka_Cap_01","rhs_ushanka","CUP_H_C_Ushanka_03","CUP_H_C_Ushanka_02","CUP_H_C_Ushanka_04","rhsgref_M56","rhs_ssh60","rhs_ssh68_2","H_Tank_eaf_F","rhssaf_helmet_m59_85_nocamo","CUP_H_SLA_Helmet_OD_worn","CUP_H_SLA_TankerHelmet"];
_primaryList = ["CUP_srifle_Remington700","CUP_srifle_LeeEnfield_rail","CUP_srifle_LeeEnfield","UK3CB_CZ550","rhs_weap_m38","uk3cb_sks_01","CUP_srifle_Mosin_Nagant","srifle_DMR_06_hunter_F","CUP_srifle_CZ550_rail","rhs_weap_scorpion","uk3cb_ppsh41","rhs_weap_m3a1","uk3cb_mat49","uk3cb_mat49m","UK3CB_Tec9_Full","UK3CB_Tec9","rhs_weap_aks74u","rhs_weap_MP44","CUP_sgun_CZ584_RIS","CUP_sgun_slamfire","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_F","rhs_weap_kar98k","rhs_weap_Izh18","CUP_SKS","CUP_smg_Mac10","CUP_smg_SA61","CUP_smg_UZI","rhs_weap_mosin_sbr"];
_handgunList = ["CUP_hgun_Colt1911","rhs_weap_makarov_pm","rhs_weap_6p53","rhs_weap_tt33","rhs_weap_pb_6p9","rhs_weap_savz61_folded","rhs_weap_cz99","hgun_P07_blk_F","rhsusf_weap_m9","CUP_hgun_Browning_HP","CUP_hgun_SA61","rhs_weap_pya","hlc_pistol_C96_Wartime"];
_launchersList = [];
_firearmList = _handgunList + _primaryList + _launchersList;
{

_weaponType = getText (configFile >> "CfgWeapons" >> _x >> "cursor");
switch (_weaponType) do {
	case ("srifle"): {_rifles1 pushBackUnique _x};
	case ("mg"): {_machineguns1 pushBackUnique _x};
	case ("arifle"): {_assaults1 pushBackUnique _x};
	case ("sgun"): {_shotguns1 pushBackUnique _x};
	case ("smg"): {_smgs1 pushBackUnique _x};
	case ("hgun"): {_handguns1 pushBackUnique _x};
	case ("missile"): {_launchers1 pushBackUnique _x};
	case ("rocket"): {_launchers1 pushBackUnique _x};
	default {_misc1 pushBackUnique _x};	

};

}forEach _firearmList;


_uniforms1 = ["U_C_PilotJacket_black_RF","U_C_PilotJacket_open_black_RF","U_C_PilotJacket_brown_RF","U_C_PilotJacket_open_brown_RF","U_C_PilotJacket_lbrown_RF","U_C_PilotJacket_open_lbrown_RF","CUP_U_C_Tracksuit_02","Project_BJC_PCU_Cargo25","Project_BJC_PCU_Cargo20","Project_BJC_PCU_Cargo21","Project_BJC_PCU_Cargo23","Project_BJC_PCU_Cargo24","Project_BJC_PCU_Cargo22","Project_BJC_PCU_Cargo28","Project_BJC_PCU_Cargo2","Project_BJC_PCU_Cargo10","Project_BJC_PCU_Cargo14","Project_BJC_PCU_Cargo18","Project_BJC_PCU_Cargo6","Project_BJC_PCU_Cargo8","Project_BJC_PCU_Cargo26","Project_BJC_PCU_Cargo16","Project_BJC_PCU_Cargo4","Project_BJC_PCU_Cargo29","Project_BJC_PCU_Cargo3","Project_BJC_PCU_Cargo11","Project_BJC_PCU_Cargo15","Project_BJC_PCU_Cargo19","Project_BJC_PCU_Cargo7","Project_BJC_PCU_Cargo5","Project_BJC_PCU_Cargo27","Project_BJC_PCU_Cargo1","Project_BJC_PCU_Cargo9","Project_BJC_PCU_Cargo13","Project_BJC_PCU_Cargo17","Project_BJC_Shirt_Cargo16","Project_BJC_Shirt_Cargo17","Project_BJC_Shirt_Cargo18","Project_BJC_Shirt_Cargo19","Project_BJC_Shirt_Cargo2","Project_BJC_Shirt_Cargo6","Project_BJC_Shirt_Cargo10","Project_BJC_Shirt_Cargo14","Project_BJC_Shirt_Cargo","Project_BJC_Shirt_Cargo4","Project_BJC_Shirt_Cargo8","Project_BJC_Shirt_Cargo12","Project_BJC_Shirt_Cargo3","Project_BJC_Shirt_Cargo7","Project_BJC_Shirt_Cargo11","Project_BJC_Shirt_Cargo15","Project_BJC_Shirt_Cargo1","Project_BJC_Shirt_Cargo5","Project_BJC_Shirt_Cargo9","Project_BJC_Shirt_Cargo13","Project_BJC_Shirt_Cut_Cargo16","Project_BJC_Shirt_Cut_Cargo17","Project_BJC_Shirt_Cut_Cargo18","Project_BJC_Shirt_Cut_Cargo19","Project_BJC_Shirt_Cut_Cargo2","Project_BJC_Shirt_Cut_Cargo6","Project_BJC_Shirt_Cut_Cargo10","Project_BJC_Shirt_Cut_Cargo14","Project_BJC_Shirt_Cut_Cargo","Project_BJC_Shirt_Cut_Cargo4","Project_BJC_Shirt_Cut_Cargo8","Project_BJC_Shirt_Cut_Cargo12","Project_BJC_Shirt_Cut_Cargo3","Project_BJC_Shirt_Cut_Cargo7","Project_BJC_Shirt_Cut_Cargo11","Project_BJC_Shirt_Cut_Cargo15","Project_BJC_Shirt_Cut_Cargo1","Project_BJC_Shirt_Cut_Cargo5","Project_BJC_Shirt_Cut_Cargo9","Project_BJC_Shirt_Cut_Cargo13","Project_BJC_Cargo19","Project_BJC_Cargo18","Project_BJC_Cargo2","Project_BJC_Cargo6","Project_BJC_Cargo14","Project_BJC_Cargo10","Project_BJC_Cargo","Project_BJC_Cargo4","Project_BJC_Cargo12","Project_BJC_Cargo8","Project_BJC_Cargo3","Project_BJC_Cargo7","Project_BJC_Cargo15","Project_BJC_Cargo11","Project_BJC_Cargo1","Project_BJC_Cargo5","Project_BJC_Cargo13","Project_BJC_Cargo9","Project_BJC_PCU_Jean5","Project_BJC_Shirt_Jean1","Project_BJC_Shirt_Jean2","Project_BJC_Shirt_Jean3","Project_BJC_Shirt_Cut_Jean","Project_BJC_Shirt_Cut_Jean1","Project_BJC_Shirt_Cut_Jean2","Project_BJC_Shirt_Cut_Jean3","Project_BJC_3","Project_BJC_1","Project_BJC_PCU_Jean_blk5","Project_BJC_PCU_Jean_blk","Project_BJC_PCU_Jean_blk2","Project_BJC_PCU_Jean_blk3","Project_BJC_PCU_Jean_blk4","Project_BJC_PCU_Jean_blk1","Project_BJC_Shirt_Jean_blk","Project_BJC_Shirt_Jean_blk1","Project_BJC_Shirt_Jean_blk2","Project_BJC_Shirt_Jean_blk3","Project_BJC_Shirt_Cut_Jean_blk","Project_BJC_Shirt_Cut_Jean_blk1","Project_BJC_Shirt_Cut_Jean_blk2","Project_BJC_Shirt_Cut_Jean_blk3","Project_BJC_blk_3","Project_BJC_blk_1","PMC_Cargo_BJCP_Tshirt_BLU","PMC_Cargo_BJCP_Tshirt_PPL","PMC_Cargo_BLK_Tshirt_BLU","PMC_Cargo_BLK_Tshirt_GRN","PMC_Cargo_BLK_Tshirt_Noori","PMC_Cargo_BLK_Tshirt_PPL","PMC_Cargo_MC_Tshirt_BLU","PMC_Cargo_MC_Tshirt_PPL","PMC_Cargo_RGR_Tshirt_BLU","PMC_Cargo_RGR_Tshirt_GRN","PMC_Cargo_RGR_Tshirt_Noori","PMC_Cargo_RGR_Tshirt_PPL","PMC_Cargo_TAN_Tshirt_BLU","PMC_Cargo_TAN_Tshirt_GRN","PMC_Cargo_TAN_Tshirt_Noori","PMC_Cargo_TAN_Tshirt_PPL","PMC_Jeans_BLK_Shirt_BLU","PMC_Jeans_BLK_Shirt_BLU_Dirty","PMC_Jeans_BLK_Shirt_WHT","PMC_Jeans_BLK_Shirt_WHT_Dirty","PMC_Jeans_BLK_Shirt_Cut_BLU","PMC_Jeans_BLK_Shirt_Cut_BLU_Dirty","PMC_Jeans_BLK_Shirt_Cut_WHT","PMC_Jeans_BLK_Shirt_Cut_WHT_Dirty","PMC_Jeans_Shirt_Cut_BLU","PMC_Jeans_Shirt_Cut_BLU_Dirty","PMC_Jeans_Shirt_Cut_WHT","PMC_Jeans_Shirt_Cut_WHT_Dirty","PMC_Jeans_BLK_Tshirt_BLU","PMC_Jeans_BLK_Tshirt_GRN","PMC_Jeans_BLK_Tshirt_Noori","PMC_Jeans_BLK_Tshirt_PPL","PMC_Jeans_Tshirt_Noori","PMC_Jeans_Tshirt_PPL","CUP_U_C_Tracksuit_01","CUP_U_C_Tracksuit_04","CUP_U_C_Tracksuit_03","Civie_V1_Blk","Civie_V1_Olv","Civie_V1_Red","Civie_V2_Blk","Civie_V2_Olv","Civie_V2_Red","Civie_V3_Blk","Civie_V3_Olv","Civie_V3_Red","eo_bandit","eo_bandit_1","eo_bandit_2","eo_diamond_2","eo_hoodie_bandit","eo_hoodie_grey","eo_hoodie_kabeiroi","eo_hoodie_red","eo_retro_bandit","eo_shirt_plainblu","Project_BJC_Cargo16","Project_BJC_PCU_Jean","Project_BJC_PCU_Jean2","Project_BJC_PCU_Jean1","Project_BJC","Project_BJC_2","Project_BJC_blk","Project_BJC_blk_2","UK3CB_MEC_C_U_CIT_02","UK3CB_MEC_C_U_CIT_04","UK3CB_CHC_C_U_CIT_05","UK3CB_MEC_C_U_CIT_01","UK3CB_MEC_C_U_CIT_05","UK3CB_CHC_C_U_CIT_01","UK3CB_MEC_C_U_CIT_03","UK3CB_CHC_C_U_CIT_04","UK3CB_CHC_C_U_CIT_02","UK3CB_CHC_C_U_CIT_03"];
_vests1 = ["rhsgref_alice_webbing","CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing","rhsgref_chestrig","rhsgref_chicom","CUP_V_CDF_CrewBelt","rhs_gear_OFF","V_AG_Invisible","rhs_vest_pistol_holster","rhs_vest_commander","V_Rangemaster_belt","PMC_Vest_RangeBelt_Black","rhs_suspender_ak4","rhs_suspender_SKS","CUP_V_OI_TKI_Jacket1_04","CUP_V_OI_TKI_Jacket1_06","CUP_V_OI_TKI_Jacket1_05","CUP_V_OI_TKI_Jacket1_03","eo_rangemaster_1","eo_rangemaster_3","eo_rangemaster_4","eo_rangemaster_2","CUP_V_CDF_OfficerBelt2","CUP_V_CDF_OfficerBelt","rhs_suspender_ak","CUP_V_O_TK_OfficerBelt2","CUP_V_O_TK_OfficerBelt","FP_Cartel_Hunting_Vest","eo_multipocket_1","eo_multipocket_2","eo_multipocket_3","eo_multipocket_5","eo_multipocket_4","V_Pocketed_black_F","UK3CB_MEC_C_V_Pocketed_BRN","V_Pocketed_coyote_F","UK3CB_MEC_C_V_Pocketed_GRY","UK3CB_MEC_C_V_Pocketed_KHK","UK3CB_MEC_C_V_Pocketed_OLI","V_Pocketed_olive_F","UK3CB_V_Pocketed_Vest_PAN","UK3CB_V_Pocketed_Vest_TTSKO_BRN","UK3CB_V_Pocketed_Vest_TTSKO_FOR","AUSPAT_Belt_MG_BLK","AUSPAT_Belt_MG_BRN","AUSPAT_Belt_MG_GRN","AUSPAT_Belt_MG_TAN","AUSPAT_Belt_Rifleman_BLK","AUSPAT_Belt_Rifleman_BRN","AUSPAT_Belt_Rifleman_GRN","AUSPAT_Belt_Rifleman_TAN","Assault_vest","BlackRock_vest","eo_bandolier_1","eo_bandolier_3","eo_bandolier_4","eo_bandolier_2","eo_legstrapbag_1","eo_legstrapbag_2","eo_legstrapbag_4","eo_legstrapbag_3","Belt_fc_GRY","Belt_gbrs_GRY","V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F","rhs_suspender_AK8_chestrig","CUP_V_OI_TKI_Jacket4_05","CUP_V_OI_TKI_Jacket4_06","CUP_V_OI_TKI_Jacket4_01","CUP_V_OI_TKI_Jacket5_04","CUP_V_OI_TKI_Jacket5_05","CUP_V_OI_TKI_Jacket5_06","CUP_V_OI_TKI_Jacket5_01","CUP_V_OI_TKI_Jacket3_04","CUP_V_OI_TKI_Jacket3_05","CUP_V_OI_TKI_Jacket3_06","CUP_V_OI_TKI_Jacket3_01","CUP_V_OI_TKI_Jacket6_04","CUP_V_OI_TKI_Jacket6_05","CUP_V_OI_TKI_Jacket2_04","CUP_V_OI_TKI_Jacket2_06","CUP_V_OI_TKI_Jacket2_05","CUP_V_OI_TKI_Jacket2_01","CUP_V_O_SLA_Carrier_Belt02","rhs_vydra_3m","UK3CB_TKA_I_V_vydra_3m_Tan","Bearing","V_Chestrig_khk","V_SmershVest_01_F","CUP_V_RUS_Smersh_New_Full","UK3CB_TKA_I_V_6Sh92_vog_Khk","UK3CB_ADA_B_V_TacVest_KHK"];
_bags1 = ["VKBO","TakedownB","Transformer","medbag","Max_Fuchs","LK3F","dikogo","DuffleBag","B_LegStrapBag_coyote_F","rhs_medic_bag","UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF","B_Messenger_Coyote_F","CUP_B_AssaultPack_Coyote"];
_headgear1 = ["UK3CB_G_Ballistic_Shemagh_Tan_Gloves_Black","rhs_beanie_green","UK3CB_H_Beanie_02_BLK","SP_BaseballCap_Black","H_Cap_tan","CUP_H_PMC_Cap_Back_Tan","UK3CB_ARD_B_H_Crew_Cap","H_ShemagOpen_tan","UK3CB_H_Shemag_blk","rhs_tsh4","SP_TSH04Helmet_Black","UK3CB_H_Ushanka_Cap_01","rhs_ushanka","CUP_H_C_Ushanka_03","CUP_H_C_Ushanka_02","CUP_H_C_Ushanka_04","rhsgref_M56","rhs_ssh60","rhs_ssh68_2","H_Tank_eaf_F","rhssaf_helmet_m59_85_nocamo","CUP_H_SLA_Helmet_OD_worn","CUP_H_SLA_TankerHelmet","rhs_beanie_green","UK3CB_H_Beanie_02_BLK","rhs_beanie_green","UK3CB_H_Beanie_02_BLK","H_Cap_tan","CUP_H_PMC_Cap_Back_Tan","UK3CB_ARD_B_H_Crew_Cap","H_ShemagOpen_tan","UK3CB_H_Shemag_blk","rhs_tsh4","UK3CB_H_Ushanka_Cap_01","rhs_ushanka","CUP_H_C_Ushanka_03","CUP_H_C_Ushanka_02","CUP_H_C_Ushanka_04","rhsgref_M56","rhs_ssh60","rhs_ssh68_2","H_Tank_eaf_F","rhssaf_helmet_m59_85_nocamo","CUP_H_SLA_Helmet_OD_worn","CUP_H_SLA_TankerHelmet"];
/*
_smgs1 = ["rhs_weap_scorpion","uk3cb_ppsh41","rhs_weap_m3a1","uk3cb_mat49","uk3cb_mat49m","UK3CB_Tec9_Full","UK3CB_Tec9"];
_assaults1 = ["rhs_weap_aks74u","rhs_weap_MP44"];
_shotguns1 = ["CUP_sgun_CZ584_RIS","CUP_sgun_slamfire","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_F"];
_rifles1 = ["CUP_srifle_Remington700","CUP_srifle_LeeEnfield_rail","CUP_srifle_LeeEnfield","UK3CB_CZ550","rhs_weap_m38","uk3cb_sks_01","CUP_srifle_Mosin_Nagant","srifle_DMR_06_hunter_F","CUP_srifle_CZ550_rail"];
_mainarms1 = _smgs1 + _assaults1 + _shotguns1 + _rifles1;

*/

[_handguns1,"handguns1","Weapon",2] call HALs_store_fnc_automateStock;
[_smgs1,"smgs1","Weapon",2] call HALs_store_fnc_automateStock;
[_assaults1,"assaults1","Weapon",2] call HALs_store_fnc_automateStock;
[_rifles1,"rifles1","Weapon",2] call HALs_store_fnc_automateStock;
[_shotguns1,"shotguns1","Weapon",2] call HALs_store_fnc_automateStock;
[_machineguns1,"machineguns1","Weapon",2] call HALs_store_fnc_automateStock;
[_launchers1,"launchers1","Weapon",2] call HALs_store_fnc_automateStock;
[_misc1,"misc1","Weapon",2] call HALs_store_fnc_automateStock;
[_uniforms1,"uniforms1","Uniform",2] call HALs_store_fnc_automateStock;
[_vests1,"vests1","Vest",2] call HALs_store_fnc_automateStock;
[_bags1,"bags1","Bag",2] call HALs_store_fnc_automateStock;
[_headgear1,"headgear1","Uniform",2] call HALs_store_fnc_automateStock;

missionNamespace setVariable ["magazines1",[_magazines1Costs,_magazines1All,15]];
