extends Node2D

enum { DEAD, ALIVE}

var state = DEAD
var num_resurrected_plants = 0
var max_resurrected_plants = 1 
var plants

onready var animator = get_node("IslandSprite")
	
func _ready():
	plants = get_tree().get_nodes_in_group("plants")
	max_resurrected_plants = plants.size()
	
	Main.connect("plant_resurrected", self, "_on_Plant_resurrected")
	
func _on_Plant_resurrected():
	num_resurrected_plants += 1
	if num_resurrected_plants == max_resurrected_plants:
		resurrect()
	
func resurrect():
	state = ALIVE
	animator.play("live")	
