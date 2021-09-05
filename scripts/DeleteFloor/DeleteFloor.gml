// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DeleteFloor(m_floorMap){
	var m_eventNum = instance_number(objEventParent),
		m_unitNum = instance_number(objUnitParent);
	//Destroying all event objects
	for (var i = 0; i < m_eventNum; i++) {
		instance_destroy(instance_find(objEventParent,0));
	}
	
	//Destroying all unit objects
	for (var i = 0; i < m_unitNum; i++) {
		instance_destroy(instance_find(objUnitParent,0));
	}
	
	//Destroying the temporary DS list to clear memory
	ds_grid_destroy(m_floorMap);
}