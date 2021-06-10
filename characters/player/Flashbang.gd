extends KinematicBody2D

var move_dir : Vector2
var thrown = false
var throw_speed = 300
var throw_time = 1.0
var cur_throw_time = 0.0
var spin_speed = 2000
var stun_time = 2.0

func _ready():
	if thrown:
		return
	hide()
	set_physics_process(false)

func throw(start_pos: Vector2, dir: Vector2):
	show()
	thrown = true
	cur_throw_time = 0.0
	set_physics_process(true)
	global_position = start_pos
	move_dir = dir
	$Sprite.rotation_degrees = rand_range(0.0, 360.0)
	$Light2D.hide()

func _physics_process(delta):
	var coll = move_and_collide(move_dir * throw_speed * delta)
	if coll:
		if coll.collider is Door:
			coll.collider.open()
		else:
			move_dir = move_dir - 2 * (move_dir.dot(coll.normal)) * coll.normal
			throw_speed *= 0.9
	
	$Sprite.rotation_degrees += delta * spin_speed
	
	cur_throw_time += delta
	if cur_throw_time >= throw_time:
		set_physics_process(false)
		flash()

func flash():
	collision_layer = 0
	collision_mask = 0
	$Light2D.show()
	$FlashTimer.start()
	
	var query = Physics2DShapeQueryParameters.new()
	var select_transform = Transform2D()
	select_transform.origin = global_position
	query.set_transform(select_transform)
	query.set_shape($FlashArea/CollisionShape2D.shape)
	query.collision_layer = 2
	var space_state = get_world_2d().get_direct_space_state()
	var result = space_state.intersect_shape(query)
	var objects_hit = []
	for item_data in result:
		if item_data.collider.has_method("stun"):
			objects_hit.append(item_data.collider)
	
	for obj in objects_hit:
		var r_result = space_state.intersect_ray(global_position, obj.global_position, [], 1+4)
		if r_result:
			pass
		else:
			obj.stun(stun_time)
	
	
