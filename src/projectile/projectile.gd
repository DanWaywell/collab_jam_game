extends Area2D


var speed = 80.0
var direction = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
