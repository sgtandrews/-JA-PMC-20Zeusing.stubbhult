#ifndef GENERAL_DIRECTORY
    #define GENERAL_DIRECTORY general
#endif

class JA_GENERAL {
    class actions 
    {
        file = GENERAL_DIRECTORY\functions\actions;

        class addActions {};
        class searchBody {};
    };

    class helpers 
    {
        file = GENERAL_DIRECTORY\functions\helpers;

        class getHeading {};
    };

    class markers 
    {
        file = GENERAL_DIRECTORY\functions\markers;

        class triggerToMarker {};
    };

    class map 
    {
        file = GENERAL_DIRECTORY\functions\map;

        class createMapBoundaries {};
    };
};
