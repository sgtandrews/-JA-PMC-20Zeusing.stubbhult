// [this] execVM "randomWeapons";
//params ["_unit"];

//diag_log _unit;

//if (!isServer) exitWith {};
if (isPlayer _unit) exitWith {};
_unit = _this select 0;


_unitType = typeOf _unit;
_possibleItems           = ["ACE_MRE_BeefStew","ACE_MRE_ChickenTikkaMasala","ACE_MRE_ChickenHerbDumplings","ACE_MRE_CreamChickenSoup","ACE_MRE_CreamTomatoSoup","ACE_MRE_LambCurry","ACE_MRE_MeatballsPasta","ACE_MRE_SteakVegetables","ACE_Banana","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit","ACE_Canteen","ACE_Canteen_Empty","ACE_Canteen_Half","ACE_Canteen_Nearly_Empty","ACE_Canteen_Nearly_Full","ACE_WaterBottle","ACE_WaterBottle_Empty","ACE_WaterBottle_Half","ACE_WaterBottle_Nearly_Empty","ACE_Humanitarian_Ration","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bloodIV","ACE_elasticBandage","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","rhssaf_zrak_rd7j","SAN_Headlamp_v1","JSHK_contam_detector","ACRE_BF888S","ACE_EntrenchingTool","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_MapTools","AnomalyDetector"];
_possiblePrimaryWeapons = flatten [missionNamespace getVariable "smgs1" select 1,missionNamespace getVariable "assaults1" select 1,missionNamespace getVariable "shotguns1" select 1,missionNamespace getVariable "rifles1" select 1];


_possibleGLWeapons = [
	"arifle_TRG21_GL_F"
	,"arifle_Katiba_GL_F"
	,"arifle_Mk20_GL_F"
	,"arifle_Mk20_GL_plain_F"
];

_possibleMarksmanWeapons = [
	"srifle_DMR_06_olive_F"
	,"srifle_DMR_06_camo_F"
	,"srifle_DMR_01_F"
];

_possibleMGs = [
	"LMG_Mk200_F"
	,"LMG_Zafir_F"
	,"MMG_01_tan_F"
];

_possibleHandguns 	= missionNamespace getVariable "handguns1" select 1;
mags_array 	= missionNamespace getVariable "magazines1" select 1;

_mags_array_Temp = [];
{
  // code...
  _mags_array_Temp pushBack (toLower _x);
} forEach mags_array;

