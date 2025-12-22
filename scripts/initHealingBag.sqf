/*
Variables for ACE Medical
player getVariable ["ace_medical_pain", 0];
player getVariable ["ace_medical_openWounds", createHashMap]; // All the wound variables are hashmaps
If healthy, returns nothing
[["rightarm",[[1,0,0.000476275,0.287589]]],["head",[[21,1,0,0.134229]]],["rightleg",[[31,1,0.0229294,0.549574]]],["leftarm",[[31,0,0.0228243,0.546532]]],["leftleg",[[31,0,0.0230386,0.552736]]],["body",[[31,0,0.0226138,0.540438]]]]
*/
_healBag = _this select 0;
_player_money = 0;

_healBag setVariable ["ace_medical_isMedicalFacility", true, true];

// Heal Nearby Units (Man)
[ 
    _healBag,              
    "Medical Service ( 1000 Rubles)",            
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",  
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa",  
    "_this distance _target < 3",        
    "_caller distance _target < 3",        
    {},               
    {},               
    {  
        private _list = nearestObjects [_caller, ["Man"], 1];
		_player_money = [_caller] call HALs_money_fnc_getFunds;
		if (_player_money > 1000 ) then {
			[_caller, -1000] call HALs_money_fnc_addFunds;
        	[_caller] call ace_medical_treatment_fnc_fullHealLocal;
            ["TAG_aVeryUniqueID", true, 2] call BIS_fnc_blackOut;
            sleep 2;
            ["TAG_aVeryUniqueID", true, 2] call BIS_fnc_blackIn;
		}
		else {
			hint parseText format ["Not enough money, you have %1",  
            _player_money];
		};

    },              
    {},              
    [],              
    2,              
    1000,              
    false,             
    false             
] call BIS_fnc_holdActionAdd;