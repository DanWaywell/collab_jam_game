extends CanvasLayer
@onready var effect_1: Label = %effect1
@onready var effect_2: Label = %effect2
@onready var effect_3: Label = %effect3
@onready var effect_4: Label = %effect4
@onready var effect_5: Label = %effect5
@onready var effect_6: Label = %effect6

@onready var player_score_int: Label = $"Panel3/VBoxContainer2/pscore int"
@onready var rival_score_int: Label = $"Panel3/VBoxContainer2/rscore int"
@onready var combo_int: Label = $"Panel3/VBoxContainer2/combo int"
@onready var qcombo_int: Label = $"Panel3/VBoxContainer2/qcombo int"



@onready var hp: Label = %hp

@onready var condition: Label = %condition
@onready var condition_2: Label = %condition2
@onready var condition_3: Label = %condition3
@onready var condition_4: Label = %condition4
@onready var condition_5: Label = %condition5
@onready var condition_6: Label = %condition6


@onready var negeffect_1: Label = %negeffect1
@onready var negeffect_2: Label = %negeffect2
@onready var negeffect_3: Label = %negeffect3
@onready var negeffect_4: Label = %negeffect4
@onready var negeffect_5: Label = %negeffect5
@onready var negeffect_6: Label = %negeffect6

@onready var pos_effects_ar: Array[Node] = [%effect1, %effect2, %effect3, %effect4, %effect5, %effect6]
@onready var neg_effects_ar: Array[Node] = [%negeffect1, %negeffect2, %negeffect3, %negeffect4, %negeffect5, %negeffect6]
@onready var conditions_ar: Array[Node] = [%condition, %condition2, %condition3, %condition4, %condition5, %condition6]


func update_condition_status0():
	condition.text = ""
	negeffect_1.add_theme_color_override("font_color", Color.RED)
func update_condition_status1():
	condition.text = ""
	negeffect_2.add_theme_color_override("font_color", Color.RED)
func update_condition_status2():
	condition.text = ""
	negeffect_3.add_theme_color_override("font_color", Color.RED)
func update_condition_status3():
	condition.text = ""
	negeffect_4.add_theme_color_override("font_color", Color.RED)
func update_condition_status4():
	condition.text = ""
	negeffect_5.add_theme_color_override("font_color", Color.RED)
func update_condition_status5():
	condition.text = ""
	negeffect_6.add_theme_color_override("font_color", Color.RED)

func update():
	
	if PotionEffects.effects.size() == 1:
		effect_1.text = PotionEffects.effects[0].positive_effect.description_small
		condition.text = PotionEffects.effects[0].condition.description_small
		negeffect_1.text = PotionEffects.effects[0].negative_effect.description_small
		PotionEffects.effects[0].negative_effect.condition_met.connect(update_condition_status0)
	if PotionEffects.effects.size() == 2:
		effect_2.text = PotionEffects.effects[1].positive_effect.description_small
		condition_2.text = PotionEffects.effects[1].condition.description_small
		negeffect_2.text = PotionEffects.effects[1].negative_effect.description_small
		PotionEffects.effects[1].negative_effect.condition_met.connect(update_condition_status1)
	if PotionEffects.effects.size() == 3:
		effect_3.text = PotionEffects.effects[2].positive_effect.description_small
		condition_3.text = PotionEffects.effects[2].condition.description_small
		negeffect_3.text = PotionEffects.effects[2].negative_effect.description_small
		PotionEffects.effects[2].negative_effect.condition_met.connect(update_condition_status2)
	if PotionEffects.effects.size() == 4:
		effect_4.text = PotionEffects.effects[3].positive_effect.description_small
		condition_4.text = PotionEffects.effects[3].condition.description_small
		negeffect_4.text = PotionEffects.effects[3].negative_effect.description_small
		PotionEffects.effects[3].negative_effect.condition_met.connect(update_condition_status3)
	if PotionEffects.effects.size() == 5:
		effect_5.text = PotionEffects.effects[4].positive_effect.description_small
		condition_5.text = PotionEffects.effects[4].condition.description_small
		negeffect_5.text = PotionEffects.effects[4].negative_effect.description_small
		PotionEffects.effects[4].negative_effect.condition_met.connect(update_condition_status4)
	if PotionEffects.effects.size() == 6:
		effect_6.text = PotionEffects.effects[5].positive_effect.description_small
		condition_6.text = PotionEffects.effects[5].condition.description_small
		negeffect_6.text = PotionEffects.effects[5].negative_effect.description_small
		PotionEffects.effects[5].negative_effect.condition_met.connect(update_condition_status5)
	
func _ready() -> void:
	PotionEffects.potion_added.connect(update)
	reset()
	
func reset():
	for cond in conditions_ar:
		cond.text = ""
	for neg in neg_effects_ar:
		neg.text = ""
		neg.add_theme_color_override("font_color", Color.WHITE)
	for pos in pos_effects_ar:
		pos.text = ""
	
	
func update_player_score():
	player_score_int.text = str(GlobalGameManager.player_score)
func update_rival_score():
	rival_score_int.text = str(GlobalGameManager.rival_score)
	
func _process(_delta: float) -> void:
	hp.text = str(GlobalData.health)
	update_player_score()
	update_rival_score()
