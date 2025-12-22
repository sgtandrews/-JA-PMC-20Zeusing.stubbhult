/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_spawnCaseLoot

Description:
    Spawns loot depending on the case 

Parameters:
    _caseBox - The object that be filled with inventory
    _buildingTypes - Array returned of checkBuildingType function e.g JA_LootGen_fnc_checkBuildingType

Returns:
	None

Examples:
    (begin example)
        [_caseBox,_buildingTypes] call JA_LootGen_fnc_spawnCaseLoot;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params ["_casebox","_buildingTypes"];

_selectedCase = _casebox call JA_LootGen_fnc_checkObject;


//Ground 
if (_selectedCase == "WeaponHolderSimulated_Scripted") then {
_randomBuilding = _buildingTypes call BIS_fnc_arrayShuffle;
{
if (_x == "Military") then {
    if ((_chanceHashs get "milChanceIncrease") > floor random 100) exitWith {
        _selectedCat = selectRandom [_milMiscLoot,_milFirearmLoot,_milUniformLoot,_milHeadgearLoot,_milVestLoot,_milBagLoot,_milNVGs];
        _selectedItem = selectRandom _selectedCat;
        _casebox addItemCargoGlobal [_selectedItem,1];
        if (count (compatibleMagazines _selectedItem) > 0) then {                         
        for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
            {
                _casebox addItemCargoGlobal [(selectRandom(compatibleMagazines _selectedItem)),1];
            };
        };
    };
};
if (_x == "Medical") then {
    if ((_chanceHashs get "medicalChanceIncrease") > floor random 100) exitWith {
        _selectedCat = selectRandom [_bandagesList,_medical_loot_drugs_misc,_medical_loot_general,_medical_loot_blood];
        if (5 > random 100) then {_selectedCat = _medical_loot_advanced};
        _selectedItem = selectRandom _selectedCat;
        _casebox addItemCargoGlobal [_selectedItem,1];
        };
};
if (_x == "Food") then {
    if ((_chanceHashs get "foodChanceIncrease") > floor random 100) exitWith {
        _selectedCat = selectRandom [_food_loot,_civHeadgearLoot,_civFacewearLoot,_civVestLoot,_civBagLoot,_flareLoot,_chemlightgren_loot];
        _selectedItem = selectRandom _selectedCat;
        _casebox addItemCargoGlobal [_selectedItem,1];
    };
};
if (_x == "Industrial") then {
    if ((_chanceHashs get "industChanceIncrease") > floor random 100) exitWith {
        _selectedCat = selectRandom [_industWeapons,_industLoot,_flareLoot,_chemlightgren_loot];
        if (5 > random 100) then {_selectedCat = _industAdv};
        _selectedItem = selectRandom _selectedCat;
        _casebox addItemCargoGlobal [_selectedItem,1];
    };
};
if (_x == "Civilian") then {
    _selectedCat = selectRandom [_civFirearmLoot,_bandagesList,_medical_loot_drugs_misc,_medical_loot_general,_medical_loot_blood,_food_loot,_civHeadgearLoot,_civFacewearLoot,_civVestLoot,_civBagLoot,_industWeapons,_industLoot,_flareLoot,_chemlightgren_loot];
    if (5 > random 100) then {_selectedCat = _industAdv};
    if (5 > random 100) then {_selectedCat = _medical_loot_advanced};
    _selectedItem = selectRandom _selectedCat;
    _casebox addItemCargoGlobal [_selectedItem,1];
    
    if (count (compatibleMagazines _selectedItem) > 0) then {                         
        for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
            {
                _casebox addItemCargoGlobal [(selectRandom(compatibleMagazines _selectedItem)),1];
            };
        };
};                              
}forEach _randomBuilding;

};        

//CaseAmmo

