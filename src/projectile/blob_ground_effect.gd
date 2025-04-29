extends AoEopponent

@onready var timer: Timer = $Timer

func _ready() -> void:
	start()
	
	

func start():
	self.visible = true
	$AnimationPlayer.play("dmg_area")
	timer.start(6.0)
	enable()
	timer.timeout.connect(queue_free)
	


func fire():
	pass
func enable():
	$CollisionShape2D.disabled = false
func explosion():
	$AnimationPlayer.play("explosion")
	@warning_ignore("unused_variable")
	var tween1 = create_tween().tween_property(collision_circle.shape, "radius", radius, 0.33 )

func implosion():
	$AnimationPlayer.play("implosion")
	@warning_ignore("unused_variable")
	var tween2 = create_tween().tween_property(collision_circle.shape, "radius", 1, 0.33 )
	
	
