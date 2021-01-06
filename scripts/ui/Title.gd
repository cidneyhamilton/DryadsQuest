##################
# Title.gd
##################

extends CanvasLayer

onready var container = get_node("Container")

func _ready() -> void:
	# Show the UI again when the game is finished
	Main.connect("finished_game", self, "_on_finished_game")
	
# Called to bring the title screen back up after the game is finished
func _on_finished_game()-> void:
	title_music()
	container.show()

# Start a new game
func _on_StartButton_pressed() -> void:
	sfx()
	game_music()
	container.hide()
	Main.emit_signal("started_game")

# Toggle the Settings menu
func _on_SettingsButton_pressed() -> void:
	sfx()
	Main.emit_signal("show_settings")

# Quit the game
func _on_QuitButton_pressed() -> void:
	sfx()
	get_tree().quit()

func sfx() -> void:
	Main.emit_signal("play_sfx", "button-press")

func title_music() -> void:
	# print("Switch to title track.")
	Main.emit_signal("play_title")
	
func game_music() -> void:
	# print("Switch to game loop track.")
	Main.emit_signal("play_game")
