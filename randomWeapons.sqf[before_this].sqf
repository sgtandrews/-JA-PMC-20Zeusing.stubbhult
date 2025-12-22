// [this] execVM "randomWeapons";
params ["_unit"];

if (!isServer) exitWith {};
if (isPlayer _unit) exitWith {};

_unit = _this select 0;

_unitType = typeOf _unit;
diag_log "_unitType";
diag_log _unitType;
_possibleItems           = ["ACE_MRE_BeefStew","ACE_MRE_ChickenTikkaMasala","ACE_MRE_ChickenHerbDumplings","ACE_MRE_CreamChickenSoup","ACE_MRE_CreamTomatoSoup","ACE_MRE_LambCurry","ACE_MRE_MeatballsPasta","ACE_MRE_SteakVegetables","ACE_Banana","ACE_Can_Franta","ACE_Can_RedGull","ACE_Can_Spirit","ACE_Canteen","ACE_Canteen_Empty","ACE_Canteen_Half","ACE_Canteen_Nearly_Empty","ACE_Canteen_Nearly_Full","ACE_WaterBottle","ACE_WaterBottle_Empty","ACE_WaterBottle_Half","ACE_WaterBottle_Nearly_Empty","ACE_Humanitarian_Ration","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bloodIV","ACE_elasticBandage","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","rhssaf_zrak_rd7j","SAN_Headlamp_v1","JSHK_contam_detector","ACRE_BF888S","ACE_EntrenchingTool","ACE_elasticBandage","ACE_morphine","ACE_tourniquet","ACE_splint","ACE_epinephrine","ACE_adenosine","ACE_MapTools","AnomalyDetector"];
_possiblePrimaryWeapons = ["UK3CB_MP5A2","rhs_weap_scorpion","uk3cb_ppsh41","rhs_weap_m3a1","CUP_sgun_slamfire","sgun_HunterShotgun_01_sawedoff_F","sgun_HunterShotgun_01_F","UK3CB_CZ550","rhs_weap_m38","uk3cb_sks_01","CUP_srifle_Mosin_Nagant"];

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

_possibleHandguns 	= ["CUP_hgun_Colt1911","rhs_weap_tt33","rhs_weap_makarov_pm","rhs_weap_pb_6p9","rhs_weap_savz61_folded","rhs_weap_6p53","rhs_weap_cz99","hgun_P07_blk_F","rhsusf_weap_m9"];
mags_array 	= ["rhsusf_mag_7x45acp_MHP","cup_8rnd_762x25_tt","rhs_mag_9x18_8_57n181s","rhsgref_20rnd_765x17_vz61","rhs_18rnd_9x21mm_7bt3","rhssaf_mag_15rnd_9x19_fmj","16rnd_9x21_green_mag","rhsusf_mag_15rnd_9x19_fmj","uk3cb_mp5_30rnd_9x19_magazine","uk3cb_mp5_30rnd_9x19_magazine_g","uk3cb_ppsh_71rnd_magazine","rhsgref_30rnd_1143x23_m1t_smg","cup_1rnd_12gauge_pellets_no00_buck","cup_1rnd_12gauge_slug","cup_2rnd_12gauge_pellets_no00_buck","cup_2rnd_12gauge_pellets_no4_bird","cup_2rnd_12gauge_slug","uk3cb_cz550_5rnd_mag","uk3cb_cz550_5rnd_mag_g","rhsgref_5rnd_762x54_m38","rhsgref_10rnd_792x57_m76"];

_mags_array_Temp = [];
{
  // code...
  _mags_array_Temp pushBack (toLower _x);
} forEach mags_array;
diag_log "Mags Array";
diag_log mags_array;

mags_array_lower = _mags_array_Temp;

