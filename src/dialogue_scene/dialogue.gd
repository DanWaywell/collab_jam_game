class_name DialogueText extends Node2D

@onready var label = %RichTextLabel2
@onready var player_label = %player_label

func _ready() -> void:
	Hud.visible = false
#	bag_manager.sprytebag_open.connect(on_start)
	on_start()
	pass
signal get_forward
signal text_appears
signal tut_finished


var do_something: bool = false
var tutorial_ongoing: bool

func tut_on():
	text_appears.emit()
	tutorial_ongoing = true

func tut_off():
	tutorial_ongoing = false
	tut_finished.emit()
	get_tree().change_scene_to_file("res://game/game.tscn")

func on_start():
#	if GlobalEventPlotter.switches["spryte_bag_tut"] == false:
		tut_on()
		text_1()
		pass

func clear_label():
	label.text = ""
	label.visible = false
	
func text_1():
	tut_on()
	var text1 = "... and this is how I'll bring an end to all evil and save cute, little kittens."
	await display_text(text1, label)
	await get_forward
	
	var text2 = "Ugh."
	await display_text(text2, player_label)
	await get_forward
	
	var text22 = "Not only that, you'll all get autograms for your grandma!"
	var text3 = "Our saviour and hero! I hate that guy, someone's got to do _something_ ..."
	display_text(text22, label)
	await display_text(text3, player_label)
	await get_forward
	%do_something.visible = true
	var text23 = "How is she called? ... Rosemary! What a lovely name ..."
	display_text(text23, label)
	player_label.text = ""
	do_something = true
	await get_forward
	tut_off()
	pass

func _input(event: InputEvent) -> void:
	if tutorial_ongoing == true and letters_appearing == false:
		if event.is_action_pressed("mouseclick") or event.is_action_pressed("ui_accept"):
			get_viewport().set_input_as_handled()
			get_forward.emit()
			print("forward")

func _unhandled_input(event: InputEvent) -> void:
	if tutorial_ongoing == true and letters_appearing == true:
		if event.is_action_pressed("mouseclick") or event.is_action_pressed("ui_accept"):
			label.visible_characters = label.text.length()
			get_viewport().set_input_as_handled()
			pass

func display_text(text: String, flabel : RichTextLabel):
	flabel.visible = true
	flabel.visible_characters = 0
	flabel.text = text
	await get_tree().process_frame #TEST
 # "[wave rate=0.2 level=0.2 connected=0]" + 
	await display_letter(flabel)
	letters_appearing = false
	text_stopped.emit()
	pass

var letters_appearing = false

func display_letter(flabel: RichTextLabel):
	flabel.visible_characters = 0
	await get_tree().create_timer(GlobalData.text_dialogue_speed).timeout
	for letter in flabel.text.length():
		await get_tree().create_timer(GlobalData.text_dialogue_speed).timeout
		letters_appearing = true
		flabel.visible_characters += 1
	#	letters_appearing = false
		pass
		if flabel.visible_characters == flabel.text.length():
			print("all visible")
			text_stopped.emit()
			letters_appearing = false
			break
	
signal text_stopped


func _on_button_pressed() -> void:
	if tutorial_ongoing == true and letters_appearing == false and do_something == false:
		get_viewport().set_input_as_handled()
		get_forward.emit()
		pass
	if tutorial_ongoing == true and letters_appearing == true and do_something == false:
		label.visible_characters = label.text.length()
		get_viewport().set_input_as_handled()
	pass # Replace with function body.


func _on_skip_pressed() -> void:
	tut_off()
	pass # Replace with function body.
