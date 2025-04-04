extends CharacterBody2D

const SPEED = 60.0
const ACCELERATION = 10.0
const DECELERATION = 20.0

const PROJECTILE = preload("res://projectile/projectile.tscn")


func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	var move_direction = input_direction.normalized()

	# Movement x y
	if move_direction:
		velocity.x = move_toward(velocity.x, move_direction.x * SPEED * input_direction.length(), ACCELERATION)
		velocity.y = move_toward(velocity.y, move_direction.y * SPEED * input_direction.length(), ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.y = move_toward(velocity.y, 0, DECELERATION)

	move_and_slide()
	
	
	if Input.is_action_just_pressed("action_1"):
		fire_projectile()

func fire_projectile():
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.position = position
	add_sibling(new_projectile)
