// Mission Ideas 
// Package Retrieval, Crate Destruction, Escort, Logistical Run, Vehicle Repair, Medical Treatment, Chemical Leak, Artifact Retrieval, Crate Request, Clear Area, Intel Gathering 

// Notice Board 
recruitMissionBoard addAction
[
	localize "STR_TFA_TITLE_MISSION_KILL_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, "Bandits",(_this select 0)] remoteExec ["JA_MISSIONGEN_fnc_assignKillMission",2];
		
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

// Medical Trader 
medical_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_SUPPLY_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		(_this select 0) removeAction (_this select 2); 
		[_this select 1, "Medical",(_this select 0),"Random"] call JA_MISSIONGEN_fnc_assignSupplyMission;
		
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

medical_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_ADVMEDICAL_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, "Advanced Medical",(_this select 0),"Single"] call JA_MISSIONGEN_fnc_assignSupplyMission;
		
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

// Weapons Trader 
weapons_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_SUPPLY_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		(_this select 0) removeAction (_this select 2); 
		[_this select 1, "Mags",(_this select 0),"Random"] call JA_MISSIONGEN_fnc_assignSupplyMission;
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

weapons_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_GUNRUN_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, "Firearm",(_this select 0),"Single"] call JA_MISSIONGEN_fnc_assignSupplyMission;
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

// Food Trader 
food_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_SUPPLY_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		(_this select 0) removeAction (_this select 2); 
		[_this select 1, "Food",(_this select 0),"Random"] call JA_MISSIONGEN_fnc_assignSupplyMission;
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

// Equipment Trader 
equipment_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_SUPPLY_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, (selectRandom ["Bag","Headgear","Facewear","Uniform"]),(_this select 0),"Single"] call JA_MISSIONGEN_fnc_assignSupplyMission;
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

// Mechanic and Industrial Trader
mechanic_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_SUPPLY_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, "Industrial",(_this select 0),"Random"] call JA_MISSIONGEN_fnc_assignSupplyMission;
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];

mechanic_traderlvl1 addAction
[
	localize "STR_TFA_TITLE_MISSION_ADVINDUST_BOARD",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"]; 
		(_this select 0) removeAction (_this select 2);
		[_this select 1, "Advanced Industrial",(_this select 0),"Single"] call JA_MISSIONGEN_fnc_assignSupplyMission;
	},
	nil,		
	1.5,		
	false,		
	false,		
	"",			
	"true",		
	5,			
	false,		
	"",			
	""			
];