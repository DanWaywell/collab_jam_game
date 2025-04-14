class_name DebugOverlay extends CanvasLayer

@onready var game_manager = $".."

##player
@onready var player: Label = %PLAYER
@onready var hp: Label = %HP
@onready var kills_total: Label = %"kills total"
@onready var combo_untouched: Label = %"combo untouched"
@onready var combo_quicktime: Label = %"combo quicktime"



##rival
@onready var hp_rival: Label = %HP_rival
@onready var kills_total_rival: Label = %"kills total_rival"
@onready var combo_untouched_rival: Label = %"combo untouched_rival"
@onready var combo_quicktime_rival: Label = %"combo quicktime_rival"
@onready var current_target_rival: Label = %current_target_rival

##potions
@onready var potion: Label = %potion
@onready var pos_comp: Label = %pos_comp
@onready var neg_comp: Label = %neg_comp
@onready var condition: Label = %condition
@onready var potion_name: Label = %potion_name
@onready var description: Label = %description

func _process(_delta: float) -> void:
	kills_total.text = str(game_manager.enemies_defeated)
	combo_untouched.text = str(game_manager.kill_combo)
	combo_quicktime.text = str(game_manager.quickness_kill_combo)
	kills_total_rival.text = str(game_manager.enemies_defeated_rival)
	combo_untouched_rival.text = str(game_manager.kill_combo_rival)
	combo_quicktime_rival.text = str(game_manager.quickness_kill_combo_rival)
	pos_comp.text = 
