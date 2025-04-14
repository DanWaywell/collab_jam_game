extends Node2D


func _process(_delta: float) -> void:
	var mob_list = []
	for child in get_children():
		if child.is_in_group("mobs"):
			mob_list.append(child)
	if mob_list.is_empty():
		end_round()


func start_game():
	process_mode = Node.PROCESS_MODE_PAUSABLE


func reset_game():
	pass


func end_round():
	pass
