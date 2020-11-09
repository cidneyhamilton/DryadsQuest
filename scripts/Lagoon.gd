extends Node2D

signal plant_resurrected
signal plant_targeted
signal spell_finished

func _on_Island_plant_resurrected():
	emit_signal("plant_resurrected")

func _on_Island_plant_targeted():
	emit_signal("plant_targeted")

func _on_Player_finished_spell():
	# TODO: Select the active island
	emit_signal("spell_finished")
