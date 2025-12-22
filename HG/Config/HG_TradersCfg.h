/*
    Author - HoverGuy
	GitHub - https://github.com/Ppgtjmad/SimpleShops
	Steam - https://steamcommunity.com/id/HoverGuy/
	Description - Defines available traders
	
	class YourTraderClass - Used as a param for the call, basically the trader you want to display
	{
		conditionToAccess - STRING - Condition that must return either true or false, if true the player will have access to the trader
		
		interestedIn - ARRAY OF ARRAYS - Stuff that the trader is interested in buying
		|- 0 - STRING - Item classname
		|- 1 - INTEGER - Item sell price
	};
*/

class HG_DefaultTrader // HG_DefaultTrader is just a placeholder for testing purposes, you can delete it completely and make your own
{
	conditionToAccess = "true"; // Example: "(playerSide in [west,independent]) AND ((rank player) isEqualTo 'COLONEL')"
	
	interestedIn[] = 
	{
		{"ItemMap",50},
		{"ItemRadio",50},
		{"ItemCompass",50},
		{"U_B_FullGhillie_ard",150},
		{"V_PlateCarrierGL_mtp",500},
		{"H_HelmetB_light_grass",1500},
		{"G_Balaclava_blk",50},
		{"G_Bandanna_shades",50},
		{"B_Carryall_oucamo",800},
		{"launch_B_Titan_F",50000},
		{"launch_RPG7_F",50000},
		{"hgun_P07_F",1500},
		{"arifle_AKM_F",12000},
		{"arifle_MX_SW_F",35000},
		{"SMG_02_f",5000},
		{"srifle_dmr_04_f",25000},
	};
};
