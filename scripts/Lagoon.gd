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
	speak("start")
	
func _on_island_healed():
	print("Incrementing current island.")
	current_island += 1
	if current_island < num_islands:
		islands[current_island].make_available()
	else:
		# Do game over handling
		sound.play()
		speak("gameover")
		Main.emit_signal("finished_game")
		
func speak(line):
	Main.emit_signal("started_speaking", line)
