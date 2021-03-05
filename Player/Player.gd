extends KinematicBody2D

export (int) var speed = 50
export (int) var jump_speed = -280
export (int) var gravity = 1000
export (float, 0, 1.0) var friction = 0.3
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var motion_previous = Vector2.ZERO

var got_key = false
var hit_the_ground = false
var is_jumping = false

const FLOOR = Vector2(0,-1)

onready var animatedSprite = $AnimatedSprite
onready var camera = $Camera2D
onready var coyoteTimer = $CoyoteTimer
onready var jumpBuffer = $JumpBuffer

func get_input():
	
	var dir = 0
	
	if Input.is_action_pressed("walk_right"):
		dir += 1
		animatedSprite.play("walk")
	
	if Input.is_action_pressed("walk_left"):
		dir -= 1
		animatedSprite.play("walk")
	
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		animatedSprite.flip_h = dir < 0
	
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if is_on_floor():
			animatedSprite.play("idle")
			

func _input(event):
	if event.is_action_pressed("jump"):
		if is_on_floor() || !coyoteTimer.is_stopped():
			coyoteTimer.stop()
			jump()
		else:
			jumpBuffer.start()
			
	if event.is_action_pressed("camera"):
		next_camera()
		
	if event.is_action_pressed("restart"):
		get_tree().change_scene("res://Levels/"+ get_tree().current_scene.name +".tscn")

func jump():
		velocity.y = jump_speed
		is_jumping = true
		MusicController.sfx_jump()

func move(_delta):
	motion_previous = velocity
	var was_on_floor = is_on_floor()
	velocity = move_and_slide(velocity, FLOOR)
	if was_on_floor && !is_on_floor() && !is_jumping:
		coyoteTimer.start()
		velocity.y = 0
	if is_on_floor() && !jumpBuffer.is_stopped():
		jumpBuffer.stop()
		jump()

func gravity(delta):
	if coyoteTimer.is_stopped():
		velocity.y += gravity * delta
		if is_jumping && velocity.y >= 0:
			is_jumping = false
	
func _ready():
	if self.name == "Player":
		camera.current = true

func _physics_process(delta):
	if !get_node("../").finishing: 
		get_input()
		gravity(delta)
		move(delta)
	
	

	"""
	-- New Code from this Point --
	If the player is in the air, make scale of sprite
	based on the y motion value using range_lerp
	The fast the y motion, 
	the larger the y stretch, 
	the larger the x squash
	"""

	if !is_on_floor() && coyoteTimer.is_stopped():
		if velocity.y < 0:
			animatedSprite.play("jump")
		else:
			
			animatedSprite.play("fall") 
		hit_the_ground = false
		if not is_on_wall():
			animatedSprite.scale.y = range_lerp(abs(velocity.y), 0, abs(jump_speed), 0.75, 1.75)
			animatedSprite.scale.x = range_lerp(abs(velocity.y), 0, abs(jump_speed), 1.25, 0.75)

	"""
	If there's a floor collision,
	set squashed scale values based on
	previous motion
	"""

	if not hit_the_ground and is_on_floor() and !is_on_wall():
		hit_the_ground = true
		#MusicController.sfx_fall()
		animatedSprite.scale.x = range_lerp(abs(motion_previous.y), 0, abs(1700), 1.8, 2.0)
		animatedSprite.scale.y = range_lerp(abs(motion_previous.y), 0, abs(1700), 0.6, 0.5)
	
	#if is_on_floor() and is_on_wall():
		#$AnimatedSprite.scale.y = range_lerp(abs(velocity.y), 0, abs(jump_speed), 1.35, 1)
		#$AnimatedSprite.scale.x = range_lerp(abs(velocity.y), 0, abs(jump_speed), 0.65, 1)
		
	"""
	lerp function eases sprite scale to default position
	See article on using delta with lerp:
		https://www.construct.net/en/blogs/ashleys-blog-2/using-lerp-delta-time-924
	"""

	animatedSprite.scale.x = lerp(animatedSprite.scale.x, 1, 1 - pow(0.01, delta))
	animatedSprite.scale.y = lerp(animatedSprite.scale.y, 1, 1 - pow(0.01, delta))

func next_camera():
	if self.name == "Player":
		get_node("../").cycle_camera()

func set_camera():
	camera.current = true
