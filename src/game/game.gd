extends Node2D

const OPPONENT = preload("res://opponent/opponent.tscn")
const BAT = preload("res://opponent/opponent_bat2.tscn")
const EDGE_MARGIN = 32

var screen_size: Vector2i

@onready var arena: Sprite2D = $Arena


func _ready() -> void:
	screen_size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	screen_size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	if AudioGlobal.music_state != AudioGlobal.STATE.FIGHT:
		AudioGlobal.set_music_state(AudioGlobal.STATE.FIGHT)
	spawn_opponents(OPPONENT, GlobalData.number_of_opponents)
	@warning_ignore("integer_division")
	var bats_number = GlobalData.number_of_opponents/2
	spawn_opponents(BAT, bats_number)
	GlobalGameManager.player_hp.emit()
	Hud.visible = true


func _process(_delta: float) -> void:
	if arena.get_child_count() == 0:
		get_tree().change_scene_to_file("res://menu/potion_shop.tscn")



func spawn_opponents(mob, amount):
	for i in amount:
		var opponent = mob.instantiate()
		opponent.position.x = randi_range(EDGE_MARGIN, screen_size.x - EDGE_MARGIN)
		opponent.position.y = randi_range(EDGE_MARGIN, screen_size.y - EDGE_MARGIN)
		arena.add_child(opponent)
