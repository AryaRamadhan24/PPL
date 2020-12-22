extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 75
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 4
const GRAVITY = 20
const UP = Vector2(0, -1)
var direction = Vector2.ZERO
var motion = Vector2()

enum {
	IDLE,
	WANDER
}

onready var wanderController = $WanderController
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = WANDER

func _ready():
	state = pick_random_state([IDLE, WANDER])
	$Timer.start(2)

func _process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
			$Timer.wait_time = 0.3
			print('idle')
		WANDER:
			var dd = rand_range(1,10)
			if(dd <5):
				print("<5")
				motion.x = rand_range(-10, -50)
				$caterpilar.flip_h = true
				move_and_slide(motion, Vector2(rand_range(-10, -10),20))
			else:
				print("1")
				motion.x = rand_range(10, 50)
				$caterpilar.flip_h = false
				move_and_slide(motion, Vector2(rand_range(10, 10),20))
			#print('wander', $".".position, "::", motion.x)
			$Timer.wait_time = 0.6

func accelerate_towards_point(point, delta):
	direction = global_position.direction_to(point)
	direction = direction.normalized()
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if direction != Vector2.ZERO:
		pass
	else:
		pass


func _on_Timer_timeout():
	update_wander()
