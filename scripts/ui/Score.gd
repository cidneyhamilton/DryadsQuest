##############
# Score.gd
##############

extends Control

var value = 0
var max_value = 0

onready var label = get_node("Container/Label")

func _ready():
	Main.connect("plant_resurrected", self, "_on_plant_resurrected")

func _on_plant_resurrected():
	update_score()
	
func set_max_score():
	if max_value == 0:
		max_value = get_tree().get_nodes_in_group("plants").size()
		print("Max value: " + str(max_value))
	
func update_score():
	set_max_score()
	value += 1
	
	label.text = "Score: " + str(value) + " out of " + str(max_value)
	
	# TODO: End the game if reached max score
