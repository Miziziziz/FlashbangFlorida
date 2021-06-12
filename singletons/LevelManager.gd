extends Node

var level_list = [
	"res://levels/Intro.tscn",
	"res://levels/Level1.tscn",
	"res://levels/Level2.tscn",
	"res://levels/StunIsSafe.tscn",
	"res://levels/Level3.tscn",
	"res://levels/CirclePatrol.tscn",
	"res://levels/GetThemBoth.tscn",
	"res://levels/Tricksy.tscn",
	"res://levels/TheTiming.tscn",
	"res://levels/FinalLevel.tscn",
	"res://levels/Outro.tscn"
]
var level_ind = 0

func load_next_level():
	level_ind += 1
	level_ind %= level_list.size()
	get_tree().call_group("instanced", "queue_free")
	get_tree().change_scene(level_list[level_ind])
	if level_ind > 1:
		$StairsSound.play()
	
	if level_ind == 1:
		$BeepSound.play()

func restart_level():
	get_tree().call_group("instanced", "queue_free")
	get_tree().reload_current_scene()

func exit_game():
	get_tree().quit()

func play_main_music():
	if !$MainMusic.playing:
		stop_music()
		$MainMusic.play()

func play_boss_music():
	if !$BossMusic.playing:
		stop_music()
		$BossMusic.play()

func play_outro_music():
	if !$OutroMusic.playing:
		stop_music()
		$OutroMusic.play()

func stop_music():
	$MainMusic.stop()
	$BossMusic.stop()
	$OutroMusic.stop()
