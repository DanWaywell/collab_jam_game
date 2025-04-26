
class_name AoE extends Area2D

var radius: int = 32
var damage: int = 1
var color: Color = Color.WEB_PURPLE
@onready var collision_circle = $CollisionShape2D

@export var source: CharacterBody2D

func _ready() -> void:
	AudioGlobal.play_sound("magic_projectile2", -20.0) #TODO aoe sound
	$AnimationPlayer.play("explosion")

func fire():
	pass

func explosion():
	$AnimationPlayer.play("explosion")
	@warning_ignore("unused_variable")
	var tween1 = create_tween().tween_property(collision_circle.shape, "radius", radius, 0.33 )

func implosion():
	$AnimationPlayer.play("implosion")
	@warning_ignore("unused_variable")
	var tween2 = create_tween().tween_property(collision_circle.shape, "radius", 1, 0.33 )
	
	
