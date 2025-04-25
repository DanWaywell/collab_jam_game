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


func update():
	hp.text = str(GlobalData.health)
	if PotionEffects.effects.size() > 0:
		effect_1.text = PotionEffects.effects[0].positive_effect.description_small
		condition.text = PotionEffects.effects[0].condition.description_small
		negeffect_1.text = PotionEffects.effects[0].negative_effect.description_small
	if PotionEffects.effects.size() > 1:
		effect_2.text = PotionEffects.effects[1].positive_effect.description_small
		condition_2.text = PotionEffects.effects[1].condition.description_small
		negeffect_2.text = PotionEffects.effects[1].negative_effect.description_small
	if PotionEffects.effects.size() > 2:
		effect_3.text = PotionEffects.effects[2].positive_effect.description_small
		condition_3.text = PotionEffects.effects[2].condition.description_small
		negeffect_3.text = PotionEffects.effects[2].negative_effect.description_small
	if PotionEffects.effects.size() > 3:
		effect_4.text = PotionEffects.effects[4].positive_effect.description_small
		condition_4.text = PotionEffects.effects[4].condition.description_small
		negeffect_4.text = PotionEffects.effects[4].negative_effect.description_small
	if PotionEffects.effects.size() > 4:
		effect_5.text = PotionEffects.effects[5].positive_effect.description_small
		condition_5.text = PotionEffects.effects[5].condition.description_small
		negeffect_5.text = PotionEffects.effects[5].negative_effect.description_small
	if PotionEffects.effects.size() > 5:
		effect_6.text = PotionEffects.effects[6].positive_effect.description_small
		condition_6.text = PotionEffects.effects[6].condition.description_small
		negeffect_6.text = PotionEffects.effects[6].negative_effect.description_small
	
func _ready() -> void:
	GlobalGameManager.player_score_changed.connect(update_player_score)
	condition.text = ""
	condition_2.text = ""
	condition_3.text = ""
	condition_6.text = ""
	condition_4.text = ""
	condition_5.text = ""
	
	negeffect_1.text = ""
	negeffect_2.text = ""
	negeffect_3.text = ""
	negeffect_4.text = ""
	negeffect_5.text = ""
	negeffect_6.text = ""
	
	effect_1.text = ""
	effect_2.text = ""
	effect_3.text = ""
	effect_4.text = ""
	effect_5.text = ""
	effect_6.text = ""
func update_player_score():
	player_score_int.text = str(GlobalGameManager.player_score)
func update_rival_score():
	rival_score_int.text = str(GlobalGameManager.rival_score)
func _process(_delta: float) -> void:
	update()
	update_player_score()
	update_rival_score()
