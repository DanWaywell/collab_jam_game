class_name AddRegenKill extends PosPotionComp

## under 20!
@export var modifier: int
func apply():
	GlobalData.regen_on_5_kill += modifier
	#show the UI / HUD Icon 
	pass
