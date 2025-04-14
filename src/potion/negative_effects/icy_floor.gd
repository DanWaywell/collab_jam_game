class_name IcyFloor extends NegPotionComp

## under 20!
@export var modifier: int
func apply():
	GlobalData.acceleration -= modifier
	#show the UI / HUD Icon 
	pass
