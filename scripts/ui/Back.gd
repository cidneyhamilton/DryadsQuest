extends Button

# The sound effect played when the button is clicked
onready var sfx = get_node("SFX")

func _on_Back_pressed():
	# Play a button effect
	sfx.play()
	
	# TODO: Play a clicking sound effect
	Main.emit_signal("finished_game")
