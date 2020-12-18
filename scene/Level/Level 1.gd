extends Node2D

const wave = preload("res://element/projectile/wave.tscn")
const boom = preload("res://element/mob/bom.tscn")
const explode = preload("res://element/explosion.png")
const caterpilar = preload("res://element/mob/caterpilar.tscn")

var poin = 0 setget set_poin, get_poin
var spawned_mob = 0 setget set_spawned_mob, get_spawned_mob
var level

func _ready():
	level = int($".".name)
	pass

func _process(delta):
	$background/point/score.text = str(get_poin())
	if Input.is_action_just_pressed("ui_select"):
		spawn_wave(Global.get_pd())
		pass
	var mob_limit = Global.get_mob_limit(level)
	if(get_spawned_mob() == mob_limit+2):
		check_result()

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
	elif(body.name == "BOOM" or body.name.left(5)=="@BOOM"):
		print("hit boom")
		set_poin(get_poin() -10);
		body.queue_free()
	else:
		pass

func _on_player_touch_object(body):
	if(body.name == "BOOM" or body.name.left(5)=="@BOOM"):
		print("hit boom")
		set_poin(get_poin() -10);
		body.get_children()[0].texture = explode
		body.get_children()[3].hide()
		yield(get_tree().create_timer(0.2), "timeout")
		body.queue_free()

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
		spawn_mob(rand_range(225,775))
	set_spawned_mob(get_spawned_mob()+1)


func _on_BomTimer_spawn():
	var bom = boom.instance()
	add_child(bom)
	bom.global_position = Vector2($player.position.x, -925.00)
	level = int($".".name)

func spawn_mob(x):
	print("Spawn Time ", get_spawned_mob())
	match level:
		1:      #caterpilar
			var mob = caterpilar.instance()
			add_child(mob)
			mob.global_position = Vector2(x, 380)
			pass
		2:      #flies
			
			pass
			
		3:      #mushroom
			pass

func check_result():
	var star = 0
	var mob_limit = Global.get_mob_limit(level)
	Global.set_level_score(level, get_poin())
	match level:
		1:      #caterpilar
			if(get_poin()<50):
				star = 0
				print('fail')
			elif(get_poin()<=60):
				star = 1
				print("*1")
			elif(get_poin()<=80):
				star = 2
				print("*2")
			elif(get_poin()>80):
				star = 3
				print("*3")
		2:      #flies
			if(get_poin()<100):
				star = 0
				print('fail')
			elif(get_poin()<=110):
				star = 1
				print("*1")
			elif(get_poin()<=130):
				star = 2
				print("*2")
			elif(get_poin()>130):
				star = 3
				print("*3")
		3:      #mushroom
			if(get_poin()<150):
				star = 0
				print('fail')
			elif(get_poin()<=160):
				star = 1
				print("*1")
			elif(get_poin()<=180):
				star = 2
				print("*2")
			elif(get_poin()>180):
				star = 3
				print("*3")
	if(level>1 && star>0):
		if(Global.get_unlocked_lvl()<level+1):
			Global.unlock_lvl(level+1)
		if(Global.get_level_star(level)<star):
			Global.set_level_star(level, star)

