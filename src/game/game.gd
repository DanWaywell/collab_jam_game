extends Node2D

const OPPONENT = preload("res://opponent/opponent.tscn")
const BAT = preload("res://opponent/opponent_bat2.tscn")
const BLOB = preload("res://opponent/opponent_blob.tscn")
const SLOWBRO = preload("res://opponent/opponent_slow_bro.tscn")
const EDGE_MARGIN = 32

var screen_size: Vector2i

@onready var arena: Sprite2D = $Arena
@onready var player = %Character
@onready var rival = $Rival


func _ready() -> void:
	screen_size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	screen_size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	if AudioGlobal.music_state != AudioGlobal.STATE.FIGHT:
		AudioGlobal.set_music_state(AudioGlobal.STATE.FIGHT)
	if GlobalData.rounds >= 2 and GlobalData.rounds <4:
		rival.rival_damage = 2
		rival.dmg_frequence = 0.6
	if GlobalData.rounds >= 4:
		rival.rival_damage = 3
		rival.dmg_frequence = 0.3
	spawn_opponents(OPPONENT, GlobalData.number_of_opponents)
	var bats_number =int(GlobalData.number_of_opponents/2.0)
	spawn_opponents(BAT, bats_number)
	var blob_number = int(bats_number / 2.0)
	spawn_opponents(BLOB,blob_number)
	var slowbro_number = int(blob_number / 2.0)
	spawn_opponents(SLOWBRO, slowbro_number)
	GlobalGameManager.player_hp.emit(0)
	Hud.visible = true


func _process(_delta: float) -> void:
	if arena.get_child_count() == 0 and is_instance_valid(player):
		GlobalData.rounds += 1
		if GlobalData.rounds == 7:
			if GlobalGameManager.player_score > GlobalGameManager.rival_score:
				GlobalData.win = true
				win()
		else:
			get_tree().change_scene_to_file("res://menu/potion_shop.tscn")

func lose():
	GlobalData.win = false
	win()

func win():
	get_tree().change_scene_to_file("res://menu/win_screen2.tscn")

@onready var q_12a: Marker2D = $q12a
@onready var q_3a: Marker2D = $q3a
@onready var q_34b: Marker2D = $q34b
@onready var q_4a: Marker2D = $q4a
@onready var q_2b: Marker2D = $q2b
@onready var q_1b: Marker2D = $q1b

#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("ui_cancel"):
#		GlobalData.win = true
#		win()
	
	
	
func spawn_opponents(mob, amount):
	for i in amount:
		var quadrant = randi_range(0,3)
		var opponent = mob.instantiate()
		if quadrant == 0:
			var x = randf_range(q_12a.position.x, q_1b.position.x)
			var y = randf_range(q_12a.position.y, q_1b.position.y)
			opponent.position = Vector2(x,y)
			#opponent.position.x = randi_range(EDGE_MARGIN, x - EDGE_MARGIN)
			#opponent.position.y = randi_range(EDGE_MARGIN, y - EDGE_MARGIN)
		if quadrant == 1:
			var x = randf_range(q_12a.position.x, q_2b.position.x)
			var y = randf_range(q_12a.position.y, q_2b.position.y)
			opponent.position = Vector2(x,y)
			#opponent.position.x = randi_range(EDGE_MARGIN, x - EDGE_MARGIN)
			#opponent.position.y = randi_range(EDGE_MARGIN, y - EDGE_MARGIN)
			pass
		if quadrant == 2:
			var x = randf_range(q_3a.position.x, q_34b.position.x)
			var y = randf_range(q_3a.position.y, q_34b.position.y)
			opponent.position = Vector2(x,y)
			#opponent.position.x = randi_range(EDGE_MARGIN, x - EDGE_MARGIN)
			#opponent.position.y = randi_range(EDGE_MARGIN, y - EDGE_MARGIN)
			pass
		if quadrant == 3:
			var x = randf_range(q_4a.position.x, q_34b.position.x)
			var y = randf_range(q_4a.position.y, q_34b.position.y)
			opponent.position = Vector2(x,y)
			#opponent.position.x = randi_range(EDGE_MARGIN, x - EDGE_MARGIN)
			#opponent.position.y = randi_range(EDGE_MARGIN, y - EDGE_MARGIN)
			pass
		arena.add_child(opponent)
