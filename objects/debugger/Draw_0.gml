/// @description Insert description here
// You can write your code in this editor

//var _manualRef = variable_global_get(manualRef);

//variable_instance_get()

draw_set_color(c_white);
draw_text(50, room_height - 50, "Current room: " + room_get_name(room));
draw_text(50, room_height - 100, "Mouse position X:" + string(mouse_x) + " Y:" + string(mouse_y));
draw_text(50, room_height - 150, "Camera X:" + string(objCamera.x)+" Y: "+string(objCamera.y));
draw_text(50, room_height - 200, "Width:" + string(window_get_width())+" Y: "+string(objCamera.y));
