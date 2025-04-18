extends Node2D

const PROJECTILE = preload("res://projectile/projectile.tscn")

@onready var player: Player = $".."
@onready var shoot_delay: Timer = $ShootDelay


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("action_1") and shoot_delay.is_stopped():
		fire_projectile()
		shoot_delay.start()


func fire_projectile():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.speed = GlobalData.projectile_speed
	new_projectile.damage = GlobalData.dmg
	new_projectile.position = global_position
	new_projectile.source = player
	
	new_projectile.direction = get_direction_between_mouse_and_player()
	player.add_sibling(new_projectile)


func get_direction_between_mouse_and_player():
	var mouse_pos = get_viewport().get_mouse_position()
	var direction = mouse_pos - player.position
	direction = direction.normalized()
	return direction
