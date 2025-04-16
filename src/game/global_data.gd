extends Node

var number_of_opponents = 4


#player vars
var speed := 60.0
var acceleration := 10.0
var deceleration := 20.0
var dmg := 1
var health := 15
var projectile_speed := 80.0
var velocity

# enemy vars
var attack_cooldown = 1.0
var attacking = false

func attack_timer():
	await get_tree().create_timer(attack_cooldown).timeout
	attacking = false
