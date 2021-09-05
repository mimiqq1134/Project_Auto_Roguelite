/// @description Insert description here
// You can write your code in this editor

var activeObject = unitList[activeUnit],
	targetObject = objStairsExit;

switch (phase) {
    case TurnPhase.Choose:
		//Setting the current unit to active
		activeObject.isActive = true;
		
		//Incrementing the turn
		if (activeObject.object_index == objPlayer) {
			turn++;
			//Checking if the player is standing on top of the stairs
			if (activeObject.x == targetObject.x && 
				activeObject.y == targetObject.y) {
			
				//Saving and destroying current floor
				SaveFloor(dungeonName, string(dungeonFloor)+"F");
				DeleteFloor(floorMap);
				dungeonFloor++;
				ini_open(global.dungeonSaveFile);
			
				//Loading the next floor
				if (!ini_key_exists(dungeonName, string(dungeonFloor)+"F")) {
					ini_close();
					FloorCreation(dungeonName, string(dungeonFloor)+"F", tempEventList, tempEnemyList, defaultMapWidth, defaultMapHeight, halfNum);
					LoadFloor(dungeonName, string(dungeonFloor)+"F");
				} else {
					ini_close();
					LoadFloor(dungeonName, string(dungeonFloor)+"F");
				}		
				DebugLog("Climbed to " + string(dungeonFloor)+"F" + " on turn " + string(turn));
				break;
			} 
		}
		DebugLog("Starting turn " + string(turn) + " for " + object_get_name(activeObject.object_index)+string(activeUnit));
		
		//Choosing where to move with the current unit
		with (activeObject) {
			
			//Checking to see if a path to the unit's goal exists
			if (array_length(routeToGoal) > 1) {
				//Setting a temp variable for the second entry of the path
				//Second entry is chosen as the first entry is the unit's current location
				var m_moveTo = routeToGoal[1];
				//Redo pathfinding if another unit is currently on the tile the current unit wants to move to
				if (IsUnitAtPos(m_moveTo, objUnitParent, true)) {
					DebugLog("Repath finding");
					if (activeObject.object_index == objPlayer) {
						routeToGoal = PathFind(currentPos, targetPos, other.floorMap);
					} else {
						do {
							randomize();
							var dirChoice = irandom(array_length(dirCoord) - 1);
							var m_xNew = x/TILESIZE_W + dirCoord[dirChoice][0],
								m_yNew = y/TILESIZE_H + dirCoord[dirChoice][1],
								m_newPos = [m_xNew,m_yNew];
						} until (other.floorMap[# m_xNew, m_yNew] == TileType.FLOOR && 
								!IsUnitAtPos(m_newPos, objUnitParent, true));
						routeToGoal = PathFind(currentPos, [m_xNew, m_yNew], objTestDungeon.floorMap);
					}
				}
				
				//Setting temp var to the first entry of the 
				m_moveTo = routeToGoal[0];
				if (m_moveTo[X] * TILESIZE_W == x && m_moveTo[Y] * TILESIZE_H == y) {
					array_delete(routeToGoal,0,1);
				}
				m_moveTo = routeToGoal[0];
				DebugLog("Target location: " + string(m_moveTo[X] * TILESIZE_W) + ", " + string(m_moveTo[Y] * TILESIZE_H));
				MoveUnitTo(m_moveTo[X], m_moveTo[Y]);	
			} else {
				DebugLog(object_get_name(activeObject.object_index)+string(other.activeUnit) + " no path found");
				DebugLog("Current path var: " + string(routeToGoal));
				do {
					randomize();
					var dirChoice = irandom(array_length(dirCoord) - 1);
					var m_xNew = x/TILESIZE_W + dirCoord[dirChoice][0],
						m_yNew = y/TILESIZE_H + dirCoord[dirChoice][1];
				} until (objTestDungeon.floorMap[# m_xNew, m_yNew] == TileType.FLOOR);
				MoveUnitToDir(dirCoord[dirChoice][X], dirCoord[dirChoice][Y]);
			}
		}
		phase = TurnPhase.Action;
		
        break;
    case TurnPhase.Action:
		with (activeObject) {
			//DebugLog(object_get_name(object_index)+string(other.activeUnit) + " location: " + string(x) + ", " + string(y));
			if (state == State.Moving) {
				transTime += other.speedSetting;
	
				var time = transTime / transLength;
	
				if (time >= 1) {
					transTime = 0;
					time = 1;
					state = State.Idle;
				}
	
				var m_xMovePos = lerp(xMoveFrom, xMoveTo, time),
					m_yMovePos = lerp(yMoveFrom, yMoveTo, time);
		
				x = m_xMovePos;
				y = m_yMovePos;
	
				if (x == xMoveTo && y == yMoveTo) {
					other.phase = TurnPhase.End;
				}
			}
		}
        break;
    case TurnPhase.End:
		DebugLog("End phase for " + object_get_name(activeObject.object_index)+string(activeUnit) +" location: " + string(activeObject.x) + ", " + string(activeObject.y));
		activeUnit++;
		if (activeUnit >= array_length(unitList)) {
			activeUnit = 0;
		}
		phase = TurnPhase.Choose;
		activeObject.isActive = false;
        break;
    default:
        break;
}