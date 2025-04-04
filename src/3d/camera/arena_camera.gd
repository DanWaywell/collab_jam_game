extends Node3D

@export var character: CharacterBody3D

var follow_extents = Vector2(1, 1)


func _process(_delta: float) -> void:
	if character.global_position.x > global_position.x + follow_extents.x:
		global_position.x = character.global_position.x - follow_extents.x
	elif character.global_position.x < global_position.x - follow_extents.x:
		global_position.x = character.global_position.x + follow_extents.x
	
	if character.global_position.z > global_position.z + follow_extents.y:
		global_position.z = character.global_position.z - follow_extents.y
	elif character.global_position.z < global_position.z - follow_extents.y:
		global_position.z = character.global_position.z + follow_extents.y
