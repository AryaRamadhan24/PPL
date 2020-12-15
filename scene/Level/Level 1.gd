extends Node2D

const wave = preload("res://element/projectile/wave.tscn")
var poin = 0 setget set_poin, get_poin

func _ready():
	pass

func _process(delta):
	$background/point/score.text = str(get_poin())
	if Input.is_action_just_pressed("ui_select"):
		spawn_wave(Global.get_pd())
		pass

func spawn_wave(direction):
	var corrector
	var obj = wave.instance()
	add_child(obj)
	obj.dir = direction
	if(direction > -1):
		obj.flip_h = false
		corrector = Vector2(75, -47)
	else:
		obj.flip_h = true
		corrector = Vector2(-75, -47)
	var spawnpoint = $player.position + corrector
	if Global.crouch:
		spawnpoint -= Vector2(0, -60)
	obj.global_position = spawnpoint
	
	var wavecolide = obj.get_children()[0]
	wavecolide.connect("body_entered", self, "colide")

func colide(body):
	#print(body.name)
	if(body.name == "MOB"):
		set_poin(get_poin() +10);
	else:
		pass


func set_poin(args):
	poin = args
func get_poin():
	return poin
