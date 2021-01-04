##############
# Player.gd
##############

extends Node2D
class_name Player

enum PlayerState { IDLE, CASTING_SPELL }

var state = PlayerState.IDLE

onready var animator = get_node("PlayerSprite")

func _ready() -> void:
	Main.connect("plant_targeted", self, "_on_plant_targeted")
	Main.connect("plant_resurrected", self, "_on_plant_resurrected")

# Callback after the plant has been resurrected
func _on_plant_resurrected():
	finish_resurrect()
	
func _input(event) -> void:
	if event is InputEventMouseButton:
		var mousePos = event.position
		animator.flip_h = mousePos.x < position.x
	
func cast_spell() -> void:
	if state == PlayerState.IDLE:
		state = PlayerState.CASTING_SPELL
		animator.play("arms_rising")
	else:
		print("Already in the middle of casting a spell")
	
func finish_resurrect() -> void:
	animator.play("arms_falling")
	
func _on_plant_targeted() -> void:
	cast_spell()

func _on_PlayerSprite_animation_finished() -> void:
	if (animator.animation == "arms_rising"):
		state = PlayerState.IDLE
		Main.emit_signal("finished_spell")
	elif (animator.animation == "arms_falling"):
		# Just reset to the idle animation
		state = PlayerState.IDLE
		animator.animation = "idle"
		Main.emit_signal("finished_lowering_arms")


