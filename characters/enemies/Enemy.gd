extends KinematicBody2D

class_name Enemy

onready var character_mover = $CharacterMover
onready var graphics = $Graphics

var nav : Navigation2D
var player : KinematicBody2D

enum STATES {IDLE, PATROL, CHASE}
var cur_state = STATES.IDLE

var patrol_points = []
var patrol_ind = 0

var move_vec : Vector2
export var vision_cone_size = 45 # degrees

func _ready():
	graphics.update_animation(Vector2.DOWN.rotated(global_rotation))
	graphics.update_animation(Vector2.ZERO)
	global_rotation = 0
	
	character_mover.set_body_to_move(self)
	nav = get_tree().get_nodes_in_group("navigation")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	
	if has_node("PatrolPoints"):
		for c in get_node("PatrolPoints").get_children():
			patrol_points.append(c.global_position)
		set_patrol_state()
	else:
		set_idle_state()
	ready_hook()

func ready_hook():
	pass

func _process(delta):
	graphics.update_animation(move_vec)
	character_mover.set_move_vec(move_vec)
	
	match cur_state:
		STATES.IDLE:
			process_idle_state(delta)
		STATES.PATROL:
			process_patrol_state(delta)
		STATES.CHASE:
			process_chase_state(delta)

func set_idle_state():
	cur_state = STATES.IDLE

func set_patrol_state():
	cur_state = STATES.PATROL
	patrol_time = 0.0

func set_chase_state():
	cur_state = STATES.CHASE

func process_idle_state(delta):
	if can_see_player():
		set_chase_state()
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
		set_chase_state()
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
	var result = space_state.intersect_ray(global_position, point, [self], 1)
	if result:
		return false
	return true
