##############
# Plant.gd
##############

class_name Plant
extends Area2D

enum { DEAD, RESURRECTING, ALIVE}

enum PlantType { PINE, PALM, MANGROVE, FERN }
export(PlantType) var type

var state = DEAD

onready var animator = get_node("PlantSprite")
onready var sound = get_node("Sound")
	
func _ready():
	animator.play("dead")
	Main.connect("finished_lowering_arms", self, "_on_finished_lowering_arms")
	Main.connect("finished_spell", self, "_on_finished_spell")
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click()
		
func _on_finished_spell():
	if state == RESURRECTING:
		print("This plant is being resurrected; finish resurrecting it.")
		resurrect()
	
func _on_finished_lowering_arms():
	if state == RESURRECTING:
		print("This plant is still being flagged as resurrecting, even though her arms are lowered.")
		state = DEAD 
		
# After the growing animation is finished, the plant remains alive
func _on_PlantSprite_animation_finished():
	if (animator.animation == "grow"):
		animator.animation = "live"
		Main.emit_signal("plant_resurrected")
		
func on_click():
	# TODO: check state of plant's island to make sure it can be resurrected
	var island = get_parent()
	if island.is_unavailable():
		speak("island_out_of_range")
	elif state == RESURRECTING:
		print("Plant being clicked is being resurrected.")
	elif state == ALIVE:
		speak("resurrect_live_plant")
	elif island.is_dead():
		if is_mangrove():
			speak("mangrove_healed")
			start_resurrect()
		else:
			speak("no_water")
	elif island.is_watered():
		start_resurrect()
		
	
func start_resurrect():
	# Show a message if the plant is alive
	if state == DEAD:
		state = RESURRECTING
		Main.emit_signal("plant_targeted")
	elif state == ALIVE:
		print("Plant is already alive")
	else:
		print("Plant trying to start resurrect on is being resurrected.")

func is_mangrove():
	return type == PlantType.MANGROVE
	
func resurrect():
	state = ALIVE
	sound.play()
	animator.play("grow")
	# TODO: Dialogue event
	
func speak(line):
	Main.emit_signal("started_speaking", line)

