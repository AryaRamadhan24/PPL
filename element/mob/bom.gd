extends KinematicBody2D

const txt = preload("res://element/explosion.png")

const UP = Vector2(0, -1)
const GRAVITY = 7
const ACCELERATION = 10
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	motion = move_and_slide(motion, UP)
	
func _ready():
	pass # Replace with function body.

func _process(delta):
	$hilang.text = str(stepify($BomHilang.get_time_left(),0.1))


func _on_Bom_Hilang_timeout():
	$bom.texture = txt
	$hilang.hide()
	yield(get_tree().create_timer(0.5), "timeout")
	$".".queue_free()
