extends AudioStreamPlayer

@export var player: CharacterBody2D


func walk():
	pass

var wait: bool = true
func _process(_delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		if wait == false:
			pass
		else:
			playing = true
			wait = false
			await get_tree().create_timer(0.25).timeout
			wait = true
	else:
		playing = false
