extends Button

func _on_Back_pressed() -> void:
	sfx()
	Main.emit_signal("finished_game")
	
# Play a button effect
func sfx() -> void:	
	Main.emit_signal("play_sfx", "button-press")
