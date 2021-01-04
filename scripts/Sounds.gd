##############
# Sounds.gd
##############

extends AudioStreamPlayer2D

const AUDIO_PATH = "res://assets/audio"

# Plays an arbitrary audio clip
func play_clip(clip_name):
	var file = AUDIO_PATH + "/" + clip_name + ".wav"
	if File.new().file_exists(file):
		var sfx = load(file)
		sfx.set_loop(false)		
		stream = sfx
		play()
		
	
	
