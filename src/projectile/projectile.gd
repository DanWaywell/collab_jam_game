extends Area2D


var speed = 80.0
var direction = Vector2.RIGHT
var damage = 1



func _ready() -> void:
	AudioGlobal.play_sound("magic_projectile2", -20.0)
	look_at(position + direction)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
