// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckTilesAroundForUnits(m_currentPos, m_checkUnit, m_countCondition, m_isCardinal = false, m_isCell = true){

	static m_directions = [[0,-1],[-1,0],[1,0],[0,1],[-1,-1],[1,-1],[-1,1],[1,1]];
	
	var m_count = 0;
	
	for (var i = 0; i < array_length(m_directions); i++) {
		if (m_isCardinal && i >= array_length(m_directions)/2) {
			break;
		}
		
		var m_checkPos = [m_currentPos[X]+dirCoord[i][X],m_currentPos[Y]+dirCoord[i][Y]];
		
		if (IsUnitAtPos(m_checkPos, m_checkUnit, m_isCell)) {
			m_count++;
		}
	}
		
	if (m_count >= m_countCondition) {
		return true;
	} else {
		return false;
	}
}