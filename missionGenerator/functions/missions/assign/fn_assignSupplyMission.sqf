/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_assignSuppliesMission

Description:
    Assigns Player/Group a Supply Mission

Parameters:
    _caller   - The player calling it
    _supplyType  - The type of Supplies. e.g Medical, Ammo etc
	_missionGiver - The object that gives the mission.
	_supplySize - How many items needed

Returns:
	None

Examples:
    (begin example)
        [_caller, _supplyType, _missionGiver,_supplySize] call JA_MISSIONGEN_fnc_assignSupplyMission;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params ["_caller",["_supplyType","Random"],"_missionGiver",["_supplySize","Random"]];


_caller = _this select 0;
_supplyType = _this select 1;
_missionGiver = _this select 2;
_supplySize = _this select 3;
diag_log _supplySize;
_employerName = [_missionGiver] call BIS_fnc_getName;
_itemType = [];
_requiredAmount = [];
_itemDisplayName = "";
_moneyReward = 0;
_bandagesList               = ["ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_quikclot"];
medicalLootGeneral       	= ["ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_painkillers","ACE_suture"];
_medical_loot_blood         = ["ACE_bloodIV_250","ACE_bloodIV_500","ACE_bloodIV","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500"];
_medical_loot_advanced      = ["ACE_personalAidKit","FSGm_ItemMedicBag","FSGm_ItemMedicBagMil","ACE_surgicalKit"];
_food_loot                  = ["ACE_MRE_BeefStew","ACE_MRE_ChickenTikkaMasala","ACE_MRE_ChickenHerbDumplings","ACE_MRE_CreamChickenSoup","ACE_MRE_CreamTomatoSoup","ACE_MRE_LambCurry","ACE_MRE_MeatballsPasta","ACE_MRE_SteakVegetables","ACE_Banana","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit","ACE_Canteen","ACE_Canteen_Empty","ACE_Canteen_Half","ACE_Canteen_Nearly_Empty","ACE_Canteen_Nearly_Full","ACE_WaterBottle","ACE_WaterBottle_Empty","ACE_WaterBottle_Half","ACE_WaterBottle_Nearly_Empty","ACE_Humanitarian_Ration"];
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
_civUniformLoot             = ["Project_BJC_PCU_Cargo25","Project_BJC_PCU_Cargo20","Project_BJC_PCU_Cargo21","Project_BJC_PCU_Cargo23","Project_BJC_PCU_Cargo24","Project_BJC_PCU_Cargo22","Project_BJC_PCU_Cargo28","Project_BJC_PCU_Cargo2","Project_BJC_PCU_Cargo10","Project_BJC_PCU_Cargo14","Project_BJC_PCU_Cargo18","Project_BJC_PCU_Cargo6","Project_BJC_PCU_Cargo8","Project_BJC_PCU_Cargo26","Project_BJC_PCU_Cargo""Project_BJC_PCU_Cargo12,","Project_BJC_PCU_Cargo16","Project_BJC_PCU_Cargo4","Project_BJC_PCU_Cargo29","Project_BJC_PCU_Cargo3","Project_BJC_PCU_Cargo11","Project_BJC_PCU_Cargo15","Project_BJC_PCU_Cargo19","Project_BJC_PCU_Cargo7","Project_BJC_PCU_Cargo5","Project_BJC_PCU_Cargo27","Project_BJC_PCU_Cargo1","Project_BJC_PCU_Cargo9","Project_BJC_PCU_Cargo13","Project_BJC_PCU_Cargo17","Project_BJC_Shirt_Cargo16","Project_BJC_Shirt_Cargo17","Project_BJC_Shirt_Cargo18","Project_BJC_Shirt_Cargo19","Project_BJC_Shirt_Cargo2","Project_BJC_Shirt_Cargo6","Project_BJC_Shirt_Cargo10","Project_BJC_Shirt_Cargo14","Project_BJC_Shirt_Cargo","Project_BJC_Shirt_Cargo4","Project_BJC_Shirt_Cargo8","Project_BJC_Shirt_Cargo12","Project_BJC_Shirt_Cargo3","Project_BJC_Shirt_Cargo7","Project_BJC_Shirt_Cargo11","Project_BJC_Shirt_Cargo15","Project_BJC_Shirt_Cargo1","Project_BJC_Shirt_Cargo5","Project_BJC_Shirt_Cargo9","Project_BJC_Shirt_Cargo13","Project_BJC_Shirt_Cut_Cargo16","Project_BJC_Shirt_Cut_Cargo17","Project_BJC_Shirt_Cut_Cargo18","Project_BJC_Shirt_Cut_Cargo19","Project_BJC_Shirt_Cut_Cargo2","Project_BJC_Shirt_Cut_Cargo6","Project_BJC_Shirt_Cut_Cargo10","Project_BJC_Shirt_Cut_Cargo14","Project_BJC_Shirt_Cut_Cargo","Project_BJC_Shirt_Cut_Cargo4","Project_BJC_Shirt_Cut_Cargo8","Project_BJC_Shirt_Cut_Cargo12","Project_BJC_Shirt_Cut_Cargo3","Project_BJC_Shirt_Cut_Cargo7","Project_BJC_Shirt_Cut_Cargo11","Project_BJC_Shirt_Cut_Cargo15","Project_BJC_Shirt_Cut_Cargo1","Project_BJC_Shirt_Cut_Cargo5","Project_BJC_Shirt_Cut_Cargo9","Project_BJC_Shirt_Cut_Cargo13","Project_BJC_Cargo16""Project_BJC_Cargo17","Project_BJC_Cargo19","Project_BJC_Cargo18","Project_BJC_Cargo2","Project_BJC_Cargo6","Project_BJC_Cargo14","Project_BJC_Cargo10","Project_BJC_Cargo","Project_BJC_Cargo4","Project_BJC_Cargo12","Project_BJC_Cargo8","Project_BJC_Cargo3","Project_BJC_Cargo7","Project_BJC_Cargo15","Project_BJC_Cargo11","Project_BJC_Cargo1","Project_BJC_Cargo5","Project_BJC_Cargo13","Project_BJC_Cargo9","Project_BJC_PCU_Jean5","Project_BJC_PCU_Jean,""Project_BJC_PCU_Jean2","Project_BJC_PCU_Jean3,""Project_BJC_PCU_Jean4,""Project_BJC_PCU_Jean1,""Project_BJC_Shirt_Jean,","Project_BJC_Shirt_Jean1","Project_BJC_Shirt_Jean2","Project_BJC_Shirt_Jean3","Project_BJC_Shirt_Cut_Jean","Project_BJC_Shirt_Cut_Jean1","Project_BJC_Shirt_Cut_Jean2","Project_BJC_Shirt_Cut_Jean3","Project_BJC""Project_BJC_2","Project_BJC_3","Project_BJC_1","Project_BJC_PCU_Jean_blk5","Project_BJC_PCU_Jean_blk","Project_BJC_PCU_Jean_blk2","Project_BJC_PCU_Jean_blk3","Project_BJC_PCU_Jean_blk4","Project_BJC_PCU_Jean_blk1","Project_BJC_Shirt_Jean_blk","Project_BJC_Shirt_Jean_blk1","Project_BJC_Shirt_Jean_blk2","Project_BJC_Shirt_Jean_blk3","Project_BJC_Shirt_Cut_Jean_blk","Project_BJC_Shirt_Cut_Jean_blk1","Project_BJC_Shirt_Cut_Jean_blk2","Project_BJC_Shirt_Cut_Jean_blk3","Project_BJC_blk""Project_BJC_blk_2","Project_BJC_blk_3","Project_BJC_blk_1","PMC_Cargo_BJCP_Tshirt_BLU","PMC_Cargo_BJCP_Tshirt_PPL","PMC_Cargo_BLK_Tshirt_BLU","PMC_Cargo_BLK_Tshirt_GRN","PMC_Cargo_BLK_Tshirt_Noori","PMC_Cargo_BLK_Tshirt_PPL","PMC_Cargo_MC_Tshirt_BLU","PMC_Cargo_MC_Tshirt_PPL","PMC_Cargo_RGR_Tshirt_BLU","PMC_Cargo_RGR_Tshirt_GRN","PMC_Cargo_RGR_Tshirt_Noori","PMC_Cargo_RGR_Tshirt_PPL","PMC_Cargo_TAN_Tshirt_BLU","PMC_Cargo_TAN_Tshirt_GRN","PMC_Cargo_TAN_Tshirt_Noori","PMC_Cargo_TAN_Tshirt_PPL","PMC_Jeans_BLK_Shirt_BLU","PMC_Jeans_BLK_Shirt_BLU_Dirty","PMC_Jeans_BLK_Shirt_WHT","PMC_Jeans_BLK_Shirt_WHT_Dirty","PMC_Jeans_Shirt_BLU""PMC_Jeans_Shirt_BLU_Dirty","PMC_Jeans_Shirt_WHT""PMC_Jeans_Shirt_WHT_Dirty","PMC_Jeans_BLK_Shirt_Cut_BLU","PMC_Jeans_BLK_Shirt_Cut_BLU_Dirty","PMC_Jeans_BLK_Shirt_Cut_WHT","PMC_Jeans_BLK_Shirt_Cut_WHT_Dirty","PMC_Jeans_Shirt_Cut_BLU","PMC_Jeans_Shirt_Cut_BLU_Dirty","PMC_Jeans_Shirt_Cut_WHT","PMC_Jeans_Shirt_Cut_WHT_Dirty","PMC_Jeans_BLK_Tshirt_BLU","PMC_Jeans_BLK_Tshirt_GRN","PMC_Jeans_BLK_Tshirt_Noori","PMC_Jeans_BLK_Tshirt_PPL","PMC_Jeans_Tshirt_BLU""PMC_Jeans_Tshirt_GRN","PMC_Jeans_Tshirt_Noori","PMC_Jeans_Tshirt_PPL"];
_civHeadgearLoot            = ["rhs_beanie_green","UK3CB_H_Beanie_02_BLK"];
_civFacewearLoot            = ["G_Balaclava_blk","G_Balaclava_lowprofile","G_Bandanna_aviator","G_Bandanna_shades"];
_civBagLoot                 = ["VKBO","TakedownB","Transformer","medbag","Max_Fuchs","LK3F","dikogo","DuffleBag","B_LegStrapBag_coyote_F"];
_industLootAll                 = ["bolts_infinite","UK3CB_Cocaine_Brick","ACE_Flashlight_Maglite_ML300L","ACE_rope12","ACE_rope15","ACE_rope18","ACE_rope27","ACE_rope3","ACE_rope36","ACE_rope6","ACE_Sandbag_empty","ACE_CableTie","ACE_SpraypaintBlack","ACE_SpraypaintBlue","ACE_SpraypaintGreen","ACE_SpraypaintRed","ACE_SpraypaintWhite","ACE_SpraypaintYellow","ACE_EHP","ACE_EarPlugs","ACRE_BF888S","ACE_Chemlight_Shield","ACE_Flashlight_XL50","acex_intelitems_notepad","ACE_wirecutter","ACE_DeadManSwitch"];
_industAdv                  = ["ACRE_BF888S","ToolKit","ACE_wirecutter"];
_taskDescription = selectRandom ["STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET2","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET3","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET4","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET5","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET6","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET7","STR_TFA_DESCRIP_MISSION_SUPPLY_TARGET8"];


