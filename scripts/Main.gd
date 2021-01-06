##############
# Main.gd
##############

extends Node2D

# Master list of game signals
signal plant_targeted
signal plant_resurrected
signal finished_spell
signal finished_lowering_arms
signal island_healed

signal started_game
signal finished_game

signal show_settings
signal hide_settings

signal started_speaking(line)
signal finished_speaking

signal play_music(clip)
signal play_sfx(clip)

# Global variables
var knowledge_of_mangroves : bool = false
var saved_start_tree : bool = false
var is_game_over : bool = false
var is_first_mangrove_healed : bool = false
var islands_healed : int= 0

func _input(event):
	Input.set_mouse_mode(Input.CURSOR_IBEAM)
	if ($CursorCanvas/CursorSprite != null):
		get_node("CursorCanvas/CursorSprite").position.x = event.position.x
		get_node("CursorCanvas/CursorSprite").position.y = event.position.y
