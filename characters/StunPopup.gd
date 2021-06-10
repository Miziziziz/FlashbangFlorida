extends Node2D



func _ready():
	hide()

func display_stun(stun_time):
	show()
	$AnimatedSprite.speed_scale = 1.0 / stun_time
	$AnimatedSprite.play("countdown")
	$AnimatedSprite.frame = 0
