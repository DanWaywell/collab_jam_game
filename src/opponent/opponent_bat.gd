extends Mob

@onready var path: Path2D = $"../.."
@onready var source = $"../../.."

func spawn():
	pass

func attack_player(body: Player):
	pass

func _physics_process(_delta: float) -> void:
	var input_direction
	if source.target:
		input_direction= source.target.position - position
	else: input_direction = Vector2.ZERO

	set_direction_facing(input_direction)
	set_sprite()
