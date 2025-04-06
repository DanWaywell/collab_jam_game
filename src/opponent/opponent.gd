class_name Mob extends CharacterBody2D

var speed = 40.0

#const PROJECTILE = preload("res://projectile/projectile.tscn")

var direction_facing = Vector2.RIGHT

@export var health = 3

@onready var sprite: Sprite2D = $Sprite2D
@onready var target: CharacterBody2D

func _ready() -> void:
	spawn()

func spawn():
	print_debug("spawned")
	GlobalGameManager.mob_spawned.emit(self)

func seek_target(new_target: CharacterBody2D):
	if target == null:
		target = new_target
	else:
		pass


func _physics_process(_delta: float) -> void:
	var input_direction
	if target:
		input_direction= target.position - position
	else: input_direction = Vector2.ZERO

	var move_direction = input_direction.normalized()

	# Movement x y
	if move_direction:
		velocity = move_direction * speed
		#velocity.x = move_toward(velocity.x, move_direction.x * speed * input_direction.length(), ACCELERATION)
		#velocity.y = move_toward(velocity.y, move_direction.y * speed * input_direction.length(), ACCELERATION)
	else:
		velocity = Vector2.ZERO
		#velocity.x = move_toward(velocity.x, 0, DECELERATION)
		#velocity.y = move_toward(velocity.y, 0, DECELERATION)

	move_and_slide()
	set_direction_facing(input_direction)
	set_sprite()
	check_health()
	
	#if Input.is_action_just_pressed("action_1"):
		#fire_projectile()
	#
	#
#func fire_projectile():
	#var new_projectile = PROJECTILE.instantiate()
	#new_projectile.position = position
	#new_projectile.direction = direction_facing
	#add_sibling(new_projectile)


func set_direction_facing(vec2):
	if vec2 != Vector2.ZERO:
		if abs(vec2.x) > abs(vec2.y):
			if vec2.x > 0:
				direction_facing = Vector2.RIGHT
			else:
				direction_facing = Vector2.LEFT
		else:
			if vec2.y > 0:
				direction_facing = Vector2.DOWN
			else:
				direction_facing = Vector2.UP


func set_sprite():
	if direction_facing == Vector2.UP:
		sprite.frame = 0
	elif direction_facing == Vector2.RIGHT:
		sprite.frame = 3
	elif direction_facing == Vector2.DOWN:
		sprite.frame = 1
	elif direction_facing == Vector2.LEFT:
		sprite.frame = 2
	else:
		pass


var last_hit_source: CharacterBody2D
func take_damage(damage, source: CharacterBody2D):
	health -= damage
	last_hit_source = source


func check_health():
	if health < 1:
		if last_hit_source is Player1:
			GlobalGameManager.enemy_killed_by_player.emit(self)
		if last_hit_source is Rival:
			GlobalGameManager.enemy_killed_by_rival.emit(self)
		queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player1 or body is Rival:
		seek_target(body)
		pass # Replace with function body.