if (_selectedCase == "CaseAmmo") then {
    _weapon_mag = selectRandom _milWeaponsMagsArray;
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
    _weapon_mag = selectRandom _milWeaponsMagsArray;
    _casebox addItemCargoGlobal [(selectRandom (_weapon_mag select 1)), 1];

    
    for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do 
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
    _rifle_mag = selectRandom _milRiflesMagsLootArray;
    _casebox addItemCargoGlobal [(_rifle_mag select 0), 1];

    
    for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
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
//plp_ct_WeathCrateMediumWorn
if (_selectedCase == "plp_ct_WeathCrateMediumWorn") then {
    _rifle_mag = selectRandom _civRiflesMagsLootArray;
    _casebox addItemCargoGlobal [(_rifle_mag select 0), 1];

    
    for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
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

        //Enables ACE Medical Facility
        ["Land_FirstAidKit_01_closed_F", "InitPost", {
            params ["_vehicle"];
            _vehicle setVariable ["ace_medical_isMedicalFacility", true];
            }, nil, nil, true] call CBA_fnc_addClassEventHandler;

        //hint format ["Medical loot chance",_max_medical_loot];
        private _max_medical_loot = 2 max floor _max_medical_loot - ((80 / 100) * _max_medical_loot);
        private _min_medical_loot = 1 max floor _min_medical_loot - ((80 / 100) * _min_medical_loot);
    for "_i" from 1 to ([_min_medical_loot,_max_medical_loot] call BIS_fnc_randomInt) do 
    {
        if (random 100< _blood_chance) then {
            _casebox addItemCargoGlobal [(selectRandom _medical_loot_blood), 1];
        } else {
            _casebox addItemCargoGlobal [(selectRandom _medical_loot_general),1];
            _casebox addItemCargoGlobal [(selectRandom _bandagesList),1];
        };
    };                          
};
//Box_B_UAV_06_medical_F        
if (_selectedCase == "Box_B_UAV_06_medical_F") then {

            //Enables ACE Medical Facility
            ["Box_B_UAV_06_medical_F", "InitPost", {
                params ["_vehicle"];
                _vehicle setVariable ["ace_medical_isMedicalFacility", true];
                }, nil, nil, true] call CBA_fnc_addClassEventHandler;

            if (random 100< _advanced_med_chance) then {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_advanced),1];
            };
            //hint format ["Medical loot chance",_max_medical_loot];
            private _max_medical_loot = 2 max floor _max_medical_loot - ((60 / 100) * _max_medical_loot);
            private _min_medical_loot = 1 max floor _min_medical_loot - ((60 / 100) * _min_medical_loot);
        for "_i" from 1 to ([_min_medical_loot,_max_medical_loot] call BIS_fnc_randomInt) do 
        {
            if (random 100< _blood_chance) then {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_blood), 1];
            } else {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_general),1];
                _casebox addItemCargoGlobal [(selectRandom _bandagesList),1];
            };
        };                          
    };
//Land_PaperBox_01_small_closed_brown_F
if (_selectedCase == "Land_PaperBox_01_small_closed_brown_F") then {
            //hint format ["Medical loot chance",_max_medical_loot];
            private _max_medical_loot = 2 max floor _max_medical_loot;
            private _min_medical_loot = 1 max floor _min_medical_loot;
        for "_i" from 1 to ([_min_medical_loot,_max_medical_loot] call BIS_fnc_randomInt) do 
        {
            if (random 100< _blood_chance) then {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_blood), 1];
            } else {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_general),1];
                _casebox addItemCargoGlobal [(selectRandom _bandagesList),1];
            };
        };                          
    };
//CaseMeds
if (_selectedCase == "CaseMeds") then {
            //Enables ACE Medical Facility
            ["CaseMeds", "InitPost", {
                params ["_vehicle"];
                _vehicle setVariable ["ace_medical_isMedicalFacility", true];
                }, nil, nil, true] call CBA_fnc_addClassEventHandler;

            
            _casebox addItemCargoGlobal [(selectRandom _medical_loot_advanced),1];
            
            //hint format ["Medical loot chance",_max_medical_loot];
            private _max_medical_loot = 2 max floor _max_medical_loot;
            private _min_medical_loot = 1 max floor _min_medical_loot;
        for "_i" from 1 to ([_min_medical_loot,_max_medical_loot] call BIS_fnc_randomInt) do 
        {
            if (random 100< _blood_chance) then {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_blood), 1];
            } else {
                _casebox addItemCargoGlobal [(selectRandom _medical_loot_general),1];
                _casebox addItemCargoGlobal [(selectRandom _bandagesList),1];
            };
        };                          
    };
    
//CasePistol
if (_selectedCase == "CasePistol") then {
    _pistol_mag = selectRandom _milPistolsMagsLootArray;
    _casebox addItemCargoGlobal [(_pistol_mag select 0), 1];

    
    for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
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

// plp_ct_WeathCrateSmallWorn
if (_selectedCase == "plp_ct_WeathCrateSmallWorn") then {
    _pistol_mag = selectRandom _civPistolsMagsLootArray;
    _casebox addItemCargoGlobal [(_pistol_mag select 0), 1];

    
    for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
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
    
    for "_i" from 1 to ([_min_magazines,_max_magazines] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _grenade_loot ), 1];
    };                      
};
//Casefood
if (_selectedCase == "Casefood") then {
    private _max_food_case = floor _max_food_case / 6;
    private _min_food_case = 1 max floor _min_food_case / 6;
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _food_loot ), 1];
    };                      
};
// plp_ct_CartonLightFlat
if (_selectedCase == "plp_ct_CartonLightFlat") then {
    private _max_food_case = floor _max_food_case / 3;
    private _min_food_case = 1 max floor _min_food_case / 3;
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _food_loot ), 1];
    };                      
};
// plp_ct_CartonLightMedium
if (_selectedCase == "plp_ct_CartonLightSmall") then {
    private _max_food_case = floor _max_food_case / 2;
    private _min_food_case = 1 max floor _min_food_case / 2;
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _food_loot ), 1];
    };                      
};

