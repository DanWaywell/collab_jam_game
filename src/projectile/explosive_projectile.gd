extends Node

var damage = 1
var radius = 16
@onready var explosion_aoe = preload("res://projectile/explosion.tscn")

func fire():
	if !GlobalGameManager.projectile_hits_mob.is_connected(explode):
		GlobalGameManager.projectile_hits_mob.connect(explode)
	
func explode(position):
	var explosion = explosion_aoe.instantiate()
	explosion.global_position = position
	explosion.damage = damage
	explosion.radius = radius
	explosion.color = Color.WEB_PURPLE
	call_deferred("add_child", explosion)
