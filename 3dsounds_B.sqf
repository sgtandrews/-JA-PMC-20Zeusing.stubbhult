params ["_type","_radial_x", "_radial_y","_radial_z","_bat1"];

//custom random function because fuck sqf
seed = serverTime;
NOVA_FNC_RAND = {
  _seed_temp = round(((1103515245 * seed) + 12345) mod 6789);
  if (finite _seed_temp) then {seed = _seed_temp}
  else {};
  seed;
};

_seekermarker = createMarker ["seekermarker", [0,0,0]];

_poz = zeus_crop getRelPos [100 + (((call NOVA_FNC_RAND) mod _radial_x) + 1), selectrandom [(((call NOVA_FNC_RAND) mod _radial_y) + 1), (((call NOVA_FNC_RAND) mod _radial_y) * -1 - 1)]];
"seekermarker" setMarkerPos _poz;

sounds_running = false;

NOVA_FNC_playAmbientSound = {
  params ["_ufo", "_sound"];

  if (!sounds_running) then {
    sounds_running = true;
    playSound3D [_sound,"",false,[getmarkerpos _ufo#0,getmarkerpos _ufo#1,200],10,1,1500];
  } else {};
};

//["seekermarker"] remoteExec ["NOVA_FNC_seek_travel_fx", 0, true];

_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
//owl = _soundPath + "sound\owlhoot.ogg";

switch (_type) do {
    case "owl": {["seekermarker", (_soundPath + "sound\owlhoot.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
    case "wolf": {["seekermarker", (_soundPath + "sound\duskwolf.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
    case "wings": {["seekermarker", (_soundPath + "sound\flappingwings.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
    case "hum": {["seekermarker", ("z\crowsEW\addons\sounds\data\spooky_background_hum.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
    case "ghorror": {["seekermarker", ( "z\crowsEW\addons\sounds\data\ghost_horror_noise.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
    case "spookywhisper": {["seekermarker", ("z\crowsEW\addons\sounds\data\whisper_spooky.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
    case "ghostlywhisper": {["seekermarker", ("z\crowsEW\addons\sounds\data\whisper_ghostly.ogg")] remoteExec ["NOVA_FNC_playAmbientSound", 0, true];};
};
/*  */
