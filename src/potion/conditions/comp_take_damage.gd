class_name TakeDamage extends ConditionPotionComp

@export var max_counter: int

func apply():
	var condition_node: TakeDamageNode = load(condition_node_path).instantiate()
	condition_node.counter_max = max_counter
	condition_node.negative_effect = negative_effect
	PotionEffects.conditions.add_child(condition_node)
	pass
