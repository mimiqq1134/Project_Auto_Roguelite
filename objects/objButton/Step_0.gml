/// @description Insert description here
// You can write your code in this editor
if (valueSign == -4) {
	if (sprite_index == sprPlus) {
		valueSign = 1;
	} else if (sprite_index == sprMinus) {
		valueSign = -1;
	}
}

if (position_meeting(mouse_x,mouse_y,id) &&
	mouse_check_button_pressed(mb_left)) {
	switch (varRef) {
		case 3:
			objTestDungeon.defaultMapWidth = clamp(objTestDungeon.defaultMapWidth+valueSign,40,75);
			// code here
			break;
		case 2:
			objTestDungeon.defaultMapHeight = clamp(objTestDungeon.defaultMapHeight+valueSign,40,75);
			// code here
			break;
		case 1:
			objTestDungeon.enemyNum = clamp(objTestDungeon.enemyNum+valueSign,4,25);
			// code here
			break;
		case 0:
			with (objTestDungeon) {
				speedRef += other.valueSign;
				if (speedRef >= array_length(speedStage)) {
					speedRef = array_length(speedStage) - 1;
				} else if (speedRef < 0) {
					speedRef = 0;
				}
				speedSetting = speedStage[speedRef];
			}
			// code here
			break;
		default:
			// code here
			break;
	}
}