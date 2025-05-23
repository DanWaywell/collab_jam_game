class_name Mob extends CharacterBody2D

@export var speed := 30.0
var acceleration := 10.0
var deceleration := 20.0
var direction_facing := Vector2.RIGHT

@export var health = 3

@onready var sprite: Sprite2D = $Sprite2D
@onready var target: CharacterBody2D


func _ready() -> void:
	spawn()

func attack_player(body: Player):
	if GlobalData.attacking == false:
		GlobalData.attacking = true
		body.take_damage(1,self, GlobalData.enemy_color)
		GlobalData.attack_timer()
	pass

func spawn():
	print_debug("spawned")
	GlobalGameManager.mob_spawned.emit(self)


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
	set_direction_facing(input_direction)
	set_sprite()
	check_health()


func set_direction_facing(vec2):
	if vec2 != Vector2.ZERO:
		if abs(vec2.x) > abs(vec2.y):
			if vec2.x > 0:
				direction_facing = Vector2.RIGHT
			else:
				direction_facing = Vector2.LEFT
		else:
			if vec2.y > 0:
				direction_facing = Vector2.DOWN
			else:
				direction_facing = Vector2.UP


func set_sprite():
	if direction_facing == Vector2.UP:
		sprite.frame = 0
	elif direction_facing == Vector2.RIGHT:
		sprite.frame = 3
	elif direction_facing == Vector2.DOWN:
		sprite.frame = 1
	elif direction_facing == Vector2.LEFT:
		sprite.frame = 2
	else:
		pass


var last_hit_source: CharacterBody2D
func take_damage(damage, source: CharacterBody2D, color: Color):
	health -= damage
	last_hit_source = source
	GlobalGameManager.popup_numbers.display_numbers(damage, global_position, self, false, color)
	$hurt_tween_comp.hurt()

var defeated = false
func check_health():
	if health < 1:
		if is_instance_valid(last_hit_source):
			if defeated == false:
				AudioGlobal.play_sound("plop", -10.0)
				if last_hit_source is Player:
					GlobalGameManager.enemy_killed_by_player.emit(self)
					GlobalData.pawns += 1
					GlobalData.enemies_killed_player += 1
				if last_hit_source is Rival:
					GlobalGameManager.enemy_killed_by_rival.emit(self)
					GlobalData.rpawns += 1
					GlobalData.renemies_killed_player += 1
				defeated = true
			# wait a bit before queue_free to show the dmg number
		defeated = true
		$attack_reach/CollisionShape2D.disabled = true
		$hurtbox/CollisionShape2D2.disabled = true
		$Sprite2D.visible = false
		await get_tree().create_timer(0.7).timeout
		queue_free()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		seek_target(body)
	if target == null and body is Rival:
		seek_target(body)

var attacking: bool = false
func _on_attack_reach_body_entered(body: Node2D) -> void:
	if body is Player and GlobalData.attacking == false:
		attack_player(body)
		pass

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is Explosion:
		take_damage(area.damage, area.source, area.color)
		GlobalGameManager.explosion_hits_mob.emit(global_position)
		AudioGlobal.play_sound("magic_explosion2", -20.0)
	#	print("explosion hit")
	if area is AoE:
		take_damage(area.damage, area.source, area.color)
		GlobalGameManager.explosion_hits_mob.emit(global_position)
	#	print("AoE hit")