switch (_supplyType) do {

	case "Medical": {
		_itemType = (selectRandom medicalLootGeneral);
		};
	case "Advanced Medical": {
		_itemType = (selectRandom _medical_loot_advanced);
	};	
	case "Food": {
		_itemType = (selectRandom _food_loot);
		};
	case "Mags": {
		_itemType = (selectRandom _civMagsCombined);
		};
	case "Firearm": {
		_itemType = (selectRandom _civFirearmLoot);
		};
	case "Uniform": {
		_itemType = (selectRandom _civUniformLoot);
		};
	case "Headgear": {
		_itemType = (selectRandom _civHeadgearLoot);
		};
	case "Facewear": {
		_itemType = (selectRandom _civFacewearLoot);
		};
	case "Bag": {
		_itemType = (selectRandom _civBagLoot);
		};
	case "Industrial": {
		_itemType = (selectRandom _industLootAll);
		};
	case "Advanced Industrial": {
		_itemType = (selectRandom _industAdv);
		}; 
	case "Random": {
		_itemType = (selectRandom ( selectRandom [medicalLootGeneral,_medical_loot_blood,_food_loot,_civMagsCombined,_industLootAll]));
		};
	default {
		_itemType = (selectRandom ( selectRandom [medicalLootGeneral,_medical_loot_blood,_food_loot,_civMagsCombined,_industLootAll]));
	};
};

