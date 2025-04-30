extends Node




func _ready() -> void:
	GlobalGameManager.enemy_killed_by_rival.connect(cheers)
	GlobalGameManager.explosion_hits_player.connect(cheers)
	GlobalGameManager.kill_combo_streak.connect(boo)

func cheers(_value):
	if _value is int:
		if _value > 2:
			AudioGlobal.play_sound_voices("pos_crowd_ole")
	AudioGlobal.play_sound_voices("pos_crowd_small_fade")

func boo(_value):
	AudioGlobal.play_sound_voices("neg_crowd_middle")
	pass
