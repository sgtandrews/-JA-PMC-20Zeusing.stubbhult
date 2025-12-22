////player sideChat "Starting Jump Encounter..";
[30] execVM "world\scripts\aliens\Nova_UFO\AL_ufo\alias_hunt.sqf";
waituntil {!isNil "hunt_alias"};
////player sideChat "Hunt ready";

//custom random function because fuck sqf
seed = serverTime;
NOVA_FNC_RAND = {
  _seed_temp = round(((1103515245 * seed) + 12345) mod 6789);
  if (finite _seed_temp) then {seed = _seed_temp}
  else {};
  seed;
};

_poz = hunt_alias getRelPos [200 + (((call NOVA_FNC_RAND) mod 1800) + 1), selectrandom [(((call NOVA_FNC_RAND) mod 60) + 1), (((call NOVA_FNC_RAND) mod 60) * -1 - 1)]];
_ini_poz = [_poz#0,_poz#1,200 + (((call NOVA_FNC_RAND) mod 1800) + 1)];

//player sideChat "IniPOZ: ";
//player sideChat str _ini_poz;

ufoPrimary = nil;

//CROSS FX
encounter_running = false;

NOVA_FNC_cross_lit_mod = {
  params ["_ufo"];

  if (!encounter_running) then {
    encounter_running = true;

    _ini_poz_x = (getPosATL ufoPrimary)#0;
    _ini_poz_y = (getPosATL ufoPrimary)#1;
    _ini_poz_z = (getPosATL ufoPrimary)#2;

    _ini_poz_2 = hunt_alias getRelPos [0,0]; //player position
    _cross_ufo = "Land_Battery_F" createVehicleLocal [_ini_poz_x, _ini_poz_y, _ini_poz_z];

    _cross_ufo setPosATL [_ini_poz_x, _ini_poz_y, _ini_poz_z]; //something is not matching here...
    //player sideChat str (getPosATL _cross_ufo);

    //From cross_lit
    _cloud = "#particlesource" createVehicle getpos _cross_ufo;
  	_cloud setParticleCircle [0,[0,0,0]];
  	_cloud setParticleRandom [0,[1500,1500,100],[0,0,0],0,0,[0,0,0,0],0,0];
  	_cloud setParticleParams[["\A3\data_f\cl_basic", 1, 0, 1],"","Billboard",1,3,[0,0,-1500],[0,0,50],3,10,7.9,0,[400,450,500],[[0.1,0.1,0.5,0],[1,1,1,0.3],[0,0,0.5,0]],[0],0,0,"","",_cross_ufo];
  	_cloud setDropInterval 0.002;
  	[_cloud] spawn {params ["_de_sters"];sleep 0.5;deleteVehicle _de_sters};

    _lum_fulg_w = "#lightpoint" createVehicle getPosATL _cross_ufo;
    _lum_fulg_w setLightDayLight true;_lum_fulg_w setLightUseFlare true;
    _lum_fulg_w setLightFlareSize 15; _lum_fulg_w setLightFlareMaxDistance 5000;
    _lum_fulg_w setLightAmbient[0.5,0.5,1];	_lum_fulg_w setLightColor[0.443,0.706,0.9];
    _lum_fulg_w setLightAttenuation [0,0,0,0,0,4000];
    _lum_fulg_w setLightBrightness 20;

    _lum_fulg_w attachto [_cross_ufo,[0,0,0]];
    // END from cross_lit

    _v_x = (_ini_poz_2#0 - _ini_poz_x)/3;
    _v_y = (_ini_poz_2#1 - _ini_poz_y)/3;
    _v_z = (_ini_poz_2#2 - _ini_poz_z)/3;

    _cross_ufo setVelocity [_v_x, _v_y, _v_z];
    sleep 2; //Calculate vector for 6 seconds

    _cross_ufo say3d ["ufo_cross",3000];

    _cross_ufo setVelocity [_v_x * 4,_v_y * 4,_v_z * -4];
    sleep 6;
    _lum_fulg_w setLightBrightness 100;
    sleep .02;
    _lum_fulg_w setLightBrightness 1000;
    sleep .03;
    _lum_fulg_w setLightBrightness 150;
    sleep .05;
    deleteVehicle _cross_ufo;
    deleteVehicle _lum_fulg_w;
  } else {};
};
//END CROSS FX

jump_encounter_running = false;

NOVA_FNC_jump_charging_fx = {
  params ["_ini_poz"];

  if (!jump_encounter_running) then {
    jump_encounter_running = true;
    //player sideChat "IniPOZ afterSpawn: ";
    //player sideChat str _ini_poz;

    _ini_poz_2 = hunt_alias getRelPos [0,0];

    _soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
    charge_done = _soundPath + "sound\charge_complete.ogg";
    charging = _soundPath + "sound\charge_2.ogg";

    _ufo = "Sign_Sphere200cm_F" createVehicleLocal [_ini_poz_2#0, _ini_poz_2#1, 200];
    _ufo setObjectTexture [0, "#(argb,8,8,3)color(1,1,1,1,ca)"];
    //_ufo setPosATL _ini_poz;

    _ufo_pos_x = _ini_poz_2#0 + (((call NOVA_FNC_RAND) mod 2500) + 1);
    _ufo_pos_y = _ini_poz_2#1 + (((call NOVA_FNC_RAND) mod 2500) + 1);
    _ufo_pos_z = 1000 + (((call NOVA_FNC_RAND) mod 1000) + 1);

    _ufo setPosATL [_ufo_pos_x, _ufo_pos_y, _ufo_pos_z];
    ufoPrimary = _ufo;

    playSound "static";
    sleep 5;

    _plasma_wave = "#particlesource" createVehicle getPosASL _ufo;
    _plasma_wave setParticleCircle [0,[0,0,0]];
    _plasma_wave setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0,0,0,0],0,0];
    _plasma_wave setParticleParams [["\A3\data_f\kouleSvetlo",1,0,1],"","Billboard",1,0.5,[0,0,1],[0,0,0],0,9.999,7,0,[1,50],[[1,1,1,0.2],[1,1,1,0]],[1],0,0,"","",_ufo];
    _plasma_wave setDropInterval 0.1;

    //From light charge SFX
    _sat_lit = [];
    _dir = 0;

    enableCamShake true;

    final_boom = _soundPath + "sound\final_boom.ogg";

    _lum_fulg_w = "#lightpoint" createVehicle getPosATL _ufo;
    _lum_fulg_w setLightDayLight true;_lum_fulg_w setLightUseFlare true;
    _lum_fulg_w setLightFlareSize 0; _lum_fulg_w setLightFlareMaxDistance 5000;
    _lum_fulg_w setLightAmbient[0.5,0.5,1];	_lum_fulg_w setLightColor[0.8,0.8,1];
    _lum_fulg_w setLightAttenuation [0,0,0,0,0,4000];
    _lum_fulg_w setLightBrightness 1;

    _cc = 0;
    while {_dir<360} do {
      _liting_1 = "#lightpoint" createVehicle (_ufo getRelPos [20,_dir]);
      _liting_1 setpos [getPosASL _liting_1 #0,getPosASL _liting_1 #1,getPosATL _ufo #2];
      _liting_1 setLightDayLight true;_liting_1 setLightUseFlare true;
      _liting_1 setLightFlareSize 5; _liting_1 setLightFlareMaxDistance 5000;
      _liting_1 setLightAmbient[0.5,0.5,1];	_liting_1 setLightColor[0.8,0.8,1];
      _liting_1 setLightAttenuation [0,0,0,0,0,4000];  _liting_1 setLightIntensity 0;
      _liting_1 setLightBrightness 1;

      _sat_lit pushback _liting_1;

      _dir = _dir+45;
      _cc = _cc + 1;
      sleep 0.05;
    };

    charge_ufo = false;
    [_lum_fulg_w] spawn {
      params ["_lum_fulg_w"];

      _intens_vf = 0;
      while {!charge_ufo} do {
        _intens_vf = _intens_vf + 0.3;

        _lum_fulg_w setLightFlareSize _intens_vf + 20;
        _lum_fulg_w setLightIntensity _intens_vf;
        _lum_fulg_w setLightBrightness _intens_vf;

        sleep 0.05;
      };
    };


    playSound3D [charge_done,"",false,getPos _ufo,1,1,5000];
    sleep 4;
    deleteVehicle _plasma_wave;
    charge_ufo = true;

    _lum_fulg_w setLightFlareSize 100;

    {deleteVehicle _x} forEach _sat_lit;
    sleep 0.5;

    _lum_fulg_w setLightFlareSize 0;
    _lum_fulg_w setLightBrightness 0;
    _lum_fulg_w setLightBrightness 200;

    [_ufo] remoteExec ["NOVA_FNC_cross_lit_mod", 0, true];//optional

    sleep 0.3;

    deleteVehicle _lum_fulg_w;

    playSound3D [final_boom,"",false,[getPos player#0, getPos player #1,1000],10,1,5000];

    _Leaves_Green = "#particlesource" createVehicle (getpos player);
    _Leaves_Green setParticleCircle [10,[0,0,0]];
    _Leaves_Green setParticleRandom [0,[0,0,1],[10,10,10],0.2,0.1,[0,0,0,0],0.5,0.5];
    _Leaves_Green setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Leaves_Green.p3d",1,0,1],"","SpaceObject",1,7,[0,0,1],[-10,-10,5],7,11,5,0.2,[3,0.1],[[1,1,1,1],[1,1,1,1]],[0],1,1,"","",vehicle player];
    _Leaves_Green setDropInterval 0.002;

    sleep 2.5;

    _dust_particles = "#particlesource" createVehicle (getPos player);
    _dust_particles setParticleCircle [20,[-5,-5,0]];
    _dust_particles setParticleRandom [1,[0,0,0],[10,10,0],1,0,[0,0,0,0.01],0,0];
    _dust_particles setParticleParams [["\A3\data_f\cl_basic",1,0,1],"","Billboard",1,5,[0,0,0],[0,0,0],13,10,8,0.1,[5,10,20],[[0.05,0.04,0.03,0.3],[0.05,0.04,0.03,0.3],[0.05,0.04,0.03,0]],[1],0, 0, "", "", vehicle player];
    _dust_particles setDropInterval 0.01;

    [_Leaves_Green] spawn {params ["_sterg"]; sleep 0.5; deleteVehicle _sterg};
    [_dust_particles] spawn {params ["_sterg"]; sleep 0.5; deleteVehicle _sterg};

    addCamShake [5,4,30];

    sleep 3;
    //END from light charge SFX

    _object_lit = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d",getPosATL _ufo];
    _object_lit attachto [_ufo,[0,150,-2]];

    deleteVehicle _ufo;
    sleep 0.5;

    deleteVehicle _object_lit;
  } else {
    //player sideChat "Encounter already in progress...";
  };
};

[_ini_poz] remoteExec ["NOVA_FNC_jump_charging_fx", 0, true];
/*  */
