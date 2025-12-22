/*
	Macro: ERROR_WITH_TITLE()

	Parameters:
	0: CLASSNAME - Classname of item
	1: PRICE - Default item price
	2: STOCK - Default item stock

	.45CP Rounds 	= 58.5 per Round 	= 1755 per 30 Rounds
	7.62x25 Rounds	= 61 per Round		= 1830 per 30 Rounds
	7.62x17 Rounds	= 63 per Round		= 1890 per 30 Rounds
	9x18 Rounds		= 54 per Round		= 1620 per 30 Rounds
	9x21 Rounds		= 55 per Round		= 1650 per 30 Rounds
	9x19 Rounds		= 54.5 per Round	= 1635 per 30 Rounds
	5.45x39 Rounds	= 81 per Round 		= 2430 per 30 Rounds
	7.92x33			= 76 per Round		= 2280 per 30 Rounds	
	12 Gauge		= 48 per Round		= 1440 per 30 Rounds
	9.30x62			= 102 per Round		= 3060 per 30 Rounds
	7.62x54			= 94 per Round		= 2820 per 30 Rounds
	7.9x57			= 98 per Round		= 2940 per 30 Rounds
__________________________________________________________________*/
#define ITEM(CLASSNAME, PRICE, STOCK)\
	class CLASSNAME {\
		price = PRICE;\
		stock = STOCK;\
	};

class cfgHALsStore {
	containerTypes[] = {"LandVehicle", "Air", "Ship"};
	containerRadius = 10;
	currencySymbol = "₽";
	sellFactor = 0.15;
	debug = 1;

	class categories {
		class handguns1 {
			displayName = "Handguns";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\handgun_ca.paa";

			#define HDG_STOCK 5
			/*
			ITEM(CUP_hgun_Colt1911, 8100, HDG_STOCK);
			ITEM(rhs_weap_tt33, 9200, HDG_STOCK);
			ITEM(rhs_weap_makarov_pm, 4600, HDG_STOCK);
			ITEM(rhs_weap_pb_6p9, 5200, HDG_STOCK);
			ITEM(rhs_weap_savz61_folded, 14000,HDG_STOCK);
			ITEM(rhs_weap_6p53, 4900, HDG_STOCK);
			ITEM(rhs_weap_cz99, 5100, HDG_STOCK);
			ITEM(hgun_P07_blk_F, 5000, HDG_STOCK);
			ITEM(rhsusf_weap_m9, 7000, HDG_STOCK);*/
		};
		class grenades1{
			displayName = "Grenades";
			#define GREN_STOCK 5
			ITEM(rhs_mag_rdg2_white,800,GREN_STOCK);
			ITEM(CUP_HandGrenade_RGO,15000,1);
			ITEM(rhs_grenade_mkii_mag,17500,1);
			ITEM(rhs_grenade_nbhgr39_mag,11000,3);
			ITEM(rhs_mag_an_m14_th3,18000,1);
			
			
			
			//ITEM(,,GREN_STOCK);

		};
		class mainarms1 {
			displayName = "Main Arms";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";

			#define MA_STOCK 5
			/*
			ITEM(uk3cb_ppsh41, 21000, MA_STOCK);
			ITEM(uk3cb_sks_01, 18000, MA_STOCK);
			ITEM(UK3CB_MP5A2, 19000, MA_STOCK);
			ITEM(CUP_sgun_slamfire, 7500, MA_STOCK);
			ITEM(sgun_HunterShotgun_01_sawedoff_F, 12000, MA_STOCK);
			ITEM(sgun_HunterShotgun_01_F, 15000, MA_STOCK);
			ITEM(CUP_srifle_Mosin_Nagant, 18000, MA_STOCK);
			ITEM(UK3CB_CZ550, 20000, MA_STOCK);
			ITEM(rhs_weap_m38, 16000, MA_STOCK);
			ITEM(rhs_weap_m3a1, 16500, MA_STOCK);
			ITEM(rhs_weap_MP44, 21000, MA_STOCK);
			ITEM(rhs_weap_scorpion, 14000, MA_STOCK);
			ITEM(rhs_weap_aks74u, 26000, 1);*/
		};
		class smgs1 {
			displayName = "SMGs";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";
			#define SMG_STOCK 5
		};
		class smgsmags1 {
			displayName = "SMGs Magazines";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";
			#define SMG_STOCK 5
		};


