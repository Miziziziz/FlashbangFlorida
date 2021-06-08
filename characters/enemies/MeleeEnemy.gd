extends Enemy

class_name MeleeEnemy

func ready_hook():
	$KillZone.connect("body_entered", self, "kill_player_on_enter")
	graphics.connect("direction_updated", $Graphics/MeleeWeapons, "update_dir")

func kill_player_on_enter(body: PhysicsBody2D):
	if body.has_method("kill"):
		body.kill()
