class_name TakeDamageNode extends ConditionNode

@export var counter_max: int
var counter: int = 0

func _ready() -> void:
	GlobalGameManager.player_takes_damage.connect(check_condition)
	pass


#or use an oberver pattern
func _process(_delta: float) -> void:
	pass

func check_condition(_argument = null):
	counter += 1
	if counter >= counter_max:
		negative_effect.apply()
		negative_effect.condition_met.emit()
		self.queue_free()
	pass
