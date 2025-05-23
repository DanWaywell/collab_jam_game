class_name ConditionComboNode extends ConditionNode
#connect neccessary signals to check_condition

@export var max_kill_streak: int

func _ready() -> void:
	GlobalGameManager.kill_combo_streak.connect(check_condition)
	pass


#or use an oberver pattern
func _process(_delta: float) -> void:
	pass

func check_condition(argument = null):
	if argument >= max_kill_streak:
		negative_effect.apply()
		negative_effect.condition_met.emit()
		self.queue_free()
	pass
