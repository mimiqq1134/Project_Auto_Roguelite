// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NumToAlpha(m_num) {
	var m_string,
		m_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
		m_alphabetSize = string_length(m_alphabet),
		m_doubleDigit = (m_num - 1) div m_alphabetSize,
		m_singleDigit = m_num mod m_alphabetSize;
		
		if (m_num == 0) {
			m_string = "";
		} else {
			if (m_doubleDigit > 0) {
				m_string = string_char_at(m_alphabet, m_doubleDigit) + string_char_at(m_alphabet, m_singleDigit);
			} else {
				m_string = string_char_at(m_alphabet, m_singleDigit);
			}
		}

	return m_string;
}