extends Sprite

var speed = 300
var dir = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	global_position.x += dir*speed*delta
	#print(global_position.x)
