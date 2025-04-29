class_name DmgWhileMoving extends PosPotionComp


@export var added_dmg: int 
var calculated_dmg: int 
var base_dmg: int
var calculated: bool = false

func apply():
	calc_dmg()
	pass
	
func effect_process():
	if calculated == true:
	#	print(GlobalData.velocity)
		if GlobalData.velocity != Vector2.ZERO:
			GlobalData.dmg = calculated_dmg
		else:
			GlobalData.dmg = base_dmg
			pass
		
func calc_dmg():
	base_dmg = GlobalData.dmg
	calculated_dmg = GlobalData.dmg + added_dmg
	#print("calc dmg = ", calculated_dmg)
	calculated = true
