extends Node2D

enum IslandState { UNAVAILABLE, DEAD, HAS_WATER, ALIVE}

export(IslandState) var state = IslandState.UNAVAILABLE

var num_resurrected_mangroves = 0
var max_mangroves = 0

var num_resurrected_plants = 0
var max_resurrected_plants = 0

var plants

onready var animator = get_node("IslandSprite")
	
func _ready():
	plants = get_tree().get_nodes_in_group("plants")
	for plant in plants:
		if plant.is_mangrove():
			max_mangroves += 1
		else:
			max_resurrected_plants += 1
	
	Main.connect("plant_resurrected", self, "_on_Plant_resurrected")
	
func _on_Plant_resurrected():
	if state == IslandState.DEAD:
		num_resurrected_mangroves += 1
		if num_resurrected_mangroves == max_mangroves:
			make_watered()
	elif state == IslandState.HAS_WATER:
		num_resurrected_plants += 1
		if num_resurrected_plants == max_resurrected_plants:
			make_alive()
	
func make_available():
	state = IslandState.DEAD
	
func make_watered():
	state = IslandState.HAS_WATER
	# animator.play("live")	
	
func make_alive():
	state = IslandState.ALIVE
	animator.play("live")	
	# TODO: Increment the island
	Main.emit_signal("island_healed")
	
func is_unavailable():
	return state == IslandState.UNAVAILABLE
	
func is_dead():
	return state == IslandState.DEAD
	
func is_watered():
	return state == IslandState.HAS_WATER
	
func is_alive():
	return state == IslandState.ALIVE
