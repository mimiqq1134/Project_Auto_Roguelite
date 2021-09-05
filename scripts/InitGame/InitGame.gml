// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InitGame(){
	
	global.dungeonSaveFile = "Dungeon_Save.ini";
	
	#macro TILESIZE_W 32
	#macro TILESIZE_H 32
	
    #macro X 0
    #macro Y 1
	
	enum FloorDataList {
		Name,
		Enemies,
		Events
	}
	
	enum TileType {
		NULL,
		FLOOR,
		WALL,
		EVENT
	}
	
	enum State {
		Idle,
		Moving
	}
	
	enum TurnPhase {
		Choose,
		Action,
		End
	}
	
	enum UnitParameters {
		Name,
		Level,
		TotalHP,
		CurrentHP,
		Attack,
		Defense,
		Speed,
		StatusEffect,
		Count
	}
	
	enum ChestParameters {
		Empty,
		Locked,
		Content,
		Count
	}
	
	enum Status {
		None,
		Sleep,
		Slow,
		Burn
	}
	
	enum Enemy {
		Walking_Armor,
		Wisp,
		Skeleton
	}
}