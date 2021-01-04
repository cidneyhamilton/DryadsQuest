##################
# Title.gd
##################

extends CanvasLayer

onready var container = get_node("Container")
onready var sfx = get_node("SFX")

func _ready() -> void:
	# Show the UI again when the game is finished
	Main.connect("finished_game", self, "_on_finished_game")
	
# Called to bring the title screen back up after the game is finished
func _on_finished_game()-> void:
	container.show()

# Start a new game
func _on_StartButton_pressed() -> void:
	sfx.play()
	container.hide()
	Main.emit_signal("started_game")

# Toggle the Settings menu
func _on_SettingsButton_pressed() -> void:
	sfx.play()
	Main.emit_signal("show_settings")

# Quit the game
func _on_QuitButton_pressed() -> void:
	sfx.play()
	get_tree().quit()
