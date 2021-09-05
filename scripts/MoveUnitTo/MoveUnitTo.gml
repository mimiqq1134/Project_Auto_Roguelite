// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MoveUnitTo(m_xPos, x_yPos){
	if (state = State.Idle) {
		xMoveFrom = xPos;
		yMoveFrom = yPos;
		
		xMoveTo = m_xPos*TILESIZE_W;
		yMoveTo = x_yPos*TILESIZE_H;
		
		xPos = xMoveTo;
		yPos = yMoveTo;
		
		state = State.Moving;
	}
}