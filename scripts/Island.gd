##############
# Island.gd
##############

extends Node2D

# The various states of the island
enum IslandState { UNAVAILABLE, DEAD, IRRIGATING, HAS_WATER, REVIVING, ALIVE}

export(IslandState) var state = IslandState.UNAVAILABLE

var num_resurrected_mangroves = 0
var max_mangroves = 0

var num_resurrected_plants = 0
var max_resurrected_plants = 0

var plants = []

onready var animator = get_node("IslandSprite")
	
func _ready():
	for child in get_children():
		if child is Plant:
			plants.append(child)
	for plant in plants:
		if plant.is_mangrove():
			max_mangroves += 1
		else:
			max_resurrected_plants += 1
	
	animator.play("dead")
	Main.connect("plant_resurrected", self, "_on_Plant_resurrected")
	
func _on_Plant_resurrected():
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

func make_available():
	state = IslandState.DEAD
	
func start_irrigating():
	start_animation(IslandState.DEAD, IslandState.IRRIGATING, "irrigating")
	
func start_reviving():
	start_animation(IslandState.HAS_WATER, IslandState.REVIVING, "reviving")
		
func start_animation(old_state, new_state, animation):
	if state == old_state:
		animator.play(animation)
		state = new_state
	
func is_unavailable():
	return state == IslandState.UNAVAILABLE
	
func is_dead():
	return state == IslandState.DEAD
	
func is_watered():
	return state == IslandState.HAS_WATER
	
func is_alive():
	return state == IslandState.ALIVE

func _on_IslandSprite_animation_finished():
	if (animator.animation == "reviving"):
		animator.animation = "live"
		state = IslandState.ALIVE
		Main.emit_signal("island_healed")
	if (animator.animation == "irrigating"):
		state = IslandState.HAS_WATER
		animator.animation = "irrigated"
