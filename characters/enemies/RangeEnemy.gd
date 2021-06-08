extends Enemy

onready var gun_base = $Graphics/GunBase
func ready_hook():
	graphics.connect("direction_updated", $Graphics/GunBase, "update_dir")
	$Graphics/GunBase.update_dir(graphics.last_dir)

var aim_time = 0.6
var cur_aim_time = 0.0
func process_chase_state(delta):
	if player.dead:
		gun_base.reset_angle()
		set_idle_state()
		return
	
	if has_los_to_point(player.global_position):
		cur_aim_time += delta
		if cur_aim_time >= aim_time:
			player.kill()
		var dir_to_player = player.global_position - global_position
		graphics.update_animation(dir_to_player)
		graphics.update_animation(Vector2.ZERO)
		gun_base.set_angle(atan2(dir_to_player.y, dir_to_player.x))
	else:
		gun_base.reset_angle()
		cur_aim_time = 0.0
		var path = nav.get_simple_path(global_position, player.global_position)
		if path.size() > 1:
			move_vec = path[1] - global_position
