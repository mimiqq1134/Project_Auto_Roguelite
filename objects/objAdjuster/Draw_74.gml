/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_black);
draw_text(31,32,"Dungeon: " + objTestDungeon.dungeonName + "\nFloor: " + string(objTestDungeon.dungeonFloor) + "F");
draw_text(32,31,"Dungeon: " + objTestDungeon.dungeonName + "\nFloor: " + string(objTestDungeon.dungeonFloor) + "F");
draw_text(33,32,"Dungeon: " + objTestDungeon.dungeonName + "\nFloor: " + string(objTestDungeon.dungeonFloor) + "F");
draw_text(32,33,"Dungeon: " + objTestDungeon.dungeonName + "\nFloor: " + string(objTestDungeon.dungeonFloor) + "F");
draw_set_color(c_white);
draw_text(32,32,"Dungeon: " + objTestDungeon.dungeonName + "\nFloor: " + string(objTestDungeon.dungeonFloor) + "F");

var xMouse = device_mouse_x_to_gui(0),
	yMouse = device_mouse_y_to_gui(0);

if (isTransitioning) {
	openTime += openSpeed;
	
	var time = openTime / openLength;
	
	if (time >= 1) {
		openTime = 0;
		time = 1;
	}
	
	if (isOpen) {
		yTabPos = lerp(window_get_height()-winHeight,window_get_height(), time);
		if (yTabPos >= window_get_height()) {
			yTabPos = window_get_height();
			isTransitioning = false;
			isOpen = false;
		}
	} else {
		yTabPos = lerp(window_get_height(), window_get_height()-winHeight, time);
		if (yTabPos <= window_get_height()-winHeight) {
			yTabPos = window_get_height()-winHeight;
			isTransitioning = false;
			isOpen = true;
		}
	}
}

var tabLeft = window_get_width()/2-tabWidth/2,
	tabTop = yTabPos-tabHeight;
draw_sprite(sprTab,0,tabLeft,tabTop);

if (xMouse == clamp(xMouse,tabLeft,tabLeft+tabWidth) &&
	yMouse == clamp(yMouse,tabTop,tabTop+tabHeight) &&
	mouse_check_button_pressed(mb_left) && !isTransitioning) {
	isTransitioning = true;
	isActive = false;
}

draw_sprite_stretched(sprForestNineSlice,0,0,yTabPos,window_get_width(),winHeight);

var leftMinusX = wPad,
	leftPlusX = window_get_width()/2-wPad-sprWidth,
	rightMinusX = window_get_width()/2+wPad,
	rightPlusX = window_get_width()-wPad-sprWidth, 
	topButtonY = yTabPos+hPad,
	botButtonY = yTabPos+winHeight/2+hPad;
	
