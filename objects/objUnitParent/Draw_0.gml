/// @description Insert description here
// You can write your code in this editor
draw_self();
var stats;

stats[0] = unitParam[UnitParameters.Name] + " Lvl: " + string(unitParam[UnitParameters.Level]);
stats[1] = string(unitParam[UnitParameters.CurrentHP]) + "/" + string(unitParam[UnitParameters.TotalHP]);
stats[2] = "ATK: " + string(unitParam[UnitParameters.Attack]);
stats[3] = "DEF: " + string(unitParam[UnitParameters.Defense]);
stats[4] = "Speed: " + string(unitParam[UnitParameters.Speed]);

var padding = 5, textWidth = 0, textHeight = 0;
for (var i = 0; i < array_length(stats); i++) {
	if (string_width(stats[i]) > textWidth) {
		textWidth = string_width(stats[i]);
	}
}
for (var i = 0; i < array_length(stats); i++) {
	if (string_height(stats[i]) > textHeight) {
		textHeight = string_height(stats[i]);
	}
}
if (position_meeting(mouse_x,mouse_y,self)) {
	draw_set_alpha(0.3);
	draw_set_color(c_black);
	draw_rectangle(x+sprite_width,y-textHeight*array_length(stats),x+textWidth+padding*2+sprite_width,y,0);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	for (var i = 0; i < array_length(stats); i++) {
		draw_text(x+padding+sprite_width,y-textHeight*array_length(stats)+i*textHeight,stats[i]);
	}
}
