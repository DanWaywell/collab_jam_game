extends Sprite2D

@onready var parent: Node2D = $".."

var is_pressed := false

var max_length = 16
var dead_zone = 4

@onready var touch_helper = $"../.."

@onready var marker_top_left: Marker2D = $"../MarkerTopLeft"
@onready var marker_top_right: Marker2D = $"../MarkerTopRight"

var finger_to_track
var finger_position

func _ready() -> void:
	max_length = max_length * parent.scale.x


func _process(delta: float) -> void:
	
	
	for ptr_index in touch_helper.state.keys():
		var pos = touch_helper.state[ptr_index]
		if pos.x > marker_top_left.global_position.x and pos.y > marker_top_left.global_position.y\
		and pos.x < marker_top_right.global_position.x and pos.y < marker_top_right.global_position.y:
			finger_to_track = ptr_index
			is_pressed = true
	
	
	if finger_to_track in touch_helper.state:
		pass
	else:
		is_pressed = false
	
	
	if is_pressed:
		finger_position = touch_helper.state[finger_to_track]
		
		if finger_position.distance_to(parent.global_position) <= max_length:
			global_position = finger_position
		else:
			var angle = parent.global_position.angle_to_point(finger_position)
			global_position.x = parent.global_position.x + cos(angle) * max_length
			global_position.y = parent.global_position.y + sin(angle) * max_length
		calculate_vector()
	else:
		global_position = lerp(global_position, parent.global_position, 20 * delta)
		parent.position_vector = Vector2(0, 0)


func calculate_vector():
	if abs(global_position.x - parent.global_position.x) >= dead_zone:
		parent.position_vector.x = (global_position.x - parent.global_position.x) / max_length
	if abs(global_position.y - parent.global_position.y) >= dead_zone:
		parent.position_vector.y = (global_position.y - parent.global_position.y) / max_length
