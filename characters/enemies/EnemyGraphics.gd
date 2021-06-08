extends Node2D

class_name EnemyGraphics

signal direction_updated

var idle_anims = [
	"res://assets/characters/enemies/idle/Alex_idle_16x16.png",
	"res://assets/characters/enemies/idle/Amelia_idle_16x16.png",
	"res://assets/characters/enemies/idle/Ash_idle_16x16.png",
	"res://assets/characters/enemies/idle/Bob_idle_16x16.png",
	"res://assets/characters/enemies/idle/Bouncer_idle_16x16.png",
	"res://assets/characters/enemies/idle/Bruce_idle_16x16.png",
	"res://assets/characters/enemies/idle/Butcher_2_idle_16x16.png",
	"res://assets/characters/enemies/idle/Butcher_idle_16x16.png",
	"res://assets/characters/enemies/idle/Chef_Alex_idle_16x16.png",
	"res://assets/characters/enemies/idle/Chef_Lucy_idle_16x16.png",
	"res://assets/characters/enemies/idle/Chef_Molly_idle_16x16.png",
	"res://assets/characters/enemies/idle/Chef_Pier_idle_16x16.png",
	"res://assets/characters/enemies/idle/Chef_Rob_idle_16x16.png",
	"res://assets/characters/enemies/idle/Conference_man_idle_16x16.png",
	"res://assets/characters/enemies/idle/Conference_woman_idle_16x16.png",
	"res://assets/characters/enemies/idle/Dan_idle_16x16.png",
	"res://assets/characters/enemies/idle/Doctor_1_idle_16x16.png",
	"res://assets/characters/enemies/idle/Doctor_2_idle_16x16.png",
	"res://assets/characters/enemies/idle/Edward_idle_16x16.png",
	"res://assets/characters/enemies/idle/Fishmonger_1_idle_16x16.png",
	"res://assets/characters/enemies/idle/Fishmonger_2_idle_16x16.png",
	"res://assets/characters/enemies/idle/Kid_Abby_idle_16x16.png",
	"res://assets/characters/enemies/idle/kid_Karen_idle_16x16.png",
	"res://assets/characters/enemies/idle/Kid_Mitty_idle_16x16.png",
	"res://assets/characters/enemies/idle/kid_Oscar_idle_16x16.png",
	"res://assets/characters/enemies/idle/Kid_Romeo_idle_16x16.png",
	"res://assets/characters/enemies/idle/Kid_Tim_idle_16x16.png",
	"res://assets/characters/enemies/idle/Lucy_idle_16x16.png",
	"res://assets/characters/enemies/idle/Molly_idle_16x16.png",
	"res://assets/characters/enemies/idle/Nurse_1_idle_16x16.png",
	"res://assets/characters/enemies/idle/Nurse_2_idle_16x16.png",
	"res://assets/characters/enemies/idle/Old_man_Josh_idle_16x16.png",
	"res://assets/characters/enemies/idle/Old_woman_Jenny_idle_16x16.png",
	"res://assets/characters/enemies/idle/Pier_idle_16x16.png",
	"res://assets/characters/enemies/idle/Prisoner_1_idle_16x16.png",
	"res://assets/characters/enemies/idle/Prisoner_2_idle_16x16.png",
	"res://assets/characters/enemies/idle/Prisoner_3_idle_16x16.png",
	"res://assets/characters/enemies/idle/Rob_idle_16x16.png",
	"res://assets/characters/enemies/idle/Roki_idle_16x16.png",
	"res://assets/characters/enemies/idle/Samuel_idle_16x16.png",
]