// plp_ct_CartonLightMedium
if (_selectedCase == "plp_ct_CartonLightMedium") then {
    private _max_food_case = floor _max_food_case;
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _food_loot ), 1];
    };                      
};

// Industrial Loot

// plp_ct_CartonDarkFlat
if (_selectedCase == "plp_ct_CartonDarkFlat") then {
    private _max_food_case = 1 max floor _max_food_case - ((60 / 100) * _max_food_case);
    private _min_food_case = 1 max floor _min_food_case - ((60 / 100) * _min_food_case);
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _industLootAll ), 1];
    };                      
};

// plp_ct_CartonDarkSmall
if (_selectedCase == "plp_ct_CartonDarkSmall") then {
    private _max_food_case = 1 max floor _max_food_case - ((30 / 100) * _max_food_case);
    private _min_food_case = 1 max floor _min_food_case - ((30 / 100) * _min_food_case);
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _industLootAll ), 1];
    };                      
};

// plp_ct_CartonDarkMedium
if (_selectedCase == "plp_ct_CartonDarkMedium") then {
    for "_i" from 1 to ([_min_food_case,_max_food_case] call BIS_fnc_randomInt) do
    {
        _casebox addItemCargoGlobal [(selectRandom _industLootAll ), 1];
    };                      
};

// Junk Cases 

//plp_ct_CartonRottenMedium
if (_selectedCase == "plp_ct_CartonRottenMedium") then {
//Need to make Junk item
    private _max_junk_case = _min_junk_case + (random(5));
    private _bagsAndvests_combined = _civVestLoot + _civBagLoot;
    private _junk_loot = _item_loot + _attachment_loot + _food_loot + _civUniformLoot + _civHeadgearLoot + _civFacewearLoot + _industLootAll;
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

//plp_ct_CartonRottenSmall
if (_selectedCase == "plp_ct_CartonRottenSmall") then {
    //Need to make Junk item
    private _max_junk_case = _min_junk_case + (random(5));
    private _bagsAndvests_combined = _civVestLoot + _civBagLoot;
    private _junk_loot = _item_loot + _attachment_loot + _food_loot + _civUniformLoot + _civHeadgearLoot + _civFacewearLoot + _industLootAll;
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

//plp_ct_CartonRottenSmall
if (_selectedCase == "plp_ct_CartonRottenSmall") then {
    //Need to make Junk item
    private _max_junk_case = _min_junk_case + (random(5));
    private _bagsAndvests_combined = _civVestLoot + _civBagLoot;
    private _junk_loot = _item_loot + _attachment_loot + _food_loot + _civUniformLoot + _civHeadgearLoot + _civFacewearLoot + _industLootAll;
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

//plp_ct_CartonRottenFlat
if (_selectedCase == "plp_ct_CartonRottenFlat") then {
    //Need to make Junk item
    private _max_junk_case = _min_junk_case + (random(3));
    private _bagsAndvests_combined = _civVestLoot + _civBagLoot;
    private _junk_loot = _item_loot + _attachment_loot + _food_loot + _civUniformLoot + _civHeadgearLoot + _civFacewearLoot + _industLootAll;
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



// Military Junk Cases 

// plp_ct_PlasticBoxBlack
if (_selectedCase == "plp_ct_PlasticBoxBlack") then {
    //Need to make Junk item
    private _general_loot_chance = 25;
    private _medical_loot_chance = 15;
    private _grenade_loot_chance = 5;
    private _loadequip_loot_chance = 2;
    private _max_junk_case = _min_junk_case + (random(5));
    private _junk_loot = _attachment_loot + _item_loot + _food_loot + _milMiscLoot;
    for "_i" from 1 to ([_min_junk_case,_max_junk_case] call BIS_fnc_randomInt) do
    {
        if (random 100 < _general_loot_chance) then {
            _casebox addItemCargoGlobal [(selectRandom _milExclusiveLoot ), 1];
        }; 
        if (random 100 < _medical_loot_chance) then {
            _casebox addItemCargoGlobal [(selectRandom _medical_loot_general ), 1];
        };
        if (random 100 < _grenade_loot_chance) then {
            _casebox addItemCargoGlobal [(selectRandom _grenade_loot ), 1];
        }; 
        if (_bagChance > random 100 ) then {
            _casebox addBackpackCargoGlobal [(selectRandom _milBagLoot ), 1];
        };
        if (_vestChance > random 100 ) then {
            _casebox addBackpackCargoGlobal [(selectRandom _milVestLoot ), 1];
        }
        else{ 
            _casebox addItemCargoGlobal ["ACE_CableTie", 1]; 
        };                                                                   
    };                      
};

                
                