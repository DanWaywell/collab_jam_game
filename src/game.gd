extends Node

@onready var ui: Control = $UI
@onready var arena: Node3D = $Arena


func _on_start_button_pressed() -> void:
	ui.hide()
	arena.process_mode = Node.PROCESS_MODE_ALWAYS
