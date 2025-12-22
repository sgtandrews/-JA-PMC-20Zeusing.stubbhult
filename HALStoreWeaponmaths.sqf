/*.45CP Rounds 	= 58.5 per Round 	= 1755 per 30 Rounds
	7.62x25 Rounds	= 61 per Round		= 1830 per 30 Rounds
	7.62x17 Rounds	= 63 per Round		= 1890 per 30 Rounds
	9x18 Rounds		= 54 per Round		= 1620 per 30 Rounds
	9x21 Rounds		= 55 per Round		= 1650 per 30 Rounds
	9x19 Rounds		= 54.5 per Round	= 1635 per 30 Rounds
	5.45x39 Rounds	= 81 per Round 		= 2430 per 30 Rounds
	7.92x33			= 76 per Round		= 2280 per 30 Rounds	
	12 Gauge		= 48 per Round		= 1440 per 30 Rounds
	9.30x62			= 102 per Round		= 3060 per 30 Rounds
	7.62x54			= 94 per Round		= 2820 per 30 Rounds
	7.9x57			= 98 per Round		= 2940 per 30 Rounds
*/
Weapons
inertia, cursor, (rate of fire), (accuracy), (range), (impact)

https://github.com/acemod/ACE3/blob/master/addons/arsenal/functions/fnc_statBarStatement_accuracy.sqf

impact = linearConversion [_initSpeedMinMax select 0, _initSpeedMinMax select 1, _initSpeed, 0.01, 1];
rof = linearConversion [_statMinMax select 0, _statMinMax select 1, _fireRate param [0, 0], _barLimits select 0, _barLimits select 1]
accuracy = linearConversion [_statMinMax select 0, _statMinMax select 1, _dispersion param [0, 0], _barLimits select 0, _barLimits select 1]

Magazines

count, initSpeed,

Trash ground model
model = "\z\ace\addons\logistics_uavbattery\data\ace_battery.p3d";

https://ace3.acemod.org/wiki/framework/advanced-ballistics-framework
https://ace3.acemod.org/wiki/framework/advanced-ballistics-framework.html#12-cfgammo

