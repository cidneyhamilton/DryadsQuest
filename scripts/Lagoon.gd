extends Node2D

signal plant_resurrected

func _on_Island_plant_resurrected():
	emit_signal("plant_resurrected")
