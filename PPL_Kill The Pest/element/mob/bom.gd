extends KinematicBody2D

const txt = preload("res://element/explosion.png")

const UP = Vector2(0, -1)
const GRAVITY = 5
const ACCELERATION = 10
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP, false, 4, 0.785398, false)
	self.transform.origin.x = self.position.x
	
func _ready():
	pass # Replace with function body.

func _process(delta):
	$hilang.text = str(int($BomHilang.get_time_left()))


func _on_Bom_Hilang_timeout():
	$bom.texture = txt
	$hilang.hide()
	yield(get_tree().create_timer(0.2), "timeout")
	$".".queue_free()
