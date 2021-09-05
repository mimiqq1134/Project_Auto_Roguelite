/// @description Insert description here
// You can write your code in this editor

activeUnit = 0;

unitList[0] = undefined;
defaultMapWidth = 75;
defaultMapHeight = 75;
dungeonName = "Test Gameplay";
dungeonFloor = 1;
halfNum = 3;
enemyNum = 4;

speedSetting = 0.06;

speedRef = 1;
speedStage[3] = 1;
speedStage[2] = 0.4;
speedStage[1] = speedSetting;
speedStage[0] = 0.01;
speedStageRef[3] = "Instant";
speedStageRef[2] = "Fast";
speedStageRef[1] = "Normal";
speedStageRef[0] = "Slow";

turn = 0;
phase = TurnPhase.Choose;

tempEventList[4][0] = "objStairsEntry";
tempEventList[3][0] = "objStairsExit";
tempEventList[2][3][0] = "Legendary Cape (?)";
tempEventList[2][2] = false;
tempEventList[2][1] = false;
tempEventList[2][0] = "objChest"
tempEventList[1][0] = "objChest"
tempEventList[1][1] = false;
tempEventList[1][2] = false;
tempEventList[1][3][0] = "Legendary Shield (?)";
tempEventList[0][0] = "objChest"
tempEventList[0][1] = false;
tempEventList[0][2] = false;
tempEventList[0][3][0] = "Legendary Sword (?)";

tempEnemyList[1][2] = 3;
tempEnemyList[1][1] = 1;
tempEnemyList[1][0] = "Wisp";
tempEnemyList[0][2] = 3;
tempEnemyList[0][1] = 1;
tempEnemyList[0][0] = "Walking Armor";

DebugLog("Creating Test Map: Initiated");

ini_open(global.dungeonSaveFile);
if (!ini_key_exists(dungeonName, string(dungeonFloor)+"F")) {
	ini_close();
	FloorCreation(dungeonName, string(dungeonFloor)+"F", tempEventList, tempEnemyList, defaultMapWidth, defaultMapHeight, halfNum);
	LoadFloor(dungeonName, string(dungeonFloor)+"F");
} else {
	ini_close();
	LoadFloor(dungeonName, string(dungeonFloor)+"F");
}

DebugLog("Creating Test Map: Complete");

