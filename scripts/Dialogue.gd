extends CanvasLayer

enum { HIDDEN, SHOWN}
var state = SHOWN

func _input(event ):
	if event is InputEventMouseButton and event.pressed and state == SHOWN:
		hide_me()
		
func _ready():
	Main.connect("finished_speaking", self, "_on_finished_speaking")
	Main.connect("started_speaking", self, "_on_started_speaking")
		
func _on_finished_speaking():
	hide_me()
	
func _on_started_speaking(line):
	show(line)
	
func hide_me():
	state = HIDDEN
	$ColorRect/Message.text = ""
	
func show(line):
	state = SHOWN
	$ColorRect/Message.text = line
	

