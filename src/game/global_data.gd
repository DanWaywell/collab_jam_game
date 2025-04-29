extends Node

var number_of_opponents = 4

#player ref
var player: Player 
##weapons to add
var weapon_to_add: Array[String]
var rounds: int
var win: bool = false


func get_player(new_player):
	player = new_player
	if weapon_to_add.size() > 0:
		for weapon in weapon_to_add:
			player.add_weapon(weapon)
	
#Score:
var potions: int
#player
var enemies_killed_player: int
var bats: int
var blobs: int
var pawns: int

#rival
var renemies_killed_player: int
var rbats: int
var rblobs: int
var rpawns: int


#player vars
var speed := 60.0
var acceleration := 10.0
var deceleration := 20.0
var dmg := 1
var health := 15
var projectile_speed := 80.0
var velocity
var shaking_hands: bool = false
var regen: int = 0
var regen_on_5_kill: int = 0
var curse: int = 0

func reset():
	curse = 0
	regen_on_5_kill = 0
	regen = 0
	speed = 60.0
	acceleration = 10.0
	deceleration = 20.0
	dmg = 1
	health = 15
	projectile_speed = 80.0
	shaking_hands = false
	weapon_to_add.clear()
	enemyaoe = false
	potions = 0
	enemies_killed_player = 0
	bats = 0
	blobs = 0
	pawns = 0
	GlobalGameManager.player_score = 0
	GlobalGameManager.rival_score = 0
	rounds = 0
	win = false

#colors 
var enemy_color: Color = Color(0.81, 0.199, 0.0)
var rival_color: Color = Color(0.883, 0.761, 0.561)

# enemy vars
var attack_cooldown = 1.0
var attacking = false
var enemyaoe = false

# other
var text_dialogue_speed =  0.01

func attack_timer():
	await get_tree().create_timer(attack_cooldown).timeout
	attacking = false
