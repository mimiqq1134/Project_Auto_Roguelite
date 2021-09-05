// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveFloor(m_dungeonName, m_floorName){

	DebugLog("Saving the floor data for " + string(m_floorName) + ": Initiated");

	var m_enemyList, m_eventList;

	//Saving the information of all enemy units on the floor	
	for (var i = 0; i < instance_number(objEnemy); i++) {
		//Save the X and Y position of the unit
		m_enemyList[i][0] = instance_find(objEnemy, i).x;
		m_enemyList[i][1] = instance_find(objEnemy, i).y;	
	
		//Save individual parameters of the unit
		for (var j = 0; j < UnitParameters.Count - 1; j++) {
			m_enemyList[i][j+2] = instance_find(objEnemy, i).unitParam[j];
		}
	}

	//Saving the information of all events on the floor
	for (var i = 0; i < instance_number(objEventParent); i++) {
		//Save the type of event and the X and Y position of the event
		m_eventList[i][0] = object_get_name(instance_find(objEventParent, i).object_index);
		m_eventList[i][1] = instance_find(objEventParent, i).x;
		m_eventList[i][2] = instance_find(objEventParent, i).y;
	
		//Save additional parameters if the event is a chest
		if (instance_find(objEventParent, i).object_index == objChest) {
			for (var j = 0; j < ChestParameters.Count - 1; j++) {
				m_eventList[i][j+3] = instance_find(objEventParent, i).chestParam[j];
			}
		}
	}

	//Saving the location of the stairs leading into the floor if they exist
	var eventListLength = array_length(m_eventList);
	if (instance_exists(objStairsEntry)) {
		m_eventList[eventListLength][0] = object_get_name(instance_find(objStairsEntry, 0).object_index);
		m_eventList[eventListLength][1] = instance_find(objStairsEntry, 0).x;
		m_eventList[eventListLength][2] = instance_find(objStairsEntry, 0).y;
	}

	//Saving the location of the stairs leading to the next floor if they exist
	eventListLength = array_length(m_eventList);
	if (instance_exists(objStairsExit)) {
		m_eventList[eventListLength][0] = object_get_name(instance_find(objStairsExit, 0).object_index);
		m_eventList[eventListLength][1] = instance_find(objStairsExit, 0).x;
		m_eventList[eventListLength][2] = instance_find(objStairsExit, 0).y;
	}

	//Creating a temporary DS list to store all the data to save
	var m_floorData = ds_list_create();
	ds_list_clear(m_floorData);
	ds_list_add(m_floorData, string(m_floorName), m_enemyList, m_eventList);

	DebugLog("Opening ini file to save data");

	ini_open(global.dungeonSaveFile);
	//Save data of the floor to [Section] Dungeon Name, [Key] Floor Name/Number
	ini_write_string(string(m_dungeonName), string(m_floorName), ds_list_write(m_floorData));
	ini_close();
	DebugLog("Closing ini file to save data");

	//Destroying the temporary DS list to clear memory
	ds_list_destroy(m_floorData);

	DebugLog("Saving the floor data for " + string(m_floorName) + ": Complete");
}