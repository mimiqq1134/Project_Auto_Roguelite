/// @description Insert description here
// You can write your code in this editor
//if (!instance_exists(objMainButton)) {
//	DebugLog("Main Button not found - Creation of Main Button: Initiated");
//	instance_create_layer(0, 0,"Instances",objMainButton);
//	DebugLog("Creation of Main Button: Complete");
//}

if (roomTransition) {
	if (currentRoom != room) {
	    currentRoom = room;
		DebugLog("Room set to " + room_get_name(currentRoom));
	}
	DebugLog("Transition for room " + room_get_name(currentRoom) + ": Initiated");
	switch (currentRoom) {
	    case rMain:
			InitMainMenu();
	        break;
	    default:
			DebugLog("No rules for room " + room_get_name(currentRoom) + " exist");
	        break;
	}
	roomTransition = false;
	DebugLog("Transition for room " + room_get_name(currentRoom) + ": Complete");
}