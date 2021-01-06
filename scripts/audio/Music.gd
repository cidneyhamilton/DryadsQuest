############
# Music.gd
###########

extends AudioStreamPlayer2D

export var title_loop : AudioStreamOGGVorbis
export var game_loop : AudioStreamOGGVorbis 

func _ready() -> void:	
	Main.connect("play_title", self, "play_title")
	Main.connect("play_game", self, "play_game")

# Changes the background music
func play_title() -> void:
	stream = title_loop
	play()
	
func play_game() -> void:
	stream = game_loop
	play()

