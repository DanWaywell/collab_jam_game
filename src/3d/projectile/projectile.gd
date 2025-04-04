extends Area3D

var direction = Vector3()
var speed = 5.0
var life_time = 5.0

var damage = 1

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = life_time
	look_at(global_position + direction, Vector3.UP)


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
