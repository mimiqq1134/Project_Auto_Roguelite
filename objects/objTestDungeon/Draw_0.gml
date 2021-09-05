/// @description Insert description here
// You can write your code in this editor
var m_mapWidth = ds_grid_width(floorMap),
	m_mapHeight = ds_grid_height(floorMap);
for (var i = 0; i < m_mapWidth; ++i) {
	for (var j = 0; j < m_mapHeight; ++j) {
		var m_xPosOffset = 0,
			m_xPos = m_xPosOffset + TILESIZE_W*i,
			m_yPosOffset = 0,
			m_yPos = m_yPosOffset + TILESIZE_H*j;
		if (floorMap[# i, j] == TileType.FLOOR || floorMap[# i, j] == TileType.EVENT) draw_sprite(sprFloorTemp,0,m_xPos,m_yPos);
		else if (floorMap[# i, j] == TileType.WALL) draw_sprite(sprWallTemp,0,m_xPos,m_yPos);
		else draw_text(m_xPos,m_yPos,floorMap[# i, j]);
		//draw_sprite(sprTestColorTileSheet,ds_grid_get(testRoom,i,j),m_xPos,m_yPos);
	}
}