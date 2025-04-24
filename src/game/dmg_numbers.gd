class_name DamageNumbers extends Node

@onready var label = preload("res://ui_common/dmg_popup_number.tscn")

var damage_number_time: float = 0.8

func display_dot_number(value: float, target_position, new_color: Color, is_heal: bool = false):
#	target_position.y -= 25
#	target_position.x -= 15
	var number: RichTextLabel = label.instantiate()
	var int_value = int(value)
	number.global_position = target_position
	if is_heal == true:
		number.text = "\n[wave amp=25.0 freq=5.0 connected=0]+ " + str(int_value) + "[/wave]"
	else:
		number.text = "\n[wave amp=25.0 freq=5.0 connected=0]" + str(int_value) + "[/wave]"
	
	number.z_index = 6
	
	number.add_theme_color_override("default_color", new_color)
	call_deferred("add_child",number)
	
	await number.ready
	number.pivot_offset =(number.size / 2)

	var tween2 = self.create_tween().bind_node(number).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween2.tween_property(number, "global_position", (target_position + Vector2 (0,-60)), damage_number_time).from(target_position)
	
	await tween2.finished

	number.visible = false
	remove_child(number)
	number.queue_free()
	
func display_numbers(value: float, _target_position: Vector2,target, _is_critical: bool = false, new_color: Color = Color.WEB_PURPLE):
	# TODO : color for Overload
	_target_position = target.global_position
	_target_position.y -= 25
	_target_position.x -= 5
	var number: RichTextLabel = label.instantiate()
	var int_value = int(value)
	number.global_position = _target_position
	number.text = "[wave amp=25.0 freq=5.0 connected=0]" + str(int_value) + "[/wave]"
	number.z_index = 6
	var color = new_color
	
	if _is_critical:
		color = "#B22"
		number.scale = Vector2(1.5,1.5)
	if value == 0:
		color = "#FFF8"
	number.add_theme_color_override("default_color", color)
	target.add_child(number)
	 
	await get_tree().process_frame
	if is_instance_valid(number):
		number.pivot_offset =(number.size / 2)
		print("number pos", number.global_position)
		var tween2 = number.create_tween().bind_node(number).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
		tween2.tween_property(number, "global_position", ( _target_position + Vector2 (0,-20)), 0.4).from(_target_position)
		
	await get_tree().create_timer(0.7).timeout
	if is_instance_valid(number):
		print("number pos", number.global_position)
		number.visible = false
		target.remove_child(number)
		number.queue_free()
