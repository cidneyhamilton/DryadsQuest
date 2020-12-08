##############
# Title.gd
##############

extends CanvasLayer

onready var container = get_node("Container")
onready var sfx = get_node("SFX")

# Called to bring the title screen back up after the game is finished
func _on_finished_game():
	container.show()

# Handle button presses
func _on_StartButton_pressed():
	sfx.play()
	print("Started game")
	container.hide()
	Main.emit_signal("started_game")
	
func _on_SettingsButton_pressed():
	sfx.play()
	Main.emit_signal("show_settings")

func _on_QuitButton_pressed():
	sfx.play()
	get_tree().quit()