		class assaults1 {
			displayName = "Assault Rifles";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";
			#define AR_STOCK 5
		};

		class shotguns1 {
			displayName = "Shotguns";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";
			#define SG_STOCK 5
		};

		class rifles1 {
			displayName = "Rifles";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";
			#define RI_STOCK 5
		};

		class attachments1 {
			displayName = "Attachments";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";

			#define AT_STOCK 10
			ITEM(rhs_acc_6p9_suppressor, 1500, AT_STOCK);
			ITEM(CUP_optic_PEM, 2500, AT_STOCK);
			ITEM(muzzle_snds_acp, 1600, AT_STOCK);
			ITEM(uk3cb_muzzle_sks_bayonet, 1000, AT_STOCK);
		};
		class medical1{
			displayName = "Medical";
			#define MED_STOCK 5
			ITEM(ACE_elasticBandage, 325, 20);
			ITEM(ACE_fieldDressing, 200, 20);
			ITEM(ACE_packingBandage, 250, 20);
			ITEM(ACE_quikclot, 200, 20);
			ITEM(ACE_morphine, 900, MED_STOCK);
			ITEM(ACE_epinephrine, 250, MED_STOCK);
			ITEM(ACE_adenosine, 200, MED_STOCK);
			ITEM(ACE_tourniquet, 100, MED_STOCK);
			ITEM(ACE_splint, 200, MED_STOCK);
			ITEM(ACE_bloodIV_250, 500, MED_STOCK);
			ITEM(ACE_bloodIV_500, 1000, MED_STOCK);
			ITEM(ACE_bloodIV, 1500, MED_STOCK);
			ITEM(ACE_plasmaIV_250, 500, MED_STOCK);
			ITEM(ACE_plasmaIV_500, 1000, MED_STOCK);
			ITEM(ACE_plasmaIV, 1500, MED_STOCK);
			ITEM(ACE_salineIV_250, 500, MED_STOCK);
			ITEM(ACE_salineIV_500, 1000, MED_STOCK);
			ITEM(ACE_salineIV, 1500, MED_STOCK);
			ITEM(ACE_personalAidKit, 8000, MED_STOCK);
			ITEM(ACE_painkillers, 1200, MED_STOCK);
			ITEM(ACE_suture, 50, 500);
			ITEM(ACE_surgicalKit, 12000, 2);
			ITEM(FSGm_ItemMedicBag, 20000, 2);
			ITEM(FSGm_ItemMedicBagMil, 20000, 0);
		};
		class food1{
			displayName = "Food & Water";
			#define FOOD_STOCK 10
			ITEM(ACE_MRE_BeefStew,1000,FOOD_STOCK);
			ITEM(ACE_MRE_ChickenTikkaMasala,1000,FOOD_STOCK);
			ITEM(ACE_MRE_ChickenHerbDumplings,1000,FOOD_STOCK);
			ITEM(ACE_MRE_CreamChickenSoup,1000,FOOD_STOCK);
			ITEM(ACE_MRE_CreamTomatoSoup,1000,FOOD_STOCK);
			ITEM(ACE_MRE_LambCurry,1000,FOOD_STOCK);
			ITEM(ACE_MRE_MeatballsPasta,1000,FOOD_STOCK);
			ITEM(ACE_MRE_SteakVegetables,1000,FOOD_STOCK);
			ITEM(ACE_Banana,1000,FOOD_STOCK);
			ITEM(ACE_Humanitarian_Ration,1000,FOOD_STOCK);
			ITEM(ACE_Can_Franta,500,FOOD_STOCK);
			ITEM(ACE_Can_RedGull,500,FOOD_STOCK);
			ITEM(ACE_Can_Spirit,500,FOOD_STOCK);  
			ITEM(ACE_Canteen,1500,FOOD_STOCK);
			ITEM(ACE_WaterBottle,1000,FOOD_STOCK);
		};
		class uniforms1 {
			displayName = "Uniforms";
			defaultstock = 2;
			#define UNI_STOCK 10

