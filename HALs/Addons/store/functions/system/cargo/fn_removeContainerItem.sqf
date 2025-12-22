params [
    ["_container", objNull, [objNull]],
    ["_classname", "", [""]]
];

if (isNull _container) exitWith {false};
if (_classname isEqualTo "") exitWith {false};
private _found = false;
private _data = (_container call HALs_store_fnc_getContainerCargo);
_data params ["_magazines", "_items", "_weapons", "_containers"];


private _containerItems = [];
private _everyContainer = everyContainer _container;

try {
    {
        if ((_x select 0) isEqualTo _classname) then {
            _magazines deleteAt _forEachIndex;
            throw true;
        };
    } forEach _magazines;

    private _curIndex = 0;
    {
        _curIndex = _forEachIndex;
        _weapon = _x;
        {
            private _wepClassname = if (_x isEqualType []) then {_x select 0} else {_x};

            if (_classname isEqualTo _wepClassname) then {
                if (_forEachIndex isEqualTo 0) then {
                    _weapon set [_forEachIndex, ""];

                    private _mags = _weapon select [4, 2];
                    {
                        _magazines pushBack _x
                    } forEach (_mags select {count _x > 0});

                    private _itemArr = _weapon;
                    {
                        if (!(_forEachIndex in [0, 4, 5]) && {count _x > 0}) then {
                            _items pushBack [_x, 1];
                        };
                    } forEach _itemArr;

                    _weapons set [_curIndex, []];
                } else {
                    _weapon set [_forEachIndex, ""];
                };

                throw true;
            };
        } forEach _weapon;
    } forEach _weapons;
    {
        if ((_x select 0) isEqualTo _classname) then {
            private _amt = _x select 1;
            if (_amt isEqualTo 1) then {
                _items deleteAt _forEachIndex;
            } else {
                (_items select _forEachIndex) set [1, _amt - 1];
            };

            throw true;
        };
    } forEach _items;

_containersTemp = + _containers;
    {
        

        private _invContainersIndex = 0;
        private _isInArray = _x find _classname;
        
        if (_isInArray isEqualTo 0) then {

            _invContainersIndex = _forEachIndex;
            
            _invContainersIndexTemp = _invContainersIndex;
        
        
        
            private _amtItems = 0;
            private _hasItems = false;
            
            for "_i" from 0 to 3 do {
                //systemChat str(_forEachIndex);
                //systemChat str(count((_x select 1) select 0));	   
                _amtItems = _amtItems + (count((_x select 1) select _i));
                            
                
                        
            };
            //systemChat str(_amtItems);
            _debugCountArray pushBack _amtItems;	   
            if (_amtItems > 0) then {
            
                //systemChat "Has Items in it"; 
                _invContainersIndexTemp = nil;
                
                } 
                
            else {
                
                //systemChat "No Items in it";
                
                _containers set [_forEachIndex, ""]; 
                throw true;
                }; 
                //systemChat str(count(((_containers select _counterIndex)select 1)select 1));
                //systemChat str(_amtItems);
                
                //systemChat str(_x);
                
            };
            
            
            
    } forEach _containers;
    
} catch {
    
    [_container] call HALs_store_fnc_clearContainerCargo;
    [_container, _data] call HALs_store_fnc_addContainerCargo;

    _found = _exception;
};
_found

/*

_containersTemp = _containers;

_invContainersIndex = [];

systemChat "===";

//systemChat str(_containers);


{
private _currentContainer = _x;
private _isInArray = _x find _classname;
if (_isInArray isEqualTo 0) then {

_invContainersIndex pushBack _forEachIndex;

}; 
 
}forEach _containers;

systemChat str(_containers);

_invContainersIndexTemp = _invContainersIndex;

//systemChat str(_invContainersIndexTemp);
{
private _counterIndex = _x;
private _amtItems = 0;
private _hasItems = false;

for "_i" from 0 to 3 do {


_amtItems = _amtItems + (count(((_containers select _counterIndex)select 1)select _forEachIndex));


};

if (_amtItems > 0) then {

systemChat "Has Items in it"; _invContainersIndexTemp deleteAt _forEachIndex;} else {

systemChat "No Items in it";

_containers deleteAt _counterIndex; 

}; 
//systemChat str(count(((_containers select _counterIndex)select 1)select 1));
//systemChat str(_amtItems);

//systemChat str(_x);
}forEach _invContainersIndex;

//systemChat str(_invContainersIndexTemp);



systemChat str(_containers);
//_invContainersIndex

//if (_amtItems > 0) then {systemChat "Has items in bag"}; 

//if (_amtItems > 0) then {_hasItems = true;};



*/