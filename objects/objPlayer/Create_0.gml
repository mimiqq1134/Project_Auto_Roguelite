/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

unitParam[UnitParameters.Name] = "Player";

currentPos = [x/TILESIZE_W,y/TILESIZE_H];
targetPos = [objStairsExit.x/TILESIZE_W,objStairsExit.y/TILESIZE_W];

DebugLog("Path finding");
routeToGoal = PathFind(currentPos, targetPos, objTestDungeon.floorMap);

