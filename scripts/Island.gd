extends Node2D

signal plant_resurrected
signal plant_targeted
signal spell_finished

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

func _on_Plant_targeted():
	emit_signal("plant_targeted")
	
func resurrect():
	state = ALIVE
	animator.play("live")	

func _on_Lagoon_spell_finished():
	emit_signal("spell_finished")
