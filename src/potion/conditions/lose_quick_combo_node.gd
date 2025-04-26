class_name LoseQuickCombo extends ConditionNode



var counter: int = 0
var value: int
#connect neccessary signals to check_condition
func _ready() -> void:
	GlobalGameManager.quick_combo_end.connect(count)
	pass

func count():
	counter += 1
	if counter >= value:
		negative_effect.apply()
		#PotionEffects.condition_met.emit()
		negative_effect.condition_met.emit()
		self.queue_free()
#or use an oberver pattern
func _process(_delta: float) -> void:
	pass

func check_condition(_argument = null):
	pass
