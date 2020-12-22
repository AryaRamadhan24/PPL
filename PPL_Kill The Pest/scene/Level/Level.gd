extends Node2D

const wave    = preload("res://element/projectile/wave.tscn")
const boom    = preload("res://element/mob/bom.tscn")
const explode = preload("res://element/explosion.png")

const caterpilar = preload("res://element/mob/caterpilar.tscn")
const beetle     = preload("res://element/mob/beetle.tscn")
const mite       = preload("res://element/mob/mite.tscn")

const b1 = preload("res://element/bintang 1.png")
const b2 = preload("res://element/bintang 2.png")
const b3 = preload("res://element/bintang 3.png")

var poin = 0 setget set_poin, get_poin
var spawned_mob = 0 setget set_spawned_mob, get_spawned_mob
var pause_state = false
var level

func _ready():
	level = int($".".name)
	$window/pause.visible = false
	pass

func _on_pause_pressed():
	get_tree().paused = true
	pause_state = !pause_state
	$window/pause.visible = true

func _on_pause_resume_pressed():
	get_tree().paused = false
	pause_state = !pause_state
	$window/pause.visible = false
func _on_pause_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scene/Main Menu.tscn")

func try():
	get_tree().paused = false
	match str(level):
		"1":
			get_tree().change_scene("res://scene/EduUlat.tscn")
		"2":
			get_tree().change_scene("res://scene/EduBeetle.tscn")
		"3":
			get_tree().change_scene("res://scene/EduMite.tscn")

func next():
	get_tree().paused = false
	if level+1<=3:
		match str(level+1):
			"2":
				get_tree().change_scene("res://scene/EduBeetle.tscn")
			"3":
				get_tree().change_scene("res://scene/EduMite.tscn")
	else:
		get_tree().change_scene("res://scene/Level Menu.tscn")
	pass

func _process(delta):
	$point/score.text = str(get_poin())
	if Input.is_action_just_pressed("ui_select"):
		spawn_wave(Global.get_pd())
		pass
	var mob_limit = Global.get_mob_limit(level)
	if(get_spawned_mob() == mob_limit+2 && ($window/win.visible == false or $window/lose.visible == false)):
		check_result()
	if(get_poin()<0):
		get_tree().paused = true
		pause_state = true
		$window/lose.show()

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
		body._on_Bom_Hilang_timeout()

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
	var y = -925.00
	var bom = boom.instance()
	add_child(bom)
	if level == 2:
		y = 50
	bom.global_position = Vector2($player.position.x, y)
	level = int($".".name)

func spawn_mob(x):
	print("Spawn Time ", get_spawned_mob())
	match level:
		1:      #caterpilar
			var mob = caterpilar.instance()
			add_child(mob)
			mob.global_position = Vector2(x, 380)
			pass
		2:      #beetle
			var mob = beetle.instance()
			add_child(mob)
			mob.global_position = Vector2(x, 200)
			pass
			
		3:      #mite
			var mob = mite.instance()
			add_child(mob)
			mob.global_position = Vector2(x, -700)
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
	if(star == 0):
		get_tree().paused = true
		pause_state = true
		$window/lose.show()
	else:
		get_tree().paused = true
		pause_state = true
		$window/win.show()
		match star:
			1:
				$window/win/star.texture = b1
			2:
				$window/win/star.texture = b2
			3:
				$window/win/star.texture = b3
	if(star>0):
		if(Global.get_unlocked_lvl()<level+1):
			Global.unlock_lvl(level+1)
		if(Global.get_level_star(level)<star):
			Global.set_level_star(level, star)