draw_text(leftMinusX+sprWidth, topButtonY-textHeight,setting[3]+": "+string(objTestDungeon.defaultMapWidth));
with (adjuster[3][0]) {
	x = objCamera.x+(leftMinusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(topButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,leftMinusX,topButtonY);
}
with (adjuster[3][1]) {
	x = objCamera.x+(leftPlusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(topButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,leftPlusX,topButtonY);
}

draw_text(leftMinusX+sprWidth, botButtonY-textHeight,setting[2]+": "+string(objTestDungeon.defaultMapHeight));
with (adjuster[2][0]) {
	x = objCamera.x+(leftMinusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(botButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,leftMinusX,botButtonY);
}
with (adjuster[2][1]) {
	x = objCamera.x+(leftPlusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(botButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,leftPlusX,botButtonY);
}

draw_text(rightMinusX+sprWidth, topButtonY-textHeight,setting[1]+": "+string(objTestDungeon.enemyNum));
with (adjuster[1][0]) {
	x = objCamera.x+(rightMinusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(topButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,rightMinusX,topButtonY);
}
with (adjuster[1][1]) {
	x = objCamera.x+(rightPlusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(topButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,rightPlusX,topButtonY);
}

draw_text(rightMinusX+sprWidth, botButtonY-textHeight,setting[0]+": "+objTestDungeon.speedStageRef[objTestDungeon.speedRef]);
with (adjuster[0][0]) {
	x = objCamera.x+(rightMinusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(botButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,rightMinusX,botButtonY);
}
with (adjuster[0][1]) {
	x = objCamera.x+(rightPlusX-window_get_width()/2)*objCamera.viewZoom;
	y = objCamera.y+(botButtonY-window_get_height()/2)*objCamera.viewZoom;
	image_xscale = objCamera.viewZoom;
	image_yscale = objCamera.viewZoom;
	draw_sprite(sprite_index,0,rightPlusX,botButtonY);
}

var leftBarX = leftMinusX + wPad/2 + sprWidth,
	topBarY =  yTabPos+winHeight-window_get_height()/3+window_get_height()/3/4-barHeight/2,
	barWidth = leftPlusX - leftMinusX - sprWidth - wPad,
	topSlideY = yTabPos+winHeight-window_get_height()/4-slideHeight/2,
	slider1Pos = lerp(leftBarX-slideWidth/4,leftBarX+barWidth-slideWidth*3/4,(objTestDungeon.defaultMapWidth-40)/35);
draw_sprite_stretched(sprBar,0,leftBarX,topBarY,barWidth,barHeight);
if (xMouse == clamp(xMouse,leftBarX,leftBarX+barWidth+slideWidth/4) &&
	yMouse == clamp(yMouse,topBarY,topBarY+barHeight) &&
	mouse_check_button(mb_left)) {
	slider1Pos = xMouse - slideWidth/2;
	objTestDungeon.defaultMapWidth = clamp(floor((xMouse-leftBarX)/(barWidth/35))+40,40,75);
}
draw_sprite(sprSlider,0,slider1Pos,topSlideY);

var botBarY = yTabPos+winHeight-window_get_height()/3+window_get_height()/4-barHeight/2,
	botSliderY = yTabPos+winHeight-window_get_height()/3+window_get_height()/4-slideHeight/2,
	slider2Pos = lerp(leftBarX-slideWidth/4,leftBarX+barWidth-slideWidth*3/4,(objTestDungeon.defaultMapHeight-40)/35);
draw_sprite_stretched(sprBar,0,leftBarX,botBarY,barWidth,barHeight);
if (xMouse == clamp(xMouse,leftBarX,leftBarX+barWidth+slideWidth/4) &&
	yMouse == clamp(yMouse,botBarY,botBarY+barHeight) &&
	mouse_check_button(mb_left)) {
	slider2Pos = xMouse - slideWidth/2;
	objTestDungeon.defaultMapHeight = clamp(floor((xMouse-leftBarX)/(barWidth/35))+40,40,75);
}
draw_sprite(sprSlider,0,slider2Pos,botSliderY);

var rightBarX = rightMinusX + wPad/2 + sprWidth,
	slider4Pos = lerp(rightBarX-slideWidth/4,rightBarX+barWidth-slideWidth*3/4,(objTestDungeon.enemyNum-4)/21),
	slider3Pos = lerp(rightBarX-slideWidth/4,rightBarX+barWidth-slideWidth*3/4,(objTestDungeon.speedRef)/3);
draw_sprite_stretched(sprBar,0,rightBarX,botBarY,barWidth,barHeight);
if (xMouse == clamp(xMouse,rightBarX,rightBarX+barWidth+slideWidth/4) &&
	yMouse == clamp(yMouse,botBarY,botBarY+barHeight) &&
	mouse_check_button(mb_left)) {
	slider3Pos = xMouse - slideWidth/2;
	objTestDungeon.speedRef = clamp(floor((xMouse-rightBarX)/(barWidth/3)),0,3)
	objTestDungeon.speedSetting = objTestDungeon.speedStage[objTestDungeon.speedRef];
}
draw_sprite(sprSlider,0,slider3Pos,botSliderY);

draw_sprite_stretched(sprBar,0,rightBarX,topBarY,barWidth,barHeight);
if (xMouse == clamp(xMouse,rightBarX,rightBarX+barWidth+slideWidth/4) &&
	yMouse == clamp(yMouse,topBarY,topBarY+barHeight) &&
	mouse_check_button(mb_left)) {
	slider4Pos = xMouse - slideWidth/2;
	objTestDungeon.enemyNum = clamp(floor((xMouse-rightBarX)/(barWidth/21))+3,4,25);
}
draw_sprite(sprSlider,0,slider4Pos,topSlideY);

