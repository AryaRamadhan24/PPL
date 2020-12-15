extends Sprite

var speed = 300
var dir = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	global_position.x += dir*speed*delta
	#print(global_position.x)


func _on_Area2D_body_entered(body):
	pass # Replace with function body.


func _on_wave_colided(body):
	$".".queue_free()
