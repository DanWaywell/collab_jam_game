extends CharacterBody3D
# Basic opponent character movement.

const SPEED = 4.0
const ACCELERATION = 1.0
const DECELERATION = 2.0

@export var camera: Node3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var input_direction = Vector2()
var move_direction = Vector3()

@onready var player_character: CharacterBody3D = $"../PlayerCharacter"


func _physics_process(delta):
	move_direction = (player_character.global_position - global_position).normalized()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Movement x z
	if move_direction:
		velocity.x = move_toward(velocity.x, move_direction.x * SPEED, ACCELERATION)
		velocity.z = move_toward(velocity.z, move_direction.z * SPEED, ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		velocity.z = move_toward(velocity.z, 0, DECELERATION)

	move_and_slide()
