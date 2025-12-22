/*
	Function: HALs_store_fnc_automateStock
	Author: HallyG
	Sets price based on the Array of items given the variables of said item and puts it in missionNamespace under the category

	Argument(s):
	1: Item Array <ARRAY>
	2. Category <STRING>
	3. Pricing/Weighting Category <STRING>
	4. Stock Amount

	Return Value:
	

	Example:
	[_itemArray,_category] call HALs_store_fnc_automateStock;
	__________________________________________________________________*/
params ["_itemArray","_category","_type","_stockAmount"];

private _categoryItemsAndPrices = [];
_itemAndPrice = [];

if (_type == "Weapon") then {
	{
		_itemAndPriceTemp = [];
		_weaponStatsArray = [];
		_weapon = _x;
		_weaponStatsArray pushBack ["Classname",_weapon];
		_itemAndPriceTemp pushBack _weapon;
		private _weaponConfig = configFile >> "CfgWeapons" >> _weapon;
		private _magConfig =  configFile >> "CfgMagazines" >> (getArray(configFile >> "CfgWeapons" >> _weapon >> "magazines")) select 0;


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
		_weaponCost = round _weaponAttachmentWeight +_weaponGLWeight + ((10 + _weaponCostRoFWeight)*(_weaponCostRoFWeight * (_weaponTypeWeight * (_weaponImpact + _weaponAccuracy + _weaponImpact + (_weaponAmmoCap * _weaponTypeWeight)) + (_weaponRange * _weaponTypeWeight))));
		reverse _weaponStatsArray; 
		_weaponStatsArray pushBack ["Weapon Cost",round _weaponCost];
		reverse _weaponStatsArray;
		_itemAndPriceTemp pushBack round _weaponCost;
		_itemAndPriceTemp pushBack _stockAmount;
		_itemAndPrice pushBack _itemAndPriceTemp;
		_magazinesTemp = compatibleMagazines _weapon;

		{
			_magStatsArray = [];
			private _magConfig =  configFile >> "CfgMagazines" >> _x;
		
		
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
		
			_magCost =  round _magPerRoundCost * _magCap;
		
			reverse _magStatsArray; 
			_magStatsArray pushBack ["Weapon Cost",round _magCost];
			reverse _magStatsArray;
			private _magazines1Temp = [];
			 
			_magazines1All pushBackUnique _x;
			_magazines1Temp pushBackUnique _x;
			_magazines1Temp pushBackUnique _magCost;
			_magazines1Costs pushBackUnique _magazines1Temp;	
	 
		}forEach _magazinesTemp;


	}forEach _itemArray;

};

if (_type == "Bag") then {
	{
		//_item = "rhs_vest_pistol_holster";
		_itemAndPriceTemp = [];
		_item = _x;
		_itemAndPriceTemp pushBack _item;
		//_item = selectRandom ["eo_bergan","B_LegStrapBag_black_F","B_AssaultPack_rgr","B_FieldPack_cbr","CUP_B_GER_Pack_Flecktarn","CUP_B_Raid_bag_SSO_Ataka_2_Rug_Khaki"];

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

		_itemAndPriceTemp pushBack round _itemCost;
		_itemAndPriceTemp pushBack _stockAmount;
		_itemAndPrice pushBack _itemAndPriceTemp;

	}forEach _itemArray;

};

if (_type == "Vest") then {
	{
		_itemAndPriceTemp = [];
		_item = _x;
		_itemAndPriceTemp pushBack _item;
		//_item = selectRandom ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Empty","rhs_vest_pistol_holster","AUSPAT_CIRAS_Light_AMCU","VSM_RAV_MG_ProjectHonor","UK3CB_LDF_B_V_TL_Vest_KKZ10_GEO","UK3CB_CSAT_U_O_V_Carrier_Rig_Heavy","UK3CB_ION_B_V_TacVest_des_01","UK3CB_TKP_I_V_6Sh92_Blk","rhs_belt_AK_GL"];
		_item = _x;
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

		_itemCost = ((((_load + _mass) + ((_load + _mass)) / 10) + (5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100)/1 max _protectionValue) * 15;

		reverse _itemStats; 
		_itemStats pushBack ["Weapon Cost",round _itemCost];
		reverse _itemStats;

		_itemStats;

		//[_item,_protectionValue,(((_load + _mass) + (_load + _mass)) / 10),(5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100,"Cost",((((_load + _mass) + ((_load + _mass)) / 10) + (5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100)/1 max _protectionValue) * 15];

		_itemAndPriceTemp pushBack round _itemCost;
		_itemAndPriceTemp pushBack _stockAmount;
		_itemAndPrice pushBack _itemAndPriceTemp;

	}forEach _itemArray;

};

if (_type == "Uniform") then {
	{
		_itemAndPriceTemp = [];
		_item = _x;
		_itemAndPriceTemp pushBack _item;
		//_item = selectRandom ["CUP_V_B_BAF_DDPM_Osprey_Mk3_Empty","rhs_vest_pistol_holster","AUSPAT_CIRAS_Light_AMCU","VSM_RAV_MG_ProjectHonor","UK3CB_LDF_B_V_TL_Vest_KKZ10_GEO","UK3CB_CSAT_U_O_V_Carrier_Rig_Heavy","UK3CB_ION_B_V_TacVest_des_01","UK3CB_TKP_I_V_6Sh92_Blk","rhs_belt_AK_GL"];
		_item = _x;
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

		_itemCost = ((((_load + _mass) + ((_load + _mass)) / 10) + (1 max(_armor * 100 ) + 1 max(_passthrough * 10 ))*100)/1 max _protectionValue) * 15;

		reverse _itemStats; 
		_itemStats pushBack ["Weapon Cost",round _itemCost];
		reverse _itemStats;

		//[_item,_protectionValue,(((_load + _mass) + (_load + _mass)) / 10),(5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100,"Cost",((((_load + _mass) + ((_load + _mass)) / 10) + (5 max(_armor * 100 ) + 5 max(_passthrough * 10 ))*100)/1 max _protectionValue) * 15];

		_itemAndPriceTemp pushBack round _itemCost;
		_itemAndPriceTemp pushBack _stockAmount;
		_itemAndPrice pushBack _itemAndPriceTemp;

	}forEach _itemArray;

};

if (_type == "Mag") then {

	missionNamespace setVariable ["magazines1",[_magazines1Costs,_magazines1All,_stockAmount]];
} else 
{

	_categoryItemsAndPrices append _itemAndPrice;

	missionNamespace setVariable [_category,[_categoryItemsAndPrices,_itemArray,_stockAmount]];

};
