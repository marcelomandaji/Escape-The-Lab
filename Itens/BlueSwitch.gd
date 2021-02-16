extends AnimatedSprite

signal BlueSwitch

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("BlueSwitch")
		$Hitbox/CollisionShape2D.set_deferred("disabled", true)
		self.play("Apertado")


func _on_RedSwitch_RedSwitch():
	$Hitbox/CollisionShape2D.set_deferred("disabled", false)
	self.play("Idle")


func _on_BlueSwitch_BlueSwitch():
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	self.play("Apertado")
