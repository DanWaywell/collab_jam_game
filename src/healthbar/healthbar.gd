extends CanvasLayer
@onready var top: Sprite2D = $top
@onready var mid_1: Sprite2D = $mid1
@onready var mid_2: Sprite2D = $mid2
@onready var mid_3: Sprite2D = $mid3
@onready var bottom: Sprite2D = $bottom

func _ready() -> void:
	GlobalGameManager.player_takes_damage.connect(update)
	GlobalGameManager.player_hp.connect(update)

func update():
	var hp = GlobalData.health
	if hp == 15:
		top.frame = 0
		mid_1.frame = 0
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 14:
		top.frame = 1
		mid_1.frame = 0
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 13:
		top.frame = 2
		mid_1.frame = 0
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 12:
		top.frame = 3
		mid_1.frame = 0
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 11:
		top.frame = 3
		mid_1.frame = 1
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 10:
		top.frame = 3
		mid_1.frame = 2
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 9:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 0
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 8:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 1
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 7:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 2
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 6:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 0
		bottom.frame = 0
	if hp == 5:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 1
		bottom.frame = 0
	if hp == 4:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 2
		bottom.frame = 0
	if hp == 3:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 3
		bottom.frame = 0
	if hp == 2:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 3
		bottom.frame = 1
	if hp == 1:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 3
		bottom.frame = 2
	if hp == 0:
		top.frame = 3
		mid_1.frame = 3
		mid_2.frame = 3
		mid_3.frame = 3
		bottom.frame = 3
