class_name SlowProjectiles extends NegPotionComp


@export var speed: int
func apply():
	GlobalData.projectile_speed -= speed
	#show the UI / HUD Icon 
	pass
