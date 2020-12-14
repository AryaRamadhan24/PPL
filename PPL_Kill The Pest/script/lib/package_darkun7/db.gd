extends Node


onready var DB      = load("res://script/lib/package_darkun7/json_reader.gd").new()
onready var Helper  = preload("res://script/lib/package_darkun7/json_helper.gd").new()

var player setget set_player, get_player
var score setget set_score, get_score

func _ready():
	set_player(DB.readJSON("pemain"))
	set_score(DB.readJSON("score"))

func get_player_data():
	return get_player()
func get_score_data():
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

func get_mob_limit(lvl):
	lvl = lvl-1
	var result = get_score_data()[lvl][2]
	print(result," will spawning soon...")
	return result

func set_score(args):
	score = args
func get_score():
	return score
func set_player(args):
	player = args
func get_player():
	return player
