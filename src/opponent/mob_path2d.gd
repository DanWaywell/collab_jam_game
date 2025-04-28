extends PathFollow2D

func _ready() -> void:
	var rand_prog = randf_range(0.0,1.0)
	progress_ratio = rand_prog


func _process(delta: float) -> void:
	var rand = randi_range(60,100)
	progress += rand * delta
