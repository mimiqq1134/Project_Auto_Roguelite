// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
///@function scrRoomClick(m_targetRoom)
///
///@param {Real} m_targetRoom The room to move to

function scrRoomClick(m_targetRoom){
	if (position_meeting(mouse_x, mouse_y, id) &&
		mouse_check_button_released(mb_left)) {
		room_goto(m_targetRoom);
		objRoomManager.roomTransition = true;
		DebugLog("Moving to room " + room_get_name(m_targetRoom));
	}
}