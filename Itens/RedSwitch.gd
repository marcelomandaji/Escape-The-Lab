extends AnimatedSprite

signal RedSwitch

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("RedSwitch")
		queue_free()
