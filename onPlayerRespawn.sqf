
//player setVariable ["greenmag_main_MagSkillCoef", parseNumber (0.05 toFixed 1), true];
params ["_newUnit", "_oldUnit"];
if (isNull _oldUnit) exitWith {};
_newUnit setUnitLoadout (getUnitLoadout _oldUnit);
_playerMoneyOld = [_oldUnit] call HALs_money_fnc_getFunds;
_moneyLost = round ((10 / 100) * _playerMoneyOld);
_playerMoneyNew = round (_playerMoneyOld - (10 / 100) * _playerMoneyOld);
[_newUnit, -_moneyLost] call HALs_money_fnc_addFunds;

["Money lost", format ["%1", _moneyLost],format ["%1 left", _playerMoneyNew]] spawn BIS_fnc_infoText;
deleteVehicle _oldUnit; 

