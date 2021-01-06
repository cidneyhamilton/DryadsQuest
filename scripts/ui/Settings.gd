##############
# Settings.gd
##############

extends CanvasLayer

onready var container = get_node("Container")

func _ready() -> void:
	Main.connect("show_settings", self, "show")
	hide()
	
# Called to bring the title screen back up after the game is finished
func show() -> void:
	container.show()
	
func hide() -> void:
	container.hide()

func _on_BackButton_pressed() -> void:
	sfx()
	hide()

func sfx() -> void:
	Main.emit_signal("play_sfx", "button-press")
