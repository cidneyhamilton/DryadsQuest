##############
# Score.gd
##############

extends Control

var value = 0
var max_value = 0

onready var label = get_node("Container/Label")

func _ready():
	Main.connect("plant_resurrected", self, "_on_plant_resurrected")
	Main.connect("started_game", self, "set_max_score")
	
func _on_plant_resurrected():
	update_score()
	
func set_max_score():
	if max_value == 0:
		max_value = get_tree().get_nodes_in_group("plants").size()
	update_score_label()
	
func update_score():
	value += 1
	update_score_label()
	# TODO: End the game if reached max score

func update_score_label():
	label.text = "Score: " + str(value) + " out of " + str(max_value)
	