if !(configName (configFile >> "CfgWeapons" >> _itemType >> "acex_field_rations_refillItem") isEqualTo "") then 
		{
			_itemType = getText (configFile >> "CfgWeapons" >> _itemType >> "acex_field_rations_refillItem");
		};

switch (true) do {
		case ((isClass (configFile >> "CfgWeapons" >> _itemType))): {_itemDisplayName = getText(configFile >> "CfgWeapons" >> _itemType >> "displayName");};
		case ((isClass (configFile >> "CfgMagazines" >> _itemType))): {_itemDisplayName = getText(configFile >> "CfgMagazines" >> _itemType >> "displayName");};
		case ((isClass (configFile >> "CfgVehicles" >> _itemType))): {_itemDisplayName = getText(configFile >> "CfgVehicles" >> _itemType >> "displayName");};
		case ((isClass (configFile >> "CfgGlasses" >> _itemType))): {_itemDisplayName = getText(configFile >> "CfgGlasses" >> _itemType >> "displayName");};
};


switch (_supplySize) do {
	case "Small": {_requiredAmount = 2;};
	case "Medium": {_requiredAmount = 4;}; 
	case "Large": {_requiredAmount = 6;};
	case "Extra Large": {_requiredAmount = 8;};
	case "Random": {_requiredAmount = selectRandom [2,4,6,8];};
	case "Single": {_requiredAmount = 1;};
	default {_requiredAmount = selectRandom [2,4,6,8];};
};

