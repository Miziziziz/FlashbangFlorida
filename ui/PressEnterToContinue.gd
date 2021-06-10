extends Button

func _ready():
	connect("button_up", LevelManager, "load_next_level")

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		LevelManager.exit_game()
	if Input.is_action_just_pressed("ui_accept"):
		LevelManager.load_next_level()
