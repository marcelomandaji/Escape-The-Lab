extends Node2D

var got_key = false
var camera_is_on_player = true
var finishing = false
var onoff = false

func cycle_camera():
	
	if camera_is_on_player && get_node("PlayerClone") != null:
		
		camera_is_on_player = false
		
		get_node("PlayerClone").get_node("Camera2D").smoothing_enabled = false
		get_node("PlayerClone").get_node("Camera2D").position.x = get_node("Player").position.x - get_node("PlayerClone").position.x
		get_node("PlayerClone").get_node("Camera2D").position.y = get_node("Player").position.y - get_node("PlayerClone").position.y
		get_node("PlayerClone").set_camera()
		get_node("PlayerClone").get_node("Camera2D").smoothing_enabled = true
		get_node("PlayerClone").get_node("Camera2D").position.x = 0
		get_node("PlayerClone").get_node("Camera2D").position.y = 0
		
	elif get_node("PlayerClone") != null:
		
		camera_is_on_player = true
		
		get_node("Player").get_node("Camera2D").smoothing_enabled = false
		get_node("Player").get_node("Camera2D").position.x = get_node("PlayerClone").position.x - get_node("Player").position.x
		get_node("Player").get_node("Camera2D").position.y = get_node("PlayerClone").position.y - get_node("Player").position.y
		get_node("Player").set_camera()
		get_node("Player").get_node("Camera2D").smoothing_enabled = true
		get_node("Player").get_node("Camera2D").position.x = 0
		get_node("Player").get_node("Camera2D").position.y = 0