			//ITEM(U_OrestesBody,500,UNI_STOCK);
			/*
			ITEM(CUP_U_C_Tracksuit_01,250,UNI_STOCK);
			ITEM(CUP_U_C_Tracksuit_02,250,UNI_STOCK);
			ITEM(CUP_U_C_Tracksuit_03,250,UNI_STOCK);
			ITEM(CUP_U_C_Tracksuit_04,250,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo25,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo20,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo21,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo23,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo24,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo22,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo28,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo2,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo10,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo14,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo18,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo6,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo8,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo26,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo12,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo16,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo4,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo29,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo3,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo11,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo15,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo19,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo7,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo5,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo27,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo1,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo9,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo13,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Cargo17,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo16,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo17,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo18,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo19,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo2,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo6,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo10,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo14,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo4,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo8,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo12,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo3,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo7,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo11,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo15,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo5,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo9,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cargo13,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo16,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo17,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo18,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo19,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo2,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo6,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo10,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo14,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo4,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo8,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo12,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo3,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo7,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo11,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo15,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo5,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo9,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Cargo13,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo16,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo17,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo19,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo18,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo2,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo6,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo14,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo10,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo4,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo12,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo8,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo3,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo7,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo15,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo11,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo1,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo5,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo13,500,UNI_STOCK);
			ITEM(Project_BJC_Cargo9,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean5,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean2,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean3,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean4,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean2,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean3,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean2,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean3,500,UNI_STOCK);
			ITEM(Project_BJC,500,UNI_STOCK);
			ITEM(Project_BJC_2,500,UNI_STOCK);
			ITEM(Project_BJC_3,500,UNI_STOCK);
			ITEM(Project_BJC_1,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean_blk5,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean_blk,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean_blk2,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean_blk3,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean_blk4,500,UNI_STOCK);
			ITEM(Project_BJC_PCU_Jean_blk1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean_blk,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean_blk1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean_blk2,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Jean_blk3,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean_blk,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean_blk1,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean_blk2,500,UNI_STOCK);
			ITEM(Project_BJC_Shirt_Cut_Jean_blk3,500,UNI_STOCK);
			ITEM(Project_BJC_blk,500,UNI_STOCK);
			ITEM(Project_BJC_blk_2,500,UNI_STOCK);
			ITEM(Project_BJC_blk_3,500,UNI_STOCK);
			ITEM(Project_BJC_blk_1,500,UNI_STOCK);
			ITEM(PMC_Cargo_BJCP_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Cargo_BJCP_Tshirt_PPL,500,UNI_STOCK);
			ITEM(PMC_Cargo_BLK_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Cargo_BLK_Tshirt_GRN,500,UNI_STOCK);
			ITEM(PMC_Cargo_BLK_Tshirt_Noori,500,UNI_STOCK);
			ITEM(PMC_Cargo_BLK_Tshirt_PPL,500,UNI_STOCK);
			ITEM(PMC_Cargo_MC_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Cargo_MC_Tshirt_PPL,500,UNI_STOCK);
			ITEM(PMC_Cargo_RGR_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Cargo_RGR_Tshirt_GRN,500,UNI_STOCK);
			ITEM(PMC_Cargo_RGR_Tshirt_Noori,500,UNI_STOCK);
			ITEM(PMC_Cargo_RGR_Tshirt_PPL,500,UNI_STOCK);
			ITEM(PMC_Cargo_TAN_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Cargo_TAN_Tshirt_GRN,500,UNI_STOCK);
			ITEM(PMC_Cargo_TAN_Tshirt_Noori,500,UNI_STOCK);
			ITEM(PMC_Cargo_TAN_Tshirt_PPL,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_BLU_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_WHT,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_WHT_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_BLU_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_WHT,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_WHT_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_Cut_BLU,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_Cut_BLU_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_Cut_WHT,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Shirt_Cut_WHT_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_Cut_BLU,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_Cut_BLU_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_Cut_WHT,500,UNI_STOCK);
			ITEM(PMC_Jeans_Shirt_Cut_WHT_Dirty,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Tshirt_GRN,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Tshirt_Noori,500,UNI_STOCK);
			ITEM(PMC_Jeans_BLK_Tshirt_PPL,500,UNI_STOCK);
			ITEM(PMC_Jeans_Tshirt_BLU,500,UNI_STOCK);
			ITEM(PMC_Jeans_Tshirt_GRN,500,UNI_STOCK);
			ITEM(PMC_Jeans_Tshirt_Noori,500,UNI_STOCK);
			ITEM(PMC_Jeans_Tshirt_PPL,500,UNI_STOCK);
			//ITEM(,0,UNI_STOCK);
			*/
		};

