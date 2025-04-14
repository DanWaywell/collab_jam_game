class_name DmgWhileMoving extends PosPotionComp


@export var added_dmg: int 
var calculated_dmg: int 
var base_dmg: int

func on_apply():
	calc_dmg()
	pass
	
func effect_process():
	if player.velocity > Vector2.ZERO:
		player.dmg = calculated_dmg
	else:
		player.dmg = base_dmg
		pass
	
func calc_dmg():
	base_dmg = player.dmg
	calculated_dmg = player.dmg + added_dmg
