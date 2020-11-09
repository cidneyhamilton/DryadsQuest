extends Area2D

signal resurrected

enum { DEAD, ALIVE}

var state = DEAD

onready var animator = get_node("PlantSprite")
onready var sound = get_node("Sound")
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click()
		
func on_click():
	# TODO: check state of plant's island to make sure it can be resurrected
	resurrect()
	
func resurrect():
	if state == ALIVE:
		# do nothing, plant was already resurrected
		pass
	else:
		state = ALIVE
		sound.play()
		animator.play("grow")
		# TODO: Play a sound effect
		# TODO: Dialogue event

# After the growing animation is finished, the plant remains alive
func _on_PlantSprite_animation_finished():
	if (animator.animation == "grow"):
		animator.animation = "live"
		emit_signal("resurrected")
