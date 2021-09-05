// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @function RoomCreation(m_roomWidth, m_roomHeight, m_minRoomSize);
///
/// @param {integer} m_roomWidth The width of the room
/// @param {integer} m_roomHeight The height of the room
/// @param {integer} m_minRoomSize The minimum size of the room
/// @param {integer} m_variance The variance of room size. A bigger number computes to more space used

function RoomCreation(m_roomWidth, m_roomHeight, m_minRoomSize = 2, m_variance = 1) {
	
	var m_smallRoom = ds_grid_create(m_roomWidth, m_roomHeight),
		m_xStartPos = floor(m_roomWidth/2),
		m_yStartPos = floor(m_roomHeight/2);
	ds_grid_clear(m_smallRoom, TileType.NULL);
	
	var m_radialSize = m_xStartPos + m_yStartPos;
	var offsetDir;
	offsetDir[3][1] = 1; offsetDir[3][0] = 1;
	offsetDir[2][1] = -1; offsetDir[2][0] = 1;
	offsetDir[1][1] = 1; offsetDir[1][0] = -1;
	offsetDir[0][1] = -1; offsetDir[0][0] = -1;
	
	for (var i = 0; i <= m_xStartPos; i++) {
		for (var j = 0; j <= m_yStartPos; j++) {
			for (var k = 0; k < array_length(offsetDir); k++) {
				var m_xDir = i * offsetDir[k][0],
					m_yDir = j * offsetDir[k][1];
				if (i + j < m_minRoomSize) {
					m_smallRoom[# m_xStartPos + m_xDir, m_yStartPos + m_yDir] = TileType.FLOOR;
				} 
				randomize();
				var m_floorVar = random(m_radialSize);
				if (ds_grid_check_get(m_smallRoom, m_xStartPos + m_xDir, m_yStartPos + m_yDir, TileType.NULL)) {
					if (m_floorVar < (m_radialSize + m_variance - (i + j)) && 
						CheckTilesAround(m_smallRoom, m_xStartPos + m_xDir, m_yStartPos + m_yDir, TileType.FLOOR, 1)) {
						m_smallRoom[# m_xStartPos + m_xDir, m_yStartPos + m_yDir] = TileType.FLOOR;
						DebugLog("Created floor for coordinate X: " + string(m_xStartPos + m_xDir) + " Y: " + string(m_yStartPos + m_yDir))
					} else {
						m_smallRoom[# m_xStartPos + m_xDir, m_yStartPos + m_yDir] = TileType.WALL;
						DebugLog("Created wall for coordinate X: " + string(m_xStartPos + m_xDir) + " Y: " + string(m_yStartPos + m_yDir))						
					}
				}
			}
		}
	}
	
	for (var i = 0; i < m_roomWidth; i++) {
		for (var j = 0; j < m_roomHeight; j++) {
			if (ds_grid_check_get(m_smallRoom, i, j, TileType.WALL) &&
				CheckTilesAround(m_smallRoom, i, j, TileType.FLOOR, 4)) {
				m_smallRoom[# i, j] = TileType.NULL;
			}
		}
	}
	
	for (var i = 0; i < m_roomWidth; i++) {
		for (var j = 0; j < m_roomHeight; j++) {
			if (ds_grid_check_get(m_smallRoom, i, j, TileType.NULL)) {
				m_smallRoom[# i, j] = TileType.FLOOR;
			}
		}
	}
	
	for (var i = 0; i < m_roomWidth; i++) {
		for (var j = 0; j < m_roomHeight; j++) {
			if (ds_grid_check_get(m_smallRoom, i, j, TileType.FLOOR) &&
				CheckNotTilesAround(m_smallRoom, i, j, TileType.FLOOR, 7)) {
				m_smallRoom[# i, j] = TileType.WALL;
			}
			if (ds_grid_check_get(m_smallRoom, m_roomWidth - i - 1, m_roomHeight - j - 1, TileType.FLOOR) &&
				CheckNotTilesAround(m_smallRoom, m_roomWidth - i - 1, m_roomHeight - j - 1, TileType.FLOOR, 7)) {
				m_smallRoom[# m_roomWidth - i - 1, m_roomHeight - j - 1] = TileType.WALL;
			}
		}
	}
	
	return m_smallRoom;	
}