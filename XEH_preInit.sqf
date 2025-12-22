/*
Script: XEH_preInit.sqf

Description:
    Executed globally When CBA is loaded.
    https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System

    If CBA is not loaded, this is executed at mission start by init(Server).sqf.
    This is to allow assigning default settings via JA_World_fnc_addSetting.

Author:
    thegamecracks

*/

// Parameters:
//     _setting     - Unique setting name. Matches resulting variable name <STRING>
//     _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
//     _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
//     _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
//     _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
//     _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
//     _script      - Script to execute when setting is changed. (optional) <CODE>
//     _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>



// Vehicle Wrecks
[
    "SHZ_wrecks_enabled",
    "CHECKBOX",
    ["STR_SHZ_settings_wrecks_enabled", "STR_SHZ_settings_wrecks_enabled_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    false,
    true,
    {},
    true
] call JA_World_fnc_addSetting;
[
    "SHZ_wrecks_density",
    "SLIDER",
    ["STR_SHZ_settings_wrecks_density", "STR_SHZ_settings_wrecks_density_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    [10, 1000, 50, 0, false],
    true,
    {},
    true
] call JA_World_fnc_addSetting;
[
    "SHZ_wrecks_townFactor",
    "SLIDER",
    ["STR_SHZ_settings_wrecks_townFactor", "STR_SHZ_settings_wrecks_townFactor_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    [1, 2000, 5, 1, false],
    true,
    {},
    true
] call JA_World_fnc_addSetting;
[
    "SHZ_wrecks_townFactor_distance",
    "SLIDER",
    ["STR_SHZ_settings_wrecks_townFactor_distance", "STR_SHZ_settings_wrecks_townFactor_distance_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    [100, 2500, 1000, 0, false],
    true,
    {},
    true
] call JA_World_fnc_addSetting;
[
    "SHZ_wrecks_rightHandDrive",
    "CHECKBOX",
    ["STR_SHZ_settings_wrecks_rightHandDrive", "STR_SHZ_settings_wrecks_rightHandDrive_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    true,
    true,
    {},
    true
] call JA_World_fnc_addSetting;
[
    "SHZ_wrecks_safezones",
    "CHECKBOX",
    ["STR_SHZ_settings_wrecks_safezones", "STR_SHZ_settings_wrecks_safezones_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    false,
    true,
    {},
    true
] call JA_World_fnc_addSetting;
[
    "SHZ_wrecks_vehicleTypes",
    "EDITBOX",
    ["STR_SHZ_settings_wrecks_vehicleTypes", "STR_SHZ_settings_wrecks_vehicleTypes_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    '["Land_Wreck_Car_F", "Land_Wreck_Car2_F", "Land_Wreck_Car3_F", "Land_Wreck_CarDismantled_F", "Land_Wreck_HMMWV_F", "Land_Wreck_Hunter_F", "Land_Wreck_Offroad_F", "Land_Wreck_Offroad2_F", "Land_Wreck_Skodovka_F", "Land_Wreck_Truck_dropside_F", "Land_Wreck_Truck_F", "Land_Wreck_Van_F"]',
    true,
    {
        SHZ_wrecks_vehicleTypes = parseSimpleArray _this;
    },
    true
] call JA_World_fnc_addSetting;

// Wreck Loot
[
    "JA_wrecks_loot",
    "CHECKBOX",
    ["STR_JA_CBA_settings_wrecks_loot", "STR_JA_CBA_settings_wrecks_loot_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    false,
    true,
    {},
    true
] call JA_World_fnc_addSetting;

[
    "JA_wrecks_loot_chance",
    "SLIDER",
    ["STR_JA_CBA_settings_wrecks_loot_chance", "STR_JA_CBA_settings_wrecks_loot_chance_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    [0, 100, 0, 0, false],
    true,
    {},
    true
] call JA_World_fnc_addSetting;

[
    "JA_wrecks_loot_chance_small",
    "SLIDER",
    ["STR_JA_CBA_settings_wrecks_loot_chance", "STR_JA_CBA_settings_wrecks_loot_chance_tooltip"],
    ["STR_JA_CBA_settings", "STR_SHZ_settings_wrecks"],
    [0, 10, 1, 2, false],
    true,
    {},
    true
] call JA_World_fnc_addSetting;