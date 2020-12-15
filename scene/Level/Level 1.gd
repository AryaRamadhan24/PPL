extends Node2D

const wave = preload("res://element/projectile/wave.tscn")
const caterpilar = preload("res://element/mob/caterpilar.tscn")

var poin = 0 setget set_poin, get_poin
var spawned_mob = 0 setget set_spawned_mob, get_spawned_mob
var level

func _ready():
	level = int($".".name)
	print(level)
	var mob = caterpilar.instance()
	add_child(mob)
	mob.global_position = $player.position
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
	wavecolide.connect("body_entered", self, "wave_colide")

func wave_colide(body):
	if(body.name == "MOB" or body.name.left(4)=="@MOB"):
		print("hit mob")
		set_poin(get_poin() +10);
		body.queue_free()
	else:
		pass

func set_poin(args):
	poin = args
func get_poin():
	return poin
func set_spawned_mob(args):
	spawned_mob = args
func get_spawned_mob():
	return spawned_mob

func _on_spawn_time():
	var mob_limit = Global.get_mob_limit(level)
	if get_spawned_mob() <= mob_limit:
		spawn_mob(rand_range(225,775), 380)

func spawn_mob(x,y):
	print("Spawn Time")
	match level:
		1:      #caterpilar
			var mob = caterpilar.instance()
			add_child(mob)
			mob.global_position = $player.position
			pass
		2:      #flies
			
			pass
			
		3:      #mushroom
			pass
