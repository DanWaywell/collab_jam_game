class_name ComboCondComp extends ConditionPotionComp

@export var max_combo: int

func apply():
	var condition_node: ConditionComboNode = load(condition_node_path).instantiate()
	condition_node.max_kill_streak = max_combo
	condition_node.negative_effect = negative_effect
	PotionEffects.conditions.add_child(condition_node)
	pass
