extends Area2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	if overlaps_body(get_parent().get_node("Player")) || overlaps_body(get_parent().get_node("PlayerClone")):
		queue_free()
