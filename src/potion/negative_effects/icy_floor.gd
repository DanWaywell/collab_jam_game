class_name IcyFloor extends NegPotionComp

## under 20!
@export var modifier: int
func apply():
	player.acceleration -= modifier
	#show the UI / HUD Icon 
	pass
