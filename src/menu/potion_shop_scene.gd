extends Control

var potion1: Potion
var potion2: Potion
var potion3: Potion

@onready var potion1_part1 = $Potion_display/potion_display1/part1
@onready var potion1_part2 = $Potion_display/potion_display1/part2
@onready var potion2_part1 = $Potion_display/potion_display2/part1
@onready var potion2_part2 = $Potion_display/potion_display2/part2
@onready var potion3_part1 = $Potion_display/potion_display3/part1
@onready var potion3_part2 = $Potion_display/potion_display3/part2

@onready var name_label = %Name
@onready var name_2: RichTextLabel = %Name2
@onready var name_3: RichTextLabel = %Name3

@onready var pos_effect: RichTextLabel = %pos_effect
@onready var condition: RichTextLabel = %condition
@onready var neg_effect: RichTextLabel = %neg_effect

func _ready() -> void:
	Hud.visible = false
	potion1 = PotionEffects.make_random_potion()
	potion2 = PotionEffects.make_random_potion()
	potion3 = PotionEffects.make_random_potion()
	name_label.text = "[center]" +potion1.name
	name_2.text = "[center]" +potion2.name
	name_3.text = "[center]" +potion3.name
	pos_effect.text = ""
	condition.text = ""
	neg_effect.text = ""
	potion1_part1.texture = potion1.sprite_pos
	potion1_part2.texture = potion1.sprite_neg
	potion2_part1.texture = potion2.sprite_pos
	potion2_part2.texture = potion2.sprite_neg
	potion3_part1.texture = potion3.sprite_pos
	potion3_part2.texture = potion3.sprite_neg
	potion1_part1.use_parent_material = false
	potion1_part2.use_parent_material = false
	potion2_part1.use_parent_material = false
	potion2_part2.use_parent_material = false
	potion3_part1.use_parent_material = false
	potion3_part2.use_parent_material = false

var picked_potion
func update_description(potion:Potion):
	pos_effect.text = potion.positive_effect.description
	neg_effect.text = potion.negative_effect.description
	condition.text = potion.condition.description
	pass
func goto_next_round():
	get_tree().change_scene_to_file("res://game/game.tscn")
	GlobalData.number_of_opponents += 4

func _on_potion_1_pressed() -> void:
	picked_potion = potion1
	
	potion1_part1.use_parent_material = true
	potion1_part2.use_parent_material = true
	potion2_part1.use_parent_material = false
	potion2_part2.use_parent_material = false
	potion3_part1.use_parent_material = false
	potion3_part2.use_parent_material = false
	update_description(potion1)
	#play sound


func update_description_labels(potion: Potion):
	pos_effect.text = potion.positive_effect.description
	condition.text = potion.condition.description
	neg_effect.text = potion.negative_effect.description
	
func _on_potion_2_pressed() -> void:
	picked_potion = potion2
	
	potion1_part1.use_parent_material = false
	potion1_part2.use_parent_material = false
	potion2_part1.use_parent_material = true
	potion2_part2.use_parent_material = true
	potion3_part1.use_parent_material = false
	potion3_part2.use_parent_material = false
	update_description(potion2)
func _on_potion_3_pressed() -> void:
	picked_potion = potion3
	
	potion1_part1.use_parent_material = false
	potion1_part2.use_parent_material = false
	potion2_part1.use_parent_material = false
	potion2_part2.use_parent_material = false
	potion3_part1.use_parent_material = true
	potion3_part2.use_parent_material = true
	update_description(potion3)

func _on_accept_button_pressed() -> void:
	AudioGlobal.play_sound("button_1", -15)
	if picked_potion != null:
		PotionEffects.add_potion(picked_potion)
		goto_next_round()
	else:
		#doh sound
		pass
		
