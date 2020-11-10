extends Area2D

enum { DEAD, RESURRECTING, ALIVE}

enum PlantType { PINE, PALM, MANGROVE, FERN }
export(PlantType) var type

var state = DEAD

onready var animator = get_node("PlantSprite")
onready var sound = get_node("Sound")
	
func _ready():
	Main.connect("finished_spell", self, "_on_finished_spell")
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		self.on_click()
		
func _on_finished_spell():
	print("Finished spell; resurrecting plant.")
	resurrect()
	
# After the growing animation is finished, the plant remains alive
func _on_PlantSprite_animation_finished():
	if (animator.animation == "grow"):
		animator.animation = "live"
		print("Plant resurrected; emitting signal")
		Main.emit_signal("plant_resurrected")
		
func on_click():
	# TODO: check state of plant's island to make sure it can be resurrected
	var island = get_parent()
	if island.is_unavailable():
		print("Island out of range")
	elif island.is_dead():
		if type == PlantType.MANGROVE:
			start_resurrect()
		else:
			print("No water")
	elif island.is_watered():
		start_resurrect()
		
	
func start_resurrect():
	# Show a message if the plant is alive
	if state == DEAD:
			state = RESURRECTING
			Main.emit_signal("plant_targeted")

func is_mangrove():
	return type == PlantType.MANGROVE
	
func resurrect():
	if state == RESURRECTING:
		state = ALIVE
		sound.play()
		animator.play("grow")
		# TODO: Dialogue event

