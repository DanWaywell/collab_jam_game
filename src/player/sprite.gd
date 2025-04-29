extends Sprite2D


@onready var character: Player = $".."

var sprite_facing_up = 0
var sprite_facing_right = 3
var sprite_facing_down = 1
var sprite_facing_left = 2


func _process(_delta: float) -> void:
	if character.direction_facing == Vector2.UP:
		frame = sprite_facing_up
	elif character.direction_facing == Vector2.RIGHT:
		frame = sprite_facing_right
	elif character.direction_facing == Vector2.DOWN:
		frame = sprite_facing_down
	elif character.direction_facing == Vector2.LEFT:
		frame = sprite_facing_left
