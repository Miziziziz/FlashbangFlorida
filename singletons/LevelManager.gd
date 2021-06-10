extends Node

var level_list = [
	"res://levels/Intro.tscn",
	"res://levels/Level1.tscn",
	"res://levels/Level2.tscn",
	"res://levels/StunIsSafe.tscn",
	"res://levels/Level3.tscn",
	"res://levels/CirclePatrol.tscn",
]
var level_ind = 0

func load_next_level():
	level_ind += 1
	level_ind %= level_list.size()
	get_tree().call_group("instanced", "queue_free")
	get_tree().change_scene(level_list[level_ind])

func restart_level():
	get_tree().call_group("instanced", "queue_free")
	get_tree().reload_current_scene()

func exit_game():
	get_tree().quit()
