extends Area2D


func _ready():
	connect("body_entered", self, "on_body_enter")

func on_body_enter(body):
	if body.name == "Player":
		LevelManager.load_next_level()
