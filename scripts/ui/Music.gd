extends HBoxContainer

# TODO: This should be a separate audio bus for music
export var audio_bus_name := "Master"

# The amount to change the volume by
export var amount = 0.25

onready var label = get_node("Label")
onready var sfx = get_node("SFX")
onready var gauge = get_node("Gauge")
onready var bus := AudioServer.get_bus_index(audio_bus_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	gauge.value = db2linear(AudioServer.get_bus_volume_db(bus))
	label.text = audio_bus_name

func _on_Up_pressed():
	gauge.value = gauge.value + amount
	if gauge.value > 1:
		gauge.value = 1
	update_volume()

func _on_Down_pressed():
	gauge.value = gauge.value - amount
	if gauge.value < 0:
		gauge.value = 0
	update_volume()

	
func update_volume():
	AudioServer.set_bus_volume_db(bus, linear2db(gauge.value))
	sfx.play()
