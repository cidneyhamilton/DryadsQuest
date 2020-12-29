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
		
# After the growing animation is finished, make sure the plant remains alive
func _on_PlantSprite_animation_finished():
	if (animator.animation == "grow"):
		animator.animation = "live"
		Main.emit_signal("plant_resurrected")
		
# Handles point and click behavior on plants
func on_click():
	var island = get_parent()
	if island.is_unavailable():
		speak("I can't reach those islands.")
	elif state == RESURRECTING:
		return
	elif state == ALIVE:
		speak("That plant is doing just fine now.")
	elif island.is_dead():
		if is_mangrove():
			if Main.is_first_mangrove_healed:
				speak("I can heal the mangrove with only a touch.")
			start_resurrect()
		else:
			speak("The land plants can't breathe on their own... they need the mangroves to protect the shoreline.")
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

