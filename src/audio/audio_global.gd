class_name AudioManager extends Node
## how to use:

# whenever you want to play a sound, use
# AudioGlobal.play_sound(soundfilename)
#
# for music switching/fading :
# load music tracks into $AudioStreamPlayer Interactive Stream

# edit Transitions
# best options :
# Immediate, Cross Fade, Transition to same position (or start)
#edit Stream Names for STATE

# to change music :
# AudioGlobal.set_music_state(AudioGlobal.STATE.STATENAME)

#---------------------------------------------------------------
# Sound Effects
## holds sound files
@export var sfx : Array[Resource]
@export var sfx_voices: Array [Resource]

## number of sound players
@export var sfx_player_number := 4
@export var sfx_player_number2 := 4
## stores sound players while playing
@onready var effect_node = $sounds
@onready var effect_node2 = $sounds2

func _ready() -> void:
	for i in sfx_player_number:
		var stream = AudioStreamPlayer.new()
		stream.bus = "sound" 
		effect_node.add_child(stream)
	for e in sfx_player_number2:
		var stream2 = AudioStreamPlayer.new()
		stream2.bus = "sound"
		effect_node2.add_child(stream2)


func play_sound_voices(play_sound_name: String, db: float = 0.0) -> void:
	for i in sfx_voices.size():
		var sound = sfx_voices[i]
		var sound_name = sound.resource_path.get_file().get_basename()
		if sound_name == play_sound_name:
			var player: AudioStreamPlayer = effect_node2.get_child(0)
			player.stream = sound
			player.volume_db = db
			player.play()
			effect_node2.move_child(player, sfx_player_number2 - 1)
			break
			
	
func play_sound(play_sound_name : String, db: float = 0.0) -> void:
	for i in sfx.size():
		var sound = sfx[i]
		var sound_name = sound.resource_path.get_file().get_basename()
		if sound_name == play_sound_name:
			var player: AudioStreamPlayer = effect_node.get_child(0)
			player.stream = sound
			player.volume_db = db
			player.play()
			effect_node.move_child(player, sfx_player_number - 1)
			break
			

#---------------------------------------------------------------
## Music 
# States with fading for different occasions
# just change the state to fade to the right track!
# music files in audio_player need to be named like this 
#OPENINGmusic, MAINMENUmusic etc. in the interactive Stream

enum  STATE {
OPENING,
MAINMENU,
FIGHT,
DIALOGUE,
}

@onready var music_player = $AudioStreamPlayer

var music_state = STATE.OPENING
var previous_state
func set_music_state(curr_state):
	music_state = curr_state
	match music_state:
		STATE.MAINMENU:
			if music_player.stream_paused == true:
				music_player.stream_paused = false
			var music:String = str(STATE.keys()[music_state]) + "music"
			music_player["parameters/switch_to_clip"] = music
			previous_state = curr_state # updates previous state in case of combat
			pass
		STATE.OPENING:
			if music_player.stream_paused == true:
				music_player.stream_paused = false
			var music:String = str(STATE.keys()[music_state]) + "music"
			music_player["parameters/switch_to_clip"] = music
			previous_state = curr_state # updates previous state in case of combat
			pass
		STATE.FIGHT:
			if music_player.stream_paused == true:
				music_player.stream_paused = false
			var music:String = str(STATE.keys()[music_state]) + "music"
			music_player["parameters/switch_to_clip"] = music
			previous_state = curr_state # updates previous state in case of combat
			pass
		STATE.DIALOGUE:
			if music_player.stream_paused == true:
				music_player.stream_paused = false
			var music:String = str(STATE.keys()[music_state]) + "music"
			music_player["parameters/switch_to_clip"] = music
			previous_state = curr_state # updates previous state in case of combat
			pass
