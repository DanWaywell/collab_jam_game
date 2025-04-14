extends Node
@onready var potions: PotionEffectHolder =  $".."

# processes effects that need to be in a process function


func _process(_delta: float) -> void:
	#positive process effects
	if potions.pos_effect_pool.size() > 0:
		for potion in potions.effects:
			potion.effects.positive_effect.effect_process()
			potion.effects.negative_effect.effect_process()
			pass
		pass
