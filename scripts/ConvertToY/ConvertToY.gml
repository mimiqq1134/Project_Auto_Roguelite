// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @function ConvertToY(m_coordAsString);
///
/// @param {string} m_coordAsString The string coordinate to separate Y position from
function ConvertToY(m_coordAsString){
	var m_refPos = string_pos(",", m_coordAsString);
	var m_yPos = real(string_delete(m_coordAsString,1,m_refPos));
	
	return m_yPos
}