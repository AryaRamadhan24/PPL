extends Node


onready var DB      = load("res://script/lib/package_darkun7/json_reader.gd").new()
onready var Helper  = preload("res://script/lib/package_darkun7/json_helper.gd").new()

var player setget set_player, get_player
var score setget set_score, get_score

var pdirection = 1 setget set_pd, get_pd
var crouch = false setget set_crouch, get_crouch

func _ready():
	set_player(DB.readJSON("pemain"))
	set_score(DB.readJSON("score"))

func get_player_data():
	_ready()
	return get_player()
func get_score_data():
	_ready()
	return get_score()

func get_username():
	var name = get_player_data()["na"]
	print("The username is ",name)
	return name

func set_username(name):
	var user = get_player_data()["na"]
	DB.pushJSON(["na"], [name], "pemain")
	get_username()

func unlock_lvl(lvl):
	var user = get_player_data()["lv"]
	DB.pushJSON(["lv"], [lvl], "pemain")

func get_unlocked_lvl():
	var lvl = get_player_data()["lv"]
	print("Maximal level now ", lvl)
	return lvl

func get_total():
	var accumulated = 0
	for lvl in range(3):
		accumulated += get_level_score(lvl+1)
	print("Total acumulated score within 3 stage is ",accumulated)
	return accumulated

func get_level_score(lvl):
	lvl = lvl-1
	var result = get_score_data()[lvl][1]
	print("Load score for stage ",lvl+1," with value ",result)
	return result
func set_level_score(lvl, score):
	if score <0:
		score = 0
	DB.appendJSON([lvl,1,score], "score")

func get_level_star(lvl):
	lvl = lvl-1
	var result = get_score_data()[lvl][3]
	print("Load Star for stage ",lvl+1," with value ",result)
	return result
func set_level_star(lvl, star):
	DB.appendJSON([lvl,3,star], "score")

func get_mob_limit(lvl):
	lvl = lvl-1
	var result = get_score_data()[lvl][2]
	#print(result," will spawning soon...")
	return result

func set_score(args):
	score = args
func get_score():
	return score
func set_player(args):
	player = args
func get_player():
	return player
func set_pd(args):
	pdirection = args
func get_pd():
	return pdirection

func set_crouch(args):
	crouch = args
func get_crouch():
	return crouch
