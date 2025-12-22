#ifndef LOOTSYSTEM_DIRECTORY
    #define LOOTSYSTEM_DIRECTORY lootsystem
#endif

class JA_LootGen {
    class checks {
        file = LOOTSYSTEM_DIRECTORY\functions\checks;

        class checkBuildingType {};
        class checkObject {};
        class isRuins {};
    };

    class currency {
        file = LOOTSYSTEM_DIRECTORY\functions\currency;

        class giveCurrency {};
    };

    class core {
        file = LOOTSYSTEM_DIRECTORY\core;
        class lootMain {};
    };

    class spawn {
        file = LOOTSYSTEM_DIRECTORY\functions\spawn;

        class spawnCase {};
        class spawnCaseLoot {};
    };

    class delete {
        file = LOOTSYSTEM_DIRECTORY\functions\delete;

        class deleteLoot {};
    };
};
