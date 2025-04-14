extends CenterContainer


var potion1: Potion
var potion2: Potion
var potion3: Potion

@onready var potion1_label = $HBoxContainer/VBoxContainer/Label
@onready var potion2_label = $HBoxContainer/VBoxContainer2/Label
@onready var potion3_label = $HBoxContainer/VBoxContainer3/Label

@onready var potion1_button = $HBoxContainer/VBoxContainer/Button1
@onready var potion2_button = $HBoxContainer/VBoxContainer2/Button2
@onready var potion3_button = $HBoxContainer/VBoxContainer3/Button3


func _ready() -> void:
	potion1 = PotionEffects.make_random_potion()
	potion2 = PotionEffects.make_random_potion()
	potion3 = PotionEffects.make_random_potion()
	potion1_label.text = potion1.name
	potion2_label.text = potion2.name
	potion3_label.text = potion3.name
	potion1_button.tooltip_text = potion1.description
	potion2_button.tooltip_text = potion2.description
	potion3_button.tooltip_text = potion3.description

func goto_next_round():
	get_tree().change_scene_to_file("res://game/game.tscn")
	GlobalData.number_of_opponents += 4


func _on_button_1_button_up() -> void:
	PotionEffects.add_potion(potion1)
	goto_next_round()


func _on_button_2_button_up() -> void:
	PotionEffects.add_potion(potion2)
	goto_next_round()


func _on_button_3_button_up() -> void:
	PotionEffects.add_potion(potion3)
	goto_next_round()
