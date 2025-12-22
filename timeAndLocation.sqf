[] spawn {
	if (isDedicated) exitWith {};
	waitUntil {player == player};
	waitUntil {time > 8};
	[(getPos player) call BIS_fnc_locationDescription, format ["%1", ([dayTime, "HH:MM"] call BIS_fnc_timeToString)], mapGridPosition player] spawn BIS_fnc_infoText;
};