extends CenterContainer


func goto_next_round():
	get_tree().change_scene_to_file("res://game/game.tscn")
	GlobalData.number_of_opponents += 4


func _on_button_1_button_up() -> void:
	goto_next_round()


func _on_button_2_button_up() -> void:
	goto_next_round()


func _on_button_3_button_up() -> void:
	goto_next_round()