		class tools1 {
			displayName = "Tools";
			#define TOOL_STOCK 5
			ITEM(ACRE_BF888S,6500,TOOL_STOCK);
			ITEM(ACE_Flashlight_Maglite_ML300L,500,TOOL_STOCK);
			ITEM(ACE_EntrenchingTool,600,TOOL_STOCK);
			ITEM(ACE_MapTools,250,TOOL_STOCK);
			ITEM(ToolKit,6000,TOOL_STOCK);
			ITEM(ACE_rope3, 300, 15);
			ITEM(ACE_rope6, 600, 10);
			ITEM(ACE_rope12, 1200, 1);
			ITEM(ACE_rope15, 1500, 1);
			ITEM(ACE_rope18, 1800, 2);
			ITEM(ACE_rope27, 2700, 2);
			ITEM(ACE_rope36, 3600, 1);
			ITEM(ACE_Sandbag_empty, 100, 25);
			ITEM(ACE_CableTie, 50, 100);
			ITEM(ACE_SpraypaintBlack, 500, 0);
			ITEM(ACE_SpraypaintBlue, 500, 0);
			ITEM(ACE_SpraypaintGreen, 500, 0);
			ITEM(ACE_SpraypaintRed, 500, 0);
			ITEM(ACE_SpraypaintWhite, 500, 0);
			ITEM(ACE_SpraypaintYellow, 500, 0);
			ITEM(ACE_EHP, 600, 0);
			ITEM(ACE_EarPlugs, 5, 100);
			ITEM(ACE_Chemlight_Shield, 250 , 0);
			ITEM(ACE_Flashlight_XL50, 600 , TOOL_STOCK);
			ITEM(acex_intelitems_notepad, 200, 10);
			ITEM(ACE_wirecutter, 1500 ,2);
			ITEM(ACE_DeadManSwitch, 2000, 0);
			ITEM(ACE_Cellphone, 2500, 1);
			//ITEM(,,TOOL_STOCK);
		};

		class toolthrowables1 {
			displayName = "Throwables";
			#define TOOLTHROW_STOCK 5

			ITEM(ACE_HandFlare_Green, 1500,TOOLTHROW_STOCK);
			ITEM(ACE_HandFlare_Red, 1500, TOOLTHROW_STOCK);
			ITEM(ACE_HandFlare_White, 1500, TOOLTHROW_STOCK);
			ITEM(ACE_HandFlare_Yellow, 1500, TOOLTHROW_STOCK);
			ITEM(Chemlight_blue, 2500, TOOLTHROW_STOCK);
			ITEM(Chemlight_green, 2500, TOOLTHROW_STOCK);
			ITEM(Chemlight_red, 2500, TOOLTHROW_STOCK);
			ITEM(Chemlight_blue, 2500, TOOLTHROW_STOCK);
			ITEM(Chemlight_yellow, 2500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_White, 2500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_HiBlue, 3500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_HiGreen, 3500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_HiRed, 3500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_HiWhite, 3500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_HiYellow, 3500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_Orange, 2500, TOOLTHROW_STOCK);
			ITEM(ACE_Chemlight_UltraHiOrange, 4500, TOOLTHROW_STOCK);

