extends Node2D

const b0 = preload("res://element/bintang.png")
const b1 = preload("res://element/bintang 1.png")
const b2 = preload("res://element/bintang 2.png")
const b3 = preload("res://element/bintang 3.png")

func _ready():
	$Sprite2/score.text = str(Global.get_total())
	$username.text = str(Global.get_username())
	set_star($star_stg1.name, 1)
	$score1.text = str(Global.get_level_score(1))
	set_star($star_stg2.name, 2)
	$score2.text = str(Global.get_level_score(2))
	set_star($star_stg3.name, 3)
	$score3.text = str(Global.get_level_score(3))
	if(Global.get_unlocked_lvl() >= 2):
		$padlock_2.hide()
	if(Global.get_unlocked_lvl() >= 3):
		$padlock_3.hide()

func set_star(named_node, lvl):
	var star  = Global.get_level_star(lvl)
	var node = get_node(named_node)
	#node.texture = b3
	match str(star):
		"0":
			node.texture = b0
			print("disini 0")
		"1":
			node.texture = b1
			print("disini 1")
		"2":
			node.texture = b2
			print("disini 2")
		"3":
			node.texture = b3
			print("disini 3")
	return
	#$star_stg1.texture = 
	#$star_stg2.texture = 
	#$star_stg3.texture = 

func _on_Level_1_pressed():
	get_tree().change_scene("res://scene/EduUlat.tscn")
	
func _on_Level_2_pressed():
	if(Global.get_unlocked_lvl()>=2):
		get_tree().change_scene("res://scene/EduBeetle.tscn")
	pass

func _on_Level_3_pressed():
	if(Global.get_unlocked_lvl()>=3):
		get_tree().change_scene("res://scene/EduMite.tscn")
	pass
	
func _on_back_pressed():
	get_tree().change_scene("res://scene/Main Menu.tscn")

func _on_editname():
	get_tree().change_scene("res://scene/Play Menu.tscn")



