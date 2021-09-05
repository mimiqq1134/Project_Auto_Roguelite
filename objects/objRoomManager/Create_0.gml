/// @description Insert description here
// You can write your code in this editor
wPad = room_width / 9;
hPad = room_height / 16;
currentRoom = room;
roomTransition = true;

mainButtons[0] = objExploreButton;
mainButtons[1] = objPartyButton;
mainButtons[2] = objCraftButton;
mainButtons[3] = objShopButton;

buttonMaxWidth = 0;
buttonMaxHeight = 0;
for (var i = 0; i < array_length(mainButtons); ++i) {
	if (sprite_get_width(mainButtons[i]) > buttonMaxWidth) {
		buttonMaxWidth = sprite_get_width(mainButtons[i]);
	}
	if (sprite_get_height(mainButtons[i]) > buttonMaxHeight) {
		buttonMaxHeight = sprite_get_height(mainButtons[i]);
	}
}

InitGame();