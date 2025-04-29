class_name IcyFloor extends NegPotionComp

## under 20!
@export var modifier: float
func apply():
	GlobalData.deceleration = modifier
	#print("applied icy floor")
	#show the UI / HUD Icon 
	pass
