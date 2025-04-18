extends CanvasLayer
@onready var effect_1: Label = %effect1
@onready var effect_2: Label = %effect2
@onready var effect_3: Label = %effect3
@onready var hp: Label = %hp

@onready var condition: Label = %condition
@onready var condition_2: Label = %condition2
@onready var condition_3: Label = %condition3

@onready var negeffect_1: Label = %negeffect1
@onready var negeffect_2: Label = %negeffect2
@onready var negeffect_3: Label = %negeffect3

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
	
func _ready() -> void:
	condition.text = ""
	condition_2.text = ""
	condition_3.text = ""
	negeffect_1.text = ""
	negeffect_2.text = ""
	negeffect_3.text = ""
	effect_1.text = ""
	effect_2.text = ""
	effect_3.text = ""
	
func _process(_delta: float) -> void:
	update()
