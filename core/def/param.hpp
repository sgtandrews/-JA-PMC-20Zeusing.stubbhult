class Params {
    //====================================== Open World Loot Spawning Options
    class TFA_p_openworldloot_title {
        title =$STR_TFA_PARAM_PARAM_OPENWORLD_LOOT_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    //====================================== Spawn Chance and Options
    class TFA_p_spawn_title {
        title =$STR_TFA_PARAM_SPAWN_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_spawn_space{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_loottogle {
        title =$STR_TFA_PARAM_LOOT_SPAWN_TOGGLE;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
    class TFA_p_loottogle {
        title =$STR_TFA_PARAM_LOOT_SPAWN_TOGGLE;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
    class TFA_p_spawnfluidity {
        title =$STR_TFA_PARAM_LOOT_SPAWN_TYPE;
        values[]={0,1};
        texts[]={"Strict | Only checks the nearest building","Fluid | Checks all nearby buildings in a radius"};
        default = 0;
    };
    class TFA_p_spawn_chance {
        title =$STR_TFA_PARAM_SPAWN_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 45;
    };
    class TFA_p_item_chance {
        title =$STR_TFA_PARAM_ITEM_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 95;
    };
    class TFA_p_box_chance {
        title =$STR_TFA_PARAM_BOX_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 10;
    };
    class TFA_p_bagChance {
        title =$STR_TFA_PARAM_bagChance;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 5;
    };
    class TFA_p_vest_chance {
        title =$STR_TFA_PARAM_VEST_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 15;
    };
    class TFA_p_launcher_chance {
        title =$STR_TFA_PARAM_LAUNCHER_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 5;
    };
    class TFA_p_mil_at_civbuildings {
        title =$STR_TFA_PARAM_LOOT_MIL_CIV_BUILDINGS;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 0;
    };
    class TFA_p_civ_at_milbuildings {
        title =$STR_TFA_PARAM_LOOT_CIV_MIL_BUILDINGS;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 0;
    };
    class TFA_p_medical_chance_increase {
        title =$STR_TFA_PARAM_LOOT_MED_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 80;
    };
    class TFA_p_military_chance_increase {
        title =$STR_TFA_PARAM_LOOT_MIL_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 80;
    };
    class TFA_p_food_chance_increase {
        title =$STR_TFA_PARAM_LOOT_FOOD_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 80;
    };
    class TFA_p_indust_chance_increase {
        title =$STR_TFA_PARAM_LOOT_INDUST_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 80;
    };
    class TFA_p_ruin_reduction_toggle {
        title =$STR_TFA_PARAM_RUINS_TOGGLE;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
    class TFA_p_ruin_reduction_chance {
        title =$STR_TFA_PARAM_RUINS_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 70;
    };
    class TFA_p_spawn_distance {
        title =$STR_TFA_PARAM_SPAWN_DISTANCE;
        values[]={50,100,250,500,1000,1500,2000};
        texts[]={"50m","100m","250m","500m","1000m","1500m","2000m"};
        default = 250;
    };
    class TFA_p_spawn_debug {
        title =$STR_TFA_PARAM_DEBUG_MODE;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 0;
    };
    class TFA_p_spawn_space2{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
//====================================== Loot Pool Options
    class TFA_p_loot_title {
        title =$STR_TFA_PARAM_LOOT_POOL_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_loot_space{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_min_glrounds {
        title =$STR_TFA_PARAM_LOOT_POOL_MIN_GL;
        values[]={0,1,2,3,4,5};
        texts[]={"0","1","2","3","4","5"};
        default = 1;
    };
    class TFA_p_min_launcherrounds {
        title =$STR_TFA_PARAM_LOOT_POOL_MIN_LAUNCHERS;
        values[]={0,1,2,3,4,5};
        texts[]={"0","1","2","3","4","5"};
        default = 1;
    };
    class TFA_p_max_glrounds {
        title =$STR_TFA_PARAM_LOOT_POOL_MAX_GL;
        values[]={0,1,2,3,4,5};
        texts[]={"0","1","2","3","4","5"};
        default = 2;
    };
    class TFA_p_max_launcherrounds {
        title =$STR_TFA_PARAM_LOOT_POOL_MAX_LAUNCHERS;
        values[]={0,1,2,3,4,5};
        texts[]={"0","1","2","3","4","5"};
        default = 2;
    };
    class TFA_p_loot_space2{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
//====================================== Ground Loot Pool Options
    class TFA_p_groundloot_title {
        title =$STR_TFA_PARAM_LOOT_POOL_GROUND_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_groundloot_space{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_groundloot_junkspawn {
        title =$STR_TFA_PARAM_CAN_SPAWN_JUNK;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
    class TFA_p_groundloot_junk_chance {
        title =$STR_TFA_PARAM_LOOT_POOL_JUNK_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 10;
    };
    class TFA_p_groundloot_min_mags {
        title =$STR_TFA_PARAM_LOOT_POOL_MIN_MAG_GROUND;
        values[]={0,1,2,3,4,5};
        texts[]={"0","1","2","3","4","5"};
        default = 1;
    };
    class TFA_p_groundloot_max_mags {
        title =$STR_TFA_PARAM_LOOT_POOL_MAX_MAG_GROUND;
        values[]={0,1,2,3,4,5};
        texts[]={"0","1","2","3","4","5"};
        default = 3;
    };
    class TFA_p_groundloot_space2{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
//====================================== Medical Loot Pool Options
    class TFA_p_medical_title {
        title =$STR_TFA_PARAM_LOOT_POOL_MEDICAL_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_medical_space{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_medical_junkspawn {
        title =$STR_TFA_PARAM_CAN_SPAWN_JUNK;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
    class TFA_p_medical_junk_chance {
        title =$STR_TFA_PARAM_LOOT_POOL_JUNK_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 35;
    };
    class TFA_p_medical_blood_chance {
        title =$STR_TFA_PARAM_LOOT_POOL_BLOOD;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 35;
    };
    class TFA_p_medical_adv_med_chance {
        title =$STR_TFA_PARAM_LOOT_POOL_ADV_MEDICAL;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 10;
    };
    class TFA_p_medical_min_items {
        title =$STR_TFA_PARAM_LOOT_POOL_MEDICAL_MIN_AMOUNT;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 15;
    };
    class TFA_p_medical_max_items {
        title =$STR_TFA_PARAM_LOOT_POOL_MEDICAL_MAX_AMOUNT;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 45;
    };
    class TFA_p_medical_space2{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
//====================================== Ammobox Loot Pool Options
    class TFA_p_ammobox_title {
        title =$STR_TFA_PARAM_LOOT_POOL_AMMOBOX_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_ammobox_space{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_ammobox_junkspawn {
        title =$STR_TFA_PARAM_CAN_SPAWN_JUNK;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 0;
    };
    class TFA_p_ammobox_junk_chance {
        title =$STR_TFA_PARAM_LOOT_POOL_JUNK_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 0;
    };
    class TFA_p_ammobox_min_items {
        title =$STR_TFA_PARAM_LOOT_POOL_MIN_MAG_AMMOBOX;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 5;
    };
    class TFA_p_ammobox_max_items {
        title =$STR_TFA_PARAM_LOOT_POOL_MAX_MAG_AMMOBOX;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 15;
    };
    class TFA_p_ammobox_space2{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
//====================================== Case Loot Pool Options
class TFA_p_case_title {
        title =$STR_TFA_PARAM_LOOT_POOL_CASE_TITLE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_case_space{
        title =$STR_TFA_PARAM_PARAM_SPACE;
        values[]={0};
        texts[]={""};
        default = 0;
    };
    class TFA_p_case_junkspawn {
        title =$STR_TFA_PARAM_CAN_SPAWN_JUNK;
        values[]={0,1};
        texts[]={"No","Yes"};
        default = 1;
    };
    class TFA_p_case_junk_chance {
        title =$STR_TFA_PARAM_LOOT_POOL_JUNK_CHANCE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0%","5%","10%","15%","20%","25%","30%","35%","40%","45%","50%","55%","60%","65%","70%","75%","80%","85%","90%","95%","100%"};
        default = 45;
    };
    class TFA_p_case_min_ammo {
        title =$STR_TFA_PARAM_LOOT_POOL_MIN_MAG_CASE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 5;
    };
    class TFA_p_case_max_ammo {
        title =$STR_TFA_PARAM_LOOT_POOL_MAX_MAG_CASE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 25;
    };
    class TFA_p_case_min_food {
        title =$STR_TFA_PARAM_LOOT_POOL_MIN_FOOD_CASE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 5;
    };
    class TFA_p_case_max_food {
        title =$STR_TFA_PARAM_LOOT_POOL_MAX_FOOD_CASE;
        values[]={0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100};
        texts[]={"0","5","1%","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90","95","100"};
        default = 15;
    };

};