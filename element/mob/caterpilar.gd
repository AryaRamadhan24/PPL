extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)
	
func _ready():
	pass # Replace with function body.

func _on_target_pos():
	var dir = rand_range(0,1)
	if(0):
		motion.x = min(rand_range(225,775)+ACCELERATION, MAX_SPEED)
	else:
		motion.x = max(rand_range(225,775)-ACCELERATION, -MAX_SPEED)
