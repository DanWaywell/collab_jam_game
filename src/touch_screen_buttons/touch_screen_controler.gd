extends CanvasLayer

var state = {}

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed: # Down.
			state[event.index] = event.position
		else: # Up.
			state.erase(event.index)
		get_viewport().set_input_as_handled()

	elif event is InputEventScreenDrag: # Movement.
		state[event.index] = event.position
		get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	if DisplayServer.is_touchscreen_available() and visible == false:
		visible = true
