// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @function CheckTilesAround(m_checkGrid, m_xPos, m_yPos, m_floorType = TileType.FLOOR, m_numCondition = 1);
///
/// @param {Real} m_checkGrid The ds grid to check in
/// @param {integer} m_xPos The x position to check
/// @param {integer} m_yPos The y position to check
/// @param {enum} m_floorType The floor type to check for
/// @param {integer} m_numCondition The number of tiles to fulfill condition
function CheckTilesAround(m_checkGrid, m_xPos, m_yPos, m_floorType, m_numCondition){
	var m_leftTile =		m_checkGrid[# m_xPos - 1, m_yPos] == m_floorType,
		m_topLeftTile =		m_checkGrid[# m_xPos - 1, m_yPos - 1] == m_floorType,
		m_topTile =			m_checkGrid[# m_xPos, m_yPos - 1] == m_floorType,
		m_topRightTile =	m_checkGrid[# m_xPos + 1, m_yPos - 1] == m_floorType,
		m_rightTile =		m_checkGrid[# m_xPos + 1, m_yPos] == m_floorType,
		m_botRightTile =	m_checkGrid[# m_xPos + 1, m_yPos + 1] == m_floorType,
		m_botTile =			m_checkGrid[# m_xPos, m_yPos + 1] == m_floorType,
		m_botLeftTile =		m_checkGrid[# m_xPos - 1, m_yPos + 1] == m_floorType;
	var m_determineFactor = m_leftTile + m_topLeftTile + m_topTile + m_topRightTile + m_rightTile + m_botRightTile + m_botTile + m_botLeftTile;
	if (m_determineFactor >= m_numCondition) return true;
	else return false;
}