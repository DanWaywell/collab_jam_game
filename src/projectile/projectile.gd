extends Area2D


var speed = 80.0
var direction = Vector2.RIGHT
var damage = 1
var color: Color

@export var source: CharacterBody2D

func _ready() -> void:
	AudioGlobal.play_sound("magic_projectile2", -25.0)
	look_at(position + direction)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		if is_instance_valid(source):
			body.take_damage(damage, source, color)
			if body is Mob:
				GlobalGameManager.projectile_hits_mob.emit(body.global_position)
	
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
