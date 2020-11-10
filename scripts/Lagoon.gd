extends Node2D

var islands = []
var current_island = 0

func _ready():
	islands = $Islands.get_children()
	Main.connect("island_healed", self, "_on_island_healed")
	
func _on_island_healed():
	current_island += 1
	islands[current_island].make_available()
