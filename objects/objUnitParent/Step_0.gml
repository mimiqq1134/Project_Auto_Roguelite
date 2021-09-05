/// @description Insert description here
// You can write your code in this editor
depth = -y/TILESIZE_H-110;
currentPos = [x/TILESIZE_W,y/TILESIZE_H];

if (!isActive) {
	if (object_index == objEnemy && 
		(array_length(routeToGoal) < 2 || !is_array(routeToGoal))) {
		do {
			randomize();
			var dirChoice = irandom(array_length(dirCoord) - 1);
			var m_xNew = x/TILESIZE_W + dirCoord[dirChoice][0],
				m_yNew = y/TILESIZE_H + dirCoord[dirChoice][1],
				m_newPos = [m_xNew,m_yNew];
		} until (objTestDungeon.floorMap[# m_xNew, m_yNew] == TileType.FLOOR && 
				!IsUnitAtPos(m_newPos, objUnitParent, true));
		DebugLog("Path finding");
		routeToGoal = PathFind(currentPos, m_newPos, objTestDungeon.floorMap);
	} else if (object_index == objPlayer) {
		if ((array_length(routeToGoal) < 1 || !is_array(routeToGoal)) && 
			round(currentPos[X]) != targetPos[X] && 
			round(currentPos[Y]) != targetPos[Y]) {
			DebugLog("Path finding");
			routeToGoal = PathFind(currentPos, targetPos, objTestDungeon.floorMap);
		} 
	}
}