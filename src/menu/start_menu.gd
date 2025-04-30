extends CenterContainer


func _on_start_button_button_up() -> void:
	AudioGlobal.play_sound("button_1", -15)
	get_tree().change_scene_to_file("res://dialogue_scene/start.tscn")
