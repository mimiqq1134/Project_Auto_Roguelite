// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IsUnitAtPos(m_checkPos, m_checkUnit, m_isCell) {
	var m_bool;
	if (m_isCell) {
		if (position_meeting((m_checkPos[X]+0.5)*TILESIZE_W, (m_checkPos[Y]+0.5)*TILESIZE_H, m_checkUnit)) {
			m_bool = true;
		} else {
			m_bool = false;
		}
	} else {
		if (position_meeting(m_checkPos[X]+0.5*TILESIZE_W, m_checkPos[Y]+0.5*TILESIZE_H, m_checkUnit)) {
			m_bool = true;
		} else {
			m_bool = false;
		}
	}
	
	return m_bool;
}