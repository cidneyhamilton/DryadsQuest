##############
# Dialogue.gd
##############

extends CanvasLayer

# Various states of the dialogue display 
enum { HIDDEN, SHOWN}

var state = SHOWN

var lines = []

# Reference to the Speech text message
onready var message = get_node("Container//Message")

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

func can_continue():
	return !lines.empty()
	
# Shows the next line of dialogue
# In Ink, this would be Story.Continue()
# For now, use a queue of lines
func next_line(new_lines):
	lines = new_lines
	return lines.pop_front()
	
# Hide the dialogue message
func hide_me():
	if can_continue():
		message.text = next_line(lines)
	else:
		state = HIDDEN
		message.text = ""
		# If the game is over, finish the game, otherwise, go back to playing as normal.
		if Main.is_game_over:
			Main.emit_signal("play_sfx", "gameover")
			Main.emit_signal("finished_game")
		

func show(text):
	if text is Array:
		show_lines(text)
	else:
		show_line(text)

# Show a line of dialogue
# Input can either be one line, or an array of lines
func show_lines(lines: Array):
	message.text = next_line(lines)
	state = SHOWN

# Show a single line
func show_line(line: String):
	message.text = line
	state = SHOWN
