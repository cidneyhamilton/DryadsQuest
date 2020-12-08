extends CanvasLayer

onready var container = get_node("Container")
onready var sfx = get_node("SFX")

func _ready():
	Main.connect("show_settings", self, "show")
	hide()
	
# Called to bring the title screen back up after the game is finished
func show():
	container.show()
	
func hide():
	container.hide()

func _on_BackButton_pressed():
	sfx.play()
	hide()
