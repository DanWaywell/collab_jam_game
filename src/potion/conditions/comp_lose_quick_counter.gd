class_name LoseQuickComboComp extends ConditionPotionComp

@export var max_counter: int
var counter: int = 0

func apply():
	var condition_node: LoseQuickCombo = load(condition_node_path).instantiate()
	condition_node.value = max_counter
	condition_node.negative_effect = negative_effect
	PotionEffects.conditions.add_child(condition_node)
	pass
