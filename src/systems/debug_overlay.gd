extends CanvasLayer

@onready var game_manager = $".."

@onready var player: Label = %PLAYER
@onready var hp: Label = %HP
@onready var kills_total: Label = %"kills total"
@onready var combo_untouched: Label = %"combo untouched"
@onready var combo_quicktime: Label = %"combo quicktime"


func _process(_delta: float) -> void:
	kills_total.text = str(game_manager.enemies_defeated)
	combo_untouched.text = str(game_manager.kill_combo)
	combo_quicktime.text = str(game_manager.quickness_kill_combo)
