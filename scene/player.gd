extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()
var crouch = false

func _physics_process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false
		if(Global.get_crouch() == false):
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("crouch")
		Global.set_pd(1)
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true
		if(Global.get_crouch() == false):
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("crouch")
		Global.set_pd(-1)
	elif Input.is_action_just_pressed("ui_down") && is_on_floor():
		Global.set_crouch(!Global.get_crouch())
		$AnimatedSprite.play("idle_crouch")
		on_crouch_scale()
	else:
		if(Global.get_crouch() == false):
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("idle_crouch")
		motion.x = lerp(motion.x, 0, 0.2)

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			Global.set_crouch(false)
			on_crouch_scale()
	else:
		$AnimatedSprite.play('idle')
	pass

func on_crouch_scale():
	var orix = 0.066
	var oriy = 0.085
	if(Global.get_crouch() && is_on_floor()):
		$AnimatedSprite.play("idle_crouch")
		$".".scale.x = 0.78
		$".".scale.y = 0.78
	else:
		$".".scale.x = 1
		$".".scale.y = 1
	print("Crouch ",Global.get_crouch())
