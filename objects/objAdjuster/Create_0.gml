/// @description Insert description here
// You can write your code in this editor
winHeight = window_get_height()/3;

sprWidth = sprite_get_width(sprPlus);
sprHeight = sprite_get_height(sprPlus);

barHeight = sprite_get_height(sprBar);

slideWidth = sprite_get_width(sprSlider);
slideHeight = sprite_get_height(sprSlider);

tabWidth = sprite_get_width(sprTab);
tabHeight = sprite_get_height(sprTab);
yTabPos = window_get_height();

openTime = 0;
openSpeed = 0.06;
openLength = 1;

padMod = 2;

hPad = (winHeight/2-sprHeight)/padMod;
wPad = window_get_width()/40;

isActive = false;
isTransitioning = false;
isOpen = true;


if (isOpen) {
	if (yTabPos >= window_get_height()) {
		yTabPos = window_get_height();
		isOpen = false;
	}
} else {
	if (yTabPos <= window_get_height()-winHeight) {
		yTabPos = window_get_height()-winHeight;
		isOpen = true;
	}
}

setting[3] = "Floor tile width";
setting[2] = "Floor tile height";
setting[1] = "Number of Enemies";
setting[0] = "Speed";

textHeight = 0;
for (var i = 0; i < array_length(setting); i++) {
	if (string_height(setting[i]) > textHeight) {
		textHeight = string_height(setting[i]);
	}
}

adjuster[3][1] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[3][1].sprite_index=sprPlus;
adjuster[3][1].varRef = 3;
adjuster[3][0] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[3][0].sprite_index=sprMinus;
adjuster[3][0].varRef = 3;
adjuster[2][1] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[2][1].sprite_index=sprPlus;
adjuster[2][1].varRef = 2;
adjuster[2][0] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[2][0].sprite_index=sprMinus;
adjuster[2][0].varRef = 2;
adjuster[1][1] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[1][1].sprite_index=sprPlus;
adjuster[1][1].varRef = 1;
adjuster[1][0] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[1][0].sprite_index=sprMinus;
adjuster[1][0].varRef = 1;
adjuster[0][1] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[0][1].sprite_index=sprPlus;
adjuster[0][1].varRef = 0;
adjuster[0][0] = instance_create_layer(0,0,"Adjusters",objButton);
adjuster[0][0].sprite_index=sprMinus;
adjuster[0][0].varRef = 0;