extends Node2D

const OPPONENT = preload("res://opponent/opponent.tscn")
const EDGE_MARGIN = 32

var screen_size: Vector2i

@onready var arena: Sprite2D = $Arena


func _ready() -> void:
	screen_size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	screen_size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	spawn_opponents(GlobalData.number_of_opponents)
	GlobalGameManager.player_hp.emit()


func _process(_delta: float) -> void:
	if arena.get_child_count() == 0:
		get_tree().change_scene_to_file("res://menu/potion_menu.tscn")



func spawn_opponents(amount):
	for i in amount:
		var opponent = OPPONENT.instantiate()
		opponent.position.x = randi_range(EDGE_MARGIN, screen_size.x - EDGE_MARGIN)
		opponent.position.y = randi_range(EDGE_MARGIN, screen_size.y - EDGE_MARGIN)
		arena.add_child(opponent)
