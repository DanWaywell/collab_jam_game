class_name ConditionNode extends Node

@export var negative_effect: NegPotionComp



#connect neccessary signals to check_condition
func _ready() -> void:
	pass


#or use an oberver pattern
func _process(_delta: float) -> void:
	pass

func check_condition(_argument = null):
	pass
