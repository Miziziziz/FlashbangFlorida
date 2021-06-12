extends KinematicBody2D

onready var flashbang_cooldown_display = $FlashbangCooldownDisplay

onready var character_mover = $CharacterMover
onready var anim_sprite = $Graphics/AnimatedSprite
onready var camera = $Camera2D
export var cam_dist_scale = 3.0

var max_flashbang_throw_dist = 600
var flashbang_cooldown_time = 2.0
var cur_flashbang_cooldown_time = 0.0

var dead = false
var cur_stun_time = 0.0

var flashbang_obj = preload("res://characters/player/Flashbang.tscn")
var flashbang_loaded = true

func _ready():
	character_mover.set_body_to_move(self)
	anim_sprite.connect("frame_changed", self, "run_frame_changed")

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("restart"):
		LevelManager.restart_level()
	if dead:
		return
	
	if cur_stun_time > 0.0:
		cur_stun_time -= delta
		return
	
	if Input.is_action_just_pressed("throw_flashbang"):
		throw_flashbang()
	
	if cur_flashbang_cooldown_time > 0.0:
		flashbang_loaded = false
		cur_flashbang_cooldown_time -= delta
		flashbang_cooldown_display.set_percent(1.0 - cur_flashbang_cooldown_time / flashbang_cooldown_time)
	else:
		if !flashbang_loaded:
			$FlashbangLoadedSound.play()
		flashbang_loaded = true
		flashbang_cooldown_display.set_percent(-1.0)
	
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
	$CanvasLayer/RestartMessage.show()
	$KillSound.play()

func throw_flashbang():
	if cur_flashbang_cooldown_time > 0.0:
		return
	
	cur_flashbang_cooldown_time = flashbang_cooldown_time
	var m_pos = get_global_mouse_position()
	var throw_dir = global_position.direction_to(m_pos)
#	var space_state = get_world_2d().direct_space_state
#	var result = space_state.intersect_ray(global_position, m_pos, [], 1)
#	var hit_position = m_pos
#	if result:
#		hit_position = result.position + result.normal * 10
#
#	result = space_state.intersect_ray(global_position, m_pos, [], 4)
#	if result and result.collider is Door:
#		result.collider.open()
	
	var flashbang_inst : KinematicBody2D = flashbang_obj.instance()
	flashbang_inst.add_collision_exception_with(self)
	get_tree().get_root().add_child(flashbang_inst)
	flashbang_inst.throw(global_position, throw_dir)

func stun(stun_time: float, _thrown_from_pos: Vector2):
	if dead:
		return
	cur_stun_time = stun_time
	character_mover.set_move_vec(Vector2.ZERO)
	anim_sprite.update_animation(Vector2.ZERO)
	$StunPopup.display_stun(stun_time)
	$DeafenSound.play()
	
func run_frame_changed():
	if anim_sprite.frame == 1: # or anim_sprite.frame == 4:
		$StepSounds.play()
