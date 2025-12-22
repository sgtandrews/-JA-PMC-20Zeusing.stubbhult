#ifndef WORLD_DIRECTORY
    #define WORLD_DIRECTORY world
#endif

class JA_World {
    class wrecks {
        file = WORLD_DIRECTORY\functions\wrecks;

        class spawnCarWrecks {};
    };

    class settings {
        file = WORLD_DIRECTORY\functions\settings;

        class addSetting {};
    };

    class general {
        file = WORLD_DIRECTORY\functions\general;

        class inAreaMarkers {};
        class inAreaSafezone {};
        class stringStartsWith {};
        class createAreaMarker {};
        class createLocalMarker {};
        class createSafezone {};
        class randomMarkerID {};
        class randomString {};
        class randomPos {};
    };

    class vehicles {
        file = WORLD_DIRECTORY\functions\vehicles;

        class spawnDamagedVehicles {};
    };

    class compositions {
        file = WORLD_DIRECTORY\functions\compositions;

        class createComposition {};
        class getComposition {};
    };
};
