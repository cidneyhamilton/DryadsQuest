##############
# Plant.gd
##############

class_name Plant

extends Area2D

# Various states the plant can be in
enum PlantState { DEAD, RESURRECTING, ALIVE}

# Types of plants
enum PlantType { PINE, PALM, MANGROVE, FERN }

export(PlantType) var type

var state = PlantState.DEAD

onready var animator = get_node("PlantSprite")
	
func _ready() -> void:
	Main.connect("started_game", self, "reset_state")
	Main.connect("finished_lowering_arms", self, "_on_finished_lowering_arms")
	Main.connect("finished_spell", self, "_on_finished_spell")

# Handle events on this plant
func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click()

# Callback when a spell is finished		
func _on_finished_spell() -> void:
	if state == PlantState.RESURRECTING:
		# print("This plant is being resurrected; finish resurrecting it.")
		resurrect()

# Callback when the player's arm lowers
func _on_finished_lowering_arms() -> void:
	if state == PlantState.RESURRECTING:
		# print("This plant is still being flagged as resurrecting, even though her arms are lowered.")
		state = PlantState.DEAD 
		
# After the growing animation is finished, make sure the plant remains alive
func _on_PlantSprite_animation_finished() -> void:
	if (animator.animation == "grow"):
		animator.animation = "live"
		Main.emit_signal("plant_resurrected")

func reset_state() -> void:
	state = PlantState.DEAD
	animator.play("dead")
	
# Handles point and click behavior on plants
func on_click() -> void:
	var island = get_parent()
	if island.is_unavailable():
		speak("I can't reach those islands.")
	elif state == PlantState.RESURRECTING:
		# print("This is currently resurrecting; do nothing")
		return
	elif state == PlantState.ALIVE:
		speak("That plant is doing just fine now.")
	elif island.is_dead():
		if is_mangrove():
			if Main.is_first_mangrove_healed:
				speak("I can heal the mangrove with only a touch.")
			start_resurrect()
		else:
			speak("The land plants can't breathe on their own... they need the mangroves to protect the shoreline.")
	elif island.is_watered():
		start_resurrect()
	else:
		# print("State not found")
		pass

# Start resurrecting the plant
func start_resurrect() -> void:
	# Show a message if the plant is alive
	if state == PlantState.DEAD:
		state = PlantState.RESURRECTING
		Main.emit_signal("plant_targeted")
	elif state == PlantState.ALIVE:
		# print("Plant is already alive")
		pass
	else:
		# print("Plant trying to start resurrect on is being resurrected.")
		pass

# Returns true if this is a mangrove
func is_mangrove() -> bool:
	return type == PlantType.MANGROVE

# Starts resurrecting the plant
func resurrect() -> void:
	state = PlantState.ALIVE
	sfx()
	animator.play("grow")
	# TODO: Dialogue event

# Speaks a line
func speak(line) -> void:
	Main.emit_signal("started_speaking", line)

func sfx() -> void:
	Main.emit_signal("play_sfx", "powerup")

