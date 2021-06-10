extends Enemy

onready var aim_timer_display = $AimTimer

onready var gun_base = $Graphics/GunBase
func ready_hook():
	graphics.connect("direction_updated", $Graphics/GunBase, "update_dir")
	$Graphics/GunBase.update_dir(graphics.last_dir)

var aim_time = 0.4
var cur_aim_time = 0.0
func process_chase_state(delta):
	if player.dead:
		gun_base.reset_angle()
		set_idle_state()
		return
	
	if has_los_to_point(player.global_position):
		cur_aim_time += delta
		aim_timer_display.aim_time_percent_complete = clamp(cur_aim_time / aim_time, 0.0, 1.0)
		if cur_aim_time >= aim_time:
			player.kill()
			gun_base.flash()
			aim_timer_display.aim_time_percent_complete = -1.0
		var dir_to_player = player.global_position - global_position
		graphics.update_animation(dir_to_player)
		graphics.update_animation(Vector2.ZERO)
		gun_base.set_angle(atan2(dir_to_player.y, dir_to_player.x))
	else:
		aim_timer_display.aim_time_percent_complete = -1.0
		gun_base.reset_angle()
		cur_aim_time = 0.0
		var path = nav.get_simple_path(global_position, player.global_position)
		if path.size() > 1:
			move_vec = path[1] - global_position
	update()


