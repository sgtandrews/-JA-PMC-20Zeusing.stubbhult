

// Wrecks and Random Vehicles 
if (isMultiplayer && {!isServer}) then {
    // Will run before init.sqf and on clients, unlike initServer.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };
};

execVM "world\scripts\aceMenu.sqf";
//Setting the Storm Variables up


/*
//Assuming you will have a few of these triggers
{
	_x params[ "_trigger" ];
	
	_trigger triggerAttachVehicle [ player ];
	_trigger setTriggerActivation [ "VEHICLE", "PRESENT", true ];
	
}forEach [
	locationTrigger1
	//add more triggers here
];
*/

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;

/*
    Author - HoverGuy
	GitHub - https://github.com/Ppgtjmad/SimpleShops
	Steam - https://steamcommunity.com/id/HoverGuy/
    Player initialization
*/

if(!hasInterface) exitWith {}; // If headless then exit

player setVariable ["LEG_PlayerLoaded", false, true];
addMissionEventHandler ["PreloadFinished", 
{
  player setVariable ["LEG_PlayerLoaded", true, true];
}];
[] execVM "HG\Setup\fn_clientInitialization.sqf";

waitUntil {player getVariable "LEG_PlayerLoaded"};
[]execVM "timeAndLocation.sqf";
[] execVM "briefing.sqf";
[] execVM "missionGenerator\functions\missions\actions\missionBoardRecruit.sqf";
/*
[15,30,40,false,false,false,"none",false,false] execVM "world\scripts\storm\ALthunder\alias_thunderbolt.sqf";
alias_thunder_1 = false; publicVariable "alias_thunder_1";
alias_thunder_2 = false; publicVariable "alias_thunder_2";
alias_thunder_3 = false; publicVariable "alias_thunder_3";
alias_rain_drops = false; publicVariable "alias_rain_drops";
alias_wind_debris = true; publicVariable "alias_wind_debris";
alias_local_fog = false; publicVariable "alias_local_fog";
screen_effect = "none"; publicVariable "screen_effect";
*/
