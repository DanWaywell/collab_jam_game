extends Node

@onready var player = $".."
var color = Color.SEA_GREEN
func _ready() -> void:
	GlobalGameManager.five_kills.connect(gain_hp)

var gained_health: bool= false
func _process(_delta: float) -> void:
	if gained_health == false:
		gain_health()
	
func gain_health():
	if GlobalData.regen > 0 and GlobalData.health < 15:
		gained_health = true
		await get_tree().create_timer(6).timeout
		GlobalData.health += GlobalData.regen
		GlobalGameManager.popup_numbers.display_numbers_label(float(GlobalData.regen), player.global_position,player, false, color)
		GlobalGameManager.player_hp.emit(GlobalData.regen)
		gained_health = false
		if GlobalData.health > 15:
			GlobalData.health = 15

func gain_hp():
	if GlobalData.regen_on_5_kill > 0 and GlobalData.health < 15:
		GlobalGameManager.popup_numbers.display_numbers_label(float(GlobalData.regen_on_5_kill), player.global_position,player, false, color)
		GlobalData.health += GlobalData.regen_on_5_kill
		GlobalGameManager.player_hp.emit(GlobalData.regen_on_5_kill)
		if GlobalData.health > 15:
			GlobalData.health = 15