_uniformList 	= missionNamespace getVariable "uniforms1" select 1;
_headgearList 	= ["rhs_beanie_green","UK3CB_H_Beanie_02_BLK","SP_BaseballCap_Black","H_Cap_tan","CUP_H_PMC_Cap_Back_Tan","UK3CB_ARD_B_H_Crew_Cap","H_ShemagOpen_tan","UK3CB_H_Shemag_blk","rhs_tsh4","SP_TSH04Helmet_Black","UK3CB_H_Ushanka_Cap_01","rhs_ushanka","CUP_H_C_Ushanka_03","CUP_H_C_Ushanka_02","CUP_H_C_Ushanka_04","rhsgref_M56","rhs_ssh60","rhs_ssh68_2","H_Tank_eaf_F","rhssaf_helmet_m59_85_nocamo","CUP_H_SLA_Helmet_OD_worn","CUP_H_SLA_TankerHelmet"];
_gasmaskList 	= ["MK503","G_CBRN_B","G_CBRN_B_black","G_CBRN_M04_Hood","G_CBRN_M50_Hood","G_RegulatorMask_F",""];
_facewearList 	= ["G_Balaclava_blk","G_Balaclava_lowprofile","G_Bandanna_aviator","G_Bandanna_shades"];
_lowVestList 	= ["CUP_V_CDF_CrewBelt","rhs_gear_OFF","V_AG_Invisible","rhs_vest_pistol_holster","rhs_vest_commander","V_Rangemaster_belt","PMC_Vest_RangeBelt_Black","rhs_suspender_ak4","rhs_suspender_SKS","CUP_V_OI_TKI_Jacket1_04","CUP_V_OI_TKI_Jacket1_06","CUP_V_OI_TKI_Jacket1_05","CUP_V_OI_TKI_Jacket1_03","eo_rangemaster_1","eo_rangemaster_3","eo_rangemaster_4","eo_rangemaster_2","CUP_V_CDF_OfficerBelt2","CUP_V_CDF_OfficerBelt","rhs_suspender_ak","CUP_V_O_TK_OfficerBelt2","CUP_V_O_TK_OfficerBelt","FP_Cartel_Hunting_Vest","eo_multipocket_1","eo_multipocket_2","eo_multipocket_3","eo_multipocket_5","eo_multipocket_4","V_Pocketed_black_F","UK3CB_MEC_C_V_Pocketed_BRN","V_Pocketed_coyote_F","UK3CB_MEC_C_V_Pocketed_GRY","UK3CB_MEC_C_V_Pocketed_KHK","UK3CB_MEC_C_V_Pocketed_OLI","V_Pocketed_olive_F","UK3CB_V_Pocketed_Vest_PAN","UK3CB_V_Pocketed_Vest_TTSKO_BRN","UK3CB_V_Pocketed_Vest_TTSKO_FOR","AUSPAT_Belt_MG_BLK","AUSPAT_Belt_MG_BRN","AUSPAT_Belt_MG_GRN","AUSPAT_Belt_MG_TAN","AUSPAT_Belt_Rifleman_BLK","AUSPAT_Belt_Rifleman_BRN","AUSPAT_Belt_Rifleman_GRN","AUSPAT_Belt_Rifleman_TAN","Assault_vest","BlackRock_vest","eo_bandolier_1","eo_bandolier_3","eo_bandolier_4","eo_bandolier_2","eo_legstrapbag_1","eo_legstrapbag_2","eo_legstrapbag_4","eo_legstrapbag_3","Belt_fc_GRY","Belt_gbrs_GRY","V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F","rhs_suspender_AK8_chestrig","CUP_V_OI_TKI_Jacket4_05","CUP_V_OI_TKI_Jacket4_06","CUP_V_OI_TKI_Jacket4_01","CUP_V_OI_TKI_Jacket5_04","CUP_V_OI_TKI_Jacket5_05","CUP_V_OI_TKI_Jacket5_06","CUP_V_OI_TKI_Jacket5_01","CUP_V_OI_TKI_Jacket3_04","CUP_V_OI_TKI_Jacket3_05","CUP_V_OI_TKI_Jacket3_06","CUP_V_OI_TKI_Jacket3_01","CUP_V_OI_TKI_Jacket6_04","CUP_V_OI_TKI_Jacket6_05","CUP_V_OI_TKI_Jacket2_04","CUP_V_OI_TKI_Jacket2_06","CUP_V_OI_TKI_Jacket2_05","CUP_V_OI_TKI_Jacket2_01","CUP_V_O_SLA_Carrier_Belt02","rhs_vydra_3m","UK3CB_TKA_I_V_vydra_3m_Tan",""];
_vestList 		= missionNamespace getVariable "vests1" select 1;
_bagList		= missionNamespace getVariable "bags1" select 1;

mags_array_lower = _mags_array_Temp;

_possibleLaunchers = [
	"launch_NLAW_F"
	,"launch_RPG32_F"
];