var run_anims = [
	"res://assets/characters/enemies/run/Alex_run_16x16.png",
	"res://assets/characters/enemies/run/Amelia_run_16x16.png",
	"res://assets/characters/enemies/run/Ash_run_16x16.png",
	"res://assets/characters/enemies/run/Bob_run_16x16.png",
	"res://assets/characters/enemies/run/Bouncer_run_16x16.png",
	"res://assets/characters/enemies/run/Bruce_run_16x16.png",
	"res://assets/characters/enemies/run/Butcher_2_run_16x16.png",
	"res://assets/characters/enemies/run/Butcher_run_16x16.png",
	"res://assets/characters/enemies/run/Chef_Alex_run_16x16.png",
	"res://assets/characters/enemies/run/Chef_Lucy_run_16x16.png",
	"res://assets/characters/enemies/run/Chef_Molly_run_16x16.png",
	"res://assets/characters/enemies/run/Chef_Pier_run_16x16.png",
	"res://assets/characters/enemies/run/Chef_Rob_run_16x16.png",
	"res://assets/characters/enemies/run/Conference_man_run_16x16.png",
	"res://assets/characters/enemies/run/Conference_woman_run_16x16.png",
	"res://assets/characters/enemies/run/Dan_run_16x16.png",
	"res://assets/characters/enemies/run/Doctor_1_run_16x16.png",
	"res://assets/characters/enemies/run/Doctor_2_run_16x16.png",
	"res://assets/characters/enemies/run/Edward_run_16x16.png",
	"res://assets/characters/enemies/run/Fishmonger_1_run_16x16.png",
	"res://assets/characters/enemies/run/Fishmonger_2_run_16x16.png",
	"res://assets/characters/enemies/run/kid_Abby_run_16x16.png",
	"res://assets/characters/enemies/run/Kid_Karen_run_16x16.png",
	"res://assets/characters/enemies/run/Kid_Mitty_run_16x16.png",
	"res://assets/characters/enemies/run/kid_Oscar_run_16x16.png",
	"res://assets/characters/enemies/run/Kid_Romeo_run_16x16.png",
	"res://assets/characters/enemies/run/Kid_Tim_run_16x16.png",
	"res://assets/characters/enemies/run/Lucy_run_16x16.png",
	"res://assets/characters/enemies/run/Molly_run_16x16.png",
	"res://assets/characters/enemies/run/Nurse_1_run_16x16.png",
	"res://assets/characters/enemies/run/Nurse_2_run_16x16.png",
	"res://assets/characters/enemies/run/Old_man_Josh_run_16x16.png",
	"res://assets/characters/enemies/run/Old_woman_Jenny_run_16x16.png",
	"res://assets/characters/enemies/run/Pier_run_16x16.png",
	"res://assets/characters/enemies/run/Prisoner_1_run_16x16.png",
	"res://assets/characters/enemies/run/Prisoner_2_run_16x16.png",
	"res://assets/characters/enemies/run/Prisoner_3_run_16x16.png",
	"res://assets/characters/enemies/run/Rob_run16x16.png",
	"res://assets/characters/enemies/run/Roki_run_16x16.png",
	"res://assets/characters/enemies/run/Samuel_run_16x16.png",
]

func _ready():
	var ind = randi() % idle_anims.size()
	$IdleSprite.texture = load(idle_anims[ind])
	$RunSprite.texture = load(run_anims[ind])


onready var anim_player = $AnimationPlayer

enum DIRECTIONS {UP, LEFT, DOWN, RIGHT}
var last_dir = DIRECTIONS.DOWN

func update_animation(move_vec: Vector2):
	if move_vec.length_squared() > 0.01:
		var d = move_vec.dot(Vector2.RIGHT)
		last_dir = DIRECTIONS.RIGHT
		var ld = move_vec.dot(Vector2.UP)
		if ld > d:
			last_dir =  DIRECTIONS.UP
			d = ld
		ld = move_vec.dot(Vector2.DOWN)
		if ld > d:
			last_dir =  DIRECTIONS.DOWN
			d = ld
		ld = move_vec.dot(Vector2.LEFT)
		if ld > d:
			last_dir =  DIRECTIONS.LEFT
			d = ld
		emit_signal("direction_updated", last_dir)
	
	if move_vec.length_squared() > 0.01:
		match last_dir:
			DIRECTIONS.UP:
				anim_player.play("run_up")
			DIRECTIONS.DOWN:
				anim_player.play("run_down")
			DIRECTIONS.LEFT:
				anim_player.play("run_left")
			DIRECTIONS.RIGHT:
				anim_player.play("run_right")
	else:
		match last_dir:
			DIRECTIONS.UP:
				anim_player.play("idle_up")
			DIRECTIONS.DOWN:
				anim_player.play("idle_down")
			DIRECTIONS.LEFT:
				anim_player.play("idle_left")
			DIRECTIONS.RIGHT:
				anim_player.play("idle_right")


