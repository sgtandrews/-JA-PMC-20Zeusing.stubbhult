// by ALIAS
// Tutorial: https://www.youtube.com/user/aliascartoons

if (!hasInterface) exitWith {};
params ["_delay3"];
while {alias_thunder_3} do
{
	//if (!alias_thunder_3) then {waitUntil {alias_thunder_3}};

	_delayth3 = linearConversion [0.3,1,overcast,30+(random 120),0.1 + (random _delay3),true];
	_sound_only = selectRandom thunder_far_alias;
	[_sound_only] remoteExec ["playSound"];
	sleep _delayth3;
};
