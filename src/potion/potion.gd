class_name Potion extends Resource

@export var positive_effect: PosPotionComp
@export var negative_effect: NegPotionComp
@export var condition: ConditionPotionComp


@export var sprite_pos: Texture2D
@export var sprite_neg: Texture2D
@export var sprite3: Texture2D

var name: String
var description: String


func create_potion_display():
	# TODO packed scene with Sprite2D components
	pass

func create_name():
	name = negative_effect.name + condition.name + positive_effect.name

func create_description():
	description = positive_effect.description + condition.description + negative_effect.description 