_possibleLaunchers = [
	"launch_NLAW_F"
	,"launch_RPG32_F"
];
/*
_GLSoldiers = [
	"B_Soldier_GL_F"
	,"B_Soldier_TL_F"
	,"O_Soldier_GL_F"
	,"O_Soldier_TL_F"
	,"I_Soldier_GL_F"
	,"I_Soldier_TL_F"
];

_MarksmanSoldiers = [
	"B_soldier_M_F"
	,"B_spotter_F"
	,"B_sniper_F"
	,"O_soldier_M_F"
	,"O_spotter_F"
	,"O_sniper_F"
	,"I_soldier_M_F"
	,"I_spotter_F"
	,"I_sniper_F"
];

_ATSoldiers = [
	"B_soldier_LAT_F"
	,"B_soldier_AT_F"
	,"O_Soldier_LAT_F"
	,"O_Soldier_AT_F"
	,"O_soldierU_LAT_F"
	,"O_soldierU_AT_F"
	,"I_Soldier_LAT_F"
	,"I_Soldier_AT_F"
];

_MGSoldiers = [
	"B_soldier_AR_F"
	,"O_Soldier_AR_F"
	,"O_soldierU_AR_F"
	,"I_Soldier_AR_F"
];

_MedicSoldiers = [
	"B_medic_F"
	,"O_medic_F"
	,"O_soldierU_medic_F"
	,"I_medic_F"
];

_RepairSoldiers = [
	"B_engineer_F"
	,"B_soldier_exp_F"
	,"B_soldier_repair_F"
	,"O_engineer_F"
	,"O_engineer_U_F"
	,"O_soldier_exp_F"
	,"O_soldierU_exp_F"
	,"O_soldier_repair_F"
	,"O_soldierU_repair_F"
	,"I_engineer_F"
	,"I_Soldier_exp_F"
	,"I_Soldier_repair_F"
];

_possibleGarmentTextures = [
	"\a3\characters_f_gamma\Civil\Data\c_cloth1_black.paa"
	,"A3\Characters_F\Civil\Data\c_cloth1_kabeiroi_co.paa"
	,"A3\Characters_F\Civil\Data\c_cloth1_bandit_co.paa"
	,"\a3\characters_f_gamma\Civil\Data\c_cloth1_brown.paa"
	,"A3\Characters_F\Civil\Data\c_cloth1_v3_co.paa"
	,"A3\Characters_F\Civil\Data\c_cloth1_v2_co.paa"
	,"A3\Characters_F\Civil\Data\c_cloth1_co.paa"	 
];

_possibleCoverallTextures = [
	"\A3\characters_f\common\data\coveralls_bandit_co.paa"
	,"\A3\characters_f\common\data\coveralls_black_co.paa"
	,"\A3\characters_f\common\data\coveralls_grey_co.paa"
	,"\A3\characters_f\common\data\coveralls_urbancamo_co.paa"
];*/

/*
_unit addVest (_possibleVests call Bis_fnc_selectRandom);
_unit addBackpack (_possibleBackpacks call Bis_fnc_selectRandom);
_unit addHeadgear (_possibleHeadgear call Bis_fnc_selectRandom);
_unit addGoggles (_possibleFacewear call Bis_fnc_selectRandom);
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemRadio"];	
_unit addItem "FirstAidKit";*/

//Checks class name
if (_unitType == "O_BD_Bandit_Highwayman_01") then { 
	_unit removeWeaponGlobal "sgun_HunterShotgun_01_sawedoff_F";
	removeAllWeapons _unit;
	removeAllItems _unit;
	_selectedHandgun = _possibleHandguns call Bis_fnc_selectRandom;
	diag_log "Highwayman Pistol";
	diag_log _selectedHandgun;
	_selectedHandGunMags = _selectedHandgun call BIS_fnc_compatibleMagazines;
	diag_log "Compactible Mags";
	diag_log _selectedHandGunMags;
	_selectedHandGunMagSpawn = mags_array_lower arrayIntersect _selectedHandGunMags;
	diag_log "Mags Array Lowered";
	diag_log mags_array_lower;
	diag_log "Intersected Mag Array";
	diag_log _selectedHandGunMagSpawn;
	_amountOfmags = ([1,3] call BIS_fnc_randomInt);
	[_unit, (_possibleHandguns call Bis_fnc_selectRandom), 0] call BIS_fnc_addWeapon;
	_unit addMagazine [_selectedHandGunMagSpawn select 0, _amountOfmags];
	_amountOfitems = ([1,8] call BIS_fnc_randomInt);
	/*for [{_1 = 0},{_1 <_amountOfitems}, {_i =_1 + 1}]
	{
		_selectedItem = [_possibleItems] call Bis_fnc_selectRandom;
		_unit addItemToBackpack _selectedItem;
	};
	*/
	if (random 100 > 25) then {
			_selectedMainArm = _possiblePrimaryWeapons call Bis_fnc_selectRandom;
			diag_log "Highwayman Weapon";
			diag_log _selectedMainArm;
			_selectedMainArmMags = _selectedMainArm call BIS_fnc_compatibleMagazines;
			diag_log "Compactible Mags";
			diag_log _selectedMainArmMags;
			_selectedMainArmMagSpawn = mags_array_lower arrayIntersect _selectedMainArmMags;
			diag_log "Intersected Mag Array";
			diag_log _selectedMainArmMagSpawn;
			[_unit, (_possiblePrimaryWeapons call Bis_fnc_selectRandom), 0] call BIS_fnc_addWeapon;
			_unit addMagazine [_selectedMainArmMagSpawn select 0, _amountOfmags];

		};
};
/* 
//Give AT weapon where appropriate
if (_unitType in _ATSoldiers) then { 
	[_unit, (_possibleLaunchers call Bis_fnc_selectRandom), 3] call BIS_fnc_addWeapon;
};

//Give Medikit to Medics
if (_unitType in _MedicSoldiers) then {
	_unit addItemToBackpack "Medikit";
	{_unit addItemToBackpack "FirstAidKit";} forEach [1,2,3,4,5,6,7,8,9,10];
};

//Give Toolkit to Engineers, etc.
if (_unitType in _RepairSoldiers) then {
	_unit addItemToBackpack "ToolKit";
	_unit addItemToBackpack "MineDetector";
	{_unit addItemToBackpack "FirstAidKit";} forEach [1,2];
};*/