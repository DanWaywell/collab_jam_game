
class_name PotionEffectHolder extends Node

#holds active potions and pools of possible effects

@onready var character:Player = $".."

@export var effects: Array[Potion]
@export var pos_effect_pool: Array[PosPotionComp]
@export var neg_effect_pool: Array[NegPotionComp]

func add_potion(potion: Potion):
	potion.positive_effect.player = character
	effects.append(potion)
	potion.positive_effect.on_apply()

func make_random_potion():
	var potion = Potion.new()
	potion.positive_effect = pos_effect_pool.pick_random()
	potion.neg_effect = neg_effect_pool.pick_random()
	potion.sprite_pos = potion.positive_effect.texture
	potion.sprite_neg = potion.negative_effect.texture
	pass
