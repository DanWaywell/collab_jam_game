extends Node

var number_of_opponents = 4

#player ref
var player: Player 
##weapons to add
var weapon_to_add: Array[String]

func get_player(new_player):
	player = new_player
	if weapon_to_add.size() > 0:
		for weapon in weapon_to_add:
			player.add_weapon(weapon)
	
	
#player vars
var speed := 60.0
var acceleration := 10.0
var deceleration := 20.0
var dmg := 1
var health := 15
var projectile_speed := 80.0
var velocity


#colors 
var enemy_color: Color = Color(0.81, 0.199, 0.0)
var rival_color: Color = Color(0.883, 0.761, 0.561)

# enemy vars
var attack_cooldown = 1.0
var attacking = false

func attack_timer():
	await get_tree().create_timer(attack_cooldown).timeout
	attacking = false
