##############
# Sounds.gd
##############

extends AudioStreamPlayer2D

export var button_press : AudioStreamSample
export var gameover : AudioStreamSample
export var powerup : AudioStreamSample

func _ready() -> void:
	Main.connect("play_sfx", self, "play_clip")
	
# Plays an arbitrary audio clip
func play_clip(clip) -> void:
	if (clip == "button-press"):
		stream = button_press
	elif (clip == "gameover"):
		stream = gameover
	elif (clip == "powerup"):
		stream = powerup
	play()
	
	