[1.7,["ACE_GForceCoef"],"G-force reduction",[true,false],[{[(_this select 0) select 0, _this select 1, [[1, 0], [0.01, 1], false]] call ace_arsenal_fnc_statBarStatement_default},{},{getNumber (_this select 1 >> (_this select 0) select 0) < 1}],"",-1,["ace_logistics_wirecutter_hasWirecutter"],"Wirecutter",[false,true],[{},{localize "STR_ace_common_yes"},{getNumber (_this select 1 >> (_this select 0) select 0) > 0}],"",-1,["ACE_isWirecutter"],"Wirecutter",[false,true],[{},{localize "STR_ace_common_yes"},{getNumber (_this select 1 >> (_this select 0) select 0) > 0}],"",1.6,[],"Night Vision Generation",[false,true],[{},{call ace_nightvision_fnc_statTextStatement_NVGeneration},{'nvg' in (getArray ((_this select 1) >> 'visionMode') apply {toLowerANSI _x})}],"",-1,["ace_overheating_allowSwapBarrel"],"Barrel Type",[false,true],[{},{call ace_overheating_fnc_statTextStatement_allowSwapBarrel},{true}],"",-1.1,["ace_overheating_closedBolt"],"Bolt Type",[false,true],[{},{call ace_overheating_fnc_statTextStatement_boltType},{true}],"",2,["ace_overpressure_angle"],"Backblast angle",[false,true],[{},{params ['_stat', '_config']; format ['%1°', getNumber (_config >> _stat select 0)]},{(compatibleMagazines (configName (_this select 1))) isNotEqualTo []}],"",1,["ace_overpressure_range"],"Backblast range",[false,true],[{},{params ['_stat', '_config']; private _blastRangeStat = getNumber (_config >> _stat select 0); format ['%1m (%2ft)', _blastRangeStat, (_blastRangeStat / 0.3048) toFixed 1]},{(compatibleMagazines (configName (_this select 1))) isNotEqualTo []}],"",-1,["ACE_isBelt"],"Link belt",[false,true],[{},{localize "STR_ace_Common_Enabled"},{params['_stat', '_config']; (getNumber (_config >> _stat select 0)) == 1}],"",-1,["ace_reloadlaunchers_enabled"],"Buddy Loading",[false,true],[{},{localize "STR_ace_Common_Enabled"},{params['_stat', '_config']; (getNumber (_config >> _stat select 0)) == 1}],"",3,["ACE_ScopeAdjust_Horizontal","ACE_ScopeAdjust_HorizontalIncrement"],"Horizontal limits",[false,true],[{},{params['_stat', '_config']; private _limits = getArray (_config >> _stat select 0); format ['%1 / %2 MIL (∆ %3 MIL)', _limits select 0, _limits select 1, getNumber (_config >> _stat select 1)]},{params['_stat', '_config']; (getArray (_config >> _stat select 0)) isNotEqualTo []}],"",2,["ACE_ScopeAdjust_Vertical","ACE_ScopeAdjust_VerticalIncrement"],"Vertical limits",[false,true],[{},{params['_stat', '_config']; private _limits = getArray (_config >> _stat select 0); format ['%1 / %2 MIL (∆ %3 MIL)', _limits select 0, _limits select 1, getNumber (_config >> _stat select 1)]},{params['_stat', '_config']; (getArray (_config >> _stat select 0)) isNotEqualTo []}],"",-1,["ace_trenches_entrenchingTool"],"Entrenching Tool",[false,true],[{},{localize "STR_ace_common_yes"},{getNumber (_this select 1 >> (_this select 0) select 0) > 0}],"",0,[],"Potassium levels",[true,false],[{1},{},{(configName (_this select 1)) == 'ACE_Banana'}],"",1.5,[],"Weight",[false,true],[{},{[_this select 0, _this select 1] call ace_arsenal_fnc_statTextStatement_mass},{true}],"",5,["reloadTime"],"Rate of fire",[true,true],[{[(_this select 0) select 0, _this select 1, [[-1.4, 0.31], [1, 0.01]]] call ace_arsenal_fnc_statBarStatement_rateOfFIre},{[(_this select 0) select 0, _this select 1, [[-1.4, 0.31], false]] call ace_arsenal_fnc_statTextStatement_rateOfFire},{true}],"",4,["dispersion"],"Accuracy",[true,true],[{[(_this select 0) select 0, _this select 1, [[-4, -1.7], [1, 0.01], true]] call ace_arsenal_fnc_statBarStatement_accuracy},{[(_this select 0) select 0, _this select 1, [[-4, -1.7], false]] call ace_arsenal_fnc_statTextStatement_accuracy},{true}],"",3.2,["maxZeroing"],"Range",[true,false],[{[(_this select 0) select 0, _this select 1, [[0, 2500], [0.01, 1], false]] call ace_arsenal_fnc_statBarStatement_default},{},{true}],"",3.1,["hit","initSpeed"],"Impact",[true,false],[{[_this select 0, _this select 1, [[0, 3.2], [-1, 1100]]] call ace_arsenal_fnc_statBarStatement_impact},{},{true}],"",2,[],"Magnification",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_scopeMag},{true}],"",2,[],"Magnification",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_binoMag},{true}],"",1.6,[],"Nightvision Support",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_scopeVisionMode},{true}],"",1.6,[],"Vision Mode",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_binoVisionMode},{true}],"",5,["passthrough"],"Ballistic Protection",[true,false],[{[(_this select 0) select 0, _this select 1, [[0, 0.63], [0.01, 1], false]] call ace_arsenal_fnc_statBarStatement_default},{},{true}],"",4,["armor"],"Explosive Resistance",[true,false],[{[(_this select 0) select 0, _this select 1, [[0, 0.80], [0.01, 1], false]] call ace_arsenal_fnc_statBarStatement_default},{},{true}],"",3,["maximumLoad"],"Load",[true,true],[{[(_this select 0) select 0, _this select 1, [[0, 500], [0.01, 1], false]] call ace_arsenal_fnc_statBarStatement_default},{call ace_arsenal_fnc_statTextStatement_load},{true}],"",3,["ammo"],"Time to live",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_smokeChemTTL},{(configName (_this select 1)) isKindOf ['smokeShell', configFile >> 'CfgMagazines']}],"",3,[],"Fuse Time",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_explosionTime},{true}],"",1,[],"Ammo count",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_magCount},{true}],"",1,[],"Illuminators",[false,true],[{},{call ace_arsenal_fnc_statTextStatement_illuminators},{true}],"",1,["ACE_barrelTwist"],"Barrel twist",[false,true],[{},{params ['_stat', '_config']; private _barrelTwist = getNumber (_config >> _stat select 0); format ['%1mm (%2in)', _barrelTwist toFixed 0, (_barrelTwist / 25.4) toFixed 1]},{true}],"",0,["ACE_barrelLength"],"Barrel length",[false,true],[{},{params ['_stat', '_config']; private _barrelLength = getNumber (_config >> _stat select 0); format ['%1mm (%2in)', _barrelLength toFixed 0, (_barrelLength / 25.4) toFixed 1]},{true}],"",5,["ammo","displayName"],"Ammo",[false,true],[{},{params ['_stat', '_config']; private _ammoDisplayName = getText (configFile >> 'CfgAmmo' >> (getText (_config >> 'ammo')) >> _stat select 1); [_ammoDisplayName, getText (_config >> _stat select 0)] select (_ammoDisplayName == '')},{getText (_this select 1 >> _this select 0 select 0) isNotEqualTo ''}],"",4,["ACE_dragModel","ACE_ballisticCoefficients","ACE_standardAtmosphere"],"Ballistic coefficient",[false,true],[{},{params['_stat', '_config']; private _ammoCfg = (configFile >> 'CfgAmmo' >> (getText (_config >> 'ammo'))); private _ballisticCoef = getArray (_ammoCfg >> _stat select 1); _ballisticCoef sort false; format ['%1 G%2 (%3)', _ballisticCoef select 0, getNumber (_ammoCfg >> _stat select 0), getText (_ammoCfg >> _stat select 2)]},{params['_stat', '_config']; private _ammoCfg = (configFile >> 'CfgAmmo' >> (getText (_config >> 'ammo'))); (getArray (_ammoCfg >> _stat select 1) isNotEqualTo [])}],"",3,["ACE_bulletMass"],"Bullet mass",[false,true],[{},{params['_stat', '_config']; private _ammoWeight = getNumber (configFile >> 'CfgAmmo' >> (getText (_config >> 'ammo')) >> _stat select 0); format ['%1g (%2gr)', _ammoWeight toFixed 1, (_ammoWeight * 15.43) toFixed 1]},{params['_stat', '_config']; getNumber (configFile >> 'CfgAmmo' >> (getText (_config >> 'ammo')) >> _stat select 0) > 0}],"",3,["initSpeed","ammo"],"Muzzle velocity",[false,true],[{},{[_this select 0, _this select 1] call ace_ballistics_fnc_statTextStatement_magazineMuzzleVelocity},{getText (_this select 1 >> _this select 0 select 1) isNotEqualTo '' && {getNumber (_this select 1 >> (_this select 0) select 0) > 0}}],"",1,["initSpeed"],"Muzzle velocity",[false,true],[{},{[_this select 0, _this select 1] call ace_ballistics_fnc_statTextStatement_weaponMuzzleVelocity},{true}],"",0,["aiAmmoUsageFlags"],"AI Usage",[false,true],[{},{call ace_ballistics_fnc_statTextStatement_magazineAiUsage},{is3DEN || {!isNull getAssignedCuratorLogic player} || {missionNamespace getVariable ["ace_ballistics_showAIMagazineUse", missionName == 'Arsenal']}}],"",-1.5,[],"Mounts on:",[false,true],[{},{(_this select 1) call ace_csw_fnc_statTextStatement_tripods},{(_this select 1) call ace_csw_fnc_statTextCondition_tripods}],"",1,["ace_explosives_Range"],"Explosive range",[false,true],[{},{params ['_stat', '_config']; private _exploRangeStat = getNumber (_config >> _stat select 0); format ['%1m (%2ft)', _exploRangeStat, (_exploRangeStat / 0.3048) toFixed 1]},{getNumber (_this select 1 >> "ace_explosives_detonator") > 0}],"",1,["ACE_Flashlight_Colour"],"Map light color",[false,true],[{},{getText (_this select 1 >> 'itemInfo' >> 'FlashLight' >> (_this select 0) select 0)},{getText (_this select 1 >> 'itemInfo' >> 'FlashLight' >> (_this select 0) select 0) != ''}],"",2,["ace_hearing_protection","ace_hearing_hasEHP"],"Hearing protection",[true,true],[{[_this select 0, _this select 1] call ace_hearing_fnc_statBarStatement_hearingProtection},{_this select 1 call ace_hearing_fnc_statTextStatement_hearingProtection},{[_this select 0, _this select 1] call ace_arsenal_fnc_statCondition_existsAny}],"",1.75,["ace_hearing_lowerVolume"],"Volume muffling",[true,false],[{[(_this select 0) select 0, _this select 1, [[0, 1], [0.01, 1], false]] call ace_arsenal_fnc_statBarStatement_default},{},{[_this select 0, _this select 1] call ace_arsenal_fnc_statCondition_existsAll}],"",0,["acre_arsenalStats_frequencyMin","acre_arsenalStats_frequencyMax"],"Frequency Range",[false,true],[{},{call acre_ace_interact_fnc_arsenalStats_frequencyRange},{(getNumber(_this select 1 >> 'acre_isRadio')) == 1}],"",0,["acre_arsenalStats_transmitPower"],"Transmit Power",[false,true],[{},{call acre_ace_interact_fnc_arsenalStats_transmitPower},{(getNumber(_this select 1 >> 'acre_isRadio')) == 1}],"",0,["acre_arsenalStats_effectiveRange"],"Effective Range (Urban)",[false,true],[{},{getText ((_this select 1) >> (_this select 0 select 0))},{(getNumber(_this select 1 >> 'acre_isRadio')) == 1}],"",0,["acre_arsenalStats_externalSpeaker"],"External Speaker",[false,true],[{},{call acre_ace_interact_fnc_arsenalStats_externalSpeaker},{(getNumber(_this select 1 >> 'acre_isRadio')) == 1}],""]



