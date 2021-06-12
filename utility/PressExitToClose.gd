extends Button

func _ready():
	connect("button_up", LevelManager, "exit_game")

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		LevelManager.exit_game()
	if Input.is_action_just_pressed("ui_accept"):
		LevelManager.exit_game()
