// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ds_grid_check_get(m_checkGrid, m_checkWidth, m_checkHeight, m_checkValue){
	if (m_checkWidth < ds_grid_width(m_checkGrid) && m_checkWidth >= 0 &&
		m_checkHeight < ds_grid_height(m_checkGrid) && m_checkHeight >= 0) {
		if (m_checkGrid[# m_checkWidth, m_checkHeight] == m_checkValue) {
			return true
		} else {
			return false
		}
	} else {
		return false
	}
}