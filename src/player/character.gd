class_name Player extends CharacterBody2D 

const PROJECTILE = preload("res://projectile/projectile.tscn")

var touch_screen_joystick: Node2D
var input_direction := Vector2()
var direction_facing := Vector2.RIGHT

var speed := 60.0
var acceleration := 10.0
var deceleration := 20.0
var dmg := 1
var health := 3
var projectile_speed := 80.0

@export var touch_controlles: CanvasLayer

@onready var shoot_delay: Timer = $ShootDelay
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	touch_screen_joystick = touch_controlles.get_node("TouchJoystick")


func _physics_process(_delta: float) -> void:
	if touch_screen_joystick.position_vector != Vector2(0,0):
		input_direction = touch_screen_joystick.position_vector
	else:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var move_direction = input_direction.normalized()

	# Movement x y
	if move_direction:
		animation_player.play("walk")
		velocity.x = move_toward(velocity.x, move_direction.x * speed * input_direction.length(), acceleration)
		velocity.y = move_toward(velocity.y, move_direction.y * speed * input_direction.length(), acceleration)
	else:
		animation_player.play("RESET")
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)

	move_and_slide()
	
	check_health()
	
	if not Input.is_action_pressed("action_1"):
		set_direction_facing(input_direction)
	
	if Input.is_action_pressed("action_1") and shoot_delay.is_stopped():
		fire_projectile()
		shoot_delay.start()


func fire_projectile():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.speed = projectile_speed
	new_projectile.damage = dmg
	new_projectile.position = position
	new_projectile.source = self
	new_projectile.direction = direction_facing
	add_sibling(new_projectile)


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


func take_damage(damage, _source: CharacterBody2D):
	health -= damage


func check_health():
	if health < 1:
		queue_free()
