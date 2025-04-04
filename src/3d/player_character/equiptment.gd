extends Node3D

const PROJECTILE = preload("res://3d/projectile/projectile.tscn")


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("action_1"):
		shoot_projectile(PROJECTILE, get_projectile_direction())


func shoot_projectile(projectile, direction):
	var new_projectile = projectile.instantiate()
	new_projectile.direction = direction
	get_parent().add_sibling(new_projectile)
	new_projectile.global_position = get_parent().global_position + Vector3(0, 0.5, 0)


func get_projectile_direction():
	# get point by firing a ray from the camera
	var camera = $"../../ArenaCamera/Camera3D"
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 100
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collision_mask ############
	#ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	var point = raycast_result.position
	
	# Get direction from point and player position
	var dir = point - get_parent().global_position
	dir.y = 0.0
	dir = dir.normalized()
	return dir
