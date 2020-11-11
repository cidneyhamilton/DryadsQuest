##############
# Lagoon.gd
##############

extends Node2D

var num_islands
var current_island = 0

onready var islands = get_node("Islands").get_children()

func _ready():
	num_islands = islands.size()
	Main.connect("island_healed", self, "_on_island_healed")
	
func _on_island_healed():
	print("Incrementing current island.")
	current_island += 1
	if current_island < num_islands:
		islands[current_island].make_available()
	else:
		# Do game over handling
		Main.emit_signal("finished_game")
