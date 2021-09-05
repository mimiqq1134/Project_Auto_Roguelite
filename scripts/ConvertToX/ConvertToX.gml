// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @function ConvertToX(m_coordAsString);
///
/// @param {string} m_coordAsString The string coordinate to separate X position from
function ConvertToX(m_coordAsString){
	var m_strLen = string_length(m_coordAsString);
	var m_refPos = string_pos(",", m_coordAsString);
	var m_xPos = real(string_delete(m_coordAsString,m_refPos,m_strLen-m_refPos+1));
	
	return m_xPos
}