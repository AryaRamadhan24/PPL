extends Node

var default_pemain = {
			na = "Tester", #nama
			lv = 1
		} setget , get_pemain
var default_score = [
	   [1, 0, 10],
	   [2, 0, 15],
	   [3, 0, 20],
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
