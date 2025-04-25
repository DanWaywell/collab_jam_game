class_name AddWeapon extends PosPotionComp


@export var modifier: int
@export var weapon_key: String
@export var weapon_nodes: Dictionary = {
	"explosive_projectiles": "res://projectile/explosive_projectile_node.tscn",
	"aoe_1": "res://projectile/aoe_effect.tscn"
	
}


func apply():
	GlobalData.weapon_to_add.append(weapon_nodes[weapon_key])
	#show the UI / HUD Icon 
	pass
