// by ALIAS
private ["_voice_fulger","_sound_close","_alias_flicker","_alias_bolt_1","_lum_fulg_w","_sound_echo","_flick_screen","_break_screen"];

if (!hasInterface) exitWith {};
params ["_alias_bolt_1","_sound_close","_sound_echo","_flick_screen"];

_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
_voice_thund = _soundPath + "sound\"+_sound_close+".ogg"; //hint str _voice_thund;
_dist_pl_thund	= player distance _alias_bolt_1;//hint str _dist_pl_thund;
_pitch_sound = linearConversion [50,2000,_dist_pl_thund,1.5,0.5,true];
_delay = (_dist_pl_thund/340);
if (sunOrMoon==1) then 
{
	if (dayscreeneffect) then 
	{
		[_flick_screen,0.1] spawn 
		{
			private ["_flick_screen"];
			params ["_flick_screen"];
			while {_flick_screen>0} do 
			{
				_brit_effect = 0.1+(random 0.5);
				_ctr_effect = 1.1+ (random 0.5);
				["ColorCorrections", 1500, [_brit_effect, _ctr_effect, 0, [0, 0, 0, 0], [1, 1, 1, 0], [1, 1, 1, 0]],0.1] call fnc_screen_effect_day;
				_flick_screen = _flick_screen-1;
				sleep 0.1;
			};
		};
	};
	playSound3D [_voice_thund,"",false,[_alias_bolt_1#0,_alias_bolt_1#1,0],50,_pitch_sound,1500];
	sleep _delay+1;
	playsound _sound_echo;
} else 
{
	playSound3D [_voice_thund,"",false,[_alias_bolt_1#0,_alias_bolt_1#1,0],50,_pitch_sound,1500];
	if (storm_clouds) then 
	{
		_cloud = "#particlesource" createVehicleLocal _alias_bolt_1;
		_cloud setParticleCircle [0,[0,0,0]];
		_cloud setParticleRandom [0,[1500,1500,100], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
		_cloud setParticleParams[["\A3\data_f\cl_basic", 1, 0, 1],"","Billboard",1,3,[0,0,800],[0,0,50],3,10,7.9,0.2,[400,450,500],[[0.1,0.1,0.5,0],[1,1,1,0.005],[0,0,0.5,0]],[0,0],0,0,"","",player];
		_cloud setDropInterval 0.002;
		sleep 1;
		deleteVehicle _cloud;
	};
	sleep _delay;
	playsound _sound_echo;
};