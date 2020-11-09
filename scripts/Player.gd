extends Node2D

signal finished_spell

onready var animator = get_node("PlayerSprite")

func cast_spell():
	animator.play("arms_rising")
	
func finish_resurrect():
	animator.play("arms_falling")
	
func _on_Lagoon_plant_targeted():
	cast_spell()

func _on_PlayerSprite_animation_finished():
	if (animator.animation == "arms_rising"):
		emit_signal("finished_spell")
	elif (animator.animation == "arms_falling"):
		# Just reset to the idle animation
		animator.animation = "idle"

func _on_Lagoon_plant_resurrected():
	finish_resurrect()
