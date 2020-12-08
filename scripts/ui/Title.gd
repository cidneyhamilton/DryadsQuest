##################
# Title.gd
##################

extends CanvasLayer

onready var container = get_node("Container")
onready var sfx = get_node("SFX")

# Called to bring the title screen back up after the game is finished
func _on_finished_game():
	container.show()

# Start a new game
func _on_StartButton_pressed():
	sfx.play()
	container.hide()
	Main.emit_signal("started_game")

# Toggle the Settings menu
func _on_SettingsButton_pressed():
	sfx.play()
	Main.emit_signal("show_settings")

# Quit the game
func _on_QuitButton_pressed():
	sfx.play()
	get_tree().quit()
