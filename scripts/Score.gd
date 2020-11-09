extends Control

var value = 0
# TODO: when can this be set?
var max_value = 3 # max_value = get_tree().get_nodes_in_group("plants").size()

func _ready():
	Main.connect("plant_resurrected", self, "_on_plant_resurrected")
	
func _on_plant_resurrected():
	update_score()
	
func update_score():
	value += 1
	
	
	$Label.text = "Score: " + str(value) + " out of " + str(max_value)
	
	# TODO: End the game if reached max score
