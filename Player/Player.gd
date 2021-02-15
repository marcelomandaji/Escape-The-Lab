extends KinematicBody2D

export (int) var speed = 50
export (int) var jump_speed = -250
export (int) var gravity = 1000
export (float, 0, 1.0) var friction = 0.3
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var motion_previous = Vector2.ZERO

var got_key = false
var hit_the_ground = false

const FLOOR = Vector2(0,-1)
func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		
		dir += 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
		
	if Input.is_action_pressed("walk_left"):
		
		dir -= 1
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
		
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if is_on_floor():
			$AnimatedSprite.play("idle")

func _ready():
	if self.name == "Player":
		$Camera2D.current = true

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	motion_previous = velocity
	velocity = move_and_slide(velocity, FLOOR)

	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			
	

	"""
	-- New Code from this Point --
	If the player is in the air, make scale of sprite
	based on the y motion value using range_lerp
	The fast the y motion, 
	the larger the y stretch, 
	the larger the x squash
	"""

	if not is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall") 
		hit_the_ground = false
		if not is_on_wall():
			$AnimatedSprite.scale.y = range_lerp(abs(velocity.y), 0, abs(jump_speed), 0.75, 1.75)
			$AnimatedSprite.scale.x = range_lerp(abs(velocity.y), 0, abs(jump_speed), 1.25, 0.75)

	"""
	If there's a floor collision,
	set squashed scale values based on
	previous motion
	"""

	if not hit_the_ground and is_on_floor():
		hit_the_ground = true
		$AnimatedSprite.scale.x = range_lerp(abs(motion_previous.y), 0, abs(1700), 1.8, 2.0)
		$AnimatedSprite.scale.y = range_lerp(abs(motion_previous.y), 0, abs(1700), 0.6, 0.5)


	"""
	lerp function eases sprite scale to default position
	See article on using delta with lerp:
		https://www.construct.net/en/blogs/ashleys-blog-2/using-lerp-delta-time-924
	"""

	$AnimatedSprite.scale.x = lerp($AnimatedSprite.scale.x, 1, 1 - pow(0.01, delta))
	$AnimatedSprite.scale.y = lerp($AnimatedSprite.scale.y, 1, 1 - pow(0.01, delta))
