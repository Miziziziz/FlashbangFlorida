extends Node


enum TRACKS {MAIN, BOSS, OUTRO}
export(TRACKS) var cur_track
func _ready():
	match cur_track:
		TRACKS.MAIN:
			LevelManager.play_main_music()
		TRACKS.BOSS:
			LevelManager.play_boss_music()
		TRACKS.OUTRO:
			LevelManager.play_outro_music()
