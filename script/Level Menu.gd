extends Node2D

const b1 = preload("res://element/bintang 1.png")
const b2 = preload("res://element/bintang 2.png")
const b3 = preload("res://element/bintang 3.png")

func _ready():
	$Sprite2/score.text = str(Global.get_total())
	$username.text = str(Global.get_username())
	#$star_stg1.texture = 
	#$star_stg2.texture = 
	#$star_stg3.texture = 
	
	if(Global.get_unlocked_lvl() >= 2):
		$padlock_2.hide()
	if(Global.get_unlocked_lvl() >= 3):
		$padlock_3.hide()

func _on_Level_1_pressed():
	get_tree().change_scene("res://scene/EduUlat.tscn")
	
func _on_Level_2_pressed():
	if(Global.get_unlocked_lvl>=2):
		get_tree().change_scene("res://scene/EduBeetle.tscn")

func _on_Level_3_pressed():
	if(Global.get_unlocked_lvl>=3):
		get_tree().change_scene("res://scene/EduMite.tscn")
	
func _on_back_pressed():
	get_tree().change_scene("res://scene/Main Menu.tscn")


func _on_editname():
	get_tree().change_scene("res://scene/Play Menu.tscn")



