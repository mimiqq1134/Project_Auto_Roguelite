// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LoadFloor(m_dungeonName, m_floorName){
	
	DebugLog("Loading the floor data for " + string(m_floorName) + ": Initiated");
	
	DebugLog("Opening ini file to load data");
	//Initializing a temporary DS list to output the data saved for the floor
	var m_floorData = ds_list_create();
	ini_open(global.dungeonSaveFile);
	var str = ini_read_string(string(m_dungeonName), string(m_floorName), "");
	if (str != "") {
		ds_list_read(m_floorData, str);
	}
	
	//Initiliazing a DS grid to store the floor map
	floorMap = ds_grid_create(100, 100);
	ds_grid_read(floorMap, ini_read_string(string(m_dungeonName) + " Maps", ds_list_find_value(m_floorData, FloorDataList.Name), ""));
	ini_close();
	DebugLog("Closing ini file to load data");

	var m_gridTrueWidth, m_gridTrueHeight;
	for (m_gridTrueWidth = 0; m_gridTrueWidth < ds_grid_width(floorMap); m_gridTrueWidth++) {
		if (floorMap[# m_gridTrueWidth, 0] == "") {
			break;
		}
	}
	for (m_gridTrueHeight = 0; m_gridTrueHeight < ds_grid_height(floorMap); m_gridTrueHeight++) {
		if (floorMap[# 0, m_gridTrueHeight] == "") {
			break;
		}
	}
	ds_grid_resize(floorMap, m_gridTrueWidth, m_gridTrueHeight)
	DebugLog("Floor size: " + string(m_gridTrueWidth) + "x" + string(m_gridTrueHeight));

	//Loading each stored event and their individual parameters
	for (var i = 0; i < array_length(ds_list_find_value(m_floorData, FloorDataList.Events)); i++) {
		//Defining event type and X and Y positions
		var m_eventObj = asset_get_index(ds_list_find_value(m_floorData, FloorDataList.Events)[i][0]),
			m_xPosEvent = ds_list_find_value(m_floorData, FloorDataList.Events)[i][1],
			m_yPosEvent = ds_list_find_value(m_floorData, FloorDataList.Events)[i][2];
		var m_eventObject = instance_create_depth(m_xPosEvent, m_yPosEvent, -m_yPosEvent, m_eventObj);
		
		//Defining the extra parameters to load if the event is a chest
		if (m_eventObj == objChest) {
			for (var j = 0; j < ChestParameters.Count - 1; j++) {
				m_eventObject.chestParam[j] = ds_list_find_value(m_floorData, FloorDataList.Events)[i][j+3];
			}
		}
	}
	
	array_resize(unitList, 0);
	//Loading the player object and storing as index 0 in the unitList array if there are stairs available 
	if (instance_exists(objStairsEntry)) {
		var m_xPosPlayer = objStairsEntry.x,
			m_yPosPlayer = objStairsEntry.y;
		unitList[0] = instance_create_depth(m_xPosPlayer, m_yPosPlayer, -m_yPosPlayer, objPlayer);
		DebugLog("Added " + object_get_name(unitList[0].object_index) + string(unitList[0]) +" to unit list")
	}
	
	//Loading each stored enemy and their individual parameters
	for (var i = 0; i < array_length(ds_list_find_value(m_floorData, FloorDataList.Enemies)); i++) {
		var m_xPosEnemy = ds_list_find_value(m_floorData, FloorDataList.Enemies)[i][0],
			m_yPosEnemy = ds_list_find_value(m_floorData, FloorDataList.Enemies)[i][1];
		unitList[i+1] = instance_create_depth(m_xPosEnemy, m_yPosEnemy, -m_yPosEnemy, objEnemy);
		DebugLog("Added "  + object_get_name(unitList[i+1].object_index) + string(unitList[i+1]) +" to unit list")
		for (var j = 0; j < UnitParameters.Count - 1; j++) {
			unitList[i+1].unitParam[j] = ds_list_find_value(m_floorData, FloorDataList.Enemies)[i][j+2];
		}
	}
	
	//Destroying the temporary DS list to clear memory
	ds_list_destroy(m_floorData);
	
	
	DebugLog("Loading the floor data for " + string(m_floorName) + ": Complete");
}