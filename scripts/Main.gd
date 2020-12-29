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

var knowledge_of_mangroves = false
var saved_start_tree = false
var is_game_over = false
var islands_healed = 0
var is_first_mangrove_healed = false

	
