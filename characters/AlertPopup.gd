extends Node2D



func _ready():
	$HideAlertTimer.connect("timeout", self, "hide")
	hide()

func alert():
	show()
	$HideAlertTimer.start()
