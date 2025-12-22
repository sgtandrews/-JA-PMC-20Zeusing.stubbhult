// by Alias

private ["_dyn_puddle"];

if (!hasInterface) exitWith {};

while {true} do 
{
	while {rain>0.02} do 
	{
		_poz_init_pl = getPos player;
		_np = 0;
		_lista_pud=[];
		while {_np<111} do 
		{
			_pos_umbla = player getRelPos [random 250, random 360];
			if (((player distance _pos_umbla) > 100) and ((player distance _pos_umbla) < 251)) then 
			{
				if (selectRandom [true,false]) then
				{				
					_dyn_puddle = (selectRandom ["WaterSpill_01_Large_Old_F","WaterSpill_01_Medium_Old_F","WaterSpill_01_Medium_Old_F","WaterSpill_01_Small_Old_F","WaterSpill_01_Small_Old_F","WaterSpill_01_Large_Foam_F","WaterSpill_01_Medium_Foam_F","WaterSpill_01_Medium_Foam_F","WaterSpill_01_Small_Foam_F","WaterSpill_01_Small_Foam_F","WaterSpill_01_Large_New_F","WaterSpill_01_Medium_New_F","WaterSpill_01_Medium_New_F","WaterSpill_01_Small_New_F","WaterSpill_01_Small_New_F"]) createVehiclelocal _pos_umbla;
					_dyn_puddle setVectorUp surfaceNormal position _dyn_puddle;
				} else {
					_rnd_text = selectRandom ["world\scripts\storm\ALthunder\1_puddle.paa","world\scripts\storm\ALthunder\2_puddle.paa","world\scripts\storm\ALthunder\3_puddle.paa","world\scripts\storm\ALthunder\4_puddle.paa","world\scripts\storm\ALthunder\5_puddle.paa","world\scripts\storm\ALthunder\6_puddle.paa"];
					_dyn_puddle = (selectRandom ["BloodPool_01_Large_New_F","WaterSpill_01_Large_Old_F","WaterSpill_01_Medium_Old_F","WaterSpill_01_Medium_Old_F","WaterSpill_01_Small_Old_F","WaterSpill_01_Small_Old_F","WaterSpill_01_Large_Foam_F","WaterSpill_01_Medium_Foam_F","WaterSpill_01_Medium_Foam_F","WaterSpill_01_Small_Foam_F","WaterSpill_01_Small_Foam_F","WaterSpill_01_Large_New_F","WaterSpill_01_Medium_New_F","WaterSpill_01_Medium_New_F","WaterSpill_01_Small_New_F","WaterSpill_01_Small_New_F"]) createVehiclelocal _pos_umbla;
					_dyn_puddle setObjectTextureGlobal [0,_rnd_text];
					_dyn_puddle setVectorUp surfaceNormal position _dyn_puddle;
				};			
				_lista_pud pushBack _dyn_puddle;
				_np=_np+1;
			};
			sleep 0.01;
		};
		waitUntil {(player distance _poz_init_pl)>250};
		{deleteVehicle _x; sleep 0.02} forEach _lista_pud;
	};
	sleep 600;
	waitUntil {rain>0.02};
};