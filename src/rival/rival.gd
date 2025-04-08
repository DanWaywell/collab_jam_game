class_name Rival extends CharacterBody2D

var speed = 50.0

#const PROJECTILE = preload("res://projectile/projectile.tscn")
var direction_facing = Vector2.RIGHT

var health = 3

@onready var sprite: Sprite2D = $Sprite2D
var current_target: Mob

func _ready() -> void:
	GlobalGameManager.enemy_killed_by_rival.connect(enemy_killed)
	GlobalGameManager.enemy_killed_by_player.connect(enemy_killed)
	GlobalGameManager.mob_spawned.connect(target_spotted)
	pass
	
	

var targets: Array [Mob]
# new enemies get signalled on spawn/ready
# if another target is near (entered area2D) target changes
func target_spotted(new_target: Mob):
	targets.append(new_target)
	if current_target == null:
		print("target_spotted: new target, target was null")
		current_target = new_target
		check_append_to_targets(new_target)
	else:
		check_append_to_targets(new_target)
	pass

func check_append_to_targets(new_target):
	if targets.has(new_target):
		pass
	else:
		targets.append(new_target)
	
func check_append_to_near_targets(new_target):
	if target_in_reach.has(new_target):
		pass
	else:
		target_in_reach.append(new_target)
		
func change_target(near_target: Mob):
	check_append_to_targets(near_target)
	if current_target == null:
		print("change_target: target was null")
		current_target = near_target
		return
	else:
		await get_tree().create_timer(0.3).timeout
		current_target = near_target
		print("change_target: new near target")

		
func attack():
	if attacking == false:
		if current_target:
			if target_in_reach.has(current_target):
				if current_target.health > 0:
					print("Rival damaged Mob")
					current_target.take_damage(1,self)
					attacking = true
					#await get_tree().create_timer(0.8).timeout
					attack()
					return
	else:
		await get_tree().create_timer(0.8).timeout
		attacking = false
		attack()


func enemy_killed(enemy: Mob):
	if current_target == enemy:
		target_in_reach.erase(enemy)
		targets.erase(enemy)
		print(target_in_reach)
		if targets.size() > 0:
			current_target = targets.back()
		else:
			current_target = null
		

func stroll():
	pass


func _physics_process(_delta: float) -> void:
	var input_direction
	if current_target:
		### debug prints -> globalgamemanager, delete later TODO
		GlobalGameManager.debug_overlay.current_target_rival.text = str(current_target.name)
		input_direction = current_target.position - position
		
	else:
		input_direction = Vector2.ZERO

	var move_direction = input_direction.normalized()

	# Movement x y
	if move_direction:
		velocity = move_direction * speed
		#velocity.x = move_toward(velocity.x, move_direction.x * speed * input_direction.length(), ACCELERATION)
		#velocity.y = move_toward(velocity.y, move_direction.y * speed * input_direction.length(), ACCELERATION)
	else:
		velocity = Vector2.ZERO
		#velocity.x = move_toward(velocity.x, 0, DECELERATION)
		#velocity.y = move_toward(velocity.y, 0, DECELERATION)

	move_and_slide()
	
	set_direction_facing(input_direction)
	set_sprite()
	check_health()
	
	

	

	
	#if Input.is_action_just_pressed("action_1"):
		#fire_projectile()
	#
	#
#func fire_projectile():
	#var new_projectile = PROJECTILE.instantiate()
	#new_projectile.position = position
	#new_projectile.direction = direction_facing
	#add_sibling(new_projectile)


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
#	if direction_facing == Vector2.UP:
#		sprite.frame = 0
#	elif direction_facing == Vector2.RIGHT:
#		sprite.frame = 3
#	elif direction_facing == Vector2.DOWN:
#		sprite.frame = 1
#	elif direction_facing == Vector2.LEFT:
#		sprite.frame = 2
#	else:
		pass


var last_hit_source: CharacterBody2D
func take_damage(damage, source: CharacterBody2D):
	if source != Player1:
		#for testing
		health -= damage
		last_hit_source = source


func check_health():
	if health < 1:
#		if last_hit_source is Player1:
#			GlobalGameManager.count_kills()
		#if last_hit_source is Rival:
		queue_free()

var target_in_reach:Array [Mob]
func _on_enemy_area_body_entered(body: Node2D) -> void:
	if body is Mob:
		change_target(body)
	pass # Replace with function body.

var attacking:bool = false
func _on_attack_reach_body_entered(body: Node2D) -> void:
	if body is Mob:
		check_append_to_near_targets(body)
		attack()
	pass # Replace with function body.


func _on_attack_reach_body_exited(body: Node2D) -> void:
	if body is Mob:
		if target_in_reach.has(body):
			target_in_reach.erase(body)
	pass # Replace with function body.
