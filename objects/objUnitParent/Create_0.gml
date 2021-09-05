/// @description Insert description here
// You can write your code in this editor
isActive = false;

transLength = 1;
speedModifier = 1000;
transModifier = room_speed/speedModifier;
transTime = 0;

state = State.Idle;

xPos = x;
yPos = y;

xMoveTo = xPos;
yMoveTo = yPos;

xMoveFrom = xPos;
yMoveFrom = yPos;

dirCoord[7][1] = -1; dirCoord[7][0] = -1; 
dirCoord[6][1] = -1; dirCoord[6][0] = 0; 
dirCoord[5][1] = -1; dirCoord[5][0] = 1; 
dirCoord[4][1] = 0; dirCoord[4][0] = -1; 
dirCoord[3][1] = 0; dirCoord[3][0] = 1; 
dirCoord[2][1] = 1; dirCoord[2][0] = -1; 
dirCoord[1][1] = 1; dirCoord[1][0] = 0; 
dirCoord[0][1] = 1; dirCoord[0][0] = 1; 

unitParam[UnitParameters.Name] = "Bones";
unitParam[UnitParameters.Level] = 1;
unitParam[UnitParameters.TotalHP] = 50;
unitParam[UnitParameters.CurrentHP] = 50;
unitParam[UnitParameters.Attack] = 10;
unitParam[UnitParameters.Defense] = 10;
unitParam[UnitParameters.Speed] = 5;
unitParam[UnitParameters.StatusEffect] = Status.None;

routeToGoal = [];
currentPos = [x/TILESIZE_W,y/TILESIZE_H];