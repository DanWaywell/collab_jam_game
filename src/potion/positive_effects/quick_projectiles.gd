class_name AddProjectileSpeed extends PosPotionComp


@export var speed: int
func apply():
	player.projectile_speed += speed
	#show the UI / HUD Icon 
	pass
