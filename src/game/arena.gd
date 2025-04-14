extends Sprite2D

const OPPONENT = preload("res://opponent/opponent.tscn")
const EDGE_MARGIN = 32

var screen_size: Vector2i
var number_of_opponents := 10


func _ready() -> void:
	screen_size.x = ProjectSettings.get_setting("display/window/size/viewport_width")
	screen_size.y = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	spawn_opponents(number_of_opponents)
	

func spawn_opponents(amount):
	for i in amount:
		var opponent = OPPONENT.instantiate()
		opponent.position.x = randi_range(EDGE_MARGIN, screen_size.x - EDGE_MARGIN)
		opponent.position.y = randi_range(EDGE_MARGIN, screen_size.y - EDGE_MARGIN)
		add_child(opponent)
