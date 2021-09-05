// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MoveUnitToDir(m_xDir, m_yDir){
	if (state = State.Idle) {
		xMoveFrom = xPos;
		yMoveFrom = yPos;
		
		xMoveTo = xPos + m_xDir*TILESIZE_W;
		yMoveTo = yPos + m_yDir*TILESIZE_H;
		
		xPos = xMoveTo;
		yPos = yMoveTo;
		
		state = State.Moving;
	}
}