// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/// @function DoubleDigitToString(m_integer);
///
/// @param {integer} m_integer The number to check for double digits
function DoubleDigitToString(m_integer){
	if (m_integer < 10) m_integer = "0" + string(m_integer);
	else m_integer = string(m_integer);
	return m_integer
}