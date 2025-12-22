// by ALIAS

if (!hasInterface) exitWith {};

missionNamespace setVariable ["under_cover_rain",true,false];

KK_fnc_incover = {
	lineIntersectsSurfaces [getPosWorld _this, getPosWorld _this vectorAdd [0, 0, 50], _this, objNull, true, 1, "GEOM", "NONE"] select 0 params ["","","","_cover"];
	if (!isNil "_cover") then {missionNamespace setVariable ["under_cover_rain", true, false]}
	else {missionNamespace setVariable ["under_cover_rain", false, false]}
};
[] spawn {while {screen_effect!="none"} do {waitUntil {rain >0};player call KK_fnc_incover;sleep 0.1}};

if (screen_effect=="blur") then {
	private ["_bottom_def"];
	while {true} do {
		_rain_temp = rain;
		waitUntil {(rain>0.04) and !(missionNamespace getVariable "under_cover_rain")};
		_top_def =  linearConversion [0.04,1,rain,0,0.5,true];
		if (_top_def>0) then {_bottom_def = _top_def+0.1} else {_bottom_def=0};
		effect_screen_wet = ppEffectCreate ["WetDistortion", 300];			
		effect_screen_wet ppEffectEnable true;
		effect_screen_wet ppEffectAdjust [0.5,_top_def,_bottom_def,0,0,0,0,0.05,0.01,0.1,0.01,0.015,0.01,0.05,0.1];
		effect_screen_wet ppEffectCommit 0;
		waitUntil {(rain<0.04) or (missionNamespace getVariable "under_cover_rain") or (abs(rain - _rain_temp)>0.1)};
		effect_screen_wet ppEffectEnable false; ppEffectDestroy effect_screen_wet;
	};
};

if (screen_effect=="drops") then {
	_poz_obj_splash = "land_helipadempty_f" createVehiclelocal [0,0,0];
	sleep 2;
	while {true} do {
		if ((rain>0.04) and !(missionNamespace getVariable "under_cover_rain")) then {
			_w_drop_int = linearConversion [0.1,1,rain,0.1,0.01,true];
			_rain_temp = rain;
			_obPos = positionCameraToWorld [0,0,0];
			_poz_obj_splash setPos _obPos;
			water_drop = "#particlesource" createVehicleLocal getPosATL _poz_obj_splash;
			water_drop setParticleCircle [0,[0,0,0]];
			water_drop setParticleRandom [0,[1,1,0.2],[0,0,0],0,0,[0,0,0,0],0,0];
			water_drop setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d",1,0,1],"","Billboard",1,0.2,[0,0,0],[0,0,0],0,10.5,7.9,0,[0.04,0.05,0.05],[[1,1,1,1],[1,1,1,1],[1,1,1,0]],[0],1,0,"","",_poz_obj_splash];
			water_drop setDropInterval _w_drop_int;			
			sleep 0.1;
			deleteVehicle water_drop;
		} else {sleep 1}
	};
};