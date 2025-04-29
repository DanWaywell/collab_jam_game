class_name AddRegen extends PosPotionComp

## under 20!
@export var modifier: int
func apply():
	GlobalData.regen += modifier
	#show the UI / HUD Icon 
	pass
