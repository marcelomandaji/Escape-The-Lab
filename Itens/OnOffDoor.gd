extends AnimatedSprite

func _ready():
	self.modulate.a = 0
	
func _on_BlueSwitch_BlueSwitch():
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	self.modulate.a = 0


func _on_RedSwitch_RedSwitch():
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	self.modulate.a = 1
