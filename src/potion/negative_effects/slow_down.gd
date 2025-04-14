class_name SlowDown extends NegPotionComp


@export var speed: int
func apply():
	player.speed -= speed
	#show the UI / HUD Icon 
	pass
