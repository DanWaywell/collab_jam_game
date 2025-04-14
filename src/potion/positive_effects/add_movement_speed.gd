class_name AddSpeed extends PosPotionComp

## under 20!
@export var modifier: int
func apply():
	GlobalData.speed += modifier
	#show the UI / HUD Icon 
	pass
