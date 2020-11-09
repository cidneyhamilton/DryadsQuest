extends Node2D

signal plant_resurrected

enum { DEAD, ALIVE}

var state = DEAD
var num_resurrected_plants = 0
var max_resurrected_plants = 1 # TODO: Set this dynamically

onready var animator = get_node("IslandSprite")
	
func _on_Plant_resurrected():
	num_resurrected_plants += 1
	emit_signal("plant_resurrected")
	if num_resurrected_plants == max_resurrected_plants:
		resurrect()
		
func resurrect():
	state = ALIVE
	animator.play("live")	
