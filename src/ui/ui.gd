extends CanvasLayer


func _on_start_button_pressed() -> void:
	hide()
	get_parent().start_game()
	AudioGlobal.set_music_state(AudioGlobal.STATE.FIGHT) #fade to fight music
	AudioGlobal.play_sound("button_1")
	
	get_tree().call_group("mobs", "spawn")

# button sounds
func _on_start_button_mouse_entered() -> void:
	AudioGlobal.play_sound("button_2")


func _on_start_button_focus_entered() -> void:
	AudioGlobal.play_sound("button_2")
