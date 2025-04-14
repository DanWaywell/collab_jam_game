extends CenterContainer


func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")
