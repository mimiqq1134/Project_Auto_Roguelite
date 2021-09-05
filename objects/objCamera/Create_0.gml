
viewWidth = room_width;
viewHeight = room_height;

viewCamera = camera_create();

var viewMatrix = matrix_build_lookat(0, 0, -10000, 0, 0, 0, 0, 1, 0),
	projectMatrix = matrix_build_projection_ortho(viewWidth, viewHeight, 1.0, 32000.0);


camera_set_view_mat(viewCamera, viewMatrix);
camera_set_proj_mat(viewCamera, projectMatrix);

viewZoom = 1;
zoomMultiplier = 1.25;

xDrag = 0;
yDrag = 0;
