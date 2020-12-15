extends Node2D

func _ready():
	$Sprite2/score.text = str(Global.get_total())
	$username.text = str(Global.get_username())

func _on_Level_1_pressed():
	get_tree().change_scene("res://scene/EduUlat.tscn")

func _on_back_pressed():
	get_tree().change_scene("res://scene/Main Menu.tscn")


func _on_editname():
	get_tree().change_scene("res://scene/Play Menu.tscn")
