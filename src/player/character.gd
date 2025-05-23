class_name Player extends CharacterBody2D 

const PROJECTILE = preload("res://projectile/projectile.tscn")

var touch_screen_joystick: Node2D
var input_direction := Vector2()
var direction_facing := Vector2.RIGHT


@export var touch_controlles: CanvasLayer

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var additional_weapons = $ProjectileShooter/additional_weapons
@onready var game = $".."

func _ready() -> void:
	touch_screen_joystick = touch_controlles.get_node("TouchJoystick")
	GlobalData.get_player(self)

func add_weapon(new_weapon: String):
	var load_weapon = load(new_weapon)
	var weapon_instance = load_weapon.instantiate()
	additional_weapons.add_child(weapon_instance)

func _physics_process(_delta: float) -> void:
	GlobalData.velocity = velocity
	if touch_screen_joystick.position_vector != Vector2(0,0):
		input_direction = touch_screen_joystick.position_vector
	else:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var move_direction = input_direction.normalized()

	# Movement x y
	if move_direction:
		animation_player.play("walk")
		velocity.x = move_toward(velocity.x, move_direction.x * GlobalData.speed * input_direction.length(), GlobalData.acceleration)
		velocity.y = move_toward(velocity.y, move_direction.y * GlobalData.speed * input_direction.length(), GlobalData.acceleration)
	else:
		animation_player.play("RESET")
		velocity.x = move_toward(velocity.x, 0, GlobalData.deceleration)
		velocity.y = move_toward(velocity.y, 0, GlobalData.deceleration)

	move_and_slide()
	
	check_health()
	
#	if not Input.is_action_pressed("action_1"):
	set_direction_facing(input_direction)


func set_direction_facing(vec2):
	if vec2 != Vector2.ZERO:
		if abs(vec2.x) > abs(vec2.y):
			if vec2.x > 0.01:
				direction_facing = Vector2.RIGHT
			else:
				direction_facing = Vector2.LEFT
		else:
			if vec2.y > 0.01:
				direction_facing = Vector2.DOWN
			else:
				direction_facing = Vector2.UP


func take_damage(damage, _source: CharacterBody2D, color: Color):
	if damage > 0:
		GlobalData.health -= damage
		GlobalGameManager.player_takes_damage.emit(damage)
	GlobalGameManager.player_got_hit.emit()
	GlobalGameManager.popup_numbers.display_numbers(damage, global_position,self, false, color)
	$hurt_tween_comp.hurt()


func check_health():
	if GlobalData.health < 1:
		game.lose()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is AoEopponent:
		AudioGlobal.play_sound("magic_explosion1", -20.0)
		take_damage(area.damage, area.source, area.color)
		GlobalGameManager.explosion_hits_player.emit(global_position)
	#	print("AoE Enemy hit")
	pass # Replace with function body.
