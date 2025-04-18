class_name ConditionPotionComp extends Resource

@export var name: String
@export_multiline var description: String
@export var description_small: String
@export var negative_effect: NegPotionComp

@export var condition_node_path: String


@export var texture: Texture2D


func apply():
	var condition_node: ConditionNode = load(condition_node_path).instantiate()
	PotionEffects.conditions.add_child(condition_node)
	pass
func effect_process():
	pass
