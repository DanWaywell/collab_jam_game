extends CenterContainer

func _ready() -> void:
	Hud.visible = false
	show_score()
	AudioGlobal.set_music_state(AudioGlobal.STATE.OPENING)

		
	
func _on_start_button_button_up() -> void:
	GlobalData.number_of_opponents = 4
	GlobalData.reset()
	PotionEffects.reset()
	Hud.reset()
	get_tree().change_scene_to_file("res://dialogue_scene/start.tscn")


#player
@onready var player_score: Label = %player_score
@onready var enemies_player: Label = %enemies_player
@onready var pawns_pl: Label = %pawns_pl
@onready var bats_pl: Label = %bats_pl
@onready var blobs_pl: Label = %blobs_pl

@export var pl_score = 0
@export var enemy_kills = 0
@export var pawns = 0
@export var bats = 0
@export var blobs = 0

#rival
@onready var rival_score: Label = %rival_score
@onready var enemies_killed_rival: Label = %enemies_killed_rival
@onready var pawns_killed_rival: Label = %pawns_killed_rival
@onready var bats_killed_rival: Label = %bats_killed_rival
@onready var blobs_killed_rival: Label = %blobs_killed_rival

@export var r_score = 0
@export var renemy_kills = 0
@export var rpawns = 0
@export var rbats = 0
@export var rblobs = 0

func show_score():
	if GlobalData.win == true:
		$VBoxContainer/TitleLabel.text = "Win!"
		$"VBoxContainer/VBoxContainer/new_game+".visible = true
		$"VBoxContainer/VBoxContainer/new_game+".disabled = false
	else:
		$VBoxContainer/TitleLabel.text = "Game over..."
	pass
	tween_number("pl_score", GlobalGameManager.player_score)
	tween_number("enemy_kills", GlobalData.enemies_killed_player)
	tween_number("pawns", GlobalData.pawns)
	tween_number("bats", GlobalData.bats)
	tween_number("blobs", GlobalData.blobs)
	tween_number("r_score", GlobalGameManager.rival_score)
	tween_number("renemy_kills", GlobalData.renemies_killed_player)
	tween_number("rpawns", GlobalData.rpawns)
	tween_number("rbats", GlobalData.rbats)
	tween_number("rblobs", GlobalData.rblobs)

func _process(_delta: float) -> void:
	player_score.text = str(pl_score)
	enemies_player.text = str(enemy_kills)
	pawns_pl.text = str(pawns)
	bats_pl.text = str(bats)
	blobs_pl.text = str(blobs)
	rival_score.text = str(r_score)
	enemies_killed_rival.text = str(renemy_kills)
	pawns_killed_rival.text = str(rpawns)
	bats_killed_rival.text = str(rbats)
	blobs_killed_rival.text = str(rblobs)
	
func tween_number(variable,number:int):
	create_tween().tween_property(self,variable,number, 1)
	


func _on_new_game_pressed() -> void:
	GlobalData.reset()
	PotionEffects.reset()
	Hud.reset()
	get_tree().change_scene_to_file("res://dialogue_scene/start.tscn")
	pass # Replace with function body.
