extends AnimatedSprite

var body_entered = null
var max_levels = 6

func _ready():
	pass
	
func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		if get_node("../").got_key:
			self.play("Open")
			body_entered = body
			get_node("../").finishing = true



func _on_AnimatedSprite_animation_finished():
	if self.animation == "Open":
		#body_entered.queue_free()
		body_entered.get_node("AnimatedSprite").modulate.a = 0
		self.play("Finish")
	elif self.animation == "Finish":
		if (int(get_tree().current_scene.name) + 1) <= max_levels:
			var _scene = get_tree().change_scene("res://Levels/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
			if (int(get_tree().current_scene.name) + 1) == 5:
				pass
				#MusicController.stopMusic()
		else:
			MusicController.play_final()
			var _scene = get_tree().change_scene("res://Final.tscn")
