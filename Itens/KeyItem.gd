extends AnimatedSprite

func _on_Hitbox_body_entered(_body):
	MusicController.sfx_key()
	get_node("../").got_key = true
	queue_free()
