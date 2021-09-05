// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InitMainMenu() {
	DebugLog("Checking for valid layer");
	if (layer_exists("Menu_Buttons")) {
		DebugLog("Creation of Main Menu Buttons: Initiated");
		for (var i = 0; i < array_length(mainButtons); ++i) {
			var m_xPos = room_width - (buttonMaxWidth + wPad);
			var m_heightOffset = buttonMaxHeight + hPad;
			var m_yPos = (room_height/2 - (array_length(mainButtons) * m_heightOffset - hPad)/2) + m_heightOffset * i
			instance_create_layer(m_xPos, m_yPos, "Menu_Buttons", mainButtons[i]);
			DebugLog(object_get_name(mainButtons[i]) + " Created");
		}
	}
	DebugLog("Creation of Main Menu Buttons: Complete");
}