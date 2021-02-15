extends Node2D

var got_key = false
var camera_is_on_player = true
var finishing = false

func cycle_camera():
	if camera_is_on_player && get_node("PlayerClone") != null:
		camera_is_on_player = false
		get_node("PlayerClone").set_camera()
	else:
		camera_is_on_player = true
		get_node("Player").set_camera()
