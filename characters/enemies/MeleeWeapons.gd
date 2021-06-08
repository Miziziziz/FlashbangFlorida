extends Node2D


func _ready():
	if randi() % 2 == 0:
		$Bat.hide()
	else:
		$Knife.hide()

func update_dir(dir):
	if dir == EnemyGraphics.DIRECTIONS.DOWN:
		rotation_degrees = -15
		position = Vector2(-9, 0)
	if dir == EnemyGraphics.DIRECTIONS.UP:
		rotation_degrees = -15
		position = Vector2(-7, -1)
	if dir == EnemyGraphics.DIRECTIONS.LEFT:
		rotation_degrees = -75
		position = Vector2(0, 0)
	if dir == EnemyGraphics.DIRECTIONS.RIGHT:
		rotation_degrees = 75
		position = Vector2(0, 0)
