extends StaticBody2D

class_name Door

var is_open = false

func _ready():
	$CharacterDetector.connect("body_entered", self, "on_body_enter")
	$SpriteOpen.hide()

func on_body_enter(body: PhysicsBody2D):
	open()

func open():
	if is_open:
		return
	is_open = true
	$SpriteClosed.hide()
	$SpriteOpen.show()
	$CollisionShape2D.call_deferred("set_disabled", true)
	$LightOccluder2D.hide()
	$OpenSounds.play()
