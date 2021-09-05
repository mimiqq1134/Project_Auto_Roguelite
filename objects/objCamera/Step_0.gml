/// @description Insert description here
// You can write your code in this editor

var viewMatrix = matrix_build_lookat(x, y, -10000, x, y, 0, 0, 1, 0),
	projectMatrix = matrix_build_projection_ortho(viewWidth*viewZoom, viewHeight*viewZoom, 1.0, 32000.0);

camera_set_view_mat(viewCamera, viewMatrix);
camera_set_proj_mat(viewCamera, projectMatrix);

if (instance_exists(objTestDungeon)) {
	if (mouse_wheel_down() && viewWidth*viewZoom < ds_grid_width(objTestDungeon.floorMap)*TILESIZE_W) {
		viewZoom = viewZoom*zoomMultiplier;
	}
	if (viewWidth*viewZoom > ds_grid_width(objTestDungeon.floorMap)*TILESIZE_W) {
		viewZoom = ds_grid_width(objTestDungeon.floorMap)*TILESIZE_W/viewWidth;
	}
	if (mouse_wheel_up() && viewZoom > 0.3) {
		viewZoom = viewZoom/zoomMultiplier;
	}

	if (device_mouse_check_button_pressed(0, mb_left)) {
		xDrag = mouse_x;
		yDrag = mouse_y;
	}

	if (device_mouse_check_button(0, mb_left)) {
		x += xDrag - mouse_x;
		y += yDrag - mouse_y;
	}
	
	x = clamp(x,window_get_width()/2*viewZoom,ds_grid_width(objTestDungeon.floorMap)*TILESIZE_W-window_get_width()/2*viewZoom);
	y = clamp(y,window_get_height()/2*viewZoom,ds_grid_height(objTestDungeon.floorMap)*TILESIZE_H-window_get_height()/2*viewZoom);
}