_moneyReward = _requiredAmount * (3 * (([HALs_item_price, _itemType, 0] call HALs_store_fnc_hashGetOrDefault) * HALs_store_sellFactor));

switch (_supplyType) do {

	case "Firearm": 
	{
		[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Gun Run</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Firearm Requested: %1</t><br/>",_itemDisplayName],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Amount: %1</t><br/>",_requiredAmount],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;
	};
	case "Advanced Medical": 
	{
		[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Advanced Medical Supply </t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Medical Item Requested: %1</t><br/>",_itemDisplayName],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Amount: %1</t><br/>",_requiredAmount],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;
	};
	case "Advanced Industrial": 
	{
		[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Advanced Industrial Supply </t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Medical Item Requested: %1</t><br/>",_itemDisplayName],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Amount: %1</t><br/>",_requiredAmount],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;
	}; 
	default 
	{
		[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Supply</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Type of Supplies: %1</t><br/>",_supplyType],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Amount: %1 %2</t><br/>",_requiredAmount,_itemDisplayName],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;
	};
};

playSoundUI ["PDA_guide"];



_taskID = [_caller,_supplyType,_itemType,_requiredAmount,_missionGiver] joinString "-";
diag_log _taskID;

[_caller, 
_taskID,
[ 
 [_taskDescription,_requiredAmount,_itemDisplayName],["STR_TFA_TITLE_MISSION_SUPPLY_TARGET",_requiredAmount,_itemDisplayName,_employerName],""
],
objNull, 
"ASSIGNED", 
-1, false, 
"BACKPACK", 
false
] call BIS_fnc_taskCreate;

