// by ALIAS
// Tutorial: https://www.youtube.com/user/aliascartoons
private ["_type1_detect"];
if (!hasInterface) exitWith {};
params ["_type1_detect"];
waitUntil {!isNil "hunt_alias"};
while {alias_thunder_1} do
{
	//if (!alias_thunder_1) then {waitUntil {alias_thunder_1}};
	_delayth1 = linearConversion [0.3,1,overcast,15+(random 15),0.1+(random _type1_detect),true];
	if (player == hunt_alias) then
	{
		
		if (isNil "alias_thunder_1")then {waitUntil {!isNil "alias_thunder_1"}};
		_jeton_poz = player getRelPos [50+random 1000, random 360];
		_poz_obj_fulger1 = [_jeton_poz # 0,_jeton_poz # 1,(getPosATL player #2)+1000+(random 500)];
		_sound_sync = selectRandom thunder_close_alias;
		_sound_echo = selectRandom thunder_far_alias;
		_tip_fulger = selectRandom tip_fulger;
		[_poz_obj_fulger1] spawn _tip_fulger;
		_flick_screen = ceil (1+(random 3));
		[[_poz_obj_fulger1,_sound_sync,_sound_echo,_flick_screen],"world\scripts\storm\ALthunder\alias_thunder_one_SFX.sqf"] remoteExec ["execVM"];
	};
	sleep _delayth1;
}
