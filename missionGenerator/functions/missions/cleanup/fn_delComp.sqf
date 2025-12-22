/* ----------------------------------------------------------------------------
Function: JA_MISSIONGEN_fnc_delComp

Description:
    Cleans up Composition and unhides any Terrain Objects. Best used with remoteExec to server.

Parameters:
	_position 		<ARRAY> 	Centre Position of the Composition
    _composition 	<ARRAY> 	Composition Array
	_unhide 		<BOOLEAN>	Unhides Terrain Objects ( Optional )
	_radius 		<NUMBER>	Radius of the Hide Area ( Optional )


Returns:
	true

Examples:
    (begin example)
        [_position,_composition,true,20]remoteExec["JA_MISSIONGEN_fnc_delComp",2];
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params [
	["_position", [0, 0, 0], [[]]],
    ["_composition", [0, 0, 0], [[]]],
	["_unhide", false, [false]],
    ["_radius", 20, [0]]
];

{

	deleteVehicle _x
		
} forEach _Composition;

if (_unhide) then {
	{ _x hideObjectGlobal false } foreach (nearestTerrainObjects [_position,[],_radius]);
};

true