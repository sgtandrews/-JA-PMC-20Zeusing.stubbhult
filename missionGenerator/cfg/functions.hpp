#ifndef MISSIONGEN_DIRECTORY
    #define MISSIONGEN_DIRECTORY missionGenerator
#endif

class JA_MissionGen {
    class pos 
    {
        file = MISSIONGEN_DIRECTORY\functions\pos;

        class findSafePos {};
        class randomizePos {};
    };

    class assign 
    {
        file = MISSIONGEN_DIRECTORY\functions\missions\assign;

        class assignKillMission {};
        class assignSupplyMission {};
    };

    class actions

    {
        file = MISSIONGEN_DIRECTORY\functions\missions\actions;

        class addKillMissionAction {};
        class addSupplyMissionAction {};
        class getTargetDirection {};
        class hintAction {};
    };

    class create

    {
        file = MISSIONGEN_DIRECTORY\functions\missions\create;

        class spawnSquad {};

    };

    class markers

    {
        file = MISSIONGEN_DIRECTORY\functions\missions\markers;

        class killMarker {};
        class deleteKillMarker {}; 

    };

    class cleanup

    {
        file = MISSIONGEN_DIRECTORY\functions\missions\cleanup;

        class delComp {};

    };

    class ui

    {
        file = MISSIONGEN_DIRECTORY\functions\missions\ui;

        class contractText {};

    };
};
