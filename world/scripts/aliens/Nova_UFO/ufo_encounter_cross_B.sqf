//custom random function because fuck sqf
seed = serverTime;
NOVA_FNC_RAND = {
  _seed_temp = round(((1103515245 * seed) + 12345) mod 6789);
  if (finite _seed_temp) then {seed = _seed_temp}
  else {};
  seed;
};

_poz = zeus_crop getrelpos [200 + (((call NOVA_FNC_RAND) mod 1800) + 1),selectrandom [(((call NOVA_FNC_RAND) mod 60) + 1),(((call NOVA_FNC_RAND) mod 60) * -1 -1)]];
_ini_poz = [_poz#0,_poz#1,200 + (((call NOVA_FNC_RAND) mod 1800) + 1)];

//player sideChat "IniPOZ: ";
//player sideChat str _ini_poz;

encounter_running = false;

NOVA_FNC_cross_lit_fx = {
  params ["_ini_poz"];

  if (!encounter_running) then {
    encounter_running = true;
    //player sideChat "IniPOZ afterSpawn: ";
    //player sideChat str _ini_poz;

    _ini_poz_2 = zeus_crop getRelPos [0,0];
    _cross_ufo = "Land_Battery_F" createVehicleLocal [_ini_poz_2#0, _ini_poz_2#1, 200];

    _cross_ufo setPosATL [_ini_poz#0,_ini_poz#1,3000];

    //player sideChat "CrossUFO atl: ";
    //player sideChat str getPosATL _cross_ufo;

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
    _cross_ufo setVelocity [0, 0, -300];
    sleep 8;

    //player sideChat "CrossUFO atl after dropping: ";
    //player sideChat str getPosATL _cross_ufo;

    _cross_ufo say3d ["ufo_cross",3000];
    _zig = 2+round ((((call NOVA_FNC_RAND) mod 10) + 1));

    while {_zig>0} do {
      _cross_ufo setVelocity [200+round((((call NOVA_FNC_RAND) mod 200) + 1))*selectRandom[-1,1],200,1];
      sleep 1+round ((((call NOVA_FNC_RAND) mod 2) + 1));
      _zig=_zig-1;
    };

    _cross_ufo setVelocity [0,0,500];
    sleep 6;
    _lum_fulg_w setLightBrightness 100;
    sleep .02;
    _lum_fulg_w setLightBrightness 1000;
    sleep .03;
    _lum_fulg_w setLightBrightness 150;
    sleep .05;
    deleteVehicle _cross_ufo;
    deleteVehicle _lum_fulg_w;
  } else {
    //player sideChat "Encounter already in progress...";
  };
};

[_ini_poz] remoteExec ["NOVA_FNC_cross_lit_fx", 0, true];
/*  */
