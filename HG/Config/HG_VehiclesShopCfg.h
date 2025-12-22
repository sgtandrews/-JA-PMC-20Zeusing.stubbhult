/*
    Author - HoverGuy
	GitHub - https://github.com/Ppgtjmad/SimpleShops
	Steam - https://steamcommunity.com/id/HoverGuy/
	Description - Defines available vehicle shops
	
	class YourShopClass - Used as a param for the call, basically the shop you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the shop
		
		class YourShopCategory - Shop category, can be whatever you want
		{
			displayName - STRING - Category display name
			vehicles - ARRAY OF ARRAYS - Shop content
			|- 0 - STRING - Classname
			|- 1 - INTEGER - Price
			|- 2 - STRING - Condition that must return either true or false, if true the vehicle appears in the list else no
			spawnPoints - ARRAY OF ARRAYS - Spawn positions (markers/positions)
			|- 0 - STRING - Display name in the dialog
			|- 1 - ARRAY OF MIXED - Markers/positions
		};
	};
*/

class HG_DefaultShop // HG_DefaultShop is just a placeholder for testing purposes, you can delete it completely and make your own
{
    conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
		class SmallVehicles
	{
	    displayName = "$STR_HG_SHOP_SMALLVEH";
		vehicles[] =
		{
		    {"UK3CB_CHC_C_Old_Bike",3000,"true"},
			{"UK3CB_CHC_C_MMT",3000,"true"}					

	    };
		spawnPoints[] =
		{
			{"$STR_HG_MARKER_2",{"civilian_vehicles_spawn_1"}}
		};
	};

	class MediumVehicles
	{
	    displayName = "$STR_HG_SHOP_MEDVEH";
		vehicles[] =
		{
			{"CUP_C_Skoda_CR_CIV",14145,"true"},
			{"CUP_LADA_LM_CIV",15627,"true"}, 
			{"CUP_C_Lada_White_CIV",15627,"true"},
			{"UK3CB_CHC_C_S1203_Amb",16228,"true"},
			{"UK3CB_ADC_C_S1203",16228,"true"},
			{"UK3CB_ADC_C_Skoda",16561,"true"},
			{"UK3CB_ADC_C_Lada_Taxi",17678,"true"},
			{"UK3CB_ADC_C_UAZ_Closed",18143,"true"}, 
			{"UK3CB_ADC_C_UAZ_Open",18143,"true"},
			{"UK3CB_ADC_C_Hatchback",18380,"true"},
			{"UK3CB_ADC_C_Sedan",18380,"true"},
			{"UK3CB_ADC_C_Datsun_Civ_Closed",18941,"true"}, 
			{"UK3CB_ADC_C_Datsun_Civ_Open",18941,"true"},
			{"UK3CB_ADC_C_Gaz24",19369,"true"},
			{"UK3CB_ADC_C_Golf",21947,"true"},
			{"CUP_C_SUV_CIV",23087,"true"}, 
			{"UK3CB_C_Landcruiser",24380,"true"},
			{"UK3CB_ADC_C_LR_Closed",25082,"true"},
			{"UK3CB_ADC_C_LR_Open",25082,"true"},
			{"UK3CB_CHC_C_Octavia",25375,"true"},
			{"UK3CB_ADC_C_Pickup",28239,"true"},
			{"UK3CB_ADC_C_SUV",30631,"true"},  
		    {"UK3CB_ADC_C_Hilux_Civ_Open",37938,"true"}, 
			{"UK3CB_ADC_C_Hilux_Civ_Closed",37938,"true"}
	    };
		spawnPoints[] =
		{
			{"$STR_HG_MARKER_2",{"civilian_vehicles_spawn_1"}}
		};
	};

	class LargeVehicles
	{
	    displayName = "$STR_HG_SHOP_LARGEVEH";
		vehicles[] =
		{
			{"CUP_C_Bus_City_CRCIV",11869,"true"},
			{"UK3CB_ADC_C_V3S_Closed",19191,"true"}, 
			{"UK3CB_ADC_C_V3S_Open",19191,"true"},
			{"UK3CB_ADC_C_Ural_Open",20061,"true"},
			{"UK3CB_ADC_C_Ural_Empty",20127,"true"}, 
		    {"UK3CB_ADC_C_Kamaz_Covered",21572,"true"}
	    };
		spawnPoints[] =
		{
			{"$STR_HG_MARKER_2",{"civilian_vehicles_spawn_1"}}
		};
	};
	class Military
	{
	    displayName = "$STR_HG_SHOP_MILITARY";
		vehicles[] =
		{
		    {"CUP_I_Hilux_DSHKM_TK",39480,"true"}
	    };
		spawnPoints[] =
		{
			{"$STR_HG_MARKER_2",{"military_vehicles_spawn_1"}}
		};
	};
};
