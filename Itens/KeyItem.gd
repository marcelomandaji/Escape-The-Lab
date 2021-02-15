extends AnimatedSprite

func _on_Hitbox_body_entered(body):
	get_node("../").got_key = true
	queue_free()
