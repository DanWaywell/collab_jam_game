extends Node2D
@onready var mouse: Label = $mouse
@onready var player_pos: Label = $player_pos
@onready var projectile_direction: Label = $projectile_direction

func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	player_pos.text = "player : " +str($"../..".position)
	mouse.text = "mouse : " + str(mouse_pos)
	projectile_direction.text = "projectile : " + str($"..".last_direction)
