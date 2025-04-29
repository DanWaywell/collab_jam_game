extends Node2D

@onready var label = %RichTextLabel2
@onready var bubble = %bubbly

func _ready() -> void:
	Hud.visible = false
	get_forward.connect(tut_off)
	if GlobalData.rounds == 1:
		tut_on()
		text_1()
	else:
		tut_on()
		text_2()
		$Button.queue_free()
		
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
	queue_free()



func clear_label():
	label.text = ""
	label.visible = false
	
func text_1():
	label.position = Vector2(185.0,182.0)
	bubble.position = Vector2(185.0,182.0)
	var text1 = "Hey Witch. You need a potion? For you it's only 1/6 of your soul. Maybe read the instrutions."
	var bubble_text = "[shake rate=6.0 level=12 connected=1]" + text1
	display_text(text1, label)
	display_text(bubble_text, bubble)
	pass


func text_2():
	label.position = Vector2(353.0,196.0)
	bubble.position = Vector2(353.0,196.0)
	var text1 = "Oh hey, it's you again."
	var bubble_text = "[shake rate=6.0 level=12 connected=1]" + text1
	display_text(text1, label)
	display_text(bubble_text, bubble)
	pass

func _input(event: InputEvent) -> void:
	if tutorial_ongoing == true and letters_appearing == false:
		if event.is_action_pressed("mouseclick") or event.is_action_pressed("ui_accept"):
			get_viewport().set_input_as_handled()
			get_forward.emit()
			#print("forward")

func _unhandled_input(event: InputEvent) -> void:
	if tutorial_ongoing == true and letters_appearing == true:
		if event.is_action_pressed("mouseclick") or event.is_action_pressed("ui_accept"):
			label.visible_characters = label.text.length()
			bubble.visible_characters = bubble.text.length()
			get_viewport().set_input_as_handled()
			pass

func display_text(text: String, flabel : RichTextLabel):
	flabel.visible = true
	flabel.visible_characters = 0
	flabel.text = text
	#await get_tree().process_frame #TEST
 # "[wave rate=0.2 level=0.2 connected=0]" + 
	display_letter(flabel)
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
			#print("all visible")
			text_stopped.emit()
			letters_appearing = false
			break
	
signal text_stopped


func _on_button_pressed() -> void:
	tut_off()
#	if tutorial_ongoing == true and letters_appearing == false and do_something == false:
#		get_forward.emit()
#		get_viewport().set_input_as_handled()
#		pass
#	if tutorial_ongoing == true and letters_appearing == true and do_something == false:
#		label.visible_characters = label.text.length()
#		bubble.visible_characters = bubble.text.length()
#		get_viewport().set_input_as_handled()
#	pass # Replace with function body.