=======================




// Pistol "CUP_hgun_Colt1911"
// SMG "rhs_weap_scorpion"
// AR "rhs_weap_aks74u"
// MG "rhs_weap_m240B"; 
// Srifle "rhs_weap_m82a1";
_weaponStatsArray = [];
_weapon = selectRandom ["rhs_weap_ak74_gp25","rhs_weap_ak74","rhsusf_weap_glock17g4","rhs_weap_m16a4_carryhandle_M203","rhs_weap_ak103_gp25_npz","hlc_rifle_rpk","CUP_hgun_Colt1911","rhs_weap_scorpion","rhs_weap_aks74u","rhs_weap_m240B","rhs_weap_m82a1","CUP_sgun_slamfire"];
//_weapon = "rhs_weap_aks74u";
_weaponStatsArray pushBack ["Classname",_weapon];
private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;
private _magConfig =  configFile >> "CfgMagazines" >> (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;
//private _magConfig = configFile >> "CfgMagazines" >> "rhs_30Rnd_545x39_7N6M_AK";



 // Accuracy
 private _dispersion = [];
{
	if (getNumber (_weaponConfig >> _x >> "showToPlayer") != 0) then {
		_dispersion pushBackUnique (getNumber (_weaponConfig >> _x >> "dispersion"));
	};
} forEach (getArray (_weaponConfig >> "modes"));

_dispersion sort true;
_dispersion = _dispersion param [0, 0];

_weaponStatsArray pushBack ["Accuracy",(_dispersion * 1000),(_dispersion / pi * 10800)]; 
format ["%1 MIL (%2 MOA)", (_dispersion * 1000) toFixed 2, (_dispersion / pi * 10800) toFixed 1];


// Rate of Fire 

private _fireRate = [];

{
	_fireRate pushBackUnique (getNumber (_weaponConfig >> _x >> "reloadTime"));
} forEach (getArray (_weaponConfig >> "modes"));

_fireRate sort true;
_fireRate = _fireRate param [0, 0];

if (_fireRate == 0) exitWith {"PEWPEWPEW"};
_weaponStatsArray pushBack ["Rate of Fire",round (60 / _fireRate)];
format ["%1 rpm", round (60 / _fireRate)];



// Range 
private _statMinMax = [0, 2500];
private _barLimits = [0.01, 1];
private _configExtremeBool = false;

private _statValues = [
	[_weaponConfig],
	["maxZeroing"],
	[_configExtremeBool],
	[_statMinMax select 0]
] call BIS_fnc_configExtremes;

_weaponStatsArray pushBack ["Range",(linearConversion [_statMinMax select 0, _statMinMax select 1, (_statValues select 1) select 0, _barLimits select 0, _barLimits select 1])];

// Impact
_stats = ["hit","initSpeed"]; 

private _hitMinMax = [0, 3.2];
private _initSpeedMinMax = [-1, 1100]; 
private _statValues = [
	[_magConfig,configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo'))],
	_stats,
	[true, false],
	[_hitMinMax select 0, _initSpeedMinMax select 0]
] call BIS_fnc_configExtremes;
(_statValues select 1) params ["_hit", "_initSpeed"];

_hit = linearConversion [_hitMinMax select 0, _hitMinMax select 1, _hit, 0.01, 1];
_initSpeed = linearConversion [_initSpeedMinMax select 0, _initSpeedMinMax select 1, _initSpeed, 0.01, 1];

//If launcher tab
//[sqrt (_hit ^ 2 * _initSpeed), _hit] select (GVAR(currentLeftPanel) == IDC_buttonSecondaryWeapon);
_weaponStatsArray pushBack ["Impact",_hit,_initSpeed];


//Type 
_weaponStatsArray pushBack ["Type",getText (_weaponConfig>> "cursor")];

// Mag Count 
_weaponStatsArray pushBack ["Max Ammo Cap",getNumber (_magConfig >> "count")];



// Barrel Length and Twist
// Barrel Length in mm
if (getNumber ((_weaponConfig>> "ACE_barrelTwist")) == 0) then {

	_weaponStatsArray pushBack ["Barrel Length (mm) and Twist",round (getNumber (_weaponConfig >> "ACE_barrelLength")),1];

} else {
	_weaponStatsArray pushBack ["Barrel Length (mm) and Twist",round (getNumber (_weaponConfig >> "ACE_barrelLength")),(getNumber (_weaponConfig>> "ACE_barrelTwist"))];
};


// Calibre
if (getNumber (configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo')) >> "ACE_caliber") == 0) then 
{
_weaponStatsArray pushBack ["Non-ACE Caliber",getNumber (configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo')) >> "caliber")]; 
} else 
{
_weaponStatsArray pushBack [ "ACE Caliber",getNumber (configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo')) >> "ACE_caliber")];

};

// Type Weights

_weaponTypeWeight = nil;
_weaponAccuracy = (_weaponStatsArray select 1 select 1) * (_weaponStatsArray select 1 select 2);
_weaponRoF = (_weaponStatsArray select 2 select 1);
_weaponRange = (1000 * (_weaponStatsArray select 3 select 1));
_weaponImpact = 1000 * (_weaponStatsArray select 4 select 1) * (_weaponStatsArray select 4 select 2);
_weaponType = (_weaponStatsArray select 5 select 1);
switch (_weaponType) do {
	case ("srifle"): {_weaponTypeWeight = 2.5};
	case ("mg"): {_weaponTypeWeight = 2};
	case ("arifle"): {_weaponTypeWeight = 1.5};
	case ("sgun"): {_weaponTypeWeight = 1.1};
	case ("smg"): {_weaponTypeWeight = 1.2};
	case ("hgun"): {_weaponTypeWeight = 1};

};

// GL Check 
_weaponMuzzles = getArray(_weaponConfig >> "muzzles");
_isGL = false;
_weaponGLWeight = 0; 
{
	if (["203", _x] call BIS_fnc_inString == true) then {_isGL = true; _weaponGLWeight = 10000; _weaponTypeWeight = _weaponTypeWeight + 0.3;};
	if (["GP", _x] call BIS_fnc_inString == true) then {_isGL = true; _weaponGLWeight = 10000; _weaponTypeWeight = _weaponTypeWeight + 0.3;};
	if (["302", _x] call BIS_fnc_inString == true) then {_isGL = true; _weaponGLWeight = 10000; _weaponTypeWeight = _weaponTypeWeight + 0.3;};
}forEach _weaponMuzzles;

_weaponStatsArray pushBack ["Has an undermounted GL",_isGL];


// Weapon Attachment Weighting
_weaponTest = [_weapon,"Optics",count ([_weapon,"optic"] call CBA_fnc_compatibleItems), "Muzzles", count ([_weapon,"muzzle"] call CBA_fnc_compatibleItems),"Pointers",count ([_weapon,"pointer"] call CBA_fnc_compatibleItems),"Bipods/Grips",count ([_weapon,"bipod"] call CBA_fnc_compatibleItems)];
_weaponAttachmentWeight =  10 * (_weaponTest select 2) + (_weaponTest select 4) + (_weaponTest select 6) + (_weaponTest select 8);
  
_weaponAmmoCap = (_weaponStatsArray select 6 select 1);
_weaponCostRoFWeight = 1 max (_weaponRoF / 100) / 2.5;
_weaponLengthTwist =  (_weaponStatsArray select 7 select 1) * (_weaponStatsArray select 7 select 2);
_weaponCaliber = _weaponStatsArray select 8 select 1;
//_weaponCost = _weaponTypeWeight * (_weaponTypeWeight * (_weaponCaliber * _weaponAmmoCap) + ((_weaponLengthTwist * _weaponRange) + ((_weaponAccuracy + _weaponRoF) + _weaponImpact)));
_weaponCost = _weaponAttachmentWeight +_weaponGLWeight + ((10 + _weaponCostRoFWeight)*(_weaponCostRoFWeight * (_weaponTypeWeight * (_weaponImpact + _weaponAccuracy + _weaponImpact + (_weaponAmmoCap * _weaponTypeWeight)) + (_weaponRange * _weaponTypeWeight))));
reverse _weaponStatsArray; 
_weaponStatsArray pushBack ["Weapon Cost",round _weaponCost];
reverse _weaponStatsArray;

_weaponStatsArray

============================

// Bags 

//_item = "rhs_vest_pistol_holster";
_item = selectRandom ["eo_bergan","B_LegStrapBag_black_F","B_AssaultPack_rgr","B_FieldPack_cbr","CUP_B_GER_Pack_Flecktarn","CUP_B_Raid_bag_SSO_Ataka_2_Rug_Khaki"];

//_bag = "B_AssaultPack_tna_F";
//_vest = "rhs_vest_pistol_holster";
_itemStats = [];
_itemStats pushBack ["Classname",_item];

//B_Bergen_dgtl_F

private _config = configFile >> "CfgWeapons" >> _item;
if (isNull _config) then {_config = configFile >> "CfgVehicles" >> _item;};

//_load = ((getNumber (configFile >> "CfgVehicles" >> _item >> "maximumLoad")));


// Load Stat 

_stats = ["maximumLoad"];

if (!isNull (_config >> "ItemInfo" >> "containerClass")) then { // Uniform/Vest
	_config = configFile >> "CfgVehicles" >> getText (_config >> "ItemInfo" >> "containerClass");
};

private _load = getNumber (_config >> "maximumLoad");


_itemStats pushBack ["Load",format ["%1kg (%2lb)", (_load * 0.1 * (1 / 2.2046)) toFixed 2, (_load * 0.1) toFixed 2]];


// Mass

 private _config = configFile >> "CfgWeapons" >> _item;
if (isNull _config) then {_config = configFile >> "CfgVehicles" >> _item;}; 

private _mass = getNumber (_config >> "mass");

if (_mass == 0 && {isClass (_config >> "ItemInfo")}) then {
	_mass = getNumber (_config >> "ItemInfo" >> "mass");
};

if (_mass == 0 && {isClass (_config >> "WeaponSlotsInfo")}) then {
	_mass = getNumber (_config >> "WeaponSlotsInfo" >> "mass");
};



_itemCost = (_load + _mass) * (_load + _mass);

_itemStats pushBack ["Mass",format ["%1kg (%2lb)", ((_mass * 0.1 * (1 / 2.2046) * 100) / 100) toFixed 2, ((_mass * 0.1 * 100) / 100) toFixed 2]];

reverse _itemStats; 
_itemStats pushBack ["Weapon Cost",round _itemCost];
reverse _itemStats;

_itemStats

================

// Vests 

_item = selectRandom ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Empty","rhs_vest_pistol_holster","AUSPAT_CIRAS_Light_AMCU","VSM_RAV_MG_ProjectHonor","UK3CB_LDF_B_V_TL_Vest_KKZ10_GEO","UK3CB_CSAT_U_O_V_Carrier_Rig_Heavy","UK3CB_ION_B_V_TacVest_des_01","UK3CB_TKP_I_V_6Sh92_Blk","rhs_belt_AK_GL"];
//_item = "rhs_belt_AK_GL";
_itemStats = [];
_itemStats pushBack ["Classname",_item];
_itemInfo = configFile >> "CfgWeapons" >> _item >> "ItemInfo";
private _config = configFile >> "CfgWeapons" >> _item;

//[_item ,["passthrough",_config,[[0,0.63],[0.01,1],false]]call ace_arsenal_fnc_statbarstatement_default,["armor",_config,[[0,0.63],[0.01,1],false]]call ace_arsenal_fnc_statbarstatement_default];

_passthrough = ["passthrough",_config,[[0,0.63],[0.01,1],false]]call ace_arsenal_fnc_statbarstatement_default;
_itemStats pushBack ["Passthrough",_passthrough];
_armor = ["armor",_config,[[0,0.63],[0.01,1],false]]call ace_arsenal_fnc_statbarstatement_default;
_itemStats pushBack ["Armor",_armor];
_protectionValue = [_itemInfo,_passthrough,_armor]call ace_arsenal_fnc_sortstatement_protection;
_itemStats pushBack ["Protection Value",_protectionValue];


// Load Stat 

_stats = ["maximumLoad"];

if (!isNull (_config >> "ItemInfo" >> "containerClass")) then { // Uniform/Vest
	_config = configFile >> "CfgVehicles" >> getText (_config >> "ItemInfo" >> "containerClass");
};

private _load = getNumber (_config >> "maximumLoad");


_itemStats pushBack ["Load",format ["%1kg (%2lb)", (_load * 0.1 * (1 / 2.2046)) toFixed 2, (_load * 0.1) toFixed 2]];


// Mass

 private _config = configFile >> "CfgWeapons" >> _item;
if (isNull _config) then {_config = configFile >> "CfgVehicles" >> _item;}; 

private _mass = getNumber (_config >> "mass");

if (_mass == 0 && {isClass (_config >> "ItemInfo")}) then {
	_mass = getNumber (_config >> "ItemInfo" >> "mass");
};

if (_mass == 0 && {isClass (_config >> "WeaponSlotsInfo")}) then {
	_mass = getNumber (_config >> "WeaponSlotsInfo" >> "mass");
};

_itemStats pushBack ["Mass",format ["%1kg (%2lb)", ((_mass * 0.1 * (1 / 2.2046) * 100) / 100) toFixed 2, ((_mass * 0.1 * 100) / 100) toFixed 2]];
//

_itemCost = (((_load + _mass) + (_load + _mass)) / 10) + (5 max(_armor * 100 ) + 5 max(_passthrough * 100 ) + (_protectionValue * 100)) * 100;

reverse _itemStats; 
_itemStats pushBack ["Weapon Cost",round _itemCost];
reverse _itemStats;

_itemStats;

[_item,_protectionValue,(((_load + _mass) + (_load + _mass)) / 10),(5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100,"Cost",((((_load + _mass) + ((_load + _mass)) / 10) + (5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100)/1 max _protectionValue) * 15];

==========================

// Magazines

_weapon = "CUP_sgun_slamfire";
_magStatsArray = [];
private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;
private _magConfig =  configFile >> "CfgMagazines" >> (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;


_stats = ["hit","initSpeed"]; 

private _hitMinMax = [0, 3.2];
private _initSpeedMinMax = [-1, 1100]; 
private _statValues = [
	[_magConfig,configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo'))],
	_stats,
	[true, false],
	[_hitMinMax select 0, _initSpeedMinMax select 0]
] call BIS_fnc_configExtremes;
(_statValues select 1) params ["_hit", "_initSpeed"];

_hit = linearConversion [_hitMinMax select 0, _hitMinMax select 1, _hit, 0.01, 1];
_initSpeed = linearConversion [_initSpeedMinMax select 0, _initSpeedMinMax select 1, _initSpeed, 0.01, 1];

//If launcher tab
//[sqrt (_hit ^ 2 * _initSpeed), _hit] select (GVAR(currentLeftPanel) == IDC_buttonSecondaryWeapon);
_magStatsArray pushBack ["Impact",_hit,_initSpeed];

//Mag Cap
_magCap = getNumber (_magConfig >> "count");
_magStatsArray pushBack ["Max Ammo Cap",getNumber (_magConfig >> "count")];

// Calibre
if (getNumber (configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo')) >> "ACE_caliber") == 0) then 
{
_magStatsArray pushBack ["Non-ACE Caliber",getNumber (configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo')) >> "caliber")]; 
} else 
{
_magStatsArray pushBack [ "ACE Caliber",getNumber (configFile >> 'CfgAmmo' >> (getText (_magConfig >> 'ammo')) >> "ACE_caliber")];

};

//Type 
_magType = getText (_weaponConfig>> "cursor");
_weaponTypeWeight = nil;

switch (_magType) do {
	case ("srifle"): {_weaponTypeWeight = 1750};
	case ("mg"): {_weaponTypeWeight = 325};
	case ("arifle"): {_weaponTypeWeight = 325};
	case ("sgun"): {_weaponTypeWeight = 325};
	case ("smg"): {_weaponTypeWeight = 625};
	case ("hgun"): {_weaponTypeWeight = 707};

};

_magPerRoundCost = (_weaponTypeWeight * _hit * _initSpeed);

_magCost = _magPerRoundCost * _magCap;

reverse _magStatsArray; 
_magStatsArray pushBack ["Weapon Cost",round _magCost];
reverse _magStatsArray;

[_weapon] call BIS_fnc_compatibleMagazines 



