if (("TFA_p_spawn_debug" call BIS_fnc_getParamValue) isEqualTo 1) then 
{
	(missionNamespace getVariable "debugContainer") addItemCargoGlobal [_itemType, _requiredAmount];
	if (_supplyType == "Bag") then {(missionNamespace getVariable "debugContainer") addBackpackCargo [_itemType,_requiredAmount]};
};

[_requiredAmount,_itemType,_missionGiver,_taskID,_caller,_supplyType,_itemDisplayName,_moneyReward,_supplySize] spawn {
_requiredAmount = _this select 0;
_itemType = _this select 1;
_missionGiver = _this select 2;
_taskID = _this select 3;
_caller = _this select 4;
_supplyType = _this select 5;
_itemDisplayName = _this select 6;
_moneyReward = _this select 7;
_supplySize = _this select 8;
if (_supplyType == "Bag") then {waitUntil {uiSleep 2; ({_x == _itemType} count (backpacks _caller)) >= _requiredAmount;};} else {waitUntil {uiSleep 2; ({_x == _itemType} count (itemsWithMagazines _caller)) >= _requiredAmount;};};

playSoundUI ["PDA_beep_1"];

[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Acquired</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>%1 %2</t><br/>",_requiredAmount,_itemDisplayName],0.4,1],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>for %1</t><br/>",([_missionGiver] call BIS_fnc_getName)],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP; 

_missionGiver addAction
    [
    	format[localize "STR_TFA_DESCRIP_DELIVER_SUPPLY_ACTION",_requiredAmount,_itemDisplayName],	
    	{
    		params ["_target", "_caller", "_actionId","_arguments"];
    		_missionGiver = (_this select 3 select 0);
    		_itemType = (_this select 3 select 1);
    		_requiredAmount = (_this select 3 select 2);
    		_taskID = (_this select 3 select 3);
            _supplyType = (_this select 3 select 4);
			_itemDisplayName = (_this select 3 select 5);
			_moneyReward = (_this select 3 select 6);
			_supplySize = (_this select 3 select 7);
			_caller = _this select 1;
    		if ((({_x == _itemType} count (itemsWithMagazines _caller)) >= _requiredAmount) or (({_x == _itemType} count (backpacks _caller)) >= _requiredAmount)) then {
    			playSoundUI ["PDA_beep_2"];
				[_moneyReward,0,1] remoteExecCall ["HG_fnc_addOrSubCash",_caller,false];
				//[_caller, _moneyReward] call HALs_money_fnc_addFunds;
				//[_missionGiver, _itemType, _requiredAmount] call HALs_store_fnc_updateStock;
				[_missionGiver, _itemType, _requiredAmount] remoteExecCall ["HALs_store_fnc_updateStock",2];
    			for [{_i = 0},{_i < _requiredAmount},{_i = _i + 1}] do 
    			{
    				_caller removeItem _itemType;
    			};
    			[["<t align = 'right' shadow = '2' size = '1.2' font='Caveat'>Contract: Fulfilled</t><br/>",0.4,1],["",0,0],[format ["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>%1 %2 Delivered.</t><br/>",_requiredAmount,_itemDisplayName],0.4,1],[format["<t align = 'right' shadow = '2' size = '0.5' font='TahomaB'>Recieved: %1 rubles</t><br/>",_moneyReward],0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP; 
    			//[_taskID, "SUCCEEDED", true] call BIS_fnc_taskSetState;
                [_taskID] call BIS_fnc_deleteTask;
				if (_missionGiver == equipment_traderlvl1) then {_supplyType = selectRandom ["Bag","Headgear","Facewear","Uniform"]};
                [_missionGiver,_supplyType,_supplySize] call JA_MISSIONGEN_fnc_addSupplyMissionAction;
    			(_this select 0) removeAction (_this select 2);
    		} else {
    		hint "You haven't got all my supplies";
    		};
    	},
    	[_missionGiver,_itemType,_requiredAmount,_taskID,_supplyType,_itemDisplayName,_moneyReward,_supplySize],		
    	1.5,		
    	false,		
    	false,		
    	"",			
    	"true",		
    	3,			
    	false,		
    	"",			
    	""			
    ];

};

