//Checks class name
if (_unitType == "CUP_O_RUS_M_Soldier_Survivor_VKPO_Summer") then { 
	removeAllWeapons _unit;
	removeAllItems _unit;
	removeAllAssignedItems _unit;
	removeUniform _unit;
	removeVest _unit;
	removeHeadgear _unit;
	removeBackpackGlobal _unit;
	_unit linkItem "SAN_Headlamp_v1";
	clearAllItemsFromBackpack _unit;
	_selectedUniform = _uniformList call Bis_fnc_selectRandom;
	_unit forceAddUniform _selectedUniform;
	if (_selectedUniform == "SE_Leather_Jacket_Bandit") then {
		_unit addHeadgear "armst_Hood_mid_loner1";

	};
	if ( random 100 < 3) then {
		_selectedVest = _vestList call Bis_fnc_selectRandom;
		_unit addVest _selectedVest;
		if (( _selectedVest == "SCE_Coat_Long_3") or (_selectedVest == "SCE_Coat_Short_3")) then {
			_unit addHeadgear "armst_Hood_band_3";
		};
		if (_selectedVest == "SCE_Coat_Sleeveless_3") then {
			_unit addHeadgear "armst_Hood_band_3";
		};
	} 
	else {
		_selectedVest = _lowVestList call Bis_fnc_selectRandom;
		_unit addVest _selectedVest;
		};
	if (random 100 < 15) then {
		//_selectedGasMask = _gasmaskList call Bis_fnc_selectRandom;
		//_unit addGoggles _selectedGasMask;
		[_unit, "gasMaskReplace"] call BIS_fnc_unitHeadgear
		} else {
			//_selectedFaceWear = _facewearList call Bis_fnc_selectRandom;
			//_unit addGoggles _selectedFaceWear;
			[_unit, "faceWearReplace"] call BIS_fnc_unitHeadgear
		};
	
	if (random 100 < 5) then {
		_selectedBag = _bagList call Bis_fnc_selectRandom;
		_unit addBackpack _selectedBag
	} else {
		_unit addBackpack "Bag_AG_Invisible";
	};
	_equipedHeadGear =  headgear _unit;
	if ( _equipedHeadGear == "") then {
		_selectedHeadGear = _headgearList call Bis_fnc_selectRandom;
		_unit addHeadgear _selectedHeadGear;
	};



	_itemCounter = 0;
	_amountOfitems = ([1,8] call BIS_fnc_randomInt);
	while {_itemCounter < _amountOfitems} do
	{
		_selectedItem = "";
		_hitChance = random 100;
		
		//Frags 
		if (2 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "hiexplogren_loot"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1; 
		continue;
		};
		
		// Mollies		
		if (5 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "civThrowables");
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1; 
		continue;
		
		//Chem Lights
		};
		if (10 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "chemlightgren_loot"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;
		continue;
		};
		
		//Flares
		if (10 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "flareLoot"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;
		continue;
		};
		
		//Food   
		if (20 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "food_loot"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;
		continue;
		};
		
		// Blood
		if (25 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "medical_loot_blood");
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;		
		continue;
		};
		
		//Drugs and other Medical
		if (45 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "medical_loot_drugs_misc"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;
		continue; 
		};
		
		//General Medical Loot
		if (55 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "medical_loot_general"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;
		continue;   
		};
		
		// Industral Loot
		if (65 > _hitChance) then {
		_selectedItem = selectRandom(missionNamespace getVariable "industLoot"); 
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1;
		continue;	   
		}
		else {
		
		//Bandages
		_selectedItem = selectRandom(missionNamespace getVariable "bandagesList");
		if (_unit canAdd _selectedItem) then {
			_unit addItem _selectedItem;
		};
		_itemCounter = _itemCounter + 1; 
		continue;
		};
		
	};
	
	if (25 > random 100 ) then {
			_selectedMainArm = _possiblePrimaryWeapons call Bis_fnc_selectRandom;
			_selectedMainArmMags = _selectedMainArm call BIS_fnc_compatibleMagazines;
			_selectedMainArmMagSpawn = mags_array_lower arrayIntersect _selectedMainArmMags;
			_amountOfmags = ([1,3] call BIS_fnc_randomInt);
			[_unit,_selectedMainArm, 2,_selectedMainArmMagSpawn select 0] call BIS_fnc_addWeapon;
			//_unit addMagazines [_selectedMainArmMagSpawn select 0, _amountOfmags];
			_unit selectWeapon _selectedMainArm;
			_unit reload [_selectedMainArm,_selectedMainArmMagSpawn select 0];
			_unit reload [];
		}
		else {
			_selectedHandgun = _possibleHandguns call Bis_fnc_selectRandom;
			_selectedHandGunMags = _selectedHandgun call BIS_fnc_compatibleMagazines;
			_selectedHandGunMagSpawn = mags_array_lower arrayIntersect _selectedHandGunMags;
			_amountOfmags = ([1,5] call BIS_fnc_randomInt);
			[_unit, _selectedHandgun, 2,_selectedHandGunMagSpawn select 0] call BIS_fnc_addWeapon;
			//_unit addMagazines [_selectedHandGunMagSpawn select 0, _amountOfmags];

		};
		[_unit, 1] spawn grantUnlimitedAmmo;
};
