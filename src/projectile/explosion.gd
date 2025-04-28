class_name Explosion extends Area2D

var radius: int
var damage: int
var color: Color
@onready var collision_circle = $CollisionShape2D

@export var source: CharacterBody2D

func _ready() -> void:
	$AnimationPlayer.play("explosion")



func _physics_process(delta: float) -> void:
	if collision_circle.shape.radius < radius:
		collision_circle.shape.radius += 40 * delta
	else:
		queue_free()
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		if is_instance_valid(source):
			if body is Mob:
				body.take_damage(damage, source, color)
				
				GlobalGameManager.explosion_hits_mob.emit(body.global_position)
				print_debug("explosion hit")



func _on_timer_timeout() -> void:
	queue_free()
