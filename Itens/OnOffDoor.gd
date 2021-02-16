extends AnimatedSprite

func _ready():
	pass
	
func _on_BlueSwitch_BlueSwitch():
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	self.play("Open")


func _on_RedSwitch_RedSwitch():
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	self.play("Closed")
