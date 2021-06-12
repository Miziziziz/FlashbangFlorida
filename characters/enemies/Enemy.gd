extends KinematicBody2D

class_name Enemy

onready var character_mover = $CharacterMover
onready var graphics = $Graphics
onready var alert_popup = $AlertPopup

var nav : Navigation2D
var player : KinematicBody2D

enum STATES {IDLE, PATROL, REACT, INVESTIGATE, CHASE}
var cur_state = STATES.IDLE
var start_state = STATES.IDLE

var patrol_points = []
var patrol_ind = 0

var move_vec : Vector2
export var vision_cone_size = 75 # degrees

export(Curve) var react_jump_curve

var cur_stun_time = 0.0

var start_dir : Vector2

func _ready():
	graphics.get_node("RunSprite").connect("frame_changed", self, "run_frame_changed")
	
	start_dir = Vector2.DOWN.rotated(global_rotation)
	graphics.update_animation(start_dir)
	graphics.update_animation(Vector2.ZERO)
	global_rotation = 0
	
	character_mover.set_body_to_move(self)
	nav = get_tree().get_nodes_in_group("navigation")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	
	if has_node("PatrolPoints"):
		for c in get_node("PatrolPoints").get_children():
			patrol_points.append(c.global_position)
		set_patrol_state()
		start_state = STATES.PATROL
	else:
		set_idle_state()
	ready_hook()

func ready_hook():
	pass

func _process(delta):
	graphics.update_animation(move_vec)
	character_mover.set_move_vec(move_vec)
	
	if cur_stun_time > 0.0:
		cur_stun_time -= delta
		graphics.update_animation(Vector2.ZERO)
		character_mover.set_move_vec(Vector2.ZERO)
		return
	
	match cur_state:
		STATES.IDLE:
			process_idle_state(delta)
		STATES.PATROL:
			process_patrol_state(delta)
		STATES.INVESTIGATE:
			process_investigate_state(delta)
		STATES.REACT:
			process_react_state(delta)
		STATES.CHASE:
			process_chase_state(delta)

func set_idle_state():
	cur_state = STATES.IDLE

func set_patrol_state():
	cur_state = STATES.PATROL
	patrol_time = 0.0

export var react_jump_height = 6.0
export var react_time = .6
var cur_react_time = 0.0
var first_reaction = true
func set_react_state():
	cur_state = STATES.REACT
	if !first_reaction:
		set_chase_state()
		return
	$AlertSounds.play()
	alert_popup.alert()
	first_reaction = false

var pos_to_investigate : Vector2
var investigate_start_pos : Vector2
var investigating = false
func set_investigate_state(pos: Vector2):
	cur_state = STATES.INVESTIGATE
	pos_to_investigate = pos
	investigate_start_pos = global_position
	investigating = true

func set_chase_state():
	cur_state = STATES.CHASE

func process_idle_state(delta):
	if can_see_player():
		set_react_state()
		return
	move_vec = Vector2.ZERO
	idle_state_hook()

func idle_state_hook():
	pass

enum PATROL_STATES {PAUSE, TURN, MOVE}
var cur_patrol_state = PATROL_STATES.PAUSE
var patrol_time = 0.0
var pause_time = 1.0
#var turn_time = 1.0
func process_patrol_state(delta):
	if can_see_player():
		set_react_state()
		return
	match cur_patrol_state:
		PATROL_STATES.PAUSE:
			move_vec = Vector2.ZERO
			patrol_time += delta
			if patrol_time >= pause_time:
				cur_patrol_state = PATROL_STATES.MOVE
				patrol_time = 0.0
#		PATROL_STATES.TURN:
#			pass
		PATROL_STATES.MOVE:
			
			var goal_point = patrol_points[patrol_ind]
			move_vec = goal_point - global_position
			if move_vec.length_squared() < 20:
				patrol_ind += 1
				patrol_ind %= patrol_points.size()
				cur_patrol_state = PATROL_STATES.PAUSE

func process_investigate_state(delta):
	if can_see_player():
		set_react_state()
		return
	var path = nav.get_simple_path(global_position, pos_to_investigate)
	if path.size() > 1:
		move_vec = path[1] - global_position
	if global_position.distance_squared_to(pos_to_investigate) < 100:
		if investigating:
			investigating = false
			pos_to_investigate = investigate_start_pos
		else:
			
			if start_state == STATES.PATROL:
				set_patrol_state()
			else:
				graphics.update_animation(start_dir)
				character_mover.velo = Vector2.ZERO
				move_vec = Vector2.ZERO
				set_idle_state()

func process_react_state(delta):
	cur_react_time += delta
	if cur_react_time > react_time:
		graphics.position.y = 0
		set_chase_state()
		return
	
	var t = cur_react_time / react_time
	
	graphics.position.y = -react_jump_height * react_jump_curve.interpolate(t)

func process_chase_state(delta):
	if player.dead:
		set_idle_state()
		return
	
	var path = nav.get_simple_path(global_position, player.global_position)
	if path.size() > 1:
		move_vec = path[1] - global_position

func can_see_player():
	if player.dead:
		return false
	if !has_los_to_point(player.global_position):
		return false
	if !point_in_vision_cone(player.global_position):
		return false
	return true

func point_in_vision_cone(point: Vector2):
	var dir = point - global_position
	var angle = rad2deg(atan2(dir.y, dir.x))
	
	var facing_dir = graphics.last_dir
	if facing_dir == EnemyGraphics.DIRECTIONS.RIGHT:
		if angle < vision_cone_size and angle > -vision_cone_size:
			return true
	if facing_dir == EnemyGraphics.DIRECTIONS.LEFT:
		if angle < -180 + vision_cone_size or angle > 180 - vision_cone_size:
			return true
	if facing_dir == EnemyGraphics.DIRECTIONS.UP:
		if angle < -90 + vision_cone_size and angle > -90 - vision_cone_size:
			return true
	if facing_dir == EnemyGraphics.DIRECTIONS.DOWN:
		if angle < 90 + vision_cone_size and angle > 90 - vision_cone_size:
			return true
	return false

func has_los_to_point(point: Vector2):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(global_position, point, [self], 1 + 4)
	if result:
		return false
	return true

func stun(stun_time: float, thrown_from_pos: Vector2):
	cur_stun_time = stun_time
	$StunPopup.display_stun(stun_time)
	set_investigate_state(thrown_from_pos)
	$AlertSounds.stop()

func run_frame_changed():
	if graphics.get_node("RunSprite").frame % 2 == 0: # or anim_sprite.frame == 4:
		$StepSounds.play()
