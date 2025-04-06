extends CharacterBody2D

var speed = 60.0
#const ACCELERATION = 10.0
#const DECELERATION = 20.0

const PROJECTILE = preload("res://projectile/projectile.tscn")

var direction_facing = Vector2.RIGHT

var health = 3

@onready var sprite = $Sprite2D

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
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
	
	if Input.is_action_just_pressed("action_1"):
		fire_projectile()
	
	
func fire_projectile():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.position = position
	new_projectile.direction = direction_facing
	add_sibling(new_projectile)


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


func take_damage(damage):
	health -= damage


func check_health():
	if health < 1:
		queue_free()
