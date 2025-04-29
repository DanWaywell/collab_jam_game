class_name GainedHealthNode extends ConditionNode
#connect neccessary signals to check_condition

@export var value: int
var start: int = 0
func _ready() -> void:
	GlobalGameManager.player_hp.connect(count)
	pass

func count(count_value):
	start += count_value
#or use an oberver pattern
func _process(_delta: float) -> void:
	check_condition_new()
	pass

func check_condition_new():
	if start >= 5:
		negative_effect.apply()
		negative_effect.condition_met.emit()
		self.queue_free()
	pass
