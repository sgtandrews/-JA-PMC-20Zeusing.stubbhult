/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_spawnCase

Description:
    Spawns case depending on the building types array

Parameters:
    _position - Position of the vehicle, e.g position player 
	_buildingTypes - Array returned of checkBuildingType function e.g JA_LootGen_fnc_checkBuildingType
	_caseClassHash - Hash created that has all the cases 
	_chanceHashs - Has created that has all the Type chances 

Returns:
	Creates the case depending.

Examples:
    (begin example)
        _caseBox = [_position,_buildingTypes,_caseClassHash,_chanceHashs] call JA_LootGen_fnc_spawnCase;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params ["_position","_buildingTypes","_caseClassHash","_chanceHashs"];

_randomBuilding = _buildingTypes call BIS_fnc_arrayShuffle;
_caseTypes = "";
{
				_loopBreak = false;
				if (_x == "Military") then {
					if ((_chanceHashs get "milChanceIncrease") > floor random 100) exitWith {
					_loopBreak = true;
					_caseTypes = "militaryCases";
					};
				};
				if (_x == "Medical") then {
					if ((_chanceHashs get "medicalChanceIncrease") > floor random 100) exitWith {
					_loopBreak = true;
					_caseTypes = "medicalCases";
					};
				};
				if (_x == "Food") then {
					if ((_chanceHashs get "foodChanceIncrease") > floor random 100) exitWith {
					_loopBreak = true;
					_caseTypes = "foodCases";
					};
				};
				if (_x == "Industrial") then {
					if ((_chanceHashs get "industChanceIncrease") > floor random 100) exitWith {
					_loopBreak = true;
					_caseTypes = "industrialCases";
					};
				};
				if (_x == "Civilian") then {
					_loopBreak = true;
					_caseTypes = "civilianCases";
	
				};
				if (_loopBreak == true) exitWith {};				
}forEach _randomBuilding;


private _isMil = !((_randomBuilding find "Military") isEqualTo -1);
if ((_isMil) and (_caseTypes == "")) then {_caseTypes = "militaryCases";};

_caseBox = createVehicle [(selectRandom (_caseClassHash get _caseTypes)), ((_position) vectorAdd [0, 0, 0.5]), [], 0.2, "CAN_COLLIDE"]; //replace with _position  

//_caseBox enableDynamicSimulation true;
[_caseBox, true, [0, 0.8, 0], 45] call ace_dragging_fnc_setDraggable; 
[_caseBox, true, [0, 0.8, 1.3], 10] call ace_dragging_fnc_setCarryable;

clearItemCargoGlobal _casebox;

if ((_caseBox call JA_LootGen_fnc_checkObject) == "CaseMoney") then {
		[_caseBox] call JA_LootGen_fnc_giveCurrency;
		_casebox lockInventory true;
		};

_caseBox;






