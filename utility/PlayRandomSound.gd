extends Node2D

func play():
	get_child(randi() % get_child_count()).play()

func stop():
	for child in get_children():
		child.stop()
