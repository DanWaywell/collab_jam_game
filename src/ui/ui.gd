extends CanvasLayer


func _on_start_button_pressed() -> void:
	hide()
	AudioGlobal.set_music_state(AudioGlobal.STATE.FIGHT) #fade to fight music
	AudioGlobal.play_sound("button_1")

# button sounds
func _on_start_button_mouse_entered() -> void:
	AudioGlobal.play_sound("button_2")


func _on_start_button_focus_entered() -> void:
	AudioGlobal.play_sound("button_2")
