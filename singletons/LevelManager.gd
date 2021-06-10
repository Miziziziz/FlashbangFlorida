extends Node

var level_list = [
	"res://levels/Level1.tscn",
	"res://levels/Level2.tscn",
	"res://levels/Level3.tscn",
	
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
