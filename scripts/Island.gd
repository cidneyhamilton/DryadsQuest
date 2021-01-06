##############
# Island.gd
##############

extends Node2D
class_name Island

# The various states of the island
enum IslandState { UNAVAILABLE, DEAD, IRRIGATING, HAS_WATER, REVIVING, ALIVE}

# The island's default state; usually unavailable
export(IslandState) var state = IslandState.UNAVAILABLE

# Keep track of the current and max number of resurrected mangroves
var num_resurrected_mangroves : int = 0
var max_mangroves : int = 0

# Keep track of the current and max number of resurrected plants
var num_resurrected_plants : int = 0
var max_resurrected_plants : int = 0

# Array of plants tied to this island
var plants = []

# Reference to the animator
onready var animator = get_node("IslandSprite")
	
func _ready() -> void:
	Main.connect("plant_resurrected", self, "_on_Plant_resurrected")
	Main.connect("started_game", self, "_on_started_game")

# Callback when finishing an animation
func _on_IslandSprite_animation_finished() -> void:
	if (animator.animation == "reviving"):
		animator.animation = "live"
		state = IslandState.ALIVE
		Main.emit_signal("island_healed")
	if (animator.animation == "irrigating"):
		state = IslandState.HAS_WATER
		animator.animation = "irrigated"

func _on_started_game() -> void:
	reset_island_state()
	
func _on_Plant_resurrected() -> void:
	if is_dead():
		num_resurrected_mangroves += 1
		print("Resurrected: " + str(num_resurrected_mangroves) + " mangroves, need to resurrect: " + str(max_mangroves))
		if num_resurrected_mangroves == max_mangroves:
			start_irrigating()
	elif is_watered():
		num_resurrected_plants += 1
		print("Resurrected: " + str(num_resurrected_plants) + " land plants, need to resurrect: " + str(max_resurrected_plants))
		if num_resurrected_plants == max_resurrected_plants:
			start_reviving()
			show_revival_text()

func reset_island_state():	
	plants.clear()
	num_resurrected_mangroves = 0
	max_mangroves = 0
	num_resurrected_plants = 0
	max_resurrected_plants = 0
	
	for child in get_children():
		if child is Plant:
			plants.append(child)
	for plant in plants:
		if plant.is_mangrove():
			max_mangroves += 1
		else:
			max_resurrected_plants += 1

	# Play the island's Dead state
	animator.play("dead")
	
func show_revival_text() -> void:
	Main.islands_healed = Main.islands_healed + 1
	var count = Main.islands_healed
	if (count== 1):
		var lines = []
		lines.append("I've healed the mangroves around me, and the tree...")
		lines.append("...but wait, what is this?")
		speak(lines)
	elif count == 3:
		speak("The lagoon is beginning to return to life. But there's still more work to be done.")
	elif (count == 5):
		speak("Yes! Yes! I'm almost done.")

# Immediately make the island dead
func make_available() -> void:
	state = IslandState.DEAD

func make_unavailable() -> void:
	state = IslandState.UNAVAILABLE
	
# Start irtigation animation
func start_irrigating() -> void:
	start_animation(IslandState.DEAD, IslandState.IRRIGATING, "irrigating")

# Start revival animation
func start_reviving() -> void:
	start_animation(IslandState.HAS_WATER, IslandState.REVIVING, "reviving")

# Start an arbitrary animation
func start_animation(old_state, new_state, animation) -> void:
	if state == old_state:
		animator.play(animation)
		state = new_state

# Check if unavailable
func is_unavailable() -> bool:
	return state == IslandState.UNAVAILABLE

# Check island state
func is_dead() -> bool:
	return state == IslandState.DEAD

# Check island state
func is_watered() -> bool:
	return state == IslandState.HAS_WATER

# Check island state
func is_alive() -> bool:
	return state == IslandState.ALIVE

# Speak a line
func speak(line):
	Main.emit_signal("started_speaking", line)
