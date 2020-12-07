extends AudioStreamPlayer2D

var path_to_audio = "res://assets/audio"

func play_clip(clip_name):
	var file = path_to_audio + "/" + clip_name + ".wav"
	if File.new().file_exists(file):
		var sfx = load(file)
		sfx.set_loop(false)
		
		stream = sfx
		play()
		
	
	
