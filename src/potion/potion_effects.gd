
class_name PotionEffectHolder extends Node
#holds active potions and pools of possible effects
#creates new potions for the shop


var character:Player 
func get_player(player:Player):
	character = player


@export var effects: Array[Potion]
@export var pos_effect_pool: Array[PosPotionComp]
@export var neg_effect_pool: Array[NegPotionComp]
@export var condition_pool: Array[ConditionPotionComp]

@onready var conditions = $conditions

func add_potion(potion: Potion):
	potion.positive_effect.player = character
	potion.condition.player = character
	potion.negative_effect.player = character
	effects.append(potion)
	potion.positive_effect.apply()
	#show positive effect TODO
	potion.condition.apply()
	#show condition TODO

func make_random_potion():
	var potion = Potion.new()
	#TODO erase after picking?
	potion.positive_effect = pos_effect_pool.pick_random()
	potion.neg_effect = neg_effect_pool.pick_random()
	potion.condition = condition_pool.pick_random()
	potion.sprite_pos = potion.positive_effect.texture
	potion.sprite_neg = potion.negative_effect.texture
	potion.sprite3 = potion.condition.texture
	potion.create_name()
	potion.create_description()
	pass
