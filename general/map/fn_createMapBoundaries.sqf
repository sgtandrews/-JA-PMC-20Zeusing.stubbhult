/* ----------------------------------------------------------------------------
Function: JA_GENERAL_fnc_createMapBoundaries

Description:
    Creates map boundary triggers and markers.

Parameters:
    NONE

Returns:
	BoundaryTrigger Array

Examples:
    (begin example)
        []call JA_GENERAL_fnc_createMapBoundaries;
    (end)

Author:
    J. Andrews


---------------------------------------------------------------------------- */
#define QUOTE(VAR) #VAR

BoundaryTriggers = [];

mapBoundariesEast = createTrigger ["EmptyDetector",[worldSize * 1.5 ,worldSize / 2,0]]; 
mapBoundariesEast setTriggerArea [worldSize / 2,worldSize,0,true];

BoundaryTriggers pushBack mapBoundariesEast;

mapBoundariesWest = createTrigger ["EmptyDetector",[-(worldSize * 0.5) ,worldSize / 2,0]]; 
mapBoundariesWest setTriggerArea [worldSize / 2,worldSize,0,true];

BoundaryTriggers pushBack mapBoundariesWest;

mapBoundariesSouth = createTrigger ["EmptyDetector",[worldSize / 2 ,-(worldSize * 0.5),0]]; 
mapBoundariesSouth setTriggerArea [worldSize / 2,worldSize / 2,0,true];

BoundaryTriggers pushBack mapBoundariesSouth;

mapBoundariesNorth = createTrigger ["EmptyDetector",[worldSize / 2 ,worldSize * 1.5,0]]; 
mapBoundariesNorth setTriggerArea [worldSize / 2,worldSize / 2,0,true];

BoundaryTriggers pushBack mapBoundariesNorth;


BoundaryTriggers