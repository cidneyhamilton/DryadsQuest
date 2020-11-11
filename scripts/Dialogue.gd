##############
# Dialogue.gd
##############

extends CanvasLayer

# Various states of the dialogue display 
enum { HIDDEN, SHOWN}
var state = SHOWN

# Reference to the Speech text message
onready var message = get_node("ColorRect//Message")

func _input(event ):
	# Hide the dialogue view after a mouse click 
	if event is InputEventMouseButton and event.pressed and state == SHOWN:
		hide_me()
		
func _ready():
	# Connect speaking events 
	Main.connect("finished_speaking", self, "_on_finished_speaking")
	Main.connect("started_speaking", self, "_on_started_speaking")
	
# Hide the dialogue after speech text is finished	
func _on_finished_speaking():
	hide_me()
	
func _on_started_speaking(line):
	show(line)

# Hide the dialogue message
func hide_me():
	state = HIDDEN
	message.text = ""

# Show a line of dialogue
func show(line):
	state = SHOWN
	message.text = line
	

