/// @function FloorCreation(m_dungeonName, m_floorName, m_events, m_enemies, m_floorWidth = 35, m_floorHeight = 35, m_splitNum = 3, m_variance = 2.5);
///
/// @param {string} m_dungeonName The name of the dungeon
/// @param {string} m_floorName The name of the floor
/// @param {integer} m_floorWidth The width of the floor
/// @param {integer} m_floorHeight The height of the floor
/// @param {integer} m_splitNum The number of times the room splits in "half"
/// @param {integer} m_variance The variance of room sizes. The smaller the number the bigger the variance

function FloorCreation(m_dungeonName, m_floorName, m_events, m_enemies, m_floorWidth = 35, m_floorHeight = 35, m_splitNum = 3, m_variance = 2.5) {
	
	DebugLog("Creating the floor " + string(m_floorName) + " for dungeon " + string(m_dungeonName) + ": Initiated");
	
	#region Variables defining core values of the random generation
	var m_regionNum = 0,
		//Placeholder for the number of total regions made
		m_lineNum = 0;
		//Placeholder for the number of total partitions made
	for (var i = 0; i < m_splitNum; ++i) {
	    m_regionNum += power(2,i);
		m_lineNum += power(2,i);
	}
	m_regionNum += power(2,m_splitNum);
	//var m_floorPlan = ds_grid_create(m_floorWidth, m_floorHeight),
		//Legacy DS Grid used for visual purposes
	var m_floorLayout = ds_grid_create(m_floorWidth, m_floorHeight);
		//Defining the size of the floor
	var dirChoiceHistory, dsGridRegion;
	dirChoiceHistory[m_lineNum - 1] = undefined;
	//Array to store the history of partition directions
	dsGridRegion[m_regionNum - 1][1] = undefined;
	DebugLog("Number of regions will be: " + string(m_regionNum - 1));
	//Array to store the area of each region
	dsGridRegion[0][0] = "0,0"; dsGridRegion[0][1] = string(ds_grid_width(m_floorLayout))+","+string(ds_grid_height(m_floorLayout));
	//The area of the default region/entire floor
	#endregion

	for (var i = 0; i < m_splitNum; i++) {
		//Repeating the process to split all regions in half
		for (var j = 0; j < power(2, i); j++) {
			//The number of partitions that need to be made
			#region Variables defining values needed to calculate region separations
			randomize();
			var m_dirChoice = irandom(1),
				//Placeholder to determine if the partition will be placed vertically or horizontally
				m_currentIndex = power(2,i+1)-1+j*2,
				//The index for the current room number (pairs with (m_currentIndex+1) as two rooms are made with one partition)
				m_previousIndex = floor(m_currentIndex/2),
				//The index for the room before the split for reference
				m_lineIndex = power(2,i)+j,
				//The index for the current partition stroke
				m_xPosNew,
				//The new width of the new regions made
				m_yPosNew,
				//The new height of the new regions made
				m_x1Prev = ConvertToX(dsGridRegion[m_previousIndex][0]),
				//x1 value of the room size before the split
				m_x2Prev = ConvertToX(dsGridRegion[m_previousIndex][1]),
				//x2 value of the room size before the split
				m_y1Prev = ConvertToY(dsGridRegion[m_previousIndex][0]),
				//y1 value of the room size before the split
				m_y2Prev = ConvertToY(dsGridRegion[m_previousIndex][1]);
				//y2 value of the room size before the split
			DebugLog("Creation of region numbers " + string(m_currentIndex) + " and " + string(m_currentIndex+1) + ": Initiated");
			DebugLog("Index for the previous region for this loop is: " + string(m_previousIndex));
			#endregion
			
			#region Modifier to mitigate bland random generations
			if (m_dirChoice == dirChoiceHistory[m_lineIndex-1] &&
				floor(m_lineIndex/2) == floor((m_lineIndex-1)/2)) {
				DebugLog("The partition for the sibling region was the same. Rerolling");
				randomize();
				m_dirChoice = irandom(1);
			}
			#endregion
			
			#region Logic to prevent partitions in the same directions consecutively 
			if (i > 1) {
				if (dirChoiceHistory[floor(m_lineIndex/2)] == dirChoiceHistory[floor(floor(m_lineIndex/2)/2)]) {
					//Checking to ensure that partitions are not made in the same directions more than twice
					m_dirChoice = !dirChoiceHistory[floor(m_lineIndex/2)];
					DebugLog("Both partitions for " + string(floor(m_lineIndex/2)) +" and "+ string(floor(floor(m_lineIndex/2)/2))+" were the same");
				}
			}
			#endregion
			
			#region Logic for determining where to draw the vertical/horizontal partition
			if (m_dirChoice == 0) {
				//Logic for when vertical partition is chosen
				DebugLog("Regions " + string(m_currentIndex) + " and " + string(m_currentIndex+1) + " were split with a vertical partition");
				
				randomize();
				var m_verLength = irandom((m_x2Prev - m_x1Prev)/2/m_variance),
					//Placeholder to determine variance for new region width
					m_plusMinus = irandom(1);
					//Placeholder to determine if the variance is added to or subtracted from width
				DebugLog("m_verLength: " + string(m_verLength));
				
				if (m_plusMinus == 1) {
					m_verLength = -1 * m_verLength;
					//Changing the variance to a negative for subtraction
				}
				m_xPosNew = floor((m_x1Prev + m_x2Prev)/2) + m_verLength;
				//The new width for the region left of the partition
				DebugLog("New region size: " + string(m_xPosNew));
				
				dsGridRegion[m_currentIndex][1] = string(m_xPosNew) + "," + string(m_y2Prev);
				//Defining the size of the region left of the partition
				
				dsGridRegion[m_currentIndex+1][0] = string(m_xPosNew) + "," + string(m_y1Prev);
				//Defining the size of the region right of the partition
				
			} else if (m_dirChoice == 1) {
				//Logic for when horizontal partition is chosen
				DebugLog("Regions " + string(m_currentIndex) + " and " + string(m_currentIndex+1) + " were split with a horizontal partition");
				
				randomize();
				var m_verLength = irandom((m_y2Prev - m_y1Prev)/2/m_variance),
					//Placeholder to determine variance for new region height
					m_plusMinus = irandom(1);
					//Placeholder to determine if the variance is added to or subtracted from height
				DebugLog("m_verLength: " + string(m_verLength));
				
				if (m_plusMinus == 1) {
					m_verLength = -1 * m_verLength;
					//Changing the variance to a negative for subtraction	
				}
				m_yPosNew = floor((m_y1Prev + m_y2Prev)/2) + m_verLength;
				//The new height for the region above the partition
				DebugLog("New region size: " + string(m_yPosNew));	
				
				dsGridRegion[m_currentIndex][1] = string(m_x2Prev) + "," + string(m_yPosNew);
				//Defining the size of the region above the partition
				
				dsGridRegion[m_currentIndex+1][0] = string(m_x1Prev) + "," + string(m_yPosNew);
				//Defining the size of the region below the partition
				
			}
			#endregion
			
			#region Storing important values pertaining region area and partition direction choice
			dsGridRegion[m_currentIndex][0] = dsGridRegion[m_previousIndex][0]; 
			DebugLog("New range for " + string(m_currentIndex) + " is from" + dsGridRegion[m_currentIndex][0] + " to " + dsGridRegion[m_currentIndex][1]);
			//Defining the start point of the first region of the partition
				
			dsGridRegion[m_currentIndex+1][1] = dsGridRegion[m_previousIndex][1];
			DebugLog("New range for " + string(m_currentIndex+1) + " is from" + dsGridRegion[m_currentIndex+1][0] + " to " + dsGridRegion[m_currentIndex+1][1]);
			//Defining the end point of the second region of the partition
			
			dirChoiceHistory[m_lineIndex] = m_dirChoice;
			//Storing the direction used for partition
			
			var m_region1X1 = ConvertToX(dsGridRegion[m_currentIndex][0]), m_region1Y1 = ConvertToY(dsGridRegion[m_currentIndex][0]),
				m_region1X2 = ConvertToX(dsGridRegion[m_currentIndex][1]), m_region1Y2 = ConvertToY(dsGridRegion[m_currentIndex][1]),
				//Top left and bottom right coordinates to define the area of the first region
				m_region2X1 = ConvertToX(dsGridRegion[m_currentIndex+1][0]), m_region2Y1 = ConvertToY(dsGridRegion[m_currentIndex+1][0]),
				m_region2X2 = ConvertToX(dsGridRegion[m_currentIndex+1][1]), m_region2Y2 = ConvertToY(dsGridRegion[m_currentIndex+1][1]);
				//Top left and bottom right coordinates to define the area of the second region
	
			//ds_grid_set_region(m_floorPlan, m_region1X1, m_region1Y1, m_region1X2, m_region1Y2, m_currentIndex);
			//ds_grid_set_region(m_floorPlan, m_region2X1, m_region2Y1, m_region2X2, m_region2Y2, m_currentIndex+1);
			//Legacy: Obsolete DS Grid used for visual tracking of region splits //Setting the new partitioned regions
			DebugLog("Creation of region numbers " + string(m_currentIndex) + " and " + string(m_currentIndex+1) + ": Complete");
			#endregion
			
			#region Creating individual rooms in each partitioned region
			if (i == m_splitNum - 1) {
				var m_room1 = RoomCreation(m_region1X2 - m_region1X1 - 1, m_region1Y2 - m_region1Y1 - 1);
				//Creating the first room of the partition
				ds_grid_set_grid_region(m_floorLayout, m_room1, 0, 0, ds_grid_width(m_room1), ds_grid_height(m_room1), m_region1X1+1, m_region1Y1+1);
				//Setting the room into the ds grid for the floor
				ds_grid_destroy(m_room1);
				//Destroying the ds grid for the room to clear space
				
				var m_room2 = RoomCreation(m_region2X2 - m_region2X1 - 1, m_region2Y2 - m_region2Y1 - 1);
				//Creating the second room of the partition
				ds_grid_set_grid_region(m_floorLayout, m_room2, 0, 0, ds_grid_width(m_room2), ds_grid_height(m_room2), m_region2X1+1, m_region2Y1+1);
				//Setting the room into the ds grid for the floor
				ds_grid_destroy(m_room2);
				//Destroying the ds grid for the room to clear space
			}
			#endregion
		}
	}
	//ds_grid_destroy(m_floorPlan);
	//Legacy DS Grid //Destroying the ds grid for the floor planning to clear space
	
	#region Reformatting the floor
	ds_grid_resize(m_floorLayout, ds_grid_width(m_floorLayout) + 1, ds_grid_height(m_floorLayout) + 1);
	//Adding an outer layer on the floor to ensure that the floor is surrounded by at least one layer of wall tiles
	for (var i = 0; i < ds_grid_width(m_floorLayout); i++) {
		for (var j = 0; j < ds_grid_height(m_floorLayout); j++) {
			if (m_floorLayout[# i, j] == TileType.NULL) {
				m_floorLayout[# i, j] = TileType.WALL;
				//Transforming all empty grids to wall tiles
			}    
		}
	}
	#endregion
	
	for (var i = 0; i < m_splitNum; i++) {
	    for (var j = 0; j < power(2, i); j++) {

			#region Variables necessary to creating pathing between each room
			var m_currentIndex = power(2,i+1)-1+j*2,
				//The index to reverse search for the room number
				m_room1Num = m_regionNum - m_currentIndex,
				//The reference for the current room number (reverse search)
				m_previousIndex = floor((m_room1Num - 1)/2),
				//The index for the room before the split for reference
				m_x1Room1 = ConvertToX(dsGridRegion[m_room1Num][0]),
				//x coordinate for the left end of the region of room 1
				m_x2Room1 = ConvertToX(dsGridRegion[m_room1Num][1]),
				//x coordinate for the right end of the region of room 1
				m_y1Room1 = ConvertToY(dsGridRegion[m_room1Num][0]),
				//y coordinate for the top end of the region of room 1
				m_y2Room1 = ConvertToY(dsGridRegion[m_room1Num][1]),
				//y coordinate for the bottom end of the region of room 1
				m_room2Num = m_room1Num - 1,
				//The index to reverse search for the other room number created at the same time
				m_x1Room2 = ConvertToX(dsGridRegion[m_room2Num][0]),
				//x coordinate for the left end of the region of room 2
				m_x2Room2 = ConvertToX(dsGridRegion[m_room2Num][1]),
				//x coordinate for the right end of the region of room 2
				m_y1Room2 = ConvertToY(dsGridRegion[m_room2Num][0]),
				//y coordinate for the top end of the region of room 2
				m_y2Room2 = ConvertToY(dsGridRegion[m_room2Num][1]),
				//y coordinate for the bottom end of the region of room 2
				m_falseCounter = 0,
				//Counter to prevent an endless loop searching for a valid start or end point
				m_trialCounter = 20,
				//The number of possible attempts before giving up
				m_room1Delete = false,
				//Bool to store whether room 1 was deleted or not
				m_room2Delete = false;
				//Bool to store whether room 2 was deleted or not
				
				//Debug log code to output the room size for visual reference
				//DebugLog("Room " + string(m_room1Num) + " is from (" + string(m_x1Room1) + ", " + string(m_y1Room1) + ") to (" + string(m_x2Room1) + ", " + string(m_y2Room1) + ")");
				//DebugLog("Room " + string(m_room2Num) + " is from (" + string(m_x1Room2) + ", " + string(m_y1Room2) + ") to (" + string(m_x2Room2) + ", " + string(m_y2Room2) + ")");
			#endregion

			#region Logic to determine a valid point to start the path
			do {
				randomize();
				var m_xPosRoom1 = irandom_range(m_x1Room1, m_x2Room1),
					m_yPosRoom1 = irandom_range(m_y1Room1, m_y2Room1);
				//Random x and y coordinate to determine a possible start of the corridor to connect the two rooms
				
				if (m_falseCounter > m_trialCounter && m_room1Num >=  power(2, m_splitNum) - 1) {
					//Procedure to fall back to if the code fails to find a valid point to start the corridor within a given time frame
					//Only applies to rooms at the lowest level
					for (var k = 0; k < m_x2Room1 - m_x1Room1; k++) {
						for (var l = 0; l < m_y2Room1 - m_y1Room1; l++) {
							m_floorLayout[# m_x1Room1 + k, m_y1Room1 + l] = TileType.WALL;
							//Resetting the room to wall tiles
						}
					}
					DebugLog("Changing all the tiles in room " + string(m_room1Num) + " to WALL");
					m_falseCounter = 0;
					//Resetting the counter to 0 for further use
					m_room1Delete = true;
					//Setting bool for deleted room to true
					break;
				}
				m_falseCounter++;
				//Increasing the counter variable
			} until (m_floorLayout[# m_xPosRoom1, m_yPosRoom1] == TileType.FLOOR);
			
			m_falseCounter = 0;
			//Resetting the counter to 0 for further use
			#endregion
				
			#region Logic to determine a valid point to end the path
			do {
				randomize();
				var m_xPosRoom2 = irandom_range(m_x1Room2, m_x2Room2),
					m_yPosRoom2 = irandom_range(m_y1Room2, m_y2Room2);
				//Random x and y coordinate to determine a possible end of the corridor to connect the two rooms
				
				if (m_falseCounter > m_trialCounter && m_room2Num >=  power(2, m_splitNum) - 1) {
					//Procedure to fall back to if the code fails to find a valid point to end the corridor within a given time frame
					// Only applies to rooms at the lowest level
					for (var k = 0; k < m_x2Room2 - m_x1Room2; k++) {
						for (var l = 0; l < m_y2Room2 - m_y1Room2; l++) {
							m_floorLayout[# m_x1Room2 + k, m_y1Room2 + l] = TileType.WALL;
							//Resetting the room to wall tiles
						}
					}
					DebugLog("Changing all the tiles in room " + string(m_room2Num) + " to WALL");
					m_falseCounter = 0;
					//Resetting the counter to 0 for further use
					m_room2Delete = true;
					//Setting bool for deleted room to true
					break;
				}
				m_falseCounter++;
				//Increasing the counter variable
			} until (m_floorLayout[# m_xPosRoom2, m_yPosRoom2] == TileType.FLOOR);
			
			m_falseCounter = 0;
			//Resetting the counter to 0 for further use
			#endregion
			
			#region Additional logic to compute where to reroute the path if one of the rooms needed to be deleted
			if (m_room1Delete && !m_room2Delete) {
				var m_previousRegion;
				if (m_previousIndex mod 2 == 0) m_previousRegion = m_previousIndex - 1;
				else m_previousRegion = m_previousIndex + 1;
				//Finding the sibling region to the region before the split
				DebugLog("Room " + string(m_room1Num) + " was deleted. Attempting to establish a path from Room " + string(m_room2Num) + " to Room " + string(m_previousRegion) + ": Initiated");
				
				var m_x1Room1 = ConvertToX(dsGridRegion[m_previousRegion][0]),
					//x coordinate for the left end of the sibling region before the split
					m_x2Room1 = ConvertToX(dsGridRegion[m_previousRegion][1]),
					//x coordinate for the right end of the sibling region before the split
					m_y1Room1 = ConvertToY(dsGridRegion[m_previousRegion][0]),
					//y coordinate for the top end of the sibling region before the split
					m_y2Room1 = ConvertToY(dsGridRegion[m_previousRegion][1]);
					//y coordinate for the bottom end of the sibling region before the split
					
				do {
					randomize();
					var m_xPosRoom1 = irandom_range(m_x1Room1, m_x2Room1),
						m_yPosRoom1 = irandom_range(m_y1Room1, m_y2Room1);
						//Random x and y coordinate to determine a possible start of the corridor to connect the two rooms
					
					if (m_falseCounter > m_trialCounter) {
						//Procedure to fall back to if the code fails to find a valid point to start the corridor within a given time frame
						
						for (var k = 0; k < m_x2Room2 - m_x1Room2; k++) {
							for (var l = 0; l < m_y2Room2 - m_y1Room2; l++) {
								m_floorLayout[# m_x1Room2 + k, m_y1Room2 + l] = TileType.WALL;
								//Resetting the room to wall tiles
							}
						}
						DebugLog("Changing all the tiles in room " + string(m_room2Num) + " to WALL");
						m_falseCounter = 0;
						//Resetting the counter to 0 for further use
						break;
					}
					m_falseCounter++;
					//Increasing the counter variable
				} until (m_floorLayout[# m_xPosRoom1, m_yPosRoom1] == TileType.FLOOR);
				
				m_falseCounter = 0;
				//Resetting the counter to 0 for further use
			
				DebugLog("Room " + string(m_room1Num) + " was deleted. Attempting to establish a path from Room " + string(m_room2Num) + " to Room " + string(m_previousRegion) + ": Complete");
				
			} else if (!m_room1Delete && m_room2Delete) {
				var m_previousRegion;
				if (m_previousIndex mod 2 == 0) m_previousRegion = m_previousIndex - 1;
				else m_previousRegion = m_previousIndex + 1;
				//Finding the sibling region to the region before the split
				DebugLog("Room " + string(m_room2Num) + " was deleted. Attempting to establish a path from Room " + string(m_room1Num) + " to Room " + string(m_previousRegion) + ": Initiated");
				
				var m_x1Room2 = ConvertToX(dsGridRegion[m_previousRegion][0]),
					//x coordinate for the left end of the sibling region before the split
					m_x2Room2 = ConvertToX(dsGridRegion[m_previousRegion][1]),
					//x coordinate for the right end of the sibling region before the split
					m_y1Room2 = ConvertToY(dsGridRegion[m_previousRegion][0]),
					//y coordinate for the top end of the sibling region before the split
					m_y2Room2 = ConvertToY(dsGridRegion[m_previousRegion][1]);
					//y coordinate for the bottom end of the sibling region before the split
					
				do {
					randomize();
					var m_xPosRoom2 = irandom_range(m_x1Room2, m_x2Room2),
						m_yPosRoom2 = irandom_range(m_y1Room2, m_y2Room2);
						//Random x and y coordinate to determine a possible start of the corridor to connect the two rooms
				
					if (m_falseCounter > m_trialCounter) {
						//Procedure to fall back to if the code fails to find a valid point to start the corridor within a given time frame
						
						for (var k = 0; k < m_x2Room1 - m_x1Room1; k++) {
							for (var l = 0; l < m_y2Room1 - m_y1Room1; l++) {
								m_floorLayout[# m_x1Room1 + k, m_y1Room1 + l] = TileType.WALL;
								//Resetting the room to wall tiles
							}
						}
						DebugLog("Changing all the tiles in room " + string(m_room1Num) + " to WALL");
						m_falseCounter = 0;
						//Resetting the counter to 0 for further use
						break;
					}
					m_falseCounter++;
					//Increasing the counter variable
				} until (m_floorLayout[# m_xPosRoom2, m_yPosRoom2] == TileType.FLOOR);
				
				m_falseCounter = 0;
				//Resetting the counter to 0 for further use
			
				DebugLog("Room " + string(m_room2Num) + " was deleted. Attempting to establish a path from Room " + string(m_room1Num) + " to Room " + string(m_previousRegion) + ": Complete");
				
			}
			#endregion
			
			#region Logic to execute the creation of the pathing between all rooms
			if (!m_room1Delete || !m_room2Delete) {
				//If either room have not been deleted
				var m_xDistance = m_xPosRoom2 - m_xPosRoom1,
					m_yDistance = m_yPosRoom2 - m_yPosRoom1;
				//Calculating the vertical and horizontal distance between the start and end of the corridor
				if (m_xDistance == 0) {
					//Adding a manual value in case the start and end points are completely vertical
					m_xDistance = 1;
				}
				if (m_yDistance == 0) {
					//Adding a manual value in case the start and end points are completely horizontal
					m_yDistance = 1;
				}
				if (abs(m_xDistance) > abs(m_yDistance)) {
					for (var k = 0; k < abs(m_xDistance); k++) {
						m_floorLayout[# m_xPosRoom1 + k * sign(m_xDistance), m_yPosRoom1 + abs(m_yDistance/m_xDistance) * k * sign(m_yDistance)] = TileType.FLOOR;
						m_floorLayout[# m_xPosRoom1 + k * sign(m_xDistance), m_yPosRoom1 + abs(m_yDistance/m_xDistance) * k * sign(m_yDistance) + sign(m_yDistance)] = TileType.FLOOR;
						//Setting the tile type of all of the coordinates (with an addition to the tile above or below) from the start to the end of the corridor to FLOOR 
					}
				} else {
					for (var k = 0; k < abs(m_yDistance); k++) {
						m_floorLayout[# m_xPosRoom1 + abs(m_xDistance/m_yDistance) * k * sign(m_xDistance), m_yPosRoom1 + k * sign(m_yDistance)] = TileType.FLOOR;
						m_floorLayout[# m_xPosRoom1 + abs(m_xDistance/m_yDistance) * k * sign(m_xDistance) + sign(m_xDistance), m_yPosRoom1 + k * sign(m_yDistance)] = TileType.FLOOR;
						//Setting the tile type of all of the coordinates (with an addition to the tile to the left or right) from the start to the end of the corridor to FLOOR 
					}
				}
			}
			#endregion
			
			#region Code for visualization
			//The code below was used to visualize the start and end points of corridors
			//if (m_floorLayout[# m_xPosRoom1, m_yPosRoom1] == TileType.FLOOR) {
			//	m_floorLayout[# m_xPosRoom1, m_yPosRoom1] = string(m_room1Num);
			//	DebugLog("Setting (" + string(m_xPosRoom1) + ", " + string(m_yPosRoom1) + ") the start point for a corridor in room " + string(m_room1Num));
			//}
				
			//if (m_floorLayout[# m_xPosRoom2, m_yPosRoom2] == TileType.FLOOR) {
			//	m_floorLayout[# m_xPosRoom2, m_yPosRoom2] = string(m_room2Num);
			//	DebugLog("Setting (" + string(m_xPosRoom2) + ", " + string(m_yPosRoom2) + ") the end point for a corridor in room " + string(m_room2Num));
			//}
			#endregion
		}
	}
	
	var m_eventList, m_enemyList;
	m_eventList[array_length(m_events)-1] = undefined;
	
	for (var i = 0; i < array_length(m_events); i++) {
		var m_eventObj = asset_get_index(m_events[i][0]);
		do {
			randomize();
			var m_xPos = irandom(ds_grid_width(m_floorLayout));
			var m_yPos = irandom(ds_grid_height(m_floorLayout));
		} until (m_floorLayout[# m_xPos, m_yPos] == TileType.FLOOR);
		
		var eventRef = instance_create_depth(m_xPos*TILESIZE_W, m_yPos*TILESIZE_H, -m_yPos, m_eventObj);
		m_eventList[i][0] = object_get_name(eventRef.object_index);
		m_eventList[i][1] = eventRef.x;
		m_eventList[i][2] = eventRef.y;
		
		if (m_eventObj == objChest) {
			for (var j = 0; j < ChestParameters.Count - 1; j++) {
				if (j == ChestParameters.Content) {
					for (var k = 0; k < array_length(m_events[i][j+1]); k++) {
					    eventRef.chestContent[k] = m_events[i][j+1][k];
					}
					eventRef.chestParam[j] = eventRef.chestContent[k];
				} else {
					eventRef.chestParam[j] = m_events[i][j+1];
				}
				m_eventList[i][j+3] = eventRef.chestParam[j];
			}
		}
		m_floorLayout[# m_xPos, m_yPos] = TileType.EVENT;
	}
	
	for (var i = 0; i < enemyNum; i++) {
		do {
			randomize();
			var m_xPos = irandom(ds_grid_width(m_floorLayout));
			var m_yPos = irandom(ds_grid_height(m_floorLayout));
		} until (m_floorLayout[# m_xPos, m_yPos] == TileType.FLOOR);
		
		var m_enemyRef = instance_create_depth(m_xPos*TILESIZE_W, m_yPos*TILESIZE_H, -m_yPos, objEnemy);
		m_enemyList[i][0] = m_enemyRef.x;
		m_enemyList[i][1] = m_enemyRef.y;	
		
		randomize();
		var m_enemyChoice = irandom(array_length(m_enemies)-1),
			m_enemyLvlChoice = irandom_range(m_enemies[m_enemyChoice][1], m_enemies[m_enemyChoice][2]);
		SpawnEnemy(m_enemyRef, m_enemies[m_enemyChoice][0], m_enemyLvlChoice);
		for (var j = 0; j < UnitParameters.Count - 1; j++) {
			m_enemyList[i][j+2] = m_enemyRef.unitParam[j];
		}
	}	
	
	#region Saving the generated dungeon
	
	//Creating a temporary DS list to store all the data to save
	var floorData = ds_list_create();
	ds_list_clear(floorData);
	ds_list_add(floorData, string(m_floorName), m_enemyList, m_eventList);

	DebugLog("Opening ini file to save data");
	ini_open(global.dungeonSaveFile);
	
	ini_write_string(string(m_dungeonName), string(m_floorName), ds_list_write(floorData));
	ini_write_string(string(m_dungeonName) + " Maps", string(m_floorName), ds_grid_write(m_floorLayout));
	ini_close();
	DebugLog("Closing ini file to save data");
	
	DebugLog("Floor size: " + string(ds_grid_width(m_floorLayout)) + "x" + string(ds_grid_height(m_floorLayout)));
	DeleteFloor(m_floorLayout);
	
	#endregion
	
	DebugLog("Creating the floor " + string(m_floorName) + " for dungeon " + string(m_dungeonName) + ": Complete");
	
}