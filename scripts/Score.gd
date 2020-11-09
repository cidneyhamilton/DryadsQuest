extends Control

var value = 0
var max_value = 1

func _on_Lagoon_plant_resurrected():
	update_score()
	
func update_score():
	value += 1
	$Label.text = "Score: " + str(value) + " out of " + str(max_value)
	
	# TODO: End the game if reached max score
