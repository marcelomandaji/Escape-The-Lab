extends Sprite

func _on_Hitbox_body_entered(body):
	
	if body.is_in_group("Player"):
		
		var cloneScene = load("res://Player/Player.tscn")
		var clone = cloneScene.instance()
		clone.set_name("PlayerClone")
		get_node("../../").add_child(clone)
		clone.position = Vector2(position.x+10, position.y)
		
		queue_free()
	
