extends Node2D

func _input(event):
	Input.set_mouse_mode(Input.CURSOR_IBEAM)
	self.position.x = event.position.x
	self.position.y = event.position.y
