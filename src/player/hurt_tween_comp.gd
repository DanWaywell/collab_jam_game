extends Node

@onready var sprite_2d: Sprite2D = $"../Sprite2D"


var rect1: Rect2
var rect2: Rect2 #= 64.0
var rect3: Rect2 #= 128.0dddd
func _ready() -> void:
	get_rects()
	pass
func get_rects():
	rect1 = sprite_2d.region_rect
	rect2 = rect1
	rect2.position += Vector2(64.0,0.0)
	rect3 = rect1
	rect3.position += Vector2(128.0,0.0)


func hurt():
	if is_instance_valid(owner):
		sprite_2d.region_rect = rect2
		await get_tree().create_timer(0.2).timeout
		if is_instance_valid(owner):
			sprite_2d.region_rect = rect3
			await get_tree().create_timer(0.2).timeout
			if is_instance_valid(owner):
				sprite_2d.region_rect = rect1
