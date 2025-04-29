extends CharacterBody2D

var speed := 30.0
var acceleration := 10.0
var deceleration := 20.0
var direction_facing := Vector2.RIGHT

@export var health = 3


@onready var target: CharacterBody2D
@onready var mob: Mob = $Path2D/PathFollow2D/Opponent
func _ready() -> void:
	spawn()

func spawn():
	#print_debug("spawned bat")
	GlobalGameManager.mob_spawned.emit(mob)

func attack_player(body: Player):
	if GlobalData.attacking == false:
		GlobalData.attacking = true
		body.take_damage(1,mob, GlobalData.enemy_color)
		GlobalData.attack_timer()
	pass

func seek_target(new_target: CharacterBody2D):
	target = new_target

func _physics_process(_delta: float) -> void:
	var input_direction
	if target:
		input_direction= target.position - position
	else: input_direction = Vector2.ZERO

	var move_direction = input_direction.normalized()

	# Movement x y
	if move_direction:
		velocity = move_direction * speed
		velocity.x = move_toward(velocity.x, move_direction.x * speed, acceleration)
		velocity.y = move_toward(velocity.y, move_direction.y * speed, acceleration)
	else:
		velocity = Vector2.ZERO
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)

	move_and_slide()
	check_health()


var last_hit_source
var defeated

func take_damage(damage, source: CharacterBody2D, color: Color):
	mob.health -= damage
	mob.last_hit_source = source
	GlobalGameManager.popup_numbers.display_numbers(damage, mob.global_position, mob, false, color)
	$Path2D/PathFollow2D/Opponent/hurt_tween_comp.hurt()

func check_health():
	if mob.health < 1:
		if is_instance_valid(mob.last_hit_source):
			if mob.defeated == false:
				if mob.last_hit_source is Player:
					GlobalGameManager.enemy_killed_by_player.emit(mob)
					GlobalData.bats += 1
					GlobalData.enemies_killed_player += 1
				if mob.last_hit_source is Rival:
					GlobalGameManager.enemy_killed_by_rival.emit(mob)
					GlobalData.rbats += 1
					GlobalData.renemies_killed_player += 1
				mob.defeated = true
			# wait a bit before queue_free to show the dmg number
		mob.defeated = true
		$Path2D/PathFollow2D/Opponent/attack_reach/CollisionShape2D.disabled = true
		$Path2D/PathFollow2D/Opponent/hurtbox/CollisionShape2D2.disabled = true
		$Path2D/PathFollow2D/Opponent/Sprite2D.visible = false
		await get_tree().create_timer(0.7).timeout
		mob.queue_free()
		queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		seek_target(body)
	if target == null and body is Rival:
		seek_target(body)

func _on_attack_reach_body_entered(body: Node2D) -> void:
	if body is Player and GlobalData.attacking == false:
		attack_player(body)
		pass

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Explosion:
		take_damage(area.damage, area.source, area.color)
		GlobalGameManager.explosion_hits_mob.emit(mob.global_position)
		AudioGlobal.play_sound("magic_explosion2", -20.0)
	#	print("explosion hit")
	if area is AoE:
		take_damage(area.damage, area.source, area.color)
		GlobalGameManager.explosion_hits_mob.emit(mob.global_position)
	#	print("AoE hit")
