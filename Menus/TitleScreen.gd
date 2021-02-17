extends Control

func _ready():
	MusicController.play_intro()

func _on_Button_pressed():
	pass
	#get_tree().change_scene("res://Levels/Level_1.tscn")
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			go_play()
	if event is InputEventJoypadButton:
		if event.pressed:
			go_play()
	if event is InputEventMouseButton:
		if event.pressed:
			go_play()

func go_play():
	MusicController.play_theme()
	get_tree().change_scene("res://Levels/Level_0.tscn")
