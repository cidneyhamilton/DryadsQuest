############
# Music.gd
###########

extends AudioStreamPlayer2D

const AUDIO_PATH = "res://assets/audio"

func _ready() -> void:
	Main.connect("play_music", self, "play_clip")

# Changes the background music
func play_clip(clip_name) -> void:
	var file = AUDIO_PATH + "/" + clip_name + ".ogg"
	print("Switching to " + file)
	if File.new().file_exists(file):
		var music = load(file)
		stream = music
		play()
