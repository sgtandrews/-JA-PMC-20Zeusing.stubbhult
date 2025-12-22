/* ----------------------------------------------------------------------------
Function: JA_LootGen_fnc_giveCurrency

Description:
    Gives currency and depending on what object will act accordingly.

Parameters:
    _object - The object that contains currency

Returns:
	----

Examples:
    (begin example)
        [_object] call JA_LootGen_fnc_giveCurrency;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
params ["_object"];
_moneyCase = _object;

[ 
 _moneyCase,               
 "Acquire Currency",              
 "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa",  
 "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\holdAction_market_ca.paa",  
 "_this distance _target < 3",          
 "_caller distance _target < 3",          
 {},                 
 {},                 
 { params ["_target","_caller"]; 
_currencyAmount = [250, 1500] call BIS_fnc_randomInt; 
_caller = _this select 1;
  _moneyAmount = [str _currencyAmount, "rubles"] joinString " ";
  [_caller, _currencyAmount] call HALs_money_fnc_addFunds;
  _moneyContainer = _target call JA_LootGen_fnc_checkObject; 
  playSoundUI ["PDA_Tip"]; 
  if ( _moneyContainer == "CaseMoney") then { 
   deleteVehicle _target;
 
[["You have recieved",0.4,1],[_moneyAmount,0.4,4,2]] spawn BIS_fnc_EXP_camp_SITREP;

  }; 
    
  
 },                 
 {},                 
 [],                 
 3,                 
 12,                 
 true,                
 false                
] remoteExec ["BIS_fnc_holdActionAdd", 0, _moneyCase];

 
			