			//ITEM(,,TOOLTHROW_STOCK);

		};
		class vests1 {
			displayName = "Vests";
			#define VEST_STOCK 5
			/*
			ITEM(rhsgref_alice_webbing,3100,VEST_STOCK);
			ITEM(CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing,3900,VEST_STOCK);
			ITEM(SP_Bandolier1_Green,2200,VEST_STOCK);
			ITEM(CUP_V_CDF_CrewBelt,2500,VEST_STOCK);
			ITEM(V_Chestrig_khk,3500,VEST_STOCK);
			ITEM(V_SmershVest_01_F,3650,VEST_STOCK);
			ITEM(CUP_V_RUS_Smersh_New_Full,3500,VEST_STOCK);
			ITEM(UK3CB_TKA_I_V_6Sh92_vog_Khk,3500,VEST_STOCK);
			ITEM(UK3CB_TKA_I_V_vydra_3m_Tan,3400,VEST_STOCK);
			ITEM(UK3CB_ADA_B_V_TacVest_KHK,4500,VEST_STOCK);
			ITEM(SE_Loner_Belt,2500,VEST_STOCK);
			//ITEM(,0,VEST_STOCK);*/

		};
		class bags1 {
			displayName = "Bags";
			#define BAG_STOCK 5
			/*
			ITEM(B_Respawn_Sleeping_bag_blue_F,40000,BAG_STOCK);
			ITEM(B_Respawn_Sleeping_bag_brown_F,40000,BAG_STOCK);
			ITEM(B_Respawn_TentDome_F,80000,BAG_STOCK);
			ITEM(B_Respawn_Sleeping_bag_F,40000,BAG_STOCK);
			ITEM(B_Respawn_TentA_F,80000,BAG_STOCK);
			ITEM(B_LegStrapBag_coyote_F,1800,BAG_STOCK);
			ITEM(rhs_medic_bag,2000,BAG_STOCK);
			ITEM(UK3CB_CW_SOV_O_EARLY_B_Sidor_RIF,2600,BAG_STOCK);
			ITEM(B_Messenger_Coyote_F,2800,BAG_STOCK);
			ITEM(CUP_B_AssaultPack_Coyote,3200,BAG_STOCK);
			//ITEM(,,BAG_STOCK);
			*/
		};
		class headgear1 {
			displayName = "Headgear";
			#define HG_STOCK 5
			/*
			ITEM(rhs_beanie_green,500,HG_STOCK);
			ITEM(UK3CB_H_Beanie_02_BLK,500,HG_STOCK);
			ITEM(H_Cap_tan,500,HG_STOCK);
			ITEM(CUP_H_PMC_Cap_Back_Tan,500,HG_STOCK);
			ITEM(UK3CB_ARD_B_H_Crew_Cap,500,HG_STOCK);
			ITEM(H_ShemagOpen_tan,500,HG_STOCK);
			ITEM(UK3CB_H_Shemag_blk,500,HG_STOCK);
			ITEM(rhs_tsh4,500,HG_STOCK);
			ITEM(UK3CB_H_Ushanka_Cap_01,500,HG_STOCK);
			ITEM(rhs_ushanka,500,HG_STOCK);
			ITEM(CUP_H_C_Ushanka_03,500,HG_STOCK);
			ITEM(CUP_H_C_Ushanka_02,500,HG_STOCK);
			ITEM(CUP_H_C_Ushanka_04,500,HG_STOCK);
			ITEM(rhsgref_M56,800,HG_STOCK);
			ITEM(rhs_ssh60,800,HG_STOCK);
			ITEM(rhs_ssh68_2,800,HG_STOCK);
			ITEM(H_Tank_eaf_F,900,HG_STOCK);
			ITEM(rhssaf_helmet_m59_85_nocamo,1200,HG_STOCK);
			ITEM(CUP_H_SLA_Helmet_OD_worn,1400,HG_STOCK);
			ITEM(CUP_H_SLA_TankerHelmet,1400,HG_STOCK);
			//ITEM(,,HG_STOCK);
			*/
		};
		class facewear1 {
			displayName = "Facewear";
			#define FW_STOCK 1
			ITEM(G_Balaclava_blk,800,FW_STOCK);
			ITEM(G_Balaclava_lowprofile,800,FW_STOCK);
			ITEM(G_Bandanna_aviator,800,FW_STOCK);
			ITEM(G_Bandanna_shades,800,FW_STOCK);
			//ITEM(,0,FW_STOCK);
		};
		class magazines1 {
			displayName = "Magazines";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
			defaultstock = 5;
			#define MAG_STOCK 2
			
		};
	};

	class stores {
		class medical1 {
			displayName = "Matvey's Medical";
			categories[] = {"medical1"};
		};

		class weapon1 {
			displayName = "Nikolay's Store";
			categories[] = {"handguns1", "smgs1","assaults1","shotguns1","rifles1", "magazines1", "attachments1","grenades1"};
		};

		class food1{
			displayName = "George's Grocery";
			categories[] = {"food1"};
		};

		class equipment1{
			displayName = "Stepan's Shit";
			categories[] = {"uniforms1","vests1","bags1","headgear1","facewear1"};
		};

		class mechanic1{
			displayName = "Konstantin's Tools";
			categories[] = {"tools1","toolthrowables1"};
		}
	};
};