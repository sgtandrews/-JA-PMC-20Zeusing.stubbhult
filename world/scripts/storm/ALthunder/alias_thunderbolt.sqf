// by ALIAS
// Tutorial: https://www.youtube.com/user/aliascartoons
// https://www.youtube.com/watch?v=CLxA0fG_0X0
// nul = [delay_thunder_1,delay_thunder_2,delay_thunder_3,raindrops,storm_debris,local_fog,screen_effect,puddles] execVM "world\scripts\storm\ALthunder\alias_thunderbolt.sqf";

[] call compile preprocessFile "world\scripts\storm\ALthunder\fnct_lightb.sqf";

sleep 3;

if (!isServer) exitWith {};
params ["_type1_detect","_type2_detect","_type3_detect","_rain_drops","_wind_debris","_local_fog","_screen_effect","_puddles","_clouds"];

storm_clouds = _clouds; publicVariable "storm_clouds";
dayscreeneffect = false; publicVariable "dayscreeneffect"; // make this false you don't want the screen flicker during daytime
thunder_close_alias = ["01_close","02_close","03_close","04_close","05_close","07_close"]; publicVariable "thunder_close_alias";
thunder_far_alias = ["01_far","02_far","03_far","04_far","05_far","06_far","07_far","08_far","09_far","10_far","11_far","12_far","13_far","14_far","16_far","17_far","18_far","19_far","20_far","21_far","22_far","23_far","24_far","25_far","26_far","27_far","08_close"]; publicVariable "thunder_far_alias";
tip_fulger = [fnc_branched_light_1,fnc_branched_light_11,fnc_branched_light_2,fnc_branched_light_21,fnc_branched_light_3,fnc_branched_light_31,fnc_branched_light_4,fnc_branched_light_41,fnc_branched_light_5,fnc_branched_light_51,fnc_branched_light_6,fnc_branched_light_61,fnc_branched_light_7,fnc_branched_light_71,fnc_branched_light_8,fnc_branched_light_81,fnc_branched_light_9_left_simplu,fnc_branched_light_9_left_complicat,fnc_branched_light_10_mijloc_simplu,fnc_branched_light_10_mijloc_centru,fnc_branched_light_10_mijloc_stanga,fnc_branched_light_10_mijloc_complicat,fnc_branched_light_11_right_simplu,fnc_branched_light_11_right_complicat,fnc_branched_light_11_right_sec_1,fnc_spider_tot]; publicVariable "tip_fulger";

[] execVM "world\scripts\storm\ALthunder\alias_hunt.sqf";
if (_type1_detect>0) then {alias_thunder_1 = true; publicVariable "alias_thunder_1"; sleep 1; [[_type1_detect],"world\scripts\storm\ALthunder\alias_thunder_one_effect.sqf"] remoteExec ["execVM",0,true]};
if (_type2_detect>0) then {alias_thunder_2 = true; publicVariable "alias_thunder_2";[[_type2_detect],"world\scripts\storm\ALthunder\alias_thunder_two_effect.sqf"] remoteExec ["execVM",0,true]};
if (_type3_detect>0) then {alias_thunder_3 = true; publicVariable "alias_thunder_3";	[[_type3_detect],"world\scripts\storm\ALthunder\alias_thunder_twohree_effect.sqf"] remoteExec ["execVM",0,true]};

if ((_rain_drops)or(_wind_debris)or(_local_fog)) then
{
	if (_rain_drops) then {alias_rain_drops = true; publicVariable "alias_rain_drops"} else {alias_rain_drops = false; publicVariable "alias_rain_drops"};
	if (_wind_debris) then {alias_wind_debris = true; publicVariable "alias_wind_debris"} else {alias_wind_debris = false; publicVariable "alias_wind_debris"};
	if (_local_fog) then {alias_local_fog = true; publicVariable "alias_local_fog"} else {alias_local_fog = false; publicVariable "alias_local_fog"};
	[[],"world\scripts\storm\ALthunder\alias_weather_effect.sqf"] remoteExec ["execVM",0,true]
};
if (_screen_effect != "none") then {screen_effect = _screen_effect; publicVariable "screen_effect";[[],"world\scripts\storm\ALthunder\splash.sqf"] remoteExec ["execVM",0,true]} else {screen_effect = "none"; publicVariable "screen_effect";};
if (_puddles) then {[[],"world\scripts\storm\ALthunder\pudd_vanilla.sqf"] remoteExec ["execVM",0,true]};
