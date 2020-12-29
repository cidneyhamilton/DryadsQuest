##############
# Lagoon.gd
##############

extends Node2D

var num_islands
var current_island = 0

onready var islands = get_node("Islands").get_children()
onready var sound = get_node("Sound")

func _ready():
	num_islands = islands.size()
	Main.connect("island_healed", self, "_on_island_healed")
	Main.connect("started_game", self, "_on_started_game")
	
func _on_started_game():
	start_text()
	
func _on_island_healed():
	# Incrementing current island
	current_island += 1
	if current_island < num_islands:
		islands[current_island].make_available()
	else:
		# Do game over handling
		sound.play()
		gameover_text()
		Main.emit_signal("finished_game")
		
func speak(line):
	Main.emit_signal("started_speaking", line)
	
func start_text():
	var lines = []
	lines.append("The city of Cocoa, Florida, USA. 2048.")
	lines.append("Where... where am I?")
	lines.append("What happened?")
	lines.append("I am the Dryad of the Indian River Lagoon...")
	lines.append("...but I live on the edge of the coastline.")
	lines.append("...now I'm... stuck... on an island?")
	lines.append("...the path around me, underwater?")
	lines.append("Everything here is dead.")
	lines.append("What happened?")
	speak(lines)
	
func gameover_text():
	var lines = []
	lines.append("YES! Yes! I've healed every plant on this loop of islands.")
	lines.append("My powers are exhausted... but with the beginning of an ecosystem, life can return to the lagoon.")
	lines.append("Seagrass, fish, dolphins, manatees...")
	lines.append("The people may be all gone, retreated inland. There are only these tiny islands.")
	lines.append("But for now, the islands can breathe.")
	speak(lines)

