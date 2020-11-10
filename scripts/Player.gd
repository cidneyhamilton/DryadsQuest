extends Node2D

onready var animator = get_node("PlayerSprite")

func _ready():
	Main.connect("plant_targeted", self, "_on_plant_targeted")
	Main.connect("plant_resurrected", self, "_on_plant_resurrected")
	
func _input(event):
	if event is InputEventMouseButton:
		var mousePos = event.position
		$PlayerSprite.flip_h = mousePos.x < position.x
	
func cast_spell():
	animator.play("arms_rising")
	
func finish_resurrect():
	print("Finished resurrect")
	animator.play("arms_falling")
	
func _on_plant_targeted():
	cast_spell()

func _on_PlayerSprite_animation_finished():
	if (animator.animation == "arms_rising"):
		Main.emit_signal("finished_spell")
	elif (animator.animation == "arms_falling"):
		# Just reset to the idle animation
		animator.animation = "idle"

func _on_plant_resurrected():
	finish_resurrect()
