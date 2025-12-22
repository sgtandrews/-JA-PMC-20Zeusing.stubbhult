// Spawn Chances and Options
_lootToggle             = ("TFA_p_loottogle" call BIS_fnc_getParamValue) isEqualTo 1; 
_spawn_chance           = "TFA_p_spawn_chance" call BIS_fnc_getParamValue;    //chance to spawn loot at specific house position
_item_chance            = "TFA_p_item_chance" call BIS_fnc_getParamValue;   //chance to spawn an item instead of a weapon
_case_chance            = "TFA_p_box_chance" call BIS_fnc_getParamValue;  //chance to spawn a case with items instead of a weapon [[[NEW ADDITION ]]
_bagChance             = "TFA_p_bagChance" call BIS_fnc_getParamValue; // chance to spawn a backpack instead of an item
_launcher_chance        = "TFA_p_launcher_chance" call BIS_fnc_getParamValue;  //chance to spawn a launcher as weapon instead of rifle, pistol or machine gun
_ruinLessLoot           = "TFA_p_ruin_reduction_toggle" call BIS_fnc_getParamValue; 
_ruinReducationChance   = "TFA_p_ruin_reduction_chance" call BIS_fnc_getParamValue; 
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