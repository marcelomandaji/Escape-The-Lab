extends KinematicBody2D

export (int) var speed = 150
export (int) var jump_speed = -250
export (int) var gravity = 1000
export (float, 0, 1.0) var friction = 0.3
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var got_key = false

const FLOOR = Vector2(0,-1)
func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += 1
	if Input.is_action_pressed("walk_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)

func _ready():
	pass

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, FLOOR)

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed


func _on_DoubleItem_body_entered(body):
	var cloneScene = load("res://Player/Player.tscn")
	var clone = cloneScene.instance()
	clone.set_name("PlayerClone")
	get_node("../").add_child(clone)
	clone.position = Vector2(position.x+32, position.y)

	


func _on_KeyItem_body_entered(body):
	print('got key')
	got_key = true


func _on_Door_body_entered(body):
	if got_key:
		print("next level")
	else:
		print("door closed")
