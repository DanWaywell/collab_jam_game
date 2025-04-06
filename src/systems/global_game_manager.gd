class_name GameManager extends Node

# tracks game state and global vars
#functions as a Signal Bus

signal enemy_killed_by_player(mob:Mob)
signal enemy_killed_by_rival(mob:Mob)
signal player_got_hit

signal mob_spawned(mob:Mob)

func _ready() -> void:
	enemy_killed_by_player.connect(quickness_combo)
	enemy_killed_by_player.connect(count_kills)
	player_got_hit.connect(kill_combo_reset)
	
	
var current_game_state
enum  STATE {
FIGHT,
SHOP,
}

var enemies_defeated: int
## how excited is the crowd? 
var crowd_activation: float
## kills without taken dmg in between
var kill_combo: int
##

func kill_combo_reset():
	kill_combo = 0

var quickness_kill_combo: int

##for quickness combo 
@export var time_between_kills: float = 3.0
@onready var kill_timer = $quick_kill_timer

func count_kills(_mob):
	kill_combo += 1
	enemies_defeated += 1

var quick_combo_start: bool = false

func quickness_combo(_mob):
	print("quick combo")
	if quick_combo_start == false:
		quickness_kill_combo += 1
		print("quick combo started")
		kill_timer.start(time_between_kills)
		quick_combo_start = true
		return
	if quick_combo_start == true:
		kill_timer.start(time_between_kills)
		quickness_kill_combo += 1
		crowd_activation += 0.1

func _on_quick_kill_timer_timeout() -> void:
	var last_combo = quickness_kill_combo
	if last_combo > 1:
		crowd_activation -= (last_combo * 0.1)
	print("quick combo timeout!")
	quickness_kill_combo = 0
	quick_combo_start = false
