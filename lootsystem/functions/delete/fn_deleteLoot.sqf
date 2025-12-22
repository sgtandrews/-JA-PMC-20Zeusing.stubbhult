/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_deleteLoot

Description:
    Deletes case at the location

Parameters:
    _position - Position of the vehicle, e.g position player 

Returns:
	None

Examples:
    (begin example)
        [_position, _deleteCases] call JA_LootGen_fnc_deleteLoot;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params ["_position","_deleteCases"];
_position = _this select 0;
_deleteCases = _this select 1;
sleep 0.25;
{
    {
        deleteVehicle _x;
        true
        
        
    } count (nearestObjects [_position, [_x], 50]);
    true    
} forEach _deleteCases;

true;