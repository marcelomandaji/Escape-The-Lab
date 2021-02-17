extends Control



func _on_Button_pressed():
	pass
	#get_tree().change_scene("res://Levels/Level_1.tscn")
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene("res://Levels/Level_0.tscn")
	if event is InputEventJoypadButton:
		if event.pressed:
			get_tree().change_scene("res://Levels/Level_0.tscn")
	if event is InputEventMouseButton:
		if event.pressed:
			get_tree().change_scene("res://Levels/Level_0.tscn")
