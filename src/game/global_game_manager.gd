class_name GameManager extends Node

# tracks game state and global vars
#functions as a Signal Bus

signal enemy_killed_by_player(mob:Mob)
signal enemy_killed_by_rival(mob:Mob)
signal player_got_hit
@warning_ignore("unused_signal")
signal player_hp

# condition signals
signal kill_combo_streak(enemies_killed: int)
signal kill_combo_end
signal quick_combo_streak(enemies_killed: int)
signal quick_combo_end
@warning_ignore("unused_signal")
signal player_takes_damage

@warning_ignore("unused_signal")
signal mob_spawned(mob:Mob)

signal projectile_hits_mob(position: Vector2)
signal explosion_hits_mob(position: Vector2)




@onready var debug_overlay = $debug_overlay
@onready var popup_numbers: DamageNumbers = $dmg_numbers

var player_score: int
var rival_score: int
signal player_score_changed

func _ready() -> void:
	enemy_killed_by_player.connect(quickness_combo)
	enemy_killed_by_player.connect(count_kills)
	
	enemy_killed_by_rival.connect(quickness_combo_rival)
	enemy_killed_by_rival.connect(count_kills_rival)
	player_got_hit.connect(kill_combo_reset)
	
	
var current_game_state
enum  STATE {
FIGHT,
SHOP,
}

func count_player_score(score):
	player_score += score
	#player_score_changed.emit()

func count_rival_score(score):
	rival_score += score






var enemies_defeated: int
var enemies_defeated_rival: int
## how excited is the crowd? 
var crowd_activation: float
## kills without taken dmg in between
var kill_combo: int
var kill_combo_rival: int
##

##Player
func kill_combo_reset():
	kill_combo = 0
	kill_combo_end.emit()

var quickness_kill_combo: int

##for quickness combo 
@export var time_between_kills: float = 3.0
@onready var kill_timer = $quick_kill_timer

func count_kills(_mob):
	kill_combo += 1
	enemies_defeated += 1
	count_player_score(1)
	if kill_combo > 0:
		count_player_score(int(kill_combo))
		pass
	if quickness_kill_combo > 0:
		@warning_ignore("integer_division")
		count_player_score(int(quickness_kill_combo/3)^2)
		pass
	kill_combo_streak.emit(kill_combo)

var quick_combo_start: bool = false

func quickness_combo(_mob):
	print("quick combo")
	if quick_combo_start == false:
		quickness_kill_combo += 1
		print("quick combo started")
		kill_timer.start(time_between_kills)
		quick_combo_start = true
		quick_combo_streak.emit(quickness_kill_combo)
		return
	if quick_combo_start == true:
		kill_timer.start(time_between_kills)
		quickness_kill_combo += 1
		crowd_activation += 0.1
		quick_combo_streak.emit(quickness_kill_combo)

func _on_quick_kill_timer_timeout() -> void:
	var last_combo = quickness_kill_combo
	if last_combo > 1:
		crowd_activation -= (last_combo * 0.1)
	print("quick combo timeout!")
	quickness_kill_combo = 0
	quick_combo_start = false
	quick_combo_end.emit()

#Rival
func kill_combo_reset_rival():
	kill_combo_rival = 0

var quickness_kill_combo_rival: int

##for quickness combo 
@export var time_between_kills_rival: float = 3.0
@onready var kill_timer_rival = $quick_kill_timer_rival

func count_kills_rival(_mob):
	kill_combo_rival += 1
	enemies_defeated_rival += 1
	count_rival_score(1)
	if kill_combo > 0:
		count_rival_score(int(kill_combo))
		pass
	if quickness_kill_combo > 0:
		@warning_ignore("integer_division")
		count_rival_score(int(quickness_kill_combo/3)^2)
		pass
var quick_combo_start_rival: bool = false

func quickness_combo_rival(_mob):
	print("quick combo rival")
	if quick_combo_start_rival == false:
		quickness_kill_combo_rival += 1
		print("quick combo started rival")
		kill_timer_rival.start(time_between_kills_rival)
		quick_combo_start_rival = true
		return
	if quick_combo_start_rival == true:
		kill_timer_rival.start(time_between_kills_rival)
		quickness_kill_combo_rival += 1
		crowd_activation -= 0.1
		

func _on_quick_kill_timer_rival_timeout() -> void:
	var last_combo = quickness_kill_combo_rival
	if last_combo > 1:
		crowd_activation += (last_combo * 0.1)
	print("quick combo rival timeout!")
	quickness_kill_combo_rival = 0
	quick_combo_start_rival = false
	pass # Replace with function body.
