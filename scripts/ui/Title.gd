##############
# Title.gd
##############

extends CanvasLayer

onready var start_button = get_node("StartButton")
onready var background = get_node("PanelContainer")

# func _ready():
	# Main.connect("finished_game", self, "_on_finished_game")
	
func _on_StartButton_pressed():
	background.hide()
	start_button.hide()
	Main.emit_signal("started_game")
	
func _on_finished_game():
	background.show()
	start_button.show()
