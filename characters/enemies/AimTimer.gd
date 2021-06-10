extends Node2D


export var aim_timer_display_width = 24
export var aim_timer_display_bar_width = 3.0
export var aim_timer_display_side_ticks_height = 8
export var aim_time_percent_complete = -1.0

export var side_colors = Color.ivory
export var main_color = Color.brown

func _process(delta):
	update()

func _draw():
	if aim_time_percent_complete < 0.0:
		#hide()
		return
	#show()
	var left_pos = -Vector2(aim_timer_display_width/2, 0.0)
	var right_pos = left_pos + Vector2(lerp(0, aim_timer_display_width, aim_time_percent_complete), 0.0)
	draw_line(left_pos, right_pos, main_color, aim_timer_display_bar_width)
	
	right_pos = left_pos + Vector2(aim_timer_display_width, 0.0)
	var bot_y = Vector2(0.0, aim_timer_display_side_ticks_height/2)
	var top_y = Vector2(0.0, -aim_timer_display_side_ticks_height/2)
	draw_line(left_pos + bot_y, left_pos + top_y, side_colors, 2.0)
	draw_line(right_pos + bot_y, right_pos + top_y, side_colors, 2.0)

func set_percent(p: float):
	aim_time_percent_complete = p
