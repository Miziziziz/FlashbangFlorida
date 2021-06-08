extends KinematicBody2D


onready var character_mover = $CharacterMover
onready var anim_sprite = $Graphics/AnimatedSprite
onready var camera = $Camera2D
export var cam_dist_scale = 3.0

var dead = false

func _ready():
	character_mover.set_body_to_move(self)

func _process(delta):
	if dead:
		return
	var move_vec : Vector2
	move_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vec.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	character_mover.set_move_vec(move_vec)
	anim_sprite.update_animation(move_vec)
	
	camera.global_position = global_position + (get_global_mouse_position() - global_position)/cam_dist_scale


func kill():
	dead = true
	$Graphics/AnimationPlayer.play("death")
	character_mover.set_move_vec(Vector2.ZERO)
	
