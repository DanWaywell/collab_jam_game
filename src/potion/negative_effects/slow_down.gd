class_name SlowDown extends NegPotionComp


@export var speed: int
func apply():
	GlobalData.speed -= speed
	#show the UI / HUD Icon 
	pass
