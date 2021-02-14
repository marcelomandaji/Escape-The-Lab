extends Sprite

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		if get_node("../").got_key:
			print("door open")
		else:
			print("door closed")
