extends AnimatedSprite

signal BlueSwitch

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("BlueSwitch")
		queue_free()
