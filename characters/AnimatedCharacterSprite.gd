extends AnimatedSprite

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
	
	if move_vec.length_squared() > 0.01:
		match last_dir:
			DIRECTIONS.UP:
				play("run_up")
			DIRECTIONS.DOWN:
				play("run_down")
			DIRECTIONS.LEFT:
				play("run_left")
			DIRECTIONS.RIGHT:
				play("run_right")
	else:
		match last_dir:
			DIRECTIONS.UP:
				play("idle_up")
			DIRECTIONS.DOWN:
				play("idle_down")
			DIRECTIONS.LEFT:
				play("idle_left")
			DIRECTIONS.RIGHT:
				play("idle_right")
