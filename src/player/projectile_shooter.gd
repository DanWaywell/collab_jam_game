extends Node2D

const PROJECTILE = preload("res://projectile/projectile.tscn")

@onready var player: Player = $".."
@onready var shoot_delay: Timer = $ShootDelay
@onready var additional_weapons = $additional_weapons

var touch_screen_joystick_2

func _ready() -> void:
	touch_screen_joystick_2 = player.touch_controlles.get_node("TouchJoystick2")


func _physics_process(_delta: float) -> void:
	if shoot_delay.is_stopped():
		if touch_screen_joystick_2.position_vector != Vector2(0,0):
			fire_projectile(touch_screen_joystick_2.position_vector)
			shoot_delay.start()
		elif Input.is_action_pressed("action_1"):
			fire_projectile(get_direction_between_mouse_and_player())
			shoot_delay.start()


func fire_projectile(direction):
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.speed = GlobalData.projectile_speed
	new_projectile.damage = GlobalData.dmg
	new_projectile.position = global_position
	new_projectile.source = player
	new_projectile.color = Color.WEB_PURPLE
	new_projectile.direction = direction
	player.add_sibling(new_projectile)
	
	var other_weapons = additional_weapons.get_children()
	for weapon in other_weapons:
		weapon.fire()
	


func get_direction_between_mouse_and_player():
	var mouse_pos = get_viewport().get_mouse_position()
	var direction = mouse_pos - player.position
	direction = direction.normalized()
	return direction
