extends Node2D

class_name CharacterMover

export var accel = 50
export var max_speed = 240
var velo : Vector2
var stop_drag = 0.7
var move_drag = 0.0

var move_vec : Vector2
var body_to_move : KinematicBody2D

func _ready():
	move_drag = float(accel) / max_speed

func set_body_to_move(_body_to_move: KinematicBody2D):
	body_to_move = _body_to_move

func set_move_vec(_move_vec: Vector2):
	move_vec = _move_vec.normalized()

func _physics_process(delta):
	if body_to_move == null:
		return
	
	var drag = move_drag
#	if move_vec.length_squared() < 0.01 or move_vec.dot(velo) < 0.0:
#		drag = stop_drag
	
	velo += accel * move_vec - velo * drag
	body_to_move.move_and_slide(velo, Vector2.ZERO)
