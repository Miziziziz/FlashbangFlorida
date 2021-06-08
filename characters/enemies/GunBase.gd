extends Node2D

#onready var gun_l = get_node("../GunHoldLeft")
onready var gun_l = $GunHoldLeft
onready var gun_r = $GunHoldRight
onready var gun_d = $GunHoldDown
#onready var gun_u = get_node("../GunHoldUp")
onready var gun_u = $GunHoldUp

func update_dir(dir):
	gun_l.hide()
	gun_r.hide()
	gun_u.hide()
	gun_d.hide()
	
	if dir == EnemyGraphics.DIRECTIONS.UP:
		gun_u.show()
	elif dir == EnemyGraphics.DIRECTIONS.DOWN:
		gun_d.show()
	elif dir == EnemyGraphics.DIRECTIONS.RIGHT:
		gun_r.show()
	else:#if dir == EnemyGraphics.DIRECTIONS.LEFT:
		gun_l.show()
	
func set_angle(new_angle):
	gun_l.global_rotation = new_angle - deg2rad(135)
	gun_r.global_rotation = new_angle - deg2rad(45)
	gun_u.global_rotation = new_angle + deg2rad(45)
	gun_d.global_rotation = new_angle - deg2rad(45)

func reset_angle():
	gun_l.global_rotation = 0
	gun_r.global_rotation = 0
	gun_u.global_rotation = 0
	gun_d.global_rotation = 0
	
