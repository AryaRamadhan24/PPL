extends Node

var default_pemain = {
			na = "Guest",
			lv = 1
		} setget , get_pemain
var default_score = [
	   [1, 0, 10, 0],
	   [2, 0, 15, 0],
	   [3, 0, 20, 0],
	] setget , get_score

func get_pemain():
	return default_pemain
func get_score():
	return default_score

func path4(target: String)->String:
	match target:
		"pemain":
			return "user://userdata.json"
		"score":
			return "user://score.json"
	return "null :("
