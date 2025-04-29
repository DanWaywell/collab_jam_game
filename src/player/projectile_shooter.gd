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
			fire_projectile(touch_screen_joystick_2.position_vector.normalized())
			shoot_delay.start()
		elif Input.is_action_pressed("action_1") and not DisplayServer.is_touchscreen_available():
			fire_projectile(get_direction_between_mouse_and_player())
			shoot_delay.start()


func fire_projectile(direction):

	if GlobalData.shaking_hands == true:
		var randomness = randf_range(0,1)
		if randomness < 0.2:
			var x = randf_range(-10, 10)
			var y = randf_range(-10,10)
			direction *= Vector2(x,y)
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
	
var last_direction 

func get_direction_between_mouse_and_player():
	var mouse_pos = get_global_mouse_position()
#	print("player_pos", player.position)
#	print("mouse_pos", mouse_pos)
	var direction = mouse_pos - player.position
	direction = direction.normalized()
	last_direction = direction
#	print("direction", direction)
	return direction
