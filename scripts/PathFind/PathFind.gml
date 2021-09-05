///@func                PathFind(start,goal,m_floor);
///@desc                The A* pathfinding algorithm
///@param {array} start An array containing the x and y positions of the starting point
///@param {array} goal  An array containing the x and y positions of the goal
///@param {array} m_floor   A ds grid containing floor data
function PathFind(start,goal,m_floor) {
     
    var true_path = [];
	
    static m_floorWidth = ds_grid_width(m_floor);
    static m_floorHeight = ds_grid_height(m_floor);
     
    static m_frontier = ds_priority_create();
    static m_cameFromList = array_create(m_floorWidth*m_floorHeight,-100);
    static m_costSoFarList = array_create(m_floorWidth*m_floorHeight,-100);
    static m_location = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]];
     
    static m_costScale = 1;
    static m_heuristicScale = 1;
     
    ///@func                    Pos(m_cell,m_floorHeight);
    ///@desc                    Returns the position of the m_cell as a single integer
    ///@param {array} m_cell      An array containing the coordinates of the m_cell we are looking at
    ///@param {int} _m_floorHeight The height of the map (unfortunately we have to pass this in as it is a static variable)
    static Pos = function(m_cell,_m_floorHeight) {
        return (m_cell[X]*_m_floorHeight+m_cell[Y]);
    }
     
    ///@func                    OutOfBounds(m_cell,m_floorWidth,m_floorHeight);
    ///@desc                    Checks whether m_cell coordinates are out of bounds
    ///@param {array} m_cell      An array containing the coordinates of the m_cell we are looking at
    ///@param {int} m_floorWidth   The width of the map
    ///@param {int} m_floorHeight  The height of the map
    static OutOfBounds = function(m_cell,_m_floorWidth,_m_floorHeight, m_floorRef) {
        if (m_cell[X] < 0 || m_cell[Y] < 0 || 
			m_cell[X] >= _m_floorWidth || m_cell[Y] >= _m_floorHeight || 
			m_floorRef[# m_cell[X],m_cell[Y]] == TileType.WALL ||
			position_meeting(m_cell[X]*TILESIZE_W+0.5*TILESIZE_W,m_cell[Y]*TILESIZE_H+0.5*TILESIZE_H, objUnitParent)) {
            return true;
        }
        return false;
    }
     
    ///@func                    Cost(m_cell,m_costScale);
    ///@desc                    Returns the "movement cost" of the m_cell we are checking, with a scaler option for optimisation purposes
    ///@param {array} m_cell      An array containing the coordinates of the m_cell we are looking at
    ///@param {real} m_costScale The scaler for the cost, this lets us optimise how much the algorithm will try to avoid costly areas (unfortunately we have to pass this in as it is a static variable)
    static Cost = function(m_cell, m_costScale,m_floorRef) {
        var cost = 0;
		for (var i = 0; i < 9; i++) {
			if (CheckTilesAround(m_floorRef, m_cell[X], m_cell[Y], TileType.WALL,i+1)) {
				cost += 0.1*m_costScale;
			}
		}
        return 1+cost;
    }
     
    ///@func                            Manhattan(m_cell,m_cell2,m_heuristicScale);
    ///@desc                            This returns the manhattan distance between m_cell and m_cell2, with a scaler option for optimisation purposes
    ///@param {array} m_cell              An array containing the coordinates for the first m_cell
    ///@param {array} m_cell2             An array containing the coordinates for the second m_cell
    ///@param {real} m_heuristicScale    This lets us influence the A* to act more like Greedy Best-First or Dijkstras, useful for optimisation purposes
    static Manhattan = function(m_cell,m_cell2,_m_heuristicScale) {
        return _m_heuristicScale*(abs(m_cell[X]-m_cell2[X])+abs(m_cell[Y]-m_cell2[Y]));
    }
     
    if (m_floor[# start[X],start[Y]] == TileType.WALL || m_floor[# goal[X],goal[Y]] == TileType.WALL) {
        return true_path = [];
    }
             
    ds_priority_clear(m_frontier);
     
    for (var i=0;i<m_floorWidth*m_floorHeight;i++) {
        m_cameFromList[i] = -100;
        m_costSoFarList[i] = -100;
    }
     
    var start_key = Pos(start,m_floorHeight);
    ds_priority_add(m_frontier,start,0);
    m_cameFromList[start_key] = start;
    m_costSoFarList[start_key] = 0;
     
    var target_reached = false; // Set target_reached to false to begin with so we can either update it later if we find the target or leave it as false if we don't
    while (ds_priority_size(m_frontier) > 0) {
        // The loop continues as long as m_frontier has more than 0 entries
        var m_currentCell = ds_priority_delete_min(m_frontier);
		DebugLog("Current cell: " + string(m_currentCell));
        // Grab the current m_cell from the lowest priority position of the priority m_cell
        var m_currentKey = Pos(m_currentCell,m_floorHeight);
        // Get the "key" which is the single integer we condense the x and y coordinates of the m_cell too
        if (array_equals(m_currentCell,goal)) {
            // Break out of the loop if the current m_cell is equal to the goal m_cell, marking target_reached as true, so we can handle the "unreachable target" scenario
            target_reached = true;
            break;
        }
        // Now we start looping through the cardinal directions and grabbing the neighbour m_cells
        for (var i=0;i<8;i++) {
            var nx = m_currentCell[X]+m_location[i][X];
            var ny = m_currentCell[Y]+m_location[i][Y];
            // We use the m_location matrix and the i variable of the for loop to find the neighbouring m_cells coordinates, using the current m_cells coordinates
            if (OutOfBounds([nx,ny],m_floorWidth,m_floorHeight, m_floor)) {
                // If the neighbouring m_cell is out of bounds, we increment the for loop to move on to the next neighbour, ignoring the rest of the code with a continue
                continue;
            }
            var neighbour_m_cell = [nx,ny];
            // We store the neighbour m_cell coordinates in an array we call next
            var new_cost = m_costSoFarList[m_currentKey]+Cost(neighbour_m_cell,m_costScale,m_floor);
            // We calculate the new cost for the neighbouring m_cell
            var neighbour_key = Pos(neighbour_m_cell,m_floorHeight);
            // We get the neighbouring m_cells condensed integer to be used in the m_cameFromList and m_costSoFarList array and store it in a variable called new_key
            if (m_costSoFarList[neighbour_key] == -100 || new_cost < m_costSoFarList[neighbour_key]) {
                // Check to see if we need to update the stored data for the neighbouring m_cell
                m_costSoFarList[neighbour_key] = new_cost;
                // If we do need to update, first we update the entry in m_costSoFarList with the new cost
                var priority = new_cost+Manhattan(neighbour_m_cell,goal,m_heuristicScale);
                // Then we figure out the priority of the neighbouring m_cell storing it in a variable named "priority"
                ds_priority_add(m_frontier,neighbour_m_cell,priority);
                // Add the neighbouring m_cell to the frontier priority queue, with the priority we just calculated
                m_cameFromList[neighbour_key] = m_currentCell;
                // Finally, update the neighbouring m_cells entry in the m_cameFromList array to point towards the current m_cell
            }
        }
    }
     
    if (target_reached) {
        var reversed_path = [];
        var m_currentCell = goal;
        while (!array_equals(m_currentCell,start)) {
            array_push(reversed_path,m_currentCell);
            var m_currentKey = Pos(m_currentCell, m_floorHeight);
            var m_currentCell = m_cameFromList[m_currentKey];
        }
        array_push(reversed_path,start);
     
        var len = array_length(reversed_path)-1;
        for (var i=len;i>=0;i--) {
            true_path[len-i] = reversed_path[i];
        }
		DebugLog("Path created");
    }
    else {
		DebugLog("Path not found");
        return true_path = [];
    }
     
    return true_path;
